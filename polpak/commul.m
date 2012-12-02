function ncomb = commul ( iarray, n, nfact )

%*****************************************************************************80
%
%% COMMUL computes a multinomial combinatorial coefficient.
%
%  Discussion:
%
%    The multinomial coefficient is a generalization of the binomial
%    coefficient.  It may be interpreted as the number of combinations of
%    N objects, where IARRAY(1) objects are indistinguishable of type 1,
%    ... and IARRAY(K) are indistinguishable of type NFACT.
%
%    The formula is
%
%      NCOMB = N! / ( IARRAY(1)! IARRAY(2)! ... IARRAY(NFACT)! )
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    23 July 2004
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer IARRAY(NFACT).
%    IARRAY contains the NFACT values used in the denominator.
%    Note that the sum of these entries should be N,
%    and that all entries should be nonnegative.
%
%    Input, integer N, determines the numerator.
%
%    Input, integer NFACT, the number of factors in the numerator.
%
%    Output, integer NCOMB, the value of the multinomial coefficient.
%
  for i = 1 : nfact

    if ( iarray(i) < 0 )
      fprintf ( 1, '\n' );
      fprintf ( 1, 'COMMUL - Fatal error!\n' );
      fprintf ( 1, '  Entry %d of IARRAY = %d\n', i, iarray(i) );
      fprintf ( 1, '  But this value must be nonnegative.\n' );
      error ( 'COMMUL - Fatal error!' );
    end

  end
 
  isum = sum ( iarray(1:nfact) );

  if ( isum ~= n )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'COMMUL - Fatal error!\n' );
    fprintf ( 1, '  The sum of the IARRAY entries is %d\n', isum );
    fprintf ( 1, '  But it must equal N = %d\n', n );
    error ( 'COMMUL - Fatal error!' );
  end
 
  facn = gammaln ( n + 1 );
 
  for i = 1 : nfact
 
    fack = gammaln ( iarray(i) + 1 );
    facn = facn - fack;
 
  end
 
  ncomb = exp ( facn ) );
 
  return
end
