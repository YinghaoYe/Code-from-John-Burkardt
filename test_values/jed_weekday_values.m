function [ n_data, jed, weekday ] = jed_weekday_values ( n_data )

%*****************************************************************************80
%
%% JED_WEEKDAY_VALUES returns the day of the week for Julian Ephemeris Dates.
%
%  Discussion:
%
%    The JED (Julian Ephemeris Date) is a calendrical system which counts days,
%    starting from noon on 1 January 4713 BCE.
%
%    Weekdays are numbered as follows:
%
%    1  Sunday
%    2  Monday
%    3  Tuesday
%    4  Wednesday
%    5  Thursday
%    6  Friday
%    7  Saturday
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    29 September 2004
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Edward Reingold and Nachum Dershowitz,
%    Calendrical Calculations: The Millennium Edition,
%    Cambridge University Press, 2001,
%    ISBN: 0 521 77752 6
%
%  Parameters:
%
%    Input/output, integer N_DATA.  The user sets N_DATA to 0 before the
%    first call.  On each call, the routine increments N_DATA by 1, and
%    returns the corresponding data; when there is no more data, the
%    output value of N_DATA will be 0 again.
%
%    Output, real JED, the Julian Ephemeris Date.
%
%    Output, integer WEEKDAY, the day of the week.
%
  n_max = 33;

  jed_vec = [ ...
    1507231.5E+00, ...
    1660037.5E+00, ...
    1746893.5E+00, ...
    1770641.5E+00, ... 
    1892731.5E+00, ...
    1931579.5E+00, ...
    1974851.5E+00, ...
    2091164.5E+00, ...
    2121509.5E+00, ...
    2155779.5E+00, ...
    2174029.5E+00, ...
    2191584.5E+00, ...
    2195261.5E+00, ...
    2229274.5E+00, ...
    2245580.5E+00, ...
    2266100.5E+00, ...
    2288542.5E+00, ...
    2290901.5E+00, ...
    2323140.5E+00, ...
    2334848.5E+00, ...
    2348020.5E+00, ...
    2366978.5E+00, ...
    2385648.5E+00, ...
    2392825.5E+00, ...
    2416223.5E+00, ...
    2425848.5E+00, ...
    2430266.5E+00, ...
    2430833.5E+00, ...
    2431004.5E+00, ...
    2448698.5E+00, ...
    2450138.5E+00, ...
    2465737.5E+00, ...
    2486076.5E+00 ];

  weekday_vec = [ ...
    1, 4, 4, 1, 4, ...
    2, 7, 1, 1, 6, ...
    7, 6, 1, 1, 4, ...
    7, 7, 7, 4, 1, ...
    6, 1, 2, 4, 1, ...
    1, 2, 2, 5, 3, ...
    1, 4, 1 ];

  if ( n_data < 0 )
    n_data = 0;
  end

  n_data = n_data + 1;

  if ( n_max < n_data )
    n_data = 0;
    jed = 0.0;
    weekday = 0;
  else
    jed = jed_vec(n_data);
    weekday = weekday_vec(n_data);
  end

  return
end
