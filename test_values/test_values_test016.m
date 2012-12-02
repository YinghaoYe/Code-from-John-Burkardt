function test_values_test016 ( )

%*****************************************************************************80
%
%% TEST016 demonstrates the use of BERNSTEIN_POLY_VALUES.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    02 February 2009
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST016:\n' );
  fprintf ( 1, '  BERNSTEIN_POLY_VALUES returns values of \n' );
  fprintf ( 1, '  the Bernstein polynomials.\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '     N     K       X      BERNSTEIN(N,K)(X)\n' );
  fprintf ( 1, '\n' );

  n_data = 0;

  while ( 1 )

    [ n_data, n, k, x, b ] = bernstein_poly_values ( n_data );

    if ( n_data == 0 )
      break
    end

    fprintf ( 1, '  %6d  %4d  %12f  %24.16f\n', n, k, x, b );

  end

  return
end
