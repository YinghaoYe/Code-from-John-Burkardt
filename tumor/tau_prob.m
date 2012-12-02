function tauxovertau = tau_prob ( fh, fhx, ch, chx )

%% TAUPROB evaluates the derivative of TAU with respect to (X/TAU).
%
%  Modified:
%
%    10 November 2005
%
  global alpha1 
  global alpha2
  global beta1
  global beta2
  global gamma1
  global gamma2

  cprod = ( ch + alpha1 ) * ( ch + alpha2 );
  fprod = ( fh + beta1 ) * ( fh + beta2 );
  dela = alpha2 - alpha1;
  delb = beta2 - beta1;
  tauxovertau = gamma1 * dela * chx / cprod + gamma2 * fhx * delb / fprod;

  return
end
