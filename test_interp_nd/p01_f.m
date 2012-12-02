function f = p01_f ( m, c, w, n, x )

%*****************************************************************************80
%
%% P01_F evaluates the function for problem p01.
%
%  Discussion:
%
%    f(x) = cos ( 2 * pi * w(1) + sum ( c(1:m) * x(1:m) ) )
%
%    Default values are:
%
%    c(1:m) = 1/m
%    w(1) = 0.3
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    26 August 2012
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Alan Genz,
%    A Package for Testing Multiple Integration Subroutines,
%    in Numerical Integration: Recent Developments, Software
%    and Applications,
%    edited by Patrick Keast and Graeme Fairweather,
%    Reidel, 1987, pages 337-340,
%    ISBN: 9027725144,
%    LC: QA299.3.N38.
%
%  Parameters:
%
%    Input, integer M, the spatial dimension.
%
%    Input, real C(M,1), W(M,1), the problem parameters.
%
%    Input, integer N, the number of points.
%
%    Input, real X(M,N), the evaluation points.
%
%    Output, real F(N,1), the function values.
%
  f = zeros ( n, 1 );

  f = 2.0 * pi * w(1);

  for i = 1 : m
    f = f + c(i) * x(i,:);
  end

  f = cos ( f );    

  return
end
