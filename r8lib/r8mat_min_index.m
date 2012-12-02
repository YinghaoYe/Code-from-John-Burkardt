function [ i, j ] = r8mat_min_index ( m, n, a )

%*****************************************************************************80
%
%% R8MAT_MIN_INDEX returns the location of the minimum entry of an R8MAT.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    28 October 2005
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer M, the number of rows in A.
%
%    Input, integer N, the number of columns in A.
%
%    Input, real A(M,N), the M by N matrix.
%
%    Output, integer I, J, the indices of the minimum entry of A.
%
  i = -1;
  j = -1;

  for jj = 1 : n
    for ii = 1 : m
      if ( ii == 1 && jj == 1 )
        i = ii;
        j = jj;
      elseif ( a(ii,jj) < a(i,j) )
        i = ii;
        j = jj;
      end
    end
  end

  return
end
