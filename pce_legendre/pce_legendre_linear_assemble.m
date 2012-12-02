function [ nxy, bxy, fxy ] = pce_legendre_linear_assemble ( n, p )

%*****************************************************************************80
%
%% PCE_LEGENDRE_LINEAR_ASSEMBLE assembles a particular stochastic Galerkin matrix.
%
%  Discussion:
%
%    We wish to analyze a stochastic PDE of the form:
%
%      -div A(X,Y) grad U(X,Y) = F(X)
%
%    where 
%
%      U is an unknown scalar function, 
%      A is a given diffusion function,
%      F is a given right hand side function,
%      X represents dependence on spatial variables,
%      Y represents dependence on stochastic variables. 
%
%    We let X be a space of finite element functions generated by piecewise linear
%    functions associated with a particular triangular dissection of the unit square.
%
%    We let Y be the space of polynomials over R^N with total degree at most P.
%
%    We seek solutions U in X cross Y using a polynomial chaos expansion approach.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    19 May 2008
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer N, the number of factors in the probability space.
%
%    Input, integer P, the maximum degree of the basis functions for the 
%    probability space.
%
%    Output, integer NXY, the order of the matrix BXY.  NXY = NX * NY.
%
%    Output, real sparse BXY(NXY,NXY), the matrix.
%
%    Output, real FXY(NXY), the right hand side.
%
%  Local Parameters:
%
%    Local, real AREA_X, the area of the current element.
%
%    Local, integer BASIS_X_NUM, the number of finite element basis functions (3).
%
%    Local, integer BASIS_Y_DEGREE(1:N), describes a particular basis function 
%    in Y, in terms of the degrees of its components.
%
%    Local, integer BASIS_Y_H(*), auxilliary "external" memory needed by 
%    SUBCOMP_NEXT.
%
%    Local, logical BASIS_Y_MORE, is set FALSE before the first call to 
%    SUBCOMP_NEXT.  SUBCOMP_NEXT returns the next subcomposition, and sets the 
%    value of BASIS_Y_MORE to TRUE if there are even more subpositions that can 
%    be produced, or FALSE if there are no more.
%
%    Local, integer BASIS_Y_T(*), auxilliary "external" memory needed by 
%    SUBCOMP_NEXT.
%
%    Local, real BVEC(1:N,1:POINT_X_NUM), stores the KL expansion coefficients 
%    of orders 1 through N at the spatial points POINT_X_P(1:2,1:POINT_X_NUM).
%
%    Local, real BZERO(1:POINT_X_NUM), stores the KL expansion coefficients 
%    of order 0 at the spatial points POINT_X_P(1:2,1:POINT_X_NUM).
%
%    Local, real CLK(1:QUAD_X_NUM), contains the integral of the KL expansion 
%    function for given values of the L-th probability basis function and the
%    K-th probability test function evaluated at the quadrature points in an 
%    element.
%
%    Local, integer ELEMENT_X, the element being considered.
%
%    Local, integer ELEMENT_X_NUM, the number of elements in the finite element
%    problem.
%
%    Local, integer ELEMENT_X_NODE(1:3,1:ELEMENT_X_NUM);
%    ELEMENT_X_NODE(I,J) is the global index of local node I in element J.
%
%    Local, integer ELEMENT_X1_NUM, the number of (pairs) of elements in the 
%    first spatial dimension in the finite element problem.
%
%    Local, integer ELEMENT_X2_NUM, the number of (pairs) of elements in the 
%    second spatial dimension in the finite element problem.
%
%    Local, real FVEC(1:QUAD_X_NUM), stores the values of the function F which
%    is the right hand side of the PDE, at the quadrature points in an element.
%
%    Local, integer I, the index of the finite element test function 
%    PHI(1:NX)(X).
%
%    Local, integer J, the index of the finite element basis function 
%    PHI(1:NX)(X).
%
%    Local, integer K, the index of the probability space test function 
%    PSI(1:NY)(Y).
%
%    Local, integer L, the index of the probability space basis function 
%    PSI(1:NY)(Y).
%
%    Local, integer NODE_X_NUM, the number of nodes.
%
%    Local, real NODE_X_P(1:2,1:NODE_X_NUM), the coordinates of nodes.
%
%    Local, integer NODE_X1_NUM, the number of nodes in the first space 
%    direction.
%
%    Local, integer NODE_X2_NUM, the number of nodes in the second space 
%    direction.
%
%    Local, integer NX, the dimension of the finite element space.
%    NX = NODE_X_NUM for a finite element problem involving a scalar variable U.
%
%    Local, integer NY, = ( N + P)! / N! / P! = the dimension of the space Y, 
%    the space of polynomials over R^N of total degree at most P.
%
%    Local, real PHI(1:BASIS_X_NUM,1:QUAD_X_NUM), the finite element basis 
%    functions, evaluated at all the quadrature points in a particular element.
%
%    Local, real PHI_DX1(1:BASIS_X_NUM,1:QUAD_X_NUM), the derivative of the 
%    finite element basis functions with respect to the first spatial variable, 
%    evaluated at all the quadrature points in a particular element.
%
%    Local, real PHI_DX2(1:BASIS_X_NUM,1:QUAD_X_NUM), the derivative of the 
%    finite element basis functions with respect to the second spatial variable, 
%    evaluated at all the quadrature points in a particular element.
%
%    Local, real PHYS_X_P(1:2,1:QUAD_X_NUM), the "physical" coordinates of the 
%    quadrature points in the current element.
%
%    Local, integer QUAD_X, the index of the current X quadrature point.
%
%    Local, integer QUAD_X_NUM, the order of the X quadrature rule.
%
%    Local, real QUAD_X_P(1:2,1:QUAD_X_NUM), the points for the X quadrature 
%    rule.
%
%    Local, real QUAD_X_W(1:QUAD_X_NUM), the weights for the X quadrature rule.
%
%    Local, real T3(1:2,1:3), the coordinates of the nodes that define the 
%    current element.
%
%    Local, real TABLE(1:P+1,1:P+1), a table of the values of integrals of the 
%    1D basis functions in Z.  TABLE(D1+1,D2+1) 
%    = Integral ( -1 <= Z <= +1 ) Z * PSI(D1)(Z) * PSI(D2)(Z) dZ.
%  
%    Local, integer TEST_X_NUM, the number of finite element test functions (3).
%
%    Local, integer TEST_Y_DEGREE(1:N), describes a particular test function in 
%    Y, in terms of the degrees of its components.
%
%    Local, integer TEST_Y_H(*), auxilliary "external" memory needed by 
%    SUBCOMP_NEXT.
%
%    Local, logical TEST_Y_MORE, is set FALSE before the first call to 
%    SUBCOMP_NEXT.  SUBCOMP_NEXT returns the next subcomposition, and sets the 
%    value of TESST_Y_MORE to TRUE if there are even more subpositions that can 
%    be produced, or FALSE if there are no more.
%
%    Local, integer TEST_Y_T(*), auxilliary "external" memory needed by 
%    SUBCOMP_NEXT.
%
  FALSE = 0;
