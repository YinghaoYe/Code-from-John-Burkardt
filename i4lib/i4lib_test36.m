function i4lib_test36 ( )

%*****************************************************************************80
%
%% TEST36 tests I4ROW_MAX and I4ROW_MIN;
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    14 April 2009
%
%  Author:
%
%    John Burkardt
%
  m = 3;
  n = 4;

  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST36\n' );
  fprintf ( 1, '  I4ROW_MAX computes row maximums;\n' );
  fprintf ( 1, '  I4ROW_MIN computes row minimums;\n' );

  k = 0;
  for i = 1 : m
    for j = 1 : n
      k = k + 1;
      a(i,j) = k;
    end
  end

  i4mat_print ( m, n, a, '  The matrix:' );

  amax = i4row_max ( m, n, a );

  amin = i4row_min ( m, n, a );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Maximum, minimum:\n' );
  fprintf ( 1, '\n' );
  for i = 1 : m
    fprintf ( 1, '  %3d  %6d  %6d\n', i, amax(i), amin(i) );
  end

  return
end
