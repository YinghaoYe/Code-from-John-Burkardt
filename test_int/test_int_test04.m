function test_int_test04 ( )

%*****************************************************************************80
%
%% TEST04 applies a composite Gauss-Legendre rule to finite interval 1D problems.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    12 November 2009
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST04\n' );
  fprintf ( 1, '  Use a composite 4 point Gauss-Legendre rule,\n' );
  fprintf ( 1, '  for 1D finite interval problems.\n' );

  prob_num = p00_prob_num ( );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Problem       Exact\n' );
  fprintf ( 1, '         Ints   Approx	   Error\n' );
%
%  Pick a problem.
%
  for prob = 1 : prob_num

    exact = p00_exact ( prob );

    fprintf ( 1, '\n' );
    fprintf ( 1, '  %4d        %14f\n', prob, exact );
%
%  Pick a number of subintervals.
%
    for int_log = 0 : 7

      int_num = 2^int_log;

      result = p00_gauss_legendre ( prob, int_num );

      error = abs ( exact - result );

      fprintf ( 1, '        %4d  %14f  %14e\n', int_num, result, error );

    end

  end

  return
end
