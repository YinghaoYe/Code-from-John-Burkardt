function rank = perm_lex_rank ( n, p )

%*****************************************************************************80
%
%% PERM_LEX_RANK computes the lexicographic rank of a permutation.
%
%  Discussion:
%
%    The original code altered the input permutation.  
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    15 June 2012
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
%    Input, integer N, the number of values being permuted.
%    N must be positive.
%
%    Input, integer P(N), describes the permutation.
%    P(I) is the item which is permuted into the I-th place
%    by the permutation.
%
%    Output, integer RANK, the rank of the permutation.
%

%
%  Check.
%
  perm_check ( n, p );

  rank = 0;

  for j = 1 : n

    rank = rank + ( p(j) - 1 ) * i4_factorial ( n - j );

    for i = j + 1 : n
      if ( p(j) < p(i) )
        p(i) = p(i) - 1;
      end
    end

  end

  return
end