%
%  Some setup for the finite element calculation.
%
  basis_x_num = 3;
  test_x_num = 3;
  node_x1_num = 11;
  node_x2_num = 11;
  node_x_num = node_x1_num * node_x2_num;
  nx = node_x_num;

  node_x_p = grid_nodes_01 ( node_x1_num, node_x2_num );

  element_x1_num = node_x1_num - 1;
  element_x2_num = node_x2_num - 1;
  element_x_num = 2 * element_x1_num * element_x2_num;
  element_x_node = grid_t3_element ( element_x1_num, element_x2_num );

  quad_x_num = 13;
  [ quad_x_p, quad_x_w ] = triangle_rule_13 ( );
%
%  Some setup for the probability space.
%
  ny = i4_choose ( n + p, n );

  e = 1;
  table = legendre_linear_product ( p, e );

  for i = 1 : p + 1
    for j = 1 : p + 1
      if ( abs ( table(i,j) ) < 10000 * eps )
        table(i,j) = 0.0;
      end
    end
  end
%
%  Define the order of the matrix BXY,
%  Define BXY as a sparse matrix;
%  Define FXY as a column vector.
%
  nxy = nx * ny;
  bxy = sparse ( [], [], [], nxy, nxy );
  fxy(1:nxy,1) = 0.0;
%
%  LOOP L:
%  Generate the L-th basis function PSI(D,Y) in Y space.  
%
  basis_y_degree(1:n) = 0;
  basis_y_more = FALSE;
  basis_y_h = [];
  basis_y_t = [];
  basis_y_n2 = [];
  basis_y_more2 = [];
  l = 0;

  while ( 1 )

    l = l + 1;

    [ basis_y_degree, basis_y_more, basis_y_h, basis_y_t, basis_y_n2, basis_y_more2 ] = ...
      subcomp_next ( p, n, basis_y_degree, basis_y_more, basis_y_h, basis_y_t, basis_y_n2, ...
      basis_y_more2 ); 
%
%  LOOP K:
%  Generate the K-th test function PSI(D,Y) in Y space.
%
    test_y_degree(1:n) = 0;
    test_y_more = FALSE;
    test_y_h = [];
    test_y_t = [];
    test_y_n2 = [];
    test_y_more2 = [];
    k = 0;

    while ( 1 )

      k = k + 1;

      [ test_y_degree, test_y_more, test_y_h, test_y_t, test_y_n2, test_y_more2 ] = ...
        subcomp_next ( p, n, test_y_degree, test_y_more, test_y_h, test_y_t, test_y_n2, ...
        test_y_more2 ); 

      for element_x = 1 : element_x_num
