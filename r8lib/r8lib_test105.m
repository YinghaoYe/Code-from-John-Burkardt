function subpak_test105 ( )

%*****************************************************************************80
%
%% TEST105 tests R8ROW_MAX and R8ROW_MIN;
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
  m = 3;
  n = 4;

  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST105\n' );
  fprintf ( 1, '  For a R8ROW (a matrix regarded as rows):\n' );
  fprintf ( 1, '  R8ROW_MAX computes maximums;\n' );
  fprintf ( 1, '  R8ROW_MIN computes minimums;\n' );

  k = 0;
  for i = 1 : m
    for j = 1 : n
      k = k + 1;
      a(i,j) = k;
    end
  end

  r8mat_print ( m, n, a, '  The original matrix:' );

  amax = r8row_max ( m, n, a );

  amin = r8row_min ( m, n, a );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Row maximum, minimum:\n' );
  fprintf ( 1, '\n' );
  for i = 1 : m
    fprintf ( 1, '  %3d  %10f  %10f\n', i, amax(i), amin(i) );
  end

  return
end
