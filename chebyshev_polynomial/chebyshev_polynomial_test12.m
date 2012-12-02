function chebyshev_polynomial_test12 ( )

%*****************************************************************************80
%
%% CHEBYSHEV_POLYNOMIAL_TEST12 tests U_POLYNOMIAL.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    24 April 2012
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'CHEBYSHEV_POLYNOMIAL_TEST12:\n' );
  fprintf ( 1, '  U_POLYNOMIAL_VALUES stores values of\n' );
  fprintf ( 1, '  the Chebyshev polynomials U(n,x).\n' );
  fprintf ( 1, '  U_POLYNOMIAL evaluates the polynomial.\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '                        Tabulated                 Computed\n' );
  fprintf ( 1, '     N        X           U(n,x)                    U(n,x)                     Error\n' );

  fprintf ( 1, '\n' );

  n_data = 0;

  while ( 1 )

    [ n_data, n, x, fx1 ] = u_polynomial_values ( n_data );

    if ( n_data == 0 )
      break
    end

    fx2_vec = u_polynomial ( 1, n, x );
    fx2 = fx2_vec(1,n+1);
    e = fx1 - fx2;

    fprintf ( 1, '  %4d  %12f  %24.16e  %24.16e  %8.2g\n', n, x, fx1, fx2, e );

  end

  return
end
