function [ n_data, a, b, n, fx ] = sin_power_int_values ( n_data )

%*****************************************************************************80
%
%% SIN_POWER_INT_VALUES returns some values of the sine power integral.
%
%  Discussion:
%
%    The function has the form
%
%      SIN_POWER_INT(A,B,N) = Integral ( A <= T <= B ) ( sin(T) )^N dt
%
%    In Mathematica, the function can be evaluated by:
%
%      Integrate [ ( Sin[x] )^n, { x, a, b } ]
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    19 September 2004
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Stephen Wolfram,
%    The Mathematica Book,
%    Fourth Edition,
%    Wolfram Media / Cambridge University Press, 1999.
%
%  Parameters:
%
%    Input/output, integer N_DATA.  The user sets N_DATA to 0 before the
%    first call.  On each call, the routine increments N_DATA by 1, and
%    returns the corresponding data; when there is no more data, the
%    output value of N_DATA will be 0 again.
%
%    Output, real A, B, the limits of integration.
%
%    Output, integer N, the power.
%
%    Output, real FX, the value of the function.
%
  n_max = 10;

  a_vec = [ ...
      0.10E+02, ...
      0.00E+00, ...
      0.00E+00, ...
      0.00E+00, ...
      0.00E+00, ...
      0.00E+00, ...
      0.00E+00, ...
      0.10E+01, ...
      0.00E+00, ...
      0.00E+00 ];

  b_vec = [ ...
      0.20E+02, ...
      0.10E+01, ...
      0.10E+01, ...
      0.10E+01, ...
      0.10E+01, ...
      0.10E+01, ...
      0.20E+01, ...
      0.20E+01, ...
      0.10E+01, ...
      0.10E+01 ];

  fx_vec = [ ...
     0.10000000000000000000E+02, ...
     0.45969769413186028260E+00, ...
     0.27267564329357957615E+00, ...
     0.17894056254885809051E+00, ...
     0.12402556531520681830E+00, ...
     0.88974396451575946519E-01, ...
     0.90393123848149944133E+00, ...
     0.81495684202992349481E+00, ...
     0.21887522421729849008E-01, ...
     0.17023439374069324596E-01 ];

  n_vec = [ ...
     0, ...
     1, ...
     2, ...
     3, ...
     4, ...
     5, ...
     5, ...
     5, ...
    10, ...
    11 ];

  if ( n_data < 0 )
    n_data = 0;
  end

  n_data = n_data + 1;

  if ( n_max < n_data )
    n_data = 0;
    a = 0.0;
    b = 0.0;
    n = 0;
    fx = 0.0;
  else
    a = a_vec(n_data);
    b = b_vec(n_data);
    n = n_vec(n_data);
    fx = fx_vec(n_data);
  end

  return
end
