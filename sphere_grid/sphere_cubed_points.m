function xyz = sphere_cubed_points ( n, ns )

%*****************************************************************************80
%
%% SPHERE_CUBED_POINTS computes the points on a cubed sphere grid.
%
%  Discussion:
%
%    For a value of N = 3, for instance, each of the 6 cube faces will
%    be divided into 3 sections, so that a single cube face will have
%    (3+1)x(3+1) points:
%
%      X---X---X---X
%      | 1 | 4 | 7 |
%      X---X---X---X
%      | 2 | 5 | 8 |
%      X---X---X---X
%      | 3 | 6 | 9 |
%      X---X---X---X
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    03 October 2012
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer N, the number of sections into which each face of
%    the cube is to be divided.
%
%    Input, integer NS, the number of points.
%
%    Output, real XYZ(3,NS), distinct points on the unit sphere
%    generated by a cubed sphere grid.
%
  xyz = zeros ( 3, ns );

  ns2 = 0;
%
%  Bottom full.
%
  [ ns2, xyz ] = ...
    sphere_cubed_points_face ( n, 0, 0, 0, n, n, 0, ns2, xyz ); 
%
%  To avoid repetition, draw the middles as grids of n-2 x n-1 points.
%
  [ ns2, xyz ] = ...
    sphere_cubed_points_face ( n, 0, 0, 1, 0,   n-1, n-1, ns2, xyz );
  [ ns2, xyz ] = ...
    sphere_cubed_points_face ( n, 0, n, 1, n-1, n,   n-1, ns2, xyz );
  [ ns2, xyz ] = ...
    sphere_cubed_points_face ( n, n, 1, 1, n,   n,   n-1, ns2, xyz );
  [ ns2, xyz ] = ...
    sphere_cubed_points_face ( n, 1, 0, 1, n,   0,   n-1, ns2, xyz );
%
%  Top full.
%
  [ ns2, xyz ] = ...
    sphere_cubed_points_face ( n, 0, 0, n, n, n, n, ns2, xyz );

  if ( ns2 ~= ns )
    fprintf ( '\n' );
    fprintf ( 'SPHERE_CUBED_POINTS - Fatal error!\n' );
    fprintf ( '  Expected to generated NS = %d points.\n', ns );
    fprintf ( '  Generated %d points.\n', ns2 );
    error ( 'SPHERE_CUBED_POINTS - Fatal error!' );
  end

  return
end
