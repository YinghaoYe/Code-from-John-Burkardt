function [ sparse_order, sparse_index ] = sparse_grid_mixed_index ( ...
  dim_num, level_max, rule, point_num, point_total_num, sparse_unique_index )

%*****************************************************************************80
%
%% SPARSE_GRID_MIXED_INDEX indexes a sparse grid made from mixed 1D rules.
%
%  Discussion:
%
%    For each "unique" point in the sparse grid, we return its INDEX and ORDER.
%
%    That is, for the I-th unique point P, we determine the product grid which
%    first generated this point, and we return in SPARSE_ORDER the orders of
%    the 1D rules in that grid, and in SPARSE_INDEX the component indexes in
%    those rules that generated this specific point.
%
%    For instance, say P was first generated by a rule which was a 3D product
%    of a 9th order CC rule and a 15th order GL rule, and that to generate P,
%    we used the 7-th point of the CC rule and the 3rh point of the GL rule.
%    Then the SPARSE_ORDER information would be (9,15) and the SPARSE_INDEX
%    information would be (7,3).  This, combined with the information in RULE,
%    is enough to regenerate the value of P.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    05 March 2011
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Fabio Nobile, Raul Tempone, Clayton Webster,
%    A Sparse Grid Stochastic Collocation Method for Partial Differential
%    Equations with Random Input Data,
%    SIAM Journal on Numerical Analysis,
%    Volume 46, Number 5, 2008, pages 2309-2345.
%
%  Parameters:
%
%    Input, integer DIM_NUM, the spatial dimension.
%
%    Input, integer LEVEL_MAX, the maximum value of LEVEL.
%
%    Input, integer RULE(DIM_NUM), the rule in each dimension.
%     1, "CC",  Clenshaw Curtis, Closed Fully Nested rule.
%     2, "F2",  Fejer Type 2, Open Fully Nested rule.
%     3, "GP",  Gauss Patterson, Open Fully Nested rule.
%     4, "GL",  Gauss Legendre, Open Weakly Nested rule.
%     5, "GH",  Gauss Hermite, Open Weakly Nested rule.
%     6, "GGH", Generalized Gauss Hermite, Open Weakly Nested rule.
%     7, "LG",  Gauss Laguerre, Open Non Nested rule.
%     8, "GLG", Generalized Gauss Laguerre, Open Non Nested rule.
%     9, "GJ",  Gauss Jacobi, Open Non Nested rule.
%    10, "GW",  Golub Welsch, (presumed) Open Non Nested rule.
%    11, "CC_SE", Clenshaw Curtis Slow Exponential, Closed Fully Nested rule.
%    12, "F2_SE", Fejer Type 2 Slow Exponential, Closed Fully Nested rule.
%    13, "GP_SE", Gauss Patterson Slow Exponential, Closed Fully Nested rule.
%    14, "CC_ME", Clenshaw Curtis Moderate Exponential, Closed Fully Nested rule.
%    15, "F2_ME", Fejer Type 2 Moderate Exponential, Closed Fully Nested rule.
%    16, "GP_ME", Gauss Patterson Moderate Exponential, Closed Fully Nested rule.
%    17, "CCN", Clenshaw Curtis Nested, Linear, Closed Fully Nested rule.
%
%    Input, integer POINT_NUM, the number of unique points in the grid.
%
%    Input, integer POINT_TOTAL_NUM, the total number of points in the grid.
%
%    Input, integer SPARSE_UNIQUE_INDEX(POINT_TOTAL_NUM), associates each
%    point in the grid with its unique representative.
%
%    Output, integer SPARSE_ORDER(DIM_NUM,POINT_NUM), lists, for each point,
%    the order of the 1D rules used in the grid that generated it.
%
%    Output, integer SPARSE_INDEX(DIM_NUM,POINT_NUM), lists, for each point,
%    its index in each of the 1D rules in the grid that generated it.
%    The indices are 1-based.
%

%
%  Special cases.
%
  if ( level_max < 0 )
    sparse_order = [];
    sparse_index = [];
    return
  end

  if ( level_max == 0 )
    sparse_order(1:dim_num,1) = 1;
    sparse_index(1:dim_num,1) = 1;
    return
  end

  sparse_order = zeros ( dim_num, point_num );
  sparse_index = zeros ( dim_num, point_num );

  point_count = 0;
%
%  The outer loop generates values of LEVEL.
%
  level_min = max ( 0, level_max + 1 - dim_num );

  for level = level_min : level_max
%
%  The middle loop generates a GRID,
%  based on the next partition that adds up to LEVEL.
%
    level_1d = [];
    more_grids = 0;
    h = 0;
    t = 0;

    while ( 1 )

      [ level_1d, more_grids, h, t ] = comp_next ( level, dim_num, level_1d, ...
        more_grids, h, t );

      order_1d = level_to_order_default ( dim_num, level_1d, rule );
%
%  The inner loop generates a POINT of the GRID of the LEVEL.
%
      point_index = [];
      more_points = 0;

      while ( 1 )

        [ point_index, more_points ] = vec_colex_next3 ( dim_num, order_1d, point_index, ...
          more_points );

        if ( ~more_points )
          break
        end

        point_count = point_count + 1;
        point_unique = sparse_unique_index(point_count);
        sparse_order(1:dim_num,point_unique) = order_1d(1:dim_num);
        sparse_index(1:dim_num,point_unique) = point_index(1:dim_num);

      end

      if ( ~more_grids )
        break
      end

    end

  end

  return
end
