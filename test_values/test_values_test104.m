function test_values_test104 ( )

%*****************************************************************************80
%
%% TEST104 demonstrates the use of LOBACHEVSKY_VALUES.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    03 November 2005
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST104:\n' );
  fprintf ( 1, '  LOBACHEVSKY_VALUES stores values of\n' );
  fprintf ( 1, '  the Lobachevsky function.\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '      X               FX\n' );
  fprintf ( 1, '\n' );

  n_data = 0;

  while ( 1 )

    [ n_data, x, fx ] = lobachevsky_values ( n_data );

    if ( n_data == 0 )
      break
    end

    fprintf ( 1, '  %12f  %24.16f\n', x, fx );

  end

  return
end
