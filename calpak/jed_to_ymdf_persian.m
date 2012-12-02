function [ y, m, d, f ] = jed_to_ymdf_persian ( jed )

%*****************************************************************************80
%
%% JED_TO_YMDF_PERSIAN converts a JED to a Persian YMDF date.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    14 July 2012
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Edward Richards,
%    Algorithm F,
%    Mapping Time, The Calendar and Its History,
%    Oxford, 1999, pages 324-325.
%
%  Parameters:
%
%    Input, real JED, the Julian Ephemeris Date.
%
%    Output, integer Y, M, D, real F, the YMDF date.
%

%
%  Determine the computational date (Y'/M'/D').
%
  j = floor ( jed + 0.5 );
  f = ( jed + 0.5 ) - j;

  j_prime = j + 77;

  y_prime = floor ( j_prime / 365 );
  t_prime = mod ( j_prime, 365 );
  m_prime = floor ( t_prime / 30 );
  d_prime = mod ( t_prime, 30 );
%
%  Convert the computational date to a calendar date.
%
  d = d_prime + 1;
  m = mod ( m_prime + 9, 13 ) + 1;
  y = y_prime - 5348 + floor ( ( 22 - m ) / 13 );

  return
end
