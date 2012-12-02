function test_matrix_exponential_test01 ( )

%*****************************************************************************80
%
%% TEST_MATRIX_EXPONENTIAL_TEST01 retrieves the test data.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    31 October 2011
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST_MATRIX_EXPONENTIAL_TEST01:\n' );
  fprintf ( 1, '  Retrieve the data for each matrix exponential test.\n' );

  test_num = mexp_test_num ( );

  for test = 1 : test_num

    fprintf ( 1, '\n' );
    fprintf ( 1, '  Test #%d\n', test );

    n = mexp_n ( test );

    mexp_story ( test );

    fprintf ( 1, '\n' );
    fprintf ( 1, '  Matrix order N = %d\n', n );

    a = mexp_a ( test, n );

    r8mat_print ( n, n, a, '  Matrix:' );

    a_exp = mexp_expa ( test, n );
    r8mat_print ( n, n, a_exp, '  Exact Exponential:' );

  end

  return
end
