function p06_header ( )

%*****************************************************************************80
%
%% P06_HEADER prints some information about problem 06.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    12 April 2009
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Per-Olof Persson and Gilbert Strang,
%    A Simple Mesh Generator in MATLAB,
%    SIAM Review,
%    Volume 46, Number 2, June 2004, pages 329-345.
%
%  Parameters:
%
%    None.
%
  r1 = 1.0;
  r2 = 0.5;

  fprintf ( 1, '\n' );
  fprintf ( 1, 'P06:\n' );
  fprintf ( 1, '  Strang and Persson example #6\n' );
  fprintf ( 1, '  Superellipse with superelliptical hole.\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  Radius R1 = %f\n', r1 );
  fprintf ( 1, '  Radius R2 = %f\n', r2 );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  A uniform mesh density is requested.\n' );
  fprintf ( 1, '  Element sizes tried were 0.4, 0.2, 0.1.\n' );

  fprintf ( 1, '\n' );
  boundary_segment_num = p06_boundary_segment_num ( );  
  fprintf ( 1, '  Number of boundary segments = %d\n', boundary_segment_num );
  fixed_num = p06_fixed_num ( );  
  fprintf ( 1, '  Number of fixed points = %d\n', fixed_num );
  hole_num = p06_hole_num ( );  
  fprintf ( 1, '  Number of holes = %d\n', hole_num );

  return
end
