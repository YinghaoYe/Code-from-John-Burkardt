function [ n_data, x, fx ] = tran07_values ( n_data )

%*****************************************************************************80
%
%% TRAN07_VALUES returns some values of the order 7 transportation function.
%
%  Discussion:
%
%    The function is defined by:
%
%      TRAN07(x) = Integral ( 0 <= t <= x ) t^7 * exp(t) / ( exp(t) - 1 )^2 dt
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
%    Milton Abramowitz and Irene Stegun,
%    Handbook of Mathematical Functions,
%    US Department of Commerce, 1964.
%
%    Allan McLeod,
%    Algorithm 757, MISCFUN: A software package to compute uncommon
%      special functions,
%    ACM Transactions on Mathematical Software,
%    Volume 22, Number 3, September 1996, pages 288-301.
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
%    Output, real X, the argument of the function.
%
%    Output, real FX, the value of the function.
%
  n_max = 20;

  fx_vec = [ ...
     0.92518563327283409427E-17, ...
     0.15521095556949867541E-09, ...
     0.63516238373841716290E-06, ...
     0.25638801246626135714E-02, ...
     0.15665328993811649746E+00, ...
     0.16538225039181097423E+01, ...
     0.83763085709508211054E+01, ...
     0.28078570717830763747E+02, ...
     0.72009676046751991365E+02, ...
     0.28174905701691911450E+03, ...
     0.36660227975327792529E+03, ...
     0.70556067982603601123E+03, ...
     0.99661927562755629434E+03, ...
     0.13288914430417403901E+04, ...
     0.27987640273169129925E+04, ...
     0.39721376409416504325E+04, ...
     0.49913492839319899726E+04, ...
     0.50781562639825019000E+04, ...
     0.50820777202028708434E+04, ...
     0.50820803580047164618E+04 ];

  x_vec = [ ...
       0.0019531250E+00, ...
       0.0312500000E+00, ...
       0.1250000000E+00, ...
       0.5000000000E+00, ...
       1.0000000000E+00, ...
       1.5000000000E+00, ...
       2.0000000000E+00, ...
       2.5000000000E+00, ...
       3.0000000000E+00, ...
       4.0000000000E+00, ...
       4.2500000000E+00, ...
       5.0000000000E+00, ...
       5.5000000000E+00, ...
       6.0000000000E+00, ...
       8.0000000000E+00, ...
      10.0000000000E+00, ...
      15.0000000000E+00, ...
      20.0000000000E+00, ...
      30.0000000000E+00, ...
      50.0000000000E+00 ];

  if ( n_data < 0 )
    n_data = 0;
  end

  n_data = n_data + 1;

  if ( n_max < n_data )
    n_data = 0;
    x = 0.0;
    fx = 0.0;
  else
    x = x_vec(n_data);
    fx = fx_vec(n_data);
  end

  return
end
