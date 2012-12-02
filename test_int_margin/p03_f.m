function f = p03_f ( n, x )

%*****************************************************************************80
%
%% P03_F returns the integrand for problem 3.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    14 January 2012
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer N, the number of variables.
%
%    Input, real X(N), the arguments.
%
%    Output, real F(N), the values of the integrand.
%
  f = 2.0 * exp ( - ( ( x - 0.25 ) / 0.05 ).^2 );

  return
end
