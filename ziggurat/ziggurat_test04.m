function test04 ( )

%*****************************************************************************80
%
%% TEST04 tests R4_EXP.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    06 May 2008
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST04\n' );
  fprintf ( 1, '  R4_EXP returns pseudorandom exponentially distributed\n' );
  fprintf ( 1, '  real numbers between 0 and 1.\n' );

  [ ke, fe, we ] = r4_exp_setup ( );

  for j = 0 : 2

    if ( mod ( j, 2 ) == 0 )
      seed = uint32 ( 123456789 );
    else
      seed = uint32 ( 987654321 );
    end

    fprintf ( 1, '\n' );
    fprintf ( 1, '  %6d  %12u\n', 0, seed );
    fprintf ( 1, '\n' );

    for i = 1 : 10
      [ value, seed ] = r4_exp ( seed, ke, fe, we );
      fprintf ( 1, '  %6d  %12d  %12u  %14f\n', i, seed, seed, value );
    end

  end

  return
end
