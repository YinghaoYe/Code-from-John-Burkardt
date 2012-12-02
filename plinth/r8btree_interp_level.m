function fx = r8btree_interp ( node_num, tree, data_num, tree_data, int_num, ...
  x, level )
 
%*****************************************************************************80
%
%% R8BTREE_INTERP_LEVEL interpolates data using an R8BTREE.
%
%  Discussion:
%
%    This function is a version of R8BTREE which restricts the search in
%    the BTREE to no more than LEVEL levels.  Setting LEVEL to 0
%    means that only the primary node of the BTREE will be considered,
%    which will use a piecewise constant interpolant.  Level 1
%    allows the two nodes of the first level to be included in the search,
%    and so on. 
%
%    A BTREE has been set up, containing pairs of data values X, FX.
%
%    Now we are given a set of points X, and we wish to perform interpolation.
%    If the interpolation point is bracketed by a pair of data values,
%    we use linear interpolation.  If it falls to the left or right of all
%    the data values, we simply use the function value at the nearest
%    data value.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    01 December 2009
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer NODE_NUM, the number of nodes in the tree.
%
%    Input, integer TREE(4,NODE_NUM).
%    TREE(1,I), the index in TREE_DATA(1,*) of the coordinate of node I.
%    TREE(2,I), the left child of node I.
%    TREE(3,I), the right child of node I.
%    TREE(4,I), the parent of node I.
%
%    Input, integer DATA_NUM, the number of data items per node.
%
%    Input, real TREE_DATA(DATA_NUM,NODE_NUM), node data.
%
%    Input, integer INT_NUM, the number of interpolation points.
%
%    Input, real X(INT_NUM), the interpolation points.
%
%    Input, integer LEVEL, the maximum level to search.
%    0 <= LEVEL.
%
%    Output, real FX(INT_NUM), the interpolated values.
%
  fx = zeros ( 1, int_num );
%
%  Later, move vector into subroutine!
%
  for i = 1 : int_num

    [ l, r ] = r8btree_bracket_level ( node_num, tree, data_num, tree_data, ...
      x(i), level );

    if ( l <= 0 )
      fr = tree_data(2,r);
      fx(i) = fr;
    elseif ( r <= 0 )
      fl = tree_data(2,l);
      fx(i) = fl;
    elseif ( r == l )
      fl = tree_data(2,l);
      fx(i) = fl;
    else
      xr = tree_data(1,r);
      fr = tree_data(2,r);
      xl = tree_data(1,l);
      fl = tree_data(2,l);
      fx(i) = ( ( xr - x(i)      ) * fl   ...
              + (      x(i) - xl ) * fr ) ...
              / ( xr        - xl );
    end

  end

  return
end
