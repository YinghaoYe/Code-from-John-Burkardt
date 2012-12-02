function subpak_test063 ( )

%*****************************************************************************80
%
%% TEST063 tests R8MAT_MAX_INDEX and R8MAT_MIN_INDEX.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    19 April 2009
%
%  Author:
%
%    John Burkardt
%
  m = 5;
  n = 3;

  b = 0.0;
  c = 10.0;

  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST063\n' );
  fprintf ( 1, '  For an R8MAT,\n' );
  fprintf ( 1, '  R8MAT_MAX_INDEX locates the maximum entry;\n' );
  fprintf ( 1, '  R8MAT_MIN_INDEX locates the minimum entry;\n' );
 
  seed = 123456789;

  [ a, seed ] = r8mat_uniform_ab ( m, n, b, c, seed );
 
  r8mat_print ( m, n, a, '  Random array:' );
 
  [ i, j ] = r8mat_max_index ( m, n, a );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Maximum I,J indices = (%d,%d)\n', i, j );

  [ i, j ] = r8mat_min_index ( m, n, a );

  fprintf ( 1, '  Minimum I,J indices = (%d,%d)\n', i, j );

  return
end
