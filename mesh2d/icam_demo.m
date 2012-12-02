function icam_demo ( )

%*****************************************************************************80
%
%% ICAM_DEMO demonstrates MESH2D on the first floor of the Wright House.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    27 October 2011
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'ICAM_DEMO:\n' );
  fprintf ( 1, '  Demonstrate MESH2D on the first floor of the Wright House.\n' );

  clf

  warning off

  v = [ ...
     7.25,  0.25; ... % Lower left corner of R1.
    14.75,  0.25; ...
    14.75,  7.75; ...
    13.00,  7.75; ...
    13.00,  8.25; ...
    25.00,  8.25; ...
    25.00,  7.75; ...
    15.25,  7.75; ...
    15.25,  0.25; ... % Lower left corner of R2.
    28.75,  0.25; ...
    28.75,  7.75; ...
    28.75,  8.25; ...
    29.25,  8.25; ...
    29.25,  7.75; ...
    29.25,  0.25; ... % Lower left corner of R3.
    40.75,  0.25; ...
    40.75,  7.75; ...
    33.00,  7.75; ...
    33.00,  8.25; ...
    33.25,  8.25; ... % Lower left corner of R5.
    40.75,  8.25; ...
    40.75, 17.75; ...
    33.25, 17.75; ...
    33.25, 12.00; ... 
    32.75, 12.00; ...
    32.75, 21.75; ...
    20.75, 21.75; ...
    20.75, 22.25; ...
    21.25, 22.25; ... % Lower left corner of R8.
    32.75, 22.25; ...
    32.75, 25.25; ...
    35.75, 25.25; ...
    35.75, 34.75; ...
    32.75, 34.75; ...
    32.75, 37.75; ...
    21.25, 37.75; ...
    21.25, 26.00; ...
    20.75, 26.00; ...
    20.75, 38.25; ...
    25.75, 38.25; ...
    26.25, 38.25; ... % Lower left corner of R11.
    32.75, 38.25; ...
    32.75, 45.75; ...
    26.25, 45.75; ...
    26.25, 41.75; ...
    25.75, 41.75; ...
    25.75, 46.25; ...
    26.25, 46.25; ... % Lower left corner of R15.
    32.75, 46.25; ...
    32.75, 53.75; ...
    26.25, 53.75; ...
    26.25, 49.25; ...
    25.75, 49.25; ...
    25.75, 53.75; ...
    23.75, 53.75; ...
    23.75, 62.75; ...
    23.75, 97.75; ...
    16.25, 97.25; ...
    16.25, 88.00; ...
    15.75, 88.00; ...
    15.75, 97.25; ...
     0.25, 97.25; ...
     0.25, 75.25; ... % Lower left corner of R21
    15.75, 75.25; ...
    15.75, 85.00; ...
    16.25, 85.00; ...
    16.25, 74.75; ...
     0.25, 74.75; ...
     0.25, 63.25; ... % Lower left corner of R19
    16.25, 63.25; ...       
    16.25, 62.75; ...
    16.25, 58.25; ... % Lower left corner of R18
    19.25, 58.25; ...
    19.25, 54.25; ...
    20.25, 54.25; ...
    20.25, 53.75; ...
    20.25, 50.75; ... % Lower left corner of R16.
    23.25, 50.75; ...
    23.25, 41.75; ...
    17.25, 41.75; ...
    16.75, 41.75; ...
    16.75, 53.75; ...
     7.25, 53.75; ...
     7.25, 38.25; ...
    17.25, 38.25; ... 
    17.25, 37.75; ...
     7.25, 37.75; ...
     7.25, 22.25; ...
    16.75, 22.25; ...
    16.75, 34.25; ...
    17.25, 34.25; ...
    17.25, 21.75; ...
     7.25, 21.75; ...
     7.25,  8.25; ... % Lower left corner of R4.
     9.00,  8.25; ...
     9.00,  7.75; ...
     7.25,  7.75; ...
     7.25,  0.25 ];

  hdata = [];
  hdata.hmax = 1.0;

  [ p, t ] = mesh2d ( v, [], hdata );

  [ nv, ~ ] = size ( v );
  [ np, ~ ] = size ( p );
  [ nt, ~ ] = size ( t );
  fprintf ( 1, '  %d boundary vertices input, %d nodes and %d triangles created\n', nv, np, nt );
  pause
%
%  Close the figure.
%
  close ( gcf )
%
%  Terminate.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'ICAM_DEMO:\n' );
  fprintf ( 1, '  Normal end of execution.\n' );

  return
end
function h = hfun1 ( x, y )

%*****************************************************************************80
%
%% HFUN1 is a size-function for the L-shaped region.
%
%  Discussion:
%
%    The smallest size is at (1.0,1.0), and sizes increase as their distance
%    from that point increases.
%
  h = 0.5

  return
end
