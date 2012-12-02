function [ n_data, jed, y, m, d, f ] = jed_ce_values ( n_data )

%*****************************************************************************80
%
%% JED_CE_VALUES returns the Common Era dates for Julian Ephemeris Dates.
%
%  Discussion:
%
%    The JED (Julian Ephemeris Date) is a calendrical system which counts days,
%    starting from noon on 1 January 4713 BCE.
%
%    The CE or Common Era is the day, month and year under the
%    hybrid Julian/Gregorian Calendar, with a transition from Julian
%    to Gregorian.  The day after 04 October 1582 was 15 October 1582.
%
%    The year before 1 AD or CE is 1 BC or BCE.  In this data set,
%    years BC/BCE are indicated by a negative year value.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    04 May 2006
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
%    Output, integer Y, M, D, the Common Era date.
%
%    Output, real F, the fractional part of the day.
%
  n_max = 51;

  d_vec = [ ...
    01, ...
    02, ...
    26, ...
    08, ...
    06, ...
    18, ...
    08, ...
    09, ...
    01, ...
    26, ...
    26, ...
    01, ...
    01, ...
    29, ...
    31, ...
    01, ...
    03, ...
    03, ...
    29, ...
    24, ...
    24, ...
    29, ...
    03, ...
    11, ...
    12, ...
    24, ...
    19, ...
    15, ...
    16, ...
    16, ...
    21, ...
    17, ...
    09, ...
    04, ...
    15, ...
    04, ...
    13, ...
    14, ...
    18, ...
    22, ...
    21, ...
    24, ...
    17, ...
    31, ...
    01, ...
    06, ...
    25, ...
    01, ...
    09, ...
    23, ...
    01 ];
  f_vec = [ ...
    0.50, ...
    0.50, ...
    0.50, ...
    0.00, ...
    0.00, ...
    0.25, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.50, ...
    0.50, ...
    0.00, ...
    0.50, ...
    0.50, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.81, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.00, ...
    0.33, ...
    0.00, ...
    0.50 ];
  jed_vec = [ ...
           0.00, ...
           1.00, ...
      259261.00, ...
      347998.50, ...
      584282.50, ...
      588465.75, ...
      758325.50, ...
     1438178.50, ...
     1446389.50, ...
     1448637.50, ...
     1448637.50, ...
     1607708.50, ...
     1607738.50, ...
     1713262.50, ...
     1721422.50, ...
     1721423.50, ...
     1721425.50, ...
     1721425.50, ...
     1724220.50, ...
     1741959.50, ...
     1749994.50, ...
     1825029.50, ...
     1862836.50, ...
     1922867.50, ...
     1936747.50, ...
     1940351.50, ...
     1948320.50, ...
     1948438.50, ...
     1948439.50, ...
     1952062.50, ...
     1952067.50, ...
     2114872.50, ...
     2289425.50, ...
     2299160.00, ...
     2299161.00, ...
     2333269.50, ...
     2361221.00, ...
     2361222.00, ...
     2372547.50, ...
     2375839.50, ...
     2394646.50, ...
     2394710.50, ...
     2400000.50, ...
     2415020.31, ...
     2440587.50, ...
     2444244.50, ...
     2450138.50, ...
     2451544.50, ...
     2453073.83, ...
     2456284.50, ...
     2913943.00 ];
  m_vec = [ ...
     01, ...
     01, ...
     10, ...
     10, ...
     09, ...
     02, ...
     03, ...
     07, ...
     01, ...
     02, ...
     02, ...
     09, ...
     10, ...
     08, ...
     12, ...
     01, ...
     01, ...
     01, ...
     08, ...
     03, ...
     03, ...
     08, ...
     03, ...
     07, ...
     07, ...
     05, ...
     03, ...
     07, ...
     07, ...
     06, ...
     06, ...
     03, ...
     02, ...
     10, ...
     10, ...
     03, ...
     09, ...
     09, ...
     09, ...
     09, ...
     03, ...
     05, ...
     11, ...
     12, ...
     01, ...
     01, ...
     02, ...
     01, ...
     03, ...
     12, ...
     01 ];
  y_vec = [ ...
    -4713, ...
    -4713, ...
    -4004, ...
    -3761, ...
    -3114, ...
    -3102, ...
    -2637, ...
     -776, ...
     -753, ...
     -747, ...
     -747, ...
     -312, ...
     -312, ...
      -23, ...
       -1, ...
        1, ...
        1, ...
        1, ...
        8, ...
       57, ...
       79, ...
      284, ...
      388, ...
      552, ...
      590, ...
      600, ...
      622, ...
      622, ...
      622, ...
      632, ...
      632, ...
     1078, ...
     1556, ...
     1582, ...
     1582, ...
     1676, ...
     1752, ...
     1752, ...
     1783, ...
     1792, ...
     1844, ...
     1844, ...
     1858, ...
     1899, ...
     1970, ...
     1980, ...
     1996, ...
     2000, ...
     2004, ...
     2012, ...
     3266 ];

  if ( n_data < 0 )
    n_data = 0;
  end

  n_data = n_data + 1;

  if ( n_max < n_data )
    n_data = 0;
    jed = 0.0;
    y = 0;
    m = 0;
    d = 0;
    f = 0.0;
  else
    jed = jed_vec(n_data);
    y = y_vec(n_data);
    m = m_vec(n_data);
    d = d_vec(n_data);
    f = f_vec(n_data);
  end

  return
end
