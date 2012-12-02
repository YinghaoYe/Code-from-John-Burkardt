function i4lib_test27 ( )

%*****************************************************************************80
%
%% TEST27 tests I4COL_SORT_A and I4COL_SORT_D.
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
  m = 5;
  n = 4;
  b = 1;
  c = 10;

  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST27\n' );
  fprintf ( 1, '  I4COL_SORT_A ascending sorts an integer array\n' );
  fprintf ( 1, '    as a table of columns.\n' );
  fprintf ( 1, '  I4COL_SORT_D descending sorts an integer array\n' );
  fprintf ( 1, '    as a table of columns.\n' );

  seed = 123456789;

  [ a, seed ] = i4mat_uniform_ab ( m, n, b, c, seed );

  i4mat_print ( m, n, a, '  The original matrix:' );

  a = i4col_sort_a ( m, n, a );

  i4mat_print ( m, n, a, '  Ascending sorted:' );

  a = i4col_sort_d ( m, n, a );

  i4mat_print ( m, n, a, '  Descending sorted:' );

  return
end
