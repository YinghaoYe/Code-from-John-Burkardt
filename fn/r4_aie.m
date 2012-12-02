function value = r4_aie ( x )

%*****************************************************************************80
%
%% R4_AIE evaluates the exponential scaled Airy function Ai of an R4 argument.
%
%  Discussion:
%
%    If X <= 0
%      R4_AIE ( X ) = R4_AI ( X )
%    else
%      R4_AIE ( X ) = R4_AI ( X ) * exp ( 2/3 X^(3/2) )
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    25 September 2011
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
%    Output, real VALUE, the Airy function Ai of X.
%
  persistent aifcs
  persistent aigcs
  persistent aipcs
  persistent naif
  persistent naig
  persistent naip
  persistent x32sml
  persistent x3sml
  persistent xbig

  if ( isempty ( naif ) )
    aifcs = [ ...
     -0.03797135849666999750E+00, ...
      0.05919188853726363857E+00, ...
      0.00098629280577279975E+00, ...
      0.00000684884381907656E+00, ...
      0.00000002594202596219E+00, ...
      0.00000000006176612774E+00, ...
      0.00000000000010092454E+00, ...
      0.00000000000000012014E+00, ...
      0.00000000000000000010E+00 ]';
    aigcs = [ ...
      0.01815236558116127E+00, ...
      0.02157256316601076E+00, ...
      0.00025678356987483E+00, ...
      0.00000142652141197E+00, ...
      0.00000000457211492E+00, ...
      0.00000000000952517E+00, ...
      0.00000000000001392E+00, ...
      0.00000000000000001E+00 ]';
    aipcs = [ ...
     -0.0187519297793868E+00, ...
     -0.0091443848250055E+00, ...
      0.0009010457337825E+00, ...
     -0.0001394184127221E+00, ...
      0.0000273815815785E+00, ...
     -0.0000062750421119E+00, ...
      0.0000016064844184E+00, ...
     -0.0000004476392158E+00, ...
      0.0000001334635874E+00, ...
     -0.0000000420735334E+00, ...
      0.0000000139021990E+00, ...
     -0.0000000047831848E+00, ...
      0.0000000017047897E+00, ...
     -0.0000000006268389E+00, ...
      0.0000000002369824E+00, ...
     -0.0000000000918641E+00, ...
      0.0000000000364278E+00, ...
     -0.0000000000147475E+00, ...
      0.0000000000060851E+00, ...
     -0.0000000000025552E+00, ...
      0.0000000000010906E+00, ...
     -0.0000000000004725E+00, ...
      0.0000000000002076E+00, ...
     -0.0000000000000924E+00, ...
      0.0000000000000417E+00, ...
     -0.0000000000000190E+00, ...
      0.0000000000000087E+00, ...
     -0.0000000000000040E+00, ...
      0.0000000000000019E+00, ...
     -0.0000000000000009E+00, ...
      0.0000000000000004E+00, ...
     -0.0000000000000002E+00, ...
      0.0000000000000001E+00, ...
     -0.0000000000000000E+00 ]';
    eta = 0.1 * r4_mach ( 3 );
    naif = r4_inits ( aifcs, 9, eta );
    naig = r4_inits ( aigcs, 8, eta );
    naip = r4_inits ( aipcs, 34, eta );
    x3sml = eta^0.3333;
    x32sml = 1.3104 * x3sml * x3sml;
    xbig = r4_mach ( 2 )^0.6666;
  end

  if ( x < - 1.0 )
    [ xm, theta ] = r4_aimp ( x );
    value = xm * cos ( theta );
  elseif ( abs ( x ) <= x32sml )
    z = 0.0;
    value = 0.375 + ( r4_csevl ( z, aifcs, naif ) ...
      - x * ( 0.25 + r4_csevl ( z, aigcs, naig ) ) );
  elseif ( abs ( x ) <= x3sml )
    z = 0.0;
    value = 0.375 + ( r4_csevl ( z, aifcs, naif ) ...
      - x * ( 0.25 + r4_csevl ( z, aigcs, naig ) ) );
    value = value * exp ( 2.0 * x * sqrt ( x ) / 3.0 );
  elseif ( x <= 1.0 )
    z = x * x * x;
    value = 0.375 + ( r4_csevl ( z, aifcs, naif ) ...
      - x * ( 0.25 + r4_csevl ( z, aigcs, naig ) ) );
    value = value * exp ( 2.0 * x * sqrt ( x ) / 3.0 );
  elseif ( x < xbig )
    sqrtx = sqrt ( x );
    z = 2.0 / ( x * sqrtx ) - 1.0;
    value = ( 0.28125 + r4_csevl ( z, aipcs, naip ) ) / sqrt ( sqrtx );
  else
    sqrtx = sqrt ( x );
    z = - 1.0;
    value = ( 0.28125 + r4_csevl ( z, aipcs, naip ) ) / sqrt ( sqrtx );
  end

  return
end
