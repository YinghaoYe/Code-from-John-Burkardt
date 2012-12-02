function [ y, yp, ypp ] = subpak_test100_f ( x )

%*****************************************************************************80
%
%% SUBPAK_TEST100_F evaluates a parabola for us.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    19 April 2009
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, real X, the argument.
%
%    Output, real Y, YP, YPP, the value, and first and second derivatives.
%
  y = 2.0 * x * x + 3.0 * x + 1.0;
  yp = 4.0 * x + 3.0;
  ypp = 4.0;

  return
end
