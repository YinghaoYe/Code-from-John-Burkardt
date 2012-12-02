function p_data = p01_data ( dim_num, data_num )

%*****************************************************************************80
%
%% P01_DATA returns the data for problem p01.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    01 August 2011
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer DIM_NUM, the spatial dimension of the dependent
%    variables.
%
%    Input, integer DATA_NUM, the number of data points.
%
%    Output, real P_DATA(DIM_NUM,DATA_NUM), the data.
%
  p_data = [ ...
    0.0, 4.0; ...
    1.0, 5.0; ...
    2.0, 6.0; ...
    4.0, 6.0; ...
    5.0, 5.0; ...
    6.0, 3.0; ...
    7.0, 1.0; ...
    8.0, 1.0; ...
    9.0, 1.0; ...
   10.0, 3.0; ...
   11.0, 4.0; ...
   12.0, 4.0; ...
   13.0, 3.0; ...
   14.0, 3.0; ...
   15.0, 4.0; ...
   16.0, 4.0; ...
   17.0, 3.0; ...
   18.0, 0.0 ]';

 return
end
