function [ grid_num, point_num ] = cc_levels_constrained_size ( dim_num, ...
  q_max, alpha, level_min, level_max )

%*****************************************************************************80
%
%% CC_LEVELS_CONSTRAINED_SIZE counts grids for CC_LEVELS_CONSTRAINED.
%
%  Discussion:
%
%    The constraint on the levels of the 1D Clenshaw Curtis rule in 
%    spatial dimension I is:
%
%      LEVEL_MIN(I) <= LEVEL(I) <= LEVEL_MAX(I) 
%
%    The constraint on the collection of levels making up a rule is:
%
%      Sum ( 1 <= I <= DIM_NUM ) ALPHA(I) * LEVEL(I) <= Q_MAX.
%
%    The relationship of level to order is roughly 
%
%      ORDER = 2**LEVEL+1.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    09 November 2006
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer DIM_NUM, the spatial dimension.
%
%    Input, real Q_MAX, the maximum values of
%    Q, the sum of the weighted orders in each spatial coordinate.
%
%    Input, real ALPHA(DIM_NUM), the weight factors for
%    the orders in each spatial dimension.
%
%    Input, integer LEVEL_MIN(DIM_NUM), LEVEL_MAX(DIM_NUM), the minimum
%    and maximum values of the level of the 1D Clenshaw Curtis rule
%    in each spatial dimension.
%
%    Output, integer GRID_NUM, the number of Clenshaw Curtis
%    grids in the constraint set.
%
%    Output, integer POINT_NUM, the total number of points in the grids.
%

%
%  Determine the total number of points that will be generated
%  by "going through the motions".
%
  point_num = 0;
  grid_num = 0;

  level_1d = [];
  more = 0;

  while ( 1 )

    [ level_1d, more ] = vector_constrained_next4 ( dim_num, alpha, ...
      level_min, level_max, level_1d, q_max, more );

    if ( ~more )
      break
    end

    order_1d = cc_level_to_order ( dim_num, level_1d );

    order_nd = prod ( order_1d(1:dim_num) );

    point_num = point_num + order_nd;

    grid_num = grid_num + 1;

  end

  return
end
