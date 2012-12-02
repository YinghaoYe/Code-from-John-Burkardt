function test_values_test0995 ( )

%*****************************************************************************80
%
%% TEST0995 demonstrates the use of LAMBERT_W_VALUES.
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
  fprintf ( 1, 'TEST0995:\n' );
  fprintf ( 1, '  LAMBERT_W_VALUES stores values of \n' );
  fprintf ( 1, '  the Lambert W function.\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '      X           W(X)\n' );
  fprintf ( 1, '\n' );

  n_data = 0;

  while ( 1 )

    [ n_data, x, fx ] = lambert_w_values ( n_data );

    if ( n_data == 0 )
      break
    end

    fprintf ( 1, '  %12f  %24.16f\n', x, fx );

  end

  return
end
