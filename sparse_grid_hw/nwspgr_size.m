function r_size  = nwspgr_size ( type, dim, k, sym, compress )

%*****************************************************************************80
%
%% NWSPGR generates nodes and weights for sparse grid integration.
%
%  Modified:
%
%    17 June 2012
%
%  Author:
%
%    Florian Heiss, Viktor Winschel
%
%  Reference:
%
%    Florian Heiss, Viktor Winschel,
%    Likelihood approximation by numerical integration on sparse grids,
%    Journal of Econometrics,
%    Volume 144, 2008, pages 62-80.
%
%  Parameters:
% 
%    Input, string TYPE, selects the 1D integration rule:
%    "kpu": Nested rule for unweighted integral over [0,1];
%    "kpn": Nested rule for integral with Gaussian weight;
%    "gqu": Gaussian quadrature for unweighted integral over [0,1] 
%    (Gauss-Legendre);
%    "gqn": Gaussian quadrature for integral with Gaussian weight 
%    (Gauss-Hermite);
%    func:  any function name. Function must accept level l and return nodes N 
%    and weights W for univariate quadrature rule with polynomial exactness 
%    2*L-1 as [n, w] = feval(func,level)
%
%    Input, integer DIM, the dimension of the integration problem.
%
%    Input, integer K, the level.  When using the built in 1D rules, the 
%    resulting sparse grid will be exact for polynomials up to total order
%    2*K-1.  When using the built-in quadrature rules, the maximum value of K 
%    that is available is 25.
%
%    Input, integer SYM.  This is only useful when the user has 
%    chosen to supply the 1D quadrature rule.  In that case, if the rule is 
%    symmetric, specifying SYM to be 1 will allow the code to run faster.
%    But this also requires that the user function only return the nonnegative
%    abscissas and their weights.
%
%    Input, integer COMPRESS,
%    0, do not compress the rule (merge duplicate points)
%    1, compress the rule.
%
%    Output, integer R_SIZE, the "size" of the rule.
%

%
%  Interpret the inputs.  Use STRCMPI so that case is ignored.
%
  builtinfct = ( strcmpi ( type, 'gqu' ) || ...
                 strcmpi ( type, 'gqn' ) || ...
                 strcmpi ( type, 'kpu' ) || ...
                 strcmpi ( type, 'kpn' ) );

  sym = logical ( sym );
%
%  Retrieve the 1D rules of levels 1 to K.
%  Create cell arrays X1D and W1D containing the node and weight information.
%  The array N1D stores the length or order of each rule.
%
%  The built in functions already return only the positive orthant.
%
%  If the rule is being supplied by the user, and the user indicates that
%  it's a symmetric rule, then similarly keep only the positive orthant.
%
%  The result will be that if SYM is true, whether for built in or user-supplied
%  functions, we have only the positive orthant data stored.
%
  n1d = zeros ( 1, k );
  x1d = cell ( k, 1 ); 
  w1d = cell ( k, 1 ); 

  for level = 1 : k

    [ x, w ] = feval ( type, level );

    if ( ( ~ builtinfct ) && sym )
      [ numnew, dummy ] = size ( x );
      [ x, sortvec ] = sortrows ( x );
      w = w ( sortvec );
      x = x((floor(numnew/2)+1):numnew,:);
      w = w((floor(numnew/2)+1):numnew,:);
    end

    n1d(level) = length ( w );
    x1d{level} = x;
    w1d{level} = w;

  end
%
%  Initialization.
%
  minq = max ( 0, k - dim );
  maxq = k - 1;
  nodes = [];
  weights = [];
%
%  Loop for max ( 0, K - DIM ) <= Q <= K - 1.
%
  for q = minq : maxq

    r = length ( weights );
%
%  BQ is the combinatorial coefficient applied to the component
%  product rules which have level Q.
%
    bq = ( -1 )^( maxq - q ) * nchoosek ( dim - 1, dim + q - k );
%
%  Compute the D-dimensional row vectors that sum to DIM+Q.
%
    is = get_seq ( dim, dim + q );
%
%  Preallocate new rows for nodes and weights.
%
    Rq = prod ( n1d(is), 2 );
    sRq = sum ( Rq );
    nodes   = [ nodes;   zeros(sRq,dim) ];
    weights = [ weights; zeros(sRq,1) ];
%
%  Generate each of the product rules indicated by IS, and
%  insert them into NODES and WEIGHTS.
%
    for j = 1 : size(is,1)
      midx = is(j,:);
      [ newn, neww ] = tensor_product ( x1d(midx), w1d(midx) );
      nodes((r+1):(r+Rq(j)),:) = newn;
      weights((r+1):(r+Rq(j))) = bq .* neww;
      r = r + Rq(j);
    end
%
%  Sort the nodes and merge repeated values.
%
    [ nodes, sortvec ] = sortrows ( nodes );
    weights = weights(sortvec);
    keep = 1; 
    lastkeep = 1;

    for j = 2 : size(nodes,1)
      if ( compress )

        if ( nodes(j,:) == nodes(j-1,:) ) 
          weights(lastkeep) = weights(lastkeep) + weights(j);
        else
          lastkeep = j;
          keep = [ keep ; j ];
        end
      else
        lastkeep = j;
        keep = [ keep ; j ];
      end
    end

    nodes = nodes(keep,:);
    weights = weights(keep);

  end
%
%  The rule has been computed.
%  If we used symmetry, we now have to extend the rule.
%
  if ( sym )

    nr = length ( weights );
    m = x1d{1};

    for j = 1 : dim

      keep = zeros(nr,1);
      numnew = 0;

      for r = 1 : nr 
        if ( nodes(r,j) ~= m )
          numnew = numnew + 1;
          keep(numnew) = r;
        end
      end

      if ( 0 < numnew )
        nodes = [nodes ; nodes(keep(1:numnew),:)];
        nodes(nr+1:nr+numnew,j) = 2*m - nodes(nr+1:nr+numnew,j);
        weights = [weights ; weights(keep(1:numnew))]; 
        nr = nr + numnew;
      end

    end

    [ nodes, sortvec ] = sortrows ( nodes );
    weights = weights(sortvec);

  end

  r_size = length ( weights );

  return
end