%
%  For ALL the quadrature points in this element, evaluate:
%  * PHI the basis functions;
%  * PHI_DX1 and PHI_DX2, basis function derivatives;
%  * PHYS_X_P, the physical coordinates of the quadrature points;
%  * BZERO and BVEC, the coefficient functions in the KL expansion for CLK;
%  * CLK, the KL function integrated against the probability basis and test functions;
%  * FVEC, the right hand side of the PDE.
%
        t3(1:2,1:3) = node_x_p(1:2,element_x_node(1:3,element_x));

        area_x = abs ( triangle_area_2d ( t3 ) );

        [ phi, phi_dx1, phi_dx2 ] = basis_mn_t3 ( t3, quad_x_num, quad_x_p );

        phys_x_p(1:2,1:quad_x_num) = reference_to_physical_t3 ( t3, quad_x_num, quad_x_p );

        [ bzero, bvec ] = b_evaluator ( n, quad_x_num, phys_x_p );

        if ( l == k )
          clk(1:quad_x_num) = bzero(1:quad_x_num);
        else
          clk(1:quad_x_num) = 0.0;
        end

        for i2 = 1 : n

          factor = 1.0;
          for i3 = 1 : n
            if ( i3 ~= i2 )
              if ( basis_y_degree(i3) ~= test_y_degree(i3) )
                factor = 0.0;
              end
            end
          end

          clk(1:quad_x_num) = clk(1:quad_x_num) ...
            + bvec(i2,1:quad_x_num) * table(basis_y_degree(i2)+1,test_y_degree(i2)+1)...
            * factor;

        end

        fvec = f_evaluator ( quad_x_num, phys_x_p );
%
%  Integrate over the finite element space X.
%
        for quad_x = 1 : quad_x_num
%
%  LOOP J:
%  All finite element basis functions J.
%  But we actually only look at those which are nonzero in this element.
%
          for basis_x = 1 : basis_x_num
          
            j = element_x_node(basis_x,element_x);
%
%  LOOP I:
%  Finite element test function I.
%  But we actually only look at those which are nonzero in this element.
%
            for test_x = 1 : test_x_num

              i = element_x_node(test_x,element_x);

              ik = ( k - 1 ) * node_x_num + i;
              jl = ( l - 1 ) * node_x_num + j;
%
%  If I is a boundary node, the equation associated with its test function
%  is replaced by a simple equation that enforces a zero Dirichlet condition.
% 
              if ( i <= node_x1_num || ...
                        node_x1_num * ( node_x2_num - 1) + 1 <= i || ...
                        mod ( i, node_x1_num ) == 1 || ...
                        mod ( i, node_x1_num ) == 0 )

                if ( ik == jl )
                  bxy(ik,jl) = 1.0;
                  fxy(ik) = 0.0;
                end
%
%  If I is not a boundary node, the equation associated with its test function
%  generates a finite element equation.
%
              else

                bxy(ik,jl) = bxy(ik,jl) + quad_x_w(quad_x) * area_x ...
                  * clk(quad_x) ...
                  * ( phi_dx1(test_x,quad_x) * phi_dx1(basis_x,quad_x) ...
                    + phi_dx2(test_x,quad_x) * phi_dx2(basis_x,quad_x) );
%
%  The only nonzero result for the right hand side FXY occurs when K = 1,
%  since this is the single test function in Y which is the product of N 
%  copies of the constant Legendre polynomial.  
%
%  (This is true as long as there is no Y dependence in F(), and
%  assuming we are using Legendre polynomials.)
%
                if ( k == 1 )
                  psi0_integral = 1 / sqrt ( 2^n );
                  fxy(ik) = fxy(ik) + quad_x_w(quad_x) * area_x ...
                    * fvec(quad_x) * phi(test_x,quad_x) * psi0_integral;
                end

              end

            end
          end 
        end

      end

      if ( test_y_more == FALSE )
        break
      end

    end

    if ( basis_y_more == FALSE )
      break
    end

  end

  return
end
function [ bzero, bvec ] = b_evaluator ( n, nx, x )

%*****************************************************************************80
%
%% B_EVALUATOR evaluates KL expansion coefficients for the diffusion coefficient.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    13 May 2008
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer N, the number of factors in the probability space.
%
%    Input, integer NX, the number of points.
%
%    Input, real X(1:2,1:NX), the point coordinates.
%
%    Output, real BZERO(1:NX), the zero-th order coefficient evaluated at X.
%
%    Output, real BVEC(1:N,1:NX), the coefficients of orders 1 to N, 
%    evaluated at X.
%
  bzero(1:nx) = 1.0;
  bvec = zeros ( n, nx );
  for i = 1 : n
    bvec(i,1:nx) = sin ( i * x(1,1:nx) );
  end

  return
end
function [ phi, dphidx, dphidy ] = basis_mn_t3 ( t, n, p )

