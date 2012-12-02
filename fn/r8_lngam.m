function value = r8_lngam ( x )

%*****************************************************************************80
%
%% R8_LNGAM evaluates the log of the absolute value of gamma of an R8 argument.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    29 September 2011
%
%  Author:
%
%    Original FORTRAN77 version by Wayne Fullerton.
%    MATLAB version by John Burkardt.
%
%  Reference:
%
%    Wayne Fullerton,
%    Portable Special Function Routines,
%    in Portability of Numerical Software,
%    edited by Wayne Cowell,
%    Lecture Notes in Computer Science, Volume 57,
%    Springer 1977,
%    ISBN: 978-3-540-08446-4,
%    LC: QA297.W65.
%
%  Parameters:
%
%    Input, real X, the argument.
%
%    Output, real VALUE, the logarithm of the absolute value of
%    the gamma function of X.
%
  persistent dxrel
  persistent sq2pil
  persistent sqpi2l
  persistent xmax

  sq2pil = 0.91893853320467274178032973640562;
  sqpi2l = +0.225791352644727432363097614947441;

  if ( isempty ( xmax ) )
    xmax = r8_mach ( 2 ) / log ( r8_mach ( 2 ) );
    dxrel = sqrt ( r8_mach ( 4 ) );
  end

  y = abs ( x );

  if ( y <= 10.0 )
    value = log ( abs ( r8_gamma ( x ) ) );
    return
  end

  if ( xmax < y )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'R8_LNGAM - Fatal error!\n' );
    fprintf ( 1, '  Result overflows, |X| too big.\n' );
    error ( 'R8_LNGAM - Fatal error!' )
  end

  if ( 0.0 < x )
    value = sq2pil + ( x - 0.5 ) * log ( x ) - x + r8_lgmc ( y );
    return
  end

  sinpiy = abs ( sin ( pi * y ) )

  if ( sinpiy == 0.0 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'R8_LNGAM - Fatal error!\n' );
    fprintf ( 1, '  X is a negative integer.\n' );
    error ( 'R8_LNGAM - Fatal error!' )
  end

  value = sqpi2l + ( x - 0.5 ) * log ( y ) - x - log ( sinpiy ) ...
    - r8_lgmc ( y );

  if ( abs ( ( x - r8_aint ( x - 0.5 ) ) * r8_lngam / x ) < dxrel )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'R8_LNGAM - Warning!\n' );
    fprintf ( 1, '  Result is half precision because\n' );
    fprintf ( 1, '  X is too near a negative integer.\n' );
  end

  return
end
