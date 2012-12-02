function value = year_is_leap_english ( y )

%*****************************************************************************80
%
%% YEAR_IS_LEAP_ENGLISH returns TRUE if the English year was a leap year.
%
%  Algorithm:
%
%    If ( the year is less than 0 ) then
%
%      if the year+1 is divisible by 4 then
%        the year is a leap year.
%
%    else if ( the year is 0 ) then
%
%      the year is not a leap year ( in fact, it's illegal )
%
%    else if ( the year is no greater than 1752 ) then
%
%      if the year is divisible by 4 then
%        the year is a leap year.
%
%    else if (
%      the year is divisible by 4 and
%      ( the year is not divisible by 100
%      or
%      the year is divisible by 400 )
%      ) then
%        the year is a leap year.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    23 September 2012
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer Y, the year to be checked.
%
%    Output, logical VALUE, TRUE if the year was a leap year,
%    FALSE otherwise.
%
  if ( y == 0 )
    value = 0;
    return
  end
%
%  BC years have to have 1 added to them to make a proper leap year evaluation.
%
  y2 = y_common_to_astronomical ( y );

  if ( y2 <= 1752 )

    if ( i4_modp ( y2, 4 ) == 0 )
      value = 1;
    else
      value = 0;
    end

  else

    if ( i4_modp ( y2, 400 ) == 0 )
      value = 1;
    elseif ( i4_modp ( y2, 100 ) == 0 )
      value = 0;
    elseif ( i4_modp ( y2, 4 ) == 0 )
      value = 1;
    else
      value = 0;
    end

  end

  return
end
