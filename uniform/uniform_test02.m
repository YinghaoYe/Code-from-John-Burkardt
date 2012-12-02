function uniform_test02 ( )

%*****************************************************************************80
%
% TEST02 tests C4VEC_UNIFORM_01.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    29 June 2006
%
%  Author:
%
%    John Burkardt
%
  seed = 123456789;

  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST02\n' );
  fprintf ( 1, '  C4VEC_UNIFORM_01 computes pseudorandom complex values\n' );
  fprintf ( 1, '  in the unit circle.\n' );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  The initial seed is %d\n', seed );
  fprintf ( 1, '\n' );

  n = 10;

  [ x, seed ] = c4vec_uniform_01 ( n, seed );

  for i = 1 : n
    fprintf ( 1, '  %6d  ( %f, %f )\n', i, real ( x(i) ), imag ( x(i) ) );
  end

  return
end
