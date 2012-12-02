function title = p00_title ( problem )

%*****************************************************************************80
%
%% P00_TITLE returns a title for a problem specified by index.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    15 February 2012
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer PROBLEM, the problem index.
%
%    Output, string TITLE, a title for the problem.
%
  if ( problem == 1 )
    title = p01_title ( );
  elseif ( problem == 2 )
    title = p02_title ( );
  elseif ( problem == 3 )
    title = p03_title ( );
  elseif ( problem == 4 )
    title = p04_title ( );
  elseif ( problem == 5 )
    title = p05_title ( );
  elseif ( problem == 6 )
    title = p06_title ( );
  elseif ( problem == 7 )
    title = p07_title ( );
  elseif ( problem == 8 )
    title = p08_title ( );
  else
    fprintf ( 1, '\n' );
    fprintf ( 1, 'P00_TITLE - Fatal error!\n' );
    fprintf ( 1, '  Problem index out of bounds.\n' );
    error ( 'P00_TITLE - Fatal error!' );
  end

  return
end