%*****************************************************************************80
%
%% BASIS_MN_T3: all bases functions at N points for a T3 element.
%
%  Discussion:
%
%    The routine is given the coordinates of the vertices of a triangle.
%    It works directly with these coordinates, and does not refer to a 
%    reference element.
%
%    The sides of the triangle DO NOT have to lie along a coordinate
%    axis.
%
%    The routine evaluates the basis functions associated with each vertex,
%    and their derivatives with respect to X and Y.
%
%  Physical Element T3:
%
%            3
%           / \
%          /   \
%         /     \
%        /       \
%       1---------2
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    14 February 2006
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, real T(2,3), the vertices of the triangle.  It is common to list 
%    these points in counter clockwise order.
%
%    Input, integer N, the number of evaluation points.
%
%    Input, real P(2,N), the coordinates of the evaluation points.
%
%    Output, real PHI(3,N), the basis functions at the evaluation points.
%
%    Output, real DPHIDX(3,N), DPHIDY(3,N), the basis derivatives 
%    at the evaluation points.
%
%  Local parameters:
%
%    Local, real AREA, is (twice) the area of the triangle.
%
  area = t(1,1) * ( t(2,2) - t(2,3) ) ...
       + t(1,2) * ( t(2,3) - t(2,1) ) ...
       + t(1,3) * ( t(2,1) - t(2,2) );

  phi(1,1:n) =     (  ( t(1,3) - t(1,2) ) * ( p(2,1:n) - t(2,2) )     ...
                    - ( t(2,3) - t(2,2) ) * ( p(1,1:n) - t(1,2) ) );
  dphidx(1,1:n) =   - ( t(2,3) - t(2,2) );
  dphidy(1,1:n) =     ( t(1,3) - t(1,2) );

  phi(2,1:n) =     (  ( t(1,1) - t(1,3) ) * ( p(2,1:n) - t(2,3) )     ...
                    - ( t(2,1) - t(2,3) ) * ( p(1,1:n) - t(1,3) ) );
  dphidx(2,1:n) =   - ( t(2,1) - t(2,3) );
  dphidy(2,1:n) =     ( t(1,1) - t(1,3) );

  phi(3,1:n) =     (  ( t(1,2) - t(1,1) ) * ( p(2,1:n) - t(2,1) )     ...
                    - ( t(2,2) - t(2,1) ) * ( p(1,1:n) - t(1,1) ) );
  dphidx(3,1:n) =   - ( t(2,2) - t(2,1) );
  dphidy(3,1:n) =     ( t(1,2) - t(1,1) );
%
%  Normalize.
%
  phi(1:3,1:n)    = phi(1:3,1:n) / area;
  dphidx(1:3,1:n) = dphidx(1:3,1:n) / area;
  dphidy(1:3,1:n) = dphidy(1:3,1:n) / area;

  return
end
function [ a, more, h, t ] = comp_next ( n, k, a, more, h, t )

%*****************************************************************************80
%
%% COMP_NEXT computes the compositions of the integer N into K parts.
%
%  Discussion:
%
%    A composition of the integer N into K parts is an ordered sequence
%    of K nonnegative integers which sum to N.  The compositions (1,2,1)
%    and (1,1,2) are considered to be distinct.
%
%    The routine computes one composition on each call until there are no more.
%    For instance, one composition of 6 into 3 parts is
%    3+2+1, another would be 6+0+0.
%
%    On the first call to this routine, set MORE = FALSE.  The routine
%    will compute the first element in the sequence of compositions, and
%    return it, as well as setting MORE = TRUE.  If more compositions
%    are desired, call again, and again.  Each time, the routine will
%    return with a new composition.
%
%    However, when the LAST composition in the sequence is computed 
%    and returned, the routine will reset MORE to FALSE, signaling that
%    the end of the sequence has been reached.
%
%    This routine originally used a SAVE statement to maintain the
%    variables H and T.  I have decided (based on wasting an
%    entire morning trying to track down a problem) that it is safer
%    to pass these variables as arguments, even though the user should
%    never alter them.  This allows this routine to safely shuffle
%    between several ongoing calculations.
%
%  Example:
%
%    The 28 compositions of 6 into three parts are:
%
%      6 0 0,
%      5 1 0,
%      5 0 1,
%      4 2 0,
%      4 1 1,
%      4 0 2,
%      3 3 0,
%      3 2 1,
%      3 1 2,
%      3 0 3,
%      2 4 0,
%      2 3 1,
%      2 2 2,
%      2 1 3,
%      2 0 4,
%      1 5 0,
%      1 4 1,
%      1 3 2,
%      1 2 3,
%      1 1 4,
%      1 0 5,
%      0 6 0,
%      0 5 1,
%      0 4 2,
%      0 3 3,
%      0 2 4,
%      0 1 5,
%      0 0 6.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    09 July 2007
%
%  Author:
%
%    Original FORTRAN77 version by Albert Nijenhuis and Herbert Wilf
%    MATLAB version by John Burkardt.
%
%  Reference:
%
%    Albert Nijenhuis, Herbert Wilf,
%    Combinatorial Algorithms for Computers and Calculators,
%    Second Edition,
%    Academic Press, 1978,
%    ISBN: 0-12-519260-6,
%    LC: QA164.N54.
%
%  Parameters:
%
%    Input, integer N, the integer whose compositions are desired.
%
%    Input, integer K, the number of parts in the composition.
%
%    Input, integer A(K), the previous composition.  On the first call,
%    with MORE = FALSE, set A = [].  Thereafter, A should be the 
%    value of A output from the previous call.
%
%    Input, logical MORE.  The input value of MORE on the first
%    call should be FALSE, which tells the program to initialize.
%    On subsequent calls, MORE should be TRUE, or simply the
%    output value of MORE from the previous call.
%
%    Input, integer H, T, two internal parameters needed for the
%    computation.  The user may need to initialize these before the
%    very first call, but these initial values are not important.
%    The user should not alter these parameters once the computation
%    begins.
%
%    Output, integer A(K), the next composition.
%
%    Output, logical MORE, will be TRUE unless the composition 
%    that is being returned is the final one in the sequence.
%
%    Output, integer H, T, the updated values of the two internal 
%    parameters.
%
  if ( ~more )

    t = n;
    h = 0;
    a(1) = n;
    a(2:k) = 0;

  else
      
    if ( 1 < t )
      h = 0;
    end

    h = h + 1;
    t = a(h);
    a(h) = 0;
    a(1) = t - 1;
    a(h+1) = a(h+1) + 1;

  end

  more = ( a(k) ~= n );

  return
