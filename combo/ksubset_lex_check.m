function ierror = ksubset_lex_check ( k, n, t )

%*****************************************************************************80
%
%% KSUBSET_LEX_CHECK checks a K subset in lex form.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    24 January 2011
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Donald Kreher, Douglas Simpson,
%    Combinatorial Algorithms,
%    CRC Press, 1998,
%    ISBN: 0-8493-3988-X,
%    LC: QA164.K73.
%
%  Parameters:
%
%    Input, integer K, the number of elements each K subset must
%    have. 1 <= K <= N.
%
%    Input, integer N, the number of elements in the master set.
%    N must be positive.
%
%    Input, integer T(K), describes a K subset.  T(I) is the I-th
%    element of the K subset.  The elements must be listed in
%    DESCENDING order.
%
%    Output, integer IERROR, error flag.
%    0, no error.
%    -1, N is illegal.
%    -2, K is illegal.
%    I, entry I is illegal.
%
  ierror = 0;

  if ( n < 1 )
    ierror = -1;
    return
  end

  if ( k < 1 || n < k )
    ierror = -2;
    return
  end

  tmin = 0;

  for i = 1 : k

    if ( t(i) <= tmin || n < t(i) )
      ierror = i;
      return
    end

    tmin = t(i);

  end

  return
end
