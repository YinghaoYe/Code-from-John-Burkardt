function euler_test ( test, step_num )

%*****************************************************************************80
%
%% EULER_TEST uses the Euler method on a test problem.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    24 March 2006
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer TEST, the number of the problem to be demonstrated.
%
%    Input, integer STEP_NUM, the number of steps to take.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'EULER_TEST\n' );
  fprintf ( 1, '  Problem number = %d\n', test );

  title = p00_title ( test );

  fprintf ( 1, '  %s\n', title );
%
%  Initialize any problem parameters.
%
  value = p00_param_default ( test );
  if ( 0 < value )
    fprintf ( 1, '  This problem has %d parameters.\n', value );
  end
%
%  Autonomous?
%
  if ( p00_autonomous ( test ) )
    fprintf ( 1, '  The system is autonomous.\n' );
  else
    fprintf ( 1, '  The system is not autonomous.\n' );
  end
%
%  Get the number of equations.
%
  neqn = p00_neqn ( test );

  fprintf ( 1, '  Number of equations is %d\n', neqn );

  if ( 8 < neqn )
    fprintf ( 1, '  The system is large.\n' );
    fprintf ( 1, '  Print only MIN, AVERAGE, MAX and L2NORM.\n' );
  end
%
%  Get the starting point.
%
  [ t_start, y_start ] = p00_start ( test );
%
%  Get the stopping point.
%
  [ t_stop, y_stop ] = p00_stop ( test );
%
%  Print the stepsize;
%
  fprintf ( 1, '  Stepsize H = %f\n', ( t_stop - t_start ) / step_num );

  fprintf ( 1, '\n' );
  if ( neqn <= 4 )
    fprintf ( 1, '  %12f', t_start );
    for i = 1 : neqn
      fprintf ( 1, '  %12f', y_start(i) );
    end
    fprintf ( 1, '\n' );
  elseif ( neqn <= 8 )
    fprintf ( 1, '  %12f', t_start );
    for i = 1 : 4
      fprintf ( 1, '  %12f', y_start(i) );
    end
    fprintf ( 1, '\n' );
    fprintf ( 1, '              ' );
    for i = 5 : neqn
      fprintf ( 1, '  %12f', y_start(i) );
    end
    fprintf ( 1, '\n' );
  else
    y_min = min ( y_start(1:neqn) );
    y_ave = sum ( y_start(1:neqn) ) / neqn;
    y_max = max ( y_start(1:neqn) );
    y_norm = sqrt ( sum ( y_start(1:neqn).^2 ) );
    fprintf ( 1, '  %12f  %12f  %12f  %12f  %12f\n', ...
      t_start, y_min, y_ave, y_max, y_norm );
  end

  y0(1:neqn) = y_start(1:neqn);


  for step = 1 : step_num

    t0 = ( ( step_num - step + 1 ) * t_start ...
         + (            step - 1 ) * t_stop ) ...
         / ( step_num );

    t1 = ( ( step_num - step ) * t_start ...
         + (            step ) * t_stop ) ...
         / ( step_num );

    y1 = p00_euler_step ( test, neqn, t0, y0, t1 );

    if ( mod ( 10 * step, step_num ) == 0 | step == step_num )
      if ( neqn <= 4 )
        fprintf ( 1, '  %12f', t1 );
        for i = 1 : neqn
          fprintf ( 1, '  %12f', y1(i) );
        end
        fprintf ( 1, '\n' );
      elseif ( neqn <= 8 )
        fprintf ( 1, '  %12f', t1 );
        for i = 1 : 4
          fprintf ( 1, '  %12f', y1(i) );
        end
        fprintf ( 1, '\n' );
        fprintf ( 1, '              ' );
        for i = 5 : neqn
          fprintf ( 1, '  %12f', y1(i) );
        end
        fprintf ( 1, '\n' );
      else
        y_min = min ( y1(1:neqn) );
        y_ave = sum ( y1(1:neqn) ) / neqn;
        y_max = max ( y1(1:neqn) );
        y_norm = sqrt ( sum ( y1(1:neqn).^2 ) );
        fprintf ( 1, '  %12f  %12f  %12f  %12f  %12f\n', ...
          t1, y_min, y_ave, y_max, y_norm );
      end
    end

    y0(1:neqn) = y1(1:neqn);

  end

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Expected final conditions:\n' );
  fprintf ( 1, '\n' );

  if ( neqn <= 4 )
    fprintf ( 1, '  %12f', t_stop );
    for i = 1 : neqn
      fprintf ( 1, '  %12f', y_stop(i) );
    end
    fprintf ( 1, '\n' );
  elseif ( neqn <= 8 )
    fprintf ( 1, '  %12f', t_stop );
    for i = 1 : 4
      fprintf ( 1, '  %12f', y_stop(i) );
    end
    fprintf ( 1, '\n' );
    fprintf ( 1, '              ' );
    for i = 5 : neqn
      fprintf ( 1, '  %12f', y_stop(i) );
    end
    fprintf ( 1, '\n' );
  else
    y_min = min ( y_stop(1:neqn) );
    y_ave = sum ( y_stop(1:neqn) ) / neqn;
    y_max = max ( y_stop(1:neqn) );
    y_norm = sqrt ( sum ( y_stop(1:neqn).^2 ) );
    fprintf ( 1, '  %12f  %12f  %12f  %12f  %12f\n', ...
      t_stop, y_min, y_ave, y_max, y_norm );
  end

  return
end
