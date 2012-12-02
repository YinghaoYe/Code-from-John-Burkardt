function a = i4row_sort_d ( m, n, a )

%*****************************************************************************80
%
%% I4ROW_SORT_D descending sorts the rows of an I4ROW.
%
%  Discussion:
%
%    In lexicographic order, the statement "X < Y", applied to two real
%    vectors X and Y of length M, means that there is some index I, with
%    1 <= I <= M, with the property that
%
%      X(J) = Y(J) for J < I,
%    and
%      X(I) < Y(I).
%
%    In other words, the first time they differ, X is smaller.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    05 June 2005
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer M, the number of rows and columns of A.
%
%    Input, integer A(M,N), the array of M rows of N-vectors.
%
%    Output, integer A(M,N), the rows of A have been sorted in descending
%    lexicographic order.
%
  if ( m <= 1 )
    return
  end

  if ( n <= 0 )
    return
  end
%
%  Initialize.
%
  i = 0;
  indx = 0;
  isgn = 0;
  j = 0;
%
%  Call the external heap sorter.
%
  while ( 1 )

    [ indx, i, j ] = sort_heap_external ( m, indx, isgn );
%
%  Interchange the I and J objects.
%
    if ( 0 < indx )

      a = i4row_swap ( m, n, a, i, j );
%
%  Compare the I and J objects.
%
    elseif ( indx < 0 )

      isgn = -i4row_compare ( m, n, a, i, j );

    elseif ( indx == 0 )

      break

    end

  end

  return
end
