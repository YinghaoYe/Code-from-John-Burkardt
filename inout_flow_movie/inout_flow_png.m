function inout_flow_png ( )

%*****************************************************************************80
%
%% INOUT_FLOW_PNG creates PNG image files from flow data.
%
%  Discussion:
%
%    This MATLAB script file reads the In/Out flow data:
%
%      geometry (XY values at nodes, assumed to be in 'xy.txt') 
%      flow (UV values at nodes, in a sequence of files starting with 'up001.txt')
%
%    and plots the velocity vectors (U,V)(X,Y), and saves each plot as a
%    PNG file, presumably so the PNG files can be gathered into an
%    animation.
%
%    The file plots either the velocity vector field, or the velocity
%    direction field, depending on the value of the internal logical
%    parameter "normalized".
%
%    The MATLAB routine QUIVER will internally scale the vectors, but this
%    can be adjusted by setting SCALE to a value that is not 1.
%
%    For the unnormalized case, the velocity field is computed to a fixed
%    scale determined by finding the largest velocity vector over time.
%
%    This routine requires some auxiliary routines in order to "increment"
%    the name of the current velocity data file to get the name of the next
%    one, with the main such routine being called FILE_NAME_INC.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    05 July 2003
%
%  Author:
%
%    John Burkardt
%
  FALSE = 0;
  TRUE = 1;
  scale = 1.0;
  normalized = TRUE;

  nframes = 500;
%
%  Get the XY coordinates of the nodes.
%
  load xy.txt;

  x = xy(:,1);
  y = xy(:,2);
%
%  Thin the data.
%
  thin_factor = 2;
  thin_dex = thin_index ( x, y, thin_factor );
  thin_num = length ( thin_dex );
  x = x(thin_dex);
  y = y(thin_dex);
%
%  For unnormalized plots, you need to make sure that a fixed scale is preserved from 
%  step to step.  The only way I can see to do this requires that I determine the
%  maximum velocity over all time, and then append one extract node and velocity
%  to the data structure.
%
  if ( normalized == FALSE )

    upfile = 'up000.txt';
    vnorm_max = 0.0;

    for ( i = 1 : nframes )
      fprintf ( 1, '  Checking file %d.\n', i );
      upfile = file_name_inc ( upfile );
      uv = load ( upfile );
      u = uv(thin_dex,1);
      v = uv(thin_dex,2);
      norm = sqrt ( u.^2 + v.^2 );
      vnorm_max = max ( vnorm_max, max ( norm ) );
    end

    fprintf ( 1, '\n' );
    fprintf ( 1, '  Maximum visible velocity magnitude is %f\n', vnorm_max );

  end
%
%  Set the coordinates of the boundary lines, and an extra set of 
%  lines that will be invisible, but which make some space for the 
%  file name to be displayed within the plot area.
%
  bx1 = [ 0.00, 1.00, 1.00, 0.99, 0.99, 0.00, 0.00 ];
  by1 = [ 0.00, 0.00, 0.80, 0.80, 0.01, 0.01, 0.00 ];

  bx2 = [ 0.00, 0.00, 1.00, 1.00, 0.01, 0.01, 0.00 ];
  by2 = [ 0.20, 1.00, 1.00, 0.99, 0.99, 0.20, 0.20 ];

  bx3 = [ -0.10,  1.10, 1.10, -0.10, -0.10 ];
  by3 = [ -0.10, -0.10, 1.10,  1.10, -0.10 ];
%
%  Set the name of the 0th (nonexistent) velocity file.
%  All the velocity files with have this format, with the
%  numeric part of the name incremented to get the next one.
%  In particular, the first velocity file is called UP001.TXT.
%
  upfile = 'up000.txt';
  pngfile = 'up000.png';

  for ( i = 1 : nframes )
    
    fprintf ( 1, '  Converting file %d.\n', i );
  
    upfile = file_name_inc ( upfile );
    pngfile = file_name_inc ( pngfile );
    uv = load ( upfile );
    u = uv(thin_dex,1);
    v = uv(thin_dex,2);

    if ( normalized == TRUE )
      norm = sqrt ( u.^2 + v.^2 );
      nonzero = find ( norm ~= 0.0 );
      u(nonzero) = u(nonzero) ./ norm(nonzero);
      v(nonzero) = v(nonzero) ./ norm(nonzero);
      vnorm_max = 1.0;
    end

    x(thin_num+1) = 0.00;
    y(thin_num+1) = 1.05;
    u(thin_num+1) = vnorm_max;
    v(thin_num+1) = 0.0;

    quiver ( x,  y, u, v, scale )
%
%  Draw the boundary lines, and the invisible bounding line.
%
    line ( bx1, by1, 'color', 'r' )
    line ( bx2, by2, 'color', 'r' )
    line ( bx3, by3, 'color', 'w' )
  
    axis equal
    if ( normalized == TRUE )
      title ( 'In/Out Direction Field' )
    else
      title ( 'In/Out Flow Field' )
    end
    text ( 0.420, 1.03, upfile )