end
function fvec = f_evaluator ( n, x )

%*****************************************************************************80
%
%% F_EVALUATOR evaluates the finite element right hand side function F.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    13 May 2008
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer N, the number of point.
%
%    Input, real X(2,N), the point coordinates.
%
%    Output, real FVEC(N), the value of F at the points.
%
  fvec(1:n) = sin ( pi * x(1,1:n) ) .* sin ( pi * x(2,1:n) );

  return
end
function node_xy = grid_nodes_01 ( x_num, y_num )

%*****************************************************************************80
%
%% GRID_NODES_01 returns an equally spaced grid of nodes in the unit square.
%
%  Example:
%
%    X_NUM = 5
%    Y_NUM = 3
%
%    NODE_XY = 
%    ( 0, 0.25, 0.5, 0.75, 1, 0,   0.25, 0.5, 0.75, 1,   0, 0.25, 0.5, 0.75, 1;
%      0, 0,    0,   0,    0, 0.5, 0.5,  0.5, 0.5,  0.5, 1, 1.0,  1.0, 1.0,  1 )
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    12 May 2008
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer X_NUM, Y_NUM, the number of nodes in the X and Y directions.
%
%    Output, real NODE_XY(2,X_NUM*Y_NUM), the coordinates of the nodes.
%
  node_num = x_num * y_num;

  node_xy(1:2,1:node_num) = 0.0;

  for i = 1 : x_num
    node_xy(1,i:x_num:i+(y_num-1)*x_num) = ( i - 1 ) / ( x_num - 1 );
  end

  for j = 1 : y_num
    node_xy(2,1+(j-1)*x_num:j*x_num) = ( j - 1 ) / ( y_num - 1 );
  end

  return
end
function [ element_node ] = grid_t3_element ( nelemx, nelemy )

%*****************************************************************************80
%
%% GRID_T3_ELEMENT produces a grid of pairs of 3 node triangles.
%
%  Example:
%
%    Input:
%
%      NELEMX = 3, NELEMY = 2
%
%    Output:
%
%      ELEMENT_NODE =
%         1,  2,  5;
%         6,  5,  2;
%         2,  3,  6;
%         7,  6,  3;
%         3,  4,  7;
%         8,  7,  4;
%         5,  6,  9;
%        10,  9,  6;
%         6,  7, 10;
%        11, 10,  7;
%         7,  8, 11;
%        12, 11,  8.
%
%  Grid:
%
%    9---10---11---12
%    |\ 8 |\10 |\12 |
%    | \  | \  | \  |
%    |  \ |  \ |  \ |
%    |  7\|  9\| 11\|
%    5----6----7----8
%    |\ 2 |\ 4 |\ 6 |
%    | \  | \  | \  |
%    |  \ |  \ |  \ |
%    |  1\|  3\|  5\|
%    1----2----3----4
%
%  Reference Element T3:
%
%    |
%    1  3
%    |  |\
%    |  | \
%    S  |  \
%    |  |   \
%    |  |    \
%    0  1-----2
%    |
%    +--0--R--1-->
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    14 April 2005
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer NELEMX, NELEMY, the number of elements along the
%    X and Y directions.  The number of elements generated will be
%    2 * NELEMX * NELEMY.
%
%    Output, integer ELEMENT_NODE(3,2*NELEMX*NELEMY), the nodes that form
%    each element.
%

