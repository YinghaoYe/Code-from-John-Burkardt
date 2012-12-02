function t = p01_vertices ( )

%*****************************************************************************80
%
%% P01_VERTICES returns the vertices for problem 1.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    09 April 2007
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Output, real T(2,3), the vertices.
%
  t(1:2,1:3) = [
    0.0, 0.0; ...
    1.0, 0.0; ...
    0.0, 1.0 ]';

  return
end
