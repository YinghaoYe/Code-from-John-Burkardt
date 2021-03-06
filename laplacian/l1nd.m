function l = l1nd ( n, h )

%*****************************************************************************80
%
%% L1ND stores the 1D ND Laplacian as a full matrix.
%
%  Discussion:
%
%    The N grid points are assumed to be evenly spaced by H.
%
%    For N = 5, the discrete Laplacian with left Neumann and right Dirichlet
%    boundary conditions on [0,6] has the matrix form L:
%
%       1 -1  0  0  0
%      -1  2 -1  0  0
%       0 -1  2 -1  0
%       0  0 -1  2 -1
%       0  0  0 -1  2
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    29 October 2013
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer N, the number of points.
%    N must be at least 3.
%
%    Input, real H, the spacing between points.
%
%    Output, real L(N,N), the Laplacian matrix.
%
  if ( n < 3 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'L1ND - Fatal error!\n' );
    fprintf ( 1, '  N < 3.\n' );
    error ( 'L1ND - Fatal error!' );
  end

  l = zeros ( n, n );

  i = 1;
  l(1,1) =  1.0 / h / h;
  l(1,2) = -1.0 / h / h;

  for i = 2 : n - 1
    l(i,i-1) = -1.0 / h / h;
    l(i,i) =    2.0 / h / h;
    l(i,i+1) = -1.0 / h / h;
  end

  i = n;
  l(n,n-1) = -1.0 / h / h;
  l(n,n) =    2.0 / h / h;

  return
end
