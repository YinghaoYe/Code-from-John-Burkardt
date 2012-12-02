function [ o, x, w ] = epn_glg_02_xiu ( n, alpha )

%*****************************************************************************80
%
%% EPN_GLG_02_XIU implements the Xiu rule for region EPN_GLG.
%
%  Discussion:
%
%    The rule has order
%
%      O = N + 1.
%
%    The rule has precision P = 2.
%
%    EPN_GLG is the N-dimensional positive space [0,+oo)^N with generalized
%    Laguerre weight function:
%
%      w(alpha;x) = product ( 1 <= i <= n ) x(i)^alpha exp ( - x(i) )
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    07 March 2010
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Dongbin Xiu,
%    Numerical integration formulas of degree two,
%    Applied Numerical Mathematics,
%    Volume 58, 2008, pages 1515-1520.
%
%  Parameters:
%
%    Input, integer N, the spatial dimension.
%
%    Input, real ALPHA, the exponent of X in the weight function.
%    -1.0 < ALPHA.
%
%    Input, integer O, the order.
%
%    Output, real X(N,O), the abscissas.
%
%    Output, real W(O), the weights.
%
  if ( alpha <= -1.0 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'EPN_GLG_02_XIU - Fatal error!\n' );
    fprintf ( 1, '  ALPHA <= -1.0\n' );
    error ( 'EPN_GLG_02_XIU - Fatal error!' );
  end

  o = n + 1;

  x = zeros ( n, o );
  w = zeros ( o, 1 );

  for j = 1 : o

    i = 0;
    for r = 1 : floor ( n / 2 )
      arg = 2 * r * ( j - 1 ) * pi / ( n + 1 );
      i = i + 1;
      x(i,j) = sqrt ( 2.0 ) * cos ( arg );
      i = i + 1;
      x(i,j) = sqrt ( 2.0 ) * sin ( arg );
    end

    if ( i < n )
      i = i + 1;
      x(i,j) = r8_mop ( j - 1 );
    end

  end

  gamma0 = - 1.0;
  delta0 = alpha + 1.0;
  c1 = - alpha - 1.0;

  x(1:n,1:o) = ( sqrt ( gamma0 * c1 ) * x(1:n,1:o) - delta0 ) / gamma0;

  expon = 0;
  volume_1d = ep1_glg_monomial_integral ( expon, alpha );
  volume = volume_1d ^ n;

  w(1:o) = volume / o;

  return
end