%
%  Node labeling:
%
%    NW--NE
%     |\ |
%     | \|
%    SW--SE
%
  element = 0;
  element_node = zeros ( 3, 2 * nelemx * nelemy );
  for j = 1 : nelemy
    for i = 1 : nelemx

      sw = i     + ( j - 1 ) * ( nelemx + 1 );
      se = i + 1 + ( j - 1 ) * ( nelemx + 1 );
      nw = i     +   j       * ( nelemx + 1 );
      ne = i + 1 +   j       * ( nelemx + 1 );

      element = element + 1;

      element_node(1,element) = sw;
      element_node(2,element) = se;
      element_node(3,element) = nw;

      element = element + 1;

      element_node(1,element) = ne;
      element_node(2,element) = nw;
      element_node(3,element) = se;

    end
  end

  return
end
function value = i4_choose ( n, k )

%*****************************************************************************80
%
%% I4_CHOOSE computes the binomial coefficient C(N,K).
%
%  Discussion:
%
%    The value is calculated in such a way as to avoid overflow and
%    roundoff.  The calculation is done in integer arithmetic.
%
%    The formula used is:
%
%      C(N,K) = N! / ( K! * (N-K)! )
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    02 June 2007
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    ML Wolfson, HV Wright,
%    Algorithm 160:
%    Combinatorial of M Things Taken N at a Time,
%    Communications of the ACM,
%    Volume 6, Number 4, April 1963, page 161.
%
%  Parameters:
%
%    Input, integer N, K, are the values of N and K.
%
%    Output, integer VALUE, the number of combinations of N
%    things taken K at a time.
%
  mn = min ( k, n - k );

  if ( mn < 0 )

    value = 0;

  elseif ( mn == 0 )

    value = 1;

  else

    mx = max ( k, n - k );
    value = mx + 1;

    for i = 2 : mn
      value = ( value * ( mx + i ) ) / i;
    end

  end

  return
end
function table = legendre_linear_product ( p, e )

%*****************************************************************************80
%
%% LEGENDRE_LINEAR_PRODUCT computes a linearly weighted Legendre product table.
%
%  Discussion:
%
%    Let L(i)(X) represent the Legendre polynomial of degree i.  
%
%    For polynomial chaos applications, it is of interest to know the
%    value of the integrals of products of X with every possible pair
%    of basis functions.  That is, we'd like to form
%
%      Tij = Integral ( -1 <= X <= +1 ) X^E * L(i)(X) * L(j)(X) dx
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    12 May 2008
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer P, the maximum degree of the polyonomial factors.
%    0 <= P.
%
%    Input, integer E, the exponent of X in the integrand.
%    0 <= E.
%
%    Output, real TABLE(P+1,P+1), the table of integrals.  TABLE(I,J)
%    represents the weighted integral of X^E * L(i+1)(X) * L(j+1)(X).
%
  table(1:p+1,1:p+1) = 0.0;

  order = p + 1 + floor ( ( e + 1 ) / 2 );
  [ x_table, w_table ] = legendre_quadrature_rule ( order );

  for k = 1 : order

    x = x_table(k);
    l_table = legendre_polynomial ( p, x );
%
%  The following formula is an outer product in L_TABLE.
%
    if ( e == 0 )
      table(1:p+1,1:p+1) = table(1:p+1,1:p+1) ...
        + w_table(k) *       l_table(1:p+1)' * l_table(1:p+1);
    else
      table(1:p+1,1:p+1) = table(1:p+1,1:p+1) ...
        + w_table(k) * x^e * l_table(1:p+1)' * l_table(1:p+1);
    end

  end

  return
end
function l = legendre_polynomial ( p, x )

%*****************************************************************************80
%
%% LEGENDRE_POLYNOMIAL evaluates the Legendre polynomials L(0:P)(X).
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    08 May 2008
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Milton Abramowitz and Irene Stegun,
%    Handbook of Mathematical Functions,
%    US Department of Commerce, 1964.
%
%    Daniel Zwillinger, editor,
%    CRC Standard Mathematical Tables and Formulae,
%    30th Edition,
%    CRC Press, 1996.
%
%  Parameters:
%
%    Input, integer P, the highest evaluation degree.
%
%    Input, real X, the evaluation point.
%
%    Output, real L(1:P+1), the Legendre polynomials of order 0 through P at X.
%
  if ( p < 0 )
    l = [];
    return
  end
%
%  Allocate space.
%
  l(1:p+1) = 0.0;
%
%  Apply recursion.
%
  l(1) = 1.0;

  if ( 1 <= p )

    l(2) = x;
 
    for i = 2 : p
 
      l(i+1) = ( ( 2 * i - 1 ) * x * l(i)   ...
               - (     i - 1 ) *     l(i-1) ) ...
               / (     i     );
 
    end

  end
%
%  Normalize.
%
  l(1:p+1) = l(1:p+1) .* sqrt ( ( 1 : 2 : 2*p+1 ) / 2 );

  return
end
function [ xtab, weight ] = legendre_quadrature_rule ( order )