%
%  Here's where we take a snapshot of the current image, and save it to 
%  a PNG file.  Doing this was surprisingly complicated, and the help
%  system was not very clear.  Surely there's a more straightforward way!
%
    F = getframe;
    [X,map] = frame2im ( F );
    imwrite ( X, pngfile, 'PNG' );

  end

  return
end
function file_name = file_name_inc ( file_name )

%*****************************************************************************80
%
%% FILE_NAME_INC generates the next filename in a series.
%
%  Discussion:
%
%    It is assumed that the digits in the name, whether scattered or
%    connected, represent a number that is to be increased by 1 on
%    each call.  If this number is all 9's on input, the output number
%    is all 0's.  Non-numeric letters of the name are unaffected..
%
%    If the name is empty, then the routine stops.
%
%    If the name contains no digits, the empty string is returned.
%
%  Example:
%
%      Input            Output
%      -----            ------
%      'a7to11.txt'     'a7to12.txt'  (typical case.  Last digit incremented)
%      'a7to99.txt'     'a8to00.txt'  (last digit incremented, with carry.)
%      'a9to99.txt'     'a0to00.txt'  (wrap around)
%      'cat.txt'        ' '           (no digits in input name.)
%      ' '              STOP!         (error.)
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    14 September 2005
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, character FILE_NAME(*), the string to be incremented.
%
%    Output, character FILE_NAME_NEW(*), the incremented string.
%
  lens = length ( file_name );

  if ( lens <= 0 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'FILE_NAME_INC - Fatal error!\n' );
    fprintf ( 1, '  The input filename is empty.\n' );
    error ( 'FILE_NAME_INC - Fatal error!' );
  end

  change = 0;

  for i = lens : -1 : 1

    c = file_name(i);

    if ( '0' <= c & c <= '8' )

      change = change + 1;

      c = c + 1;
      
      file_name(i) = c;

      return

    elseif ( c == '9' )

      change = change + 1;

      c = '0';
      
      file_name(i) = c;

    end

  end

  if ( change == 0 )
    file_name = ' ';
  end

  return
end
function thin_dex = thin_index ( x, y, thin_factor )

%*****************************************************************************80
%
%%  THIN_INDEX determines thinning indices for a X, Y data.
%
%  Discussion:
%
%    A set of X, Y data is given, that is presumably, not too far off
%    from being on a rectangular grid.
%
%    The input value of THIN_FACTOR indicates by how much the data should
%    be thinned.
%
%    The X and Y ranges are computed, and only those data points are
%    retained for which both X and Y lie in an appropriate subrange.
%
%    For instance, a THIN_FACTOR of 2 would essentially save data
%    that lay in the black squares of a checkerboard.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    17 June
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, real X(NODE_NUM), Y(NODE_NUM), the X and Y coordinates
%    of the nodes.
%
%    Input, integer THIN_FACTOR, the thinning factor.
%
%    Output, integer THIN_DEX(NODE_NUM), contains in (1:THIN_NUM) the
%    indices into X and Y of the vectors to be retained after thinning.
%
  TRUE = 1;
  FALSE = 0;

  node_num = length ( x );

  x_unique_num = 0;

  for ( i = 1 : node_num )

    unique = TRUE;

    for ( j = 1 : x_unique_num )
      if ( x(i) == x_unique(j) )
        unique = FALSE;
        break;
      end
    end

    if ( unique )
      x_unique_num = x_unique_num + 1;
      x_unique(x_unique_num) = x(i);
    end

  end

  sort ( x_unique );

  y_unique_num = 0;

  for ( i = 1 : node_num )

    unique = TRUE;

    for ( j = 1 : y_unique_num )
      if ( y(i) == y_unique(j) )
        unique = FALSE;
        break;
      end
    end

    if ( unique )
      y_unique_num = y_unique_num + 1;
      y_unique(y_unique_num) = y(i);
    end

  end

  sort ( y_unique );

  thin_num = 0;

  for ( i = 1 : node_num )

    for ( j = 1 : x_unique_num-1 )
      if ( x_unique(j) <= x(i) & x(i) <= x_unique(j+1) )
        x_bin = j;
        break;
      end
    end

    for ( j = 1 : y_unique_num-1 )
      if ( y_unique(j) <= y(i) & y(i) <= y_unique(j+1) )
        y_bin = j;
        break;
      end
    end

    if ( mod ( y_bin, thin_factor ) == thin_factor / 2 & ...
         mod ( x_bin, thin_factor ) == thin_factor / 2 )

      thin_num = thin_num + 1;
      thin_dex(thin_num) = i;

    end

  end

  return
end
function timestamp ( )

%*****************************************************************************80
%
%% TIMESTAMP prints the current YMDHMS date as a timestamp.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    14 February 2003
%
%  Author:
%
%    John Burkardt
%
  t = now;
  c = datevec ( t );
  s = datestr ( c, 0 );
  fprintf ( 1, '%s\n', s );

  return
end
