function c = correlation_damped_cosine ( n, rho, rho0 )

%*****************************************************************************80
%
%% CORRELATION_DAMPED_COSINE evaluates the damped cosine correlation function.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    22 March 2012
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Petter Abrahamsen,
%    A Review of Gaussian Random Fields and Correlation Functions,
%    Norwegian Computing Center, 1997.
%
%  Parameters:
%
%    Input, integer N, the number of arguments.
%
%    Input, real RHO(N,1), the arguments.
%
%    Input, real RHO0, the correlation length.
%
%    Output, real C(N,1), the correlations.
%
  rho = rho ( : );

  rhohat = abs ( rho ) / rho0;

  c = exp ( - rhohat ) .* cos ( rhohat );

  return
end


  