%*****************************************************************************80
%
%% LEGENDRE_QUADRATURE_RULE computes a Gauss-Legendre quadrature rule.
%
%  Discussion:
%
%    The integration interval is [ -1, 1 ].
%
%    The weight function is w(x) = 1.0.
%
%    The integral to approximate:
%
%      Integral ( -1 <= X <= 1 ) F(X) dX
%
%    The quadrature rule:
%
%      Sum ( 1 <= I <= NORDER ) WEIGHT(I) * F ( XTAB(I) )
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    08 May 2008
%
%  Author:
%
%    FORTRAN77 original version by Philip Davis, Philip Rabinowitz
%    MATLAB version by John Burkardt
%
%  Reference:
%
%    Philip Davis, Philip Rabinowitz,
%    Methods of Numerical Integration,
%    Second Edition,
%    Dover, 2007,
%    ISBN: 0486453391,
%    LC: QA299.3.D28.
%
%  Parameters:
%
%    Input, integer ORDER, the order of the rule.
%    ORDER must be greater than 0.
%
%    Output, real XTAB(ORDER), the abscissas of the rule.
%
%    Output, real WEIGHT(ORDER), the weights of the rule.
%    The weights are positive, symmetric, and should sum to 2.
%
  xtab = zeros ( order, 1 );
  weight = zeros ( order, 1 );
  
  if ( order < 1 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'LEGENDRE_RULE - Fatal error!\n' );
    fprintf ( 1, '  Illegal value of ORDER = %d\n', order );
    error ( 'LEGENDRE_RULE - Fatal error!' );
  end

  e1 = order * ( order + 1 );

  m = floor ( ( order + 1 ) / 2 );

  for i = 1 : floor ( ( order + 1 ) / 2 )

    mp1mi = m + 1 - i;

    t = ( 4 * i - 1 ) * pi / ( 4 * order + 2 );

    x0 = cos(t) * ( 1.0 - ( 1.0 - 1.0 / ( order ) ) / ( 8 * order * order ) );

    pkm1 = 1.0;
    pk = x0;

    for k = 2 : order
      pkp1 = 2.0 * x0 * pk - pkm1 - ( x0 * pk - pkm1 ) / k;
      pkm1 = pk;
      pk = pkp1;
    end

    d1 = order * ( pkm1 - x0 * pk );

    dpn = d1 / ( 1.0 - x0 * x0 );

    d2pn = ( 2.0 * x0 * dpn - e1 * pk ) / ( 1.0 - x0 * x0 );

    d3pn = ( 4.0 * x0 * d2pn + ( 2.0 - e1 ) * dpn ) / ( 1.0 - x0 * x0 );

    d4pn = ( 6.0 * x0 * d3pn + ( 6.0 - e1 ) * d2pn ) / ( 1.0 - x0 * x0 );

    u = pk / dpn;
    v = d2pn / dpn;
%
%  Initial approximation H:
%
    h = - u * ( 1.0 + 0.5 * u * ( v + u * ( v * v - d3pn / ( 3.0 * dpn ) ) ) );
%
%  Refine H using one step of Newton's method:
%
    p = pk + h * ( dpn + 0.5 * h * ( d2pn + h / 3.0 ...
      * ( d3pn + 0.25 * h * d4pn ) ) );

    dp = dpn + h * ( d2pn + 0.5 * h * ( d3pn + h * d4pn / 3.0 ) );

    h = h - p / dp;

    xtemp = x0 + h;

    xtab(mp1mi) = xtemp;

    fx = d1 - h * e1 * ( pk + 0.5 * h * ( dpn + h / 3.0 ...
      * ( d2pn + 0.25 * h * ( d3pn + 0.2 * h * d4pn ) ) ) );

    weight(mp1mi) = 2.0 * ( 1.0 - xtemp * xtemp ) / fx / fx;

  end

  if ( mod ( order, 2 ) == 1 )
    xtab(1) = 0.0;
  end
%
%  Shift the data up.
%
  nmove = floor ( ( order + 1 ) / 2 );
  ncopy = order - nmove;

  for i = 1 : nmove
    iback = order + 1 - i;
    xtab(iback) = xtab(iback-ncopy);
    weight(iback) = weight(iback-ncopy);
  end
%
%  Reflect values for the negative abscissas.
%
  for i = 1 : order - nmove
    xtab(i) = - xtab(order+1-i);
    weight(i) = weight(order+1-i);
  end

  return
end
function phy = reference_to_physical_t3 ( t, n, ref )

