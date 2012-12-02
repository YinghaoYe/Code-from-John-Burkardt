function [ y, m ] = month_carry_gregorian ( y, m )

%*****************************************************************************80
%
%% MONTH_CARRY_GREGORIAN carries a year of months on the Gregorian calendar.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    08 December 2008
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer Y, integer M, the year and month.
%
%    Output, integer Y, integer M, the year and month.
%    On output, M is no greater than 12.
%
  while ( 1 )

    months = year_length_months_gregorian ( y );

    if ( m <= months )
      break
    end

    m = m - months;
    y = y + 1;

  end

  return
end
