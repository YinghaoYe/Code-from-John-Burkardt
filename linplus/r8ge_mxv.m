function b = r8ge_mxv ( m, n, a, x )

%*****************************************************************************80
%
%% R8GE_MXV multiplies a R8GE matrix times a vector.
%
%  Discussion:
%
%    The R8GE storage format is used for a general M by N matrix.  A storage 
%    space is made for each logical entry.  The two dimensional logical
%    array is mapped to a vector, in which storage is by columns.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    20 March 2004
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer M, the number of rows of the matrix.
%    M must be positive.
%
%    Input, integer N, the number of columns of the matrix.
%    N must be positive.
%
%    Input, real A(M,N), the R8GE matrix.
%
%    Input, real X(N), the vector to be multiplied by A.
%
%    Output, real B(M), the product A * x.
%
  b(1:m) = a(1:m,1:n) * x(1:n)';

  return
end
