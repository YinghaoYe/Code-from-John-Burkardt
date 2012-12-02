function i4lib_test16 ( )

%*****************************************************************************80
%
%% TEST16 tests I4_LOG_R8.
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
  test_num = 10;

  b_test = [ 2.0, 3.0,  4.0,  5.0,   6.0, 7.0, 8.0, 16.0, 32.0, 256.0 ];

  x = 16;
 
  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST16\n' );
  fprintf ( 1, '  I4_LOG_R8: whole part of log base B,\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  X    B   I4_LOG_R8\n' );
  fprintf ( 1, '\n' );

  for test = 1 : test_num
 
    b = b_test(test);

    fprintf ( 1, '  %6d  %12f  %12d\n', x, b, i4_log_r8 ( x, b ) );
 
  end

  return
end