%*****************************************************************************80
%
%% REFERENCE_TO_PHYSICAL_T3 maps a reference point to a physical point.
%
%  Discussion:
%
%    Given the vertices of an order 3 physical triangle and a point
%    (XSI,ETA) in the reference triangle, the routine computes the value
%    of the corresponding image point (X,Y) in physical space.
%
%    Note that this routine may also be appropriate for an order 6
%    triangle, if the mapping between reference and physical space
%    is linear.  This implies, in particular, that the sides of the
%    image triangle are straight and that the "midside" nodes in the
%    physical triangle are halfway along the sides of
%    the physical triangle.
%
%    The T3 reference element is suggested by the following diagram:
%
%    |
%    1  3
%    |  |\
%    |  | \
%    S  |  \
%    |  |   \
%    |  |    \
%    0  1-----2
%    |
%    +--0--R--1-->
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    24 June 2005
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, real T(2,3), the coordinates of the vertices.  The vertices are assumed 
%    to be the images of (0,0), (1,0) and (0,1) respectively.
%
%    Input, integer N, the number of points to transform.
%
%    Input, real REF(2,N), the coordinates of points in the reference space.
%
%    Output, real PHY(2,N), the coordinates of the corresponding points in the 
%    physical space.
%
  phy = zeros ( 2, n );
  
  for i = 1 : 2

    phy(i,1:n) = t(i,1) * ( 1.0 - ref(1,1:n) - ref(2,1:n) ) ...
               + t(i,2) *        ref(1,1:n)                ...
               + t(i,3) *                     ref(2,1:n);
  end

  return
end
function [ a, more, h, t, n2, more2 ] = subcomp_next ( n, k, a, more, h, t, ...
  n2, more2 )

%*****************************************************************************80
%
%% SUBCOMP_NEXT computes the next subcomposition of N into K parts.
%
%  Discussion:
%
%    A composition of the integer N into K parts is an ordered sequence
%    of K nonnegative integers which sum to a value of N.
%
%    A subcomposition of the integer N into K parts is a composition
%    of M into K parts, where 0 <= M <= N.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    13 May 2008
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer N, the integer whose subcompositions are desired.
%
%    Input, integer K, the number of parts in the subcomposition.
%
%    Input, integer A(K), the parts of the subcomposition.
%
%    Input, logical MORE, set to FALSE by the user to start the computation.
%
%    Input, integer H, T, N2, MORE2, internal parameters needed for the
%    computation.  The user may need to initialize these before the
%    very first call, but these initial values are not important.
%    The user should not alter these parameters once the computation
%    begins.
%
%    Output, integer A(K), the parts of the subcomposition.
%
%    Output, logical MORE, set to FALSE by the routine to terminate 
%    the computation.
%
%    Output, integer H, T, N2, MORE2, the updated values of the two internal 
%    parameters.
%

%
%  The first computation.
%
  if ( ~more )

    n2 = 0;
    a(1:k) = 0;
    more2 = 0;
    h = 0;
    t = 0;

    more = 1;
%
%  Do the next element at the current value of N.
%
  elseif ( more2 )

    [ a, more2, h, t ] = comp_next ( n2, k, a, more2, h, t );

  else

    more2 = 0;
    n2 = n2 + 1;

    [ a, more2, h, t ] = comp_next ( n2, k, a, more2, h, t );

  end
%
%  Termination occurs if MORE2 = FALSE and N2 = N.
%
  if ( ~more2 && n2 == n )
    more = 0;
  end

  return
end
function area = triangle_area_2d ( t )

%*****************************************************************************80
%
%% TRIANGLE_AREA_2D computes the area of a triangle in 2D.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    28 January 2005
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, real T(2,3), the triangle vertices.
%
%    Output, real AREA, the absolute area of the triangle.
%
  area = 0.5 * abs ( ...
      t(1,1) * ( t(2,2) - t(2,3) ) ...
    + t(1,2) * ( t(2,3) - t(2,1) ) ...
    + t(1,3) * ( t(2,1) - t(2,2) ) );

  return
end
function [ x, w ] = triangle_rule_13 ( )

%*****************************************************************************80
%
%% TRIANGLE_RULE_13 sets a 13 point quadrature rule for triangles.
%
%  Discussion:
%
%    The Integration region is points (X,Y) such that
%
%      0 <= X,
%      0 <= Y, and
%      X + Y <= 1.
%
%    Graph:
%
%      ^
%    1 | *
%      | |\
%    Y | | \
%      | |  \
%    0 | *---*
%      +------->
%        0 X 1
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    12 May 2008
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Gilbert Strang, George Fix,
%    An Analysis of the Finite Element Method,
%    Prentice Hall, 1973, page 184,
%    ISBN: 096140888X,
%    LC: TA335.S77.
%
%  Parameters:
%
%    Output, real X(2,13), the abscissas.
%
%    Output, real W(13), the weights.
%
  a = 0.479308067841923;
  b = 0.260345966079038;
  c = 0.869739794195568;
  d = 0.065130102902216;
  e = 0.638444188569809;
  f = 0.312865496004875;
  g = 0.048690315425316;
  h = 1.0 / 3.0;
  t = 0.175615257433204;
  u = 0.053347235608839;
  v = 0.077113760890257;
  w = -0.149570044467670;

  x(1:2,1:13) = [ a, b, b, c, d, d, e, e, f, f, g, g, h;
                  b, a, b, d, c, d, f, g, e, g, e, f, h ];

  w(1:13) = [ t, t, t, u, u, u, v, v, v, v, v, v, w ];

  return
end
