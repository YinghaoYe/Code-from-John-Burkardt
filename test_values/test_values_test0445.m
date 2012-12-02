function test_values_test0445 ( )

%*****************************************************************************80
%
%% TEST0445 demonstrates the use of CBRT_VALUES.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    22 June 2007
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST0445:\n' );
  fprintf ( 1, '  CBRT_VALUES stores values of the cube root.\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '      X           CBRT(X)\n' );
  fprintf ( 1, '\n' );

  n_data = 0;

  while ( 1 )

    [ n_data, x, fx ] = cbrt_values ( n_data );

    if ( n_data == 0 )
      break
    end

    fprintf ( 1, '  %12f  %24.16f\n', x, fx );

  end

  return
end
