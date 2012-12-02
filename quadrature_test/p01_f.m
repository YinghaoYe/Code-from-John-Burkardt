function value = p01_f ( dim_num, point_num, x )

%*****************************************************************************80
%
%% P01_F evaluates the integrand for problem 01.
%
%  Dimension:
%
%    DIM_NUM is arbitrary.
%
%  Region:
%
%    0 <= X(1:DIM_NUM) <= 1
%
%  Integrand:
%
%    f(x) = ( sum ( x(1:dim_num) ) )**2
%
%  Exact Integral:
%
%    dim_num * ( 3 * dim_num + 1 ) / 12
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
%  Parameters:
%
%    Input, integer DIM_NUM, the dimension of the argument.
%
%    Input, integer POINT_NUM, the number of points.
%
%    Input, real X(DIM_NUM,POINT_NUM), the evaluation points.
%
%    Output, real VALUE(POINT_NUM), the integrand values.
%
  value(1:point_num) = 0.0;

  for point = 1 : point_num
    value(point) = ( sum ( x(1:dim_num,point) ) )^2;
  end

  p01_i4 ( 'I', '#', point_num );

  return
end
