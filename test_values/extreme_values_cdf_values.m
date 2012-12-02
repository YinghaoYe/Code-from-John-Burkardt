function [ n_data, alpha, beta, x, fx ] = extreme_values_cdf_values ( n_data )

%*****************************************************************************80
%
%% EXTREME_VALUES_CDF_VALUES returns some values of the Extreme Values CDF.
%
%  Discussion:
%
%    In Mathematica, the function can be evaluated by:
%
%      Needs["Statistics`ContinuousDistributions`"]
%      dist = ExtremeValuesDistribution [ alpha, beta ]
%      CDF [ dist, x ]
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    16 September 2004
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
%    Output, real ALPHA, the first parameter of the distribution.
%
%    Output, real BETA, the second parameter of the distribution.
%
%    Output, real X, the argument of the function.
%
%    Output, real FX, the value of the function.
%
  n_max = 12;

  alpha_vec = [ ...
     0.1000000000000000E+01, ...  
     0.1000000000000000E+01, ...  
     0.1000000000000000E+01, ...  
     0.1000000000000000E+01, ...  
     0.1000000000000000E+01, ...  
     0.1000000000000000E+01, ...  
     0.1000000000000000E+01, ...  
     0.1000000000000000E+01, ...  
     0.2000000000000000E+01, ...  
     0.3000000000000000E+01, ...  
     0.4000000000000000E+01, ...  
     0.5000000000000000E+01 ];

  beta_vec = [ ...
     0.5000000000000000E+00, ...  
     0.5000000000000000E+00, ...
     0.5000000000000000E+00, ...
     0.5000000000000000E+00, ...
     0.2000000000000000E+01, ...
     0.3000000000000000E+01, ...
     0.4000000000000000E+01, ...
     0.5000000000000000E+01, ...
     0.2000000000000000E+01, ...
     0.2000000000000000E+01, ...
     0.2000000000000000E+01, ...
     0.2000000000000000E+01 ];

  fx_vec = [ ...
     0.3678794411714423E+00, ...
     0.8734230184931166E+00, ...
     0.9818510730616665E+00, ...
     0.9975243173927525E+00, ...
     0.5452392118926051E+00, ...
     0.4884435800065159E+00, ...
     0.4589560693076638E+00, ...
     0.4409910259429826E+00, ...
     0.5452392118926051E+00, ...
     0.3678794411714423E+00, ...
     0.1922956455479649E+00, ...
     0.6598803584531254E-01 ];

  x_vec = [ ...
     0.1000000000000000E+01, ...  
     0.2000000000000000E+01, ...  
     0.3000000000000000E+01, ...  
     0.4000000000000000E+01, ...  
     0.2000000000000000E+01, ...  
     0.2000000000000000E+01, ...  
     0.2000000000000000E+01, ...  
     0.2000000000000000E+01, ...  
     0.3000000000000000E+01, ...  
     0.3000000000000000E+01, ...  
     0.3000000000000000E+01, ...  
     0.3000000000000000E+01 ];

  if ( n_data < 0 )
    n_data = 0;
  end

  n_data = n_data + 1;

  if ( n_max < n_data )
    n_data = 0;
    alpha = 0.0;
    beta = 0.0;
    x = 0.0;
    fx = 0.0;
  else
    alpha = alpha_vec(n_data);
    beta = beta_vec(n_data);
    x = x_vec(n_data);
    fx = fx_vec(n_data);
  end

  return
end
