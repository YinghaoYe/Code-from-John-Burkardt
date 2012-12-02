function [ n, x, indx ] = i4vec_index_insert_unique ( n, x, indx, xval )

%*****************************************************************************80
%
%% I4VEC_INDEX_INSERT_UNIQUE inserts a unique value in an indexed sorted I4VEC.
%
%  Discussion:
%
%    If the value does not occur in the list, it is included in the list,
%    and N, X and INDX are updated.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    04 November 2000
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer N, the size of the current list.
%
%    Input, integer X(N), the list.
%
%    Input, integer INDX(N), the sort index of the list.
%
%    Input, integer XVAL, the value to be sought.
%
%    Output, integer N, the size of the current list.
%
%    Output, integer X(N), the list.
%
%    Output, integer INDX(N), the sort index of the list.
%
  if ( n <= 0 )
    n = 1;
    x = [ xval ];
    indx = [ 1 ];
    return
  end
%
%  Does XVAL already occur in X?
%
  [ less, equal, more ] = i4vec_index_search ( n, x, indx, xval );

  if ( equal == 0 )
    x(n+1) = xval;
    indx(n+1:-1:more+1) = indx(n:-1:more);
    indx(more) = n + 1;
    n = n + 1;
  end

  return
end
