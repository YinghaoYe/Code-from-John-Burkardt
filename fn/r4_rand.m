function value = r4_rand ( r )

%*****************************************************************************80
%
%% R4_RAND is a portable pseudorandom number generator.
%
%  Discussion:
%
%    This pseudo-random number generator is portable amoung a wide
%    variety of computers.  It is undoubtedly not as good as many
%    readily available installation dependent versions, and so this
%    routine is not recommended for widespread usage.  Its redeeming
%    feature is that the exact same random numbers (to within final round-
%    off error) can be generated from machine to machine.  Thus, programs
%    that make use of random numbers can be easily transported to and
%    checked in a new environment.
%
%    The random numbers are generated by the linear congruential
%    method described by Knuth in seminumerical methods (p.9),
%    addison-wesley, 1969.  Given the i-th number of a pseudo-random
%    sequence, the i+1 -st number is generated from
%      x(i+1) = (a*x(i) + c) mod m,
%    where here m = 2**22 = 4194304, c = 1731 and several suitable values
%    of the multiplier a are discussed below.  Both the multiplier a and
%    random number x are represented in real as two 11-bit
%    words.  The constants are chosen so that the period is the maximum
%    possible, 4194304.
%
%    In order that the same numbers be generated from machine to
%    machine, it is necessary that 23-bit integers be reducible modulo
%    2**11 exactly, that 23-bit integers be added exactly, and that 11-bit
%    integers be multiplied exactly.  Furthermore, if the restart option
%    is used (where r is between 0 and 1), then the product r*2**22 =
%    r*4194304 must be correct to the nearest integer.
%
%    The first four random numbers should be
%
%      0.0004127026,
%      0.6750836372,
%      0.1614754200,
%      0.9086198807.
%
%    The tenth random number is
%
%      0.5527787209.
%
%    The hundredth random number is
%
%      0.3600893021.
%
%    The thousandth number should be
%
%      0.2176990509.
%
%    In order to generate several effectively independent sequences
%    with the same generator, it is necessary to know the random number
%    for several widely spaced calls.  The I-th random number times 2**22,
%    where I=K*P/8 and P is the period of the sequence (P = 2**22), is
%    still of the form L*P/8.  In particular we find the I-th random
%    number multiplied by 2**22 is given by
%      I   =  0  1*p/8  2*p/8  3*p/8  4*p/8  5*p/8  6*p/8  7*p/8  8*p/8
%      RAND=  0  5*p/8  2*p/8  7*p/8  4*p/8  1*p/8  6*p/8  3*p/8  0
%    thus the 4*P/8 = 2097152 random number is 2097152/2**22.
%
%    Several multipliers have been subjected to the spectral test
%    (see Knuth, p. 82).  Four suitable multipliers roughly in order of
%    goodness according to the spectral test are
%      3146757 = 1536*2048 + 1029 = 2**21 + 2**20 + 2**10 + 5
%      2098181 = 1024*2048 + 1029 = 2**21 + 2**10 + 5
%      3146245 = 1536*2048 +  517 = 2**21 + 2**20 + 2**9 + 5
%      2776669 = 1355*2048 + 1629 = 5**9 + 7**7 + 1
%
%    In the table below log10(NU(I)) gives roughly the number of
%    random decimal digits in the random numbers considered I at a time.
%    C is the primary measure of goodness.  In both cases bigger is better.
%
%                     log10 nu(i)              c(i)
%         a       i=2  i=3  i=4  i=5    i=2  i=3  i=4  i=5
%
%      3146757    3.3  2.0  1.6  1.3    3.1  1.3  4.6  2.6
%      2098181    3.3  2.0  1.6  1.2    3.2  1.3  4.6  1.7
%      3146245    3.3  2.2  1.5  1.1    3.2  4.2  1.1  0.4
%      2776669    3.3  2.1  1.6  1.3    2.5  2.0  1.9  2.6
%     best
%      possible   3.3  2.3  1.7  1.4    3.6  5.9  9.7  14.9
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    02 October 2011
%
%  Author:
%
%    MATLAB version by John Burkardt.
%
%  Parameters:
%
%    Input, real R, determines the action.
%    * R = 0.0, the next random number of the sequence is generated.
%    * R < 0.0, the last generated number will be returned for
%    possible use in a restart procedure.
%    * R > 0.0, the sequence of random numbers will start with the
%    seed ( R mod 1 ).  This seed is also returned as the value of
%    R4_RAND provided the arithmetic is done exactly.
%
%    Output, real VALUE, a pseudo-random number between
%    0.0 and 1.0.
%
  persistent ia0
  persistent ia1
  persistent ia1ma0
  persistent ic
  persistent ix0
  persistent ix1

  if ( isempty ( ia0 ) )
    ia0 = 1029;
    ia1 = 1536;
    ia1ma0 = 507;
    ic = 1731;
    ix0 = 0;
    ix1 = 0;
  end

  if ( r == 0.0 )
    iy0 = ia0 * ix0;
    iy1 = ia1 * ix1 + ia1ma0 * ( ix0 - ix1 ) + iy0;
    iy0 = iy0 + ic;
    ix0 = mod ( iy0, 2048 );
    iy1 = iy1 + ( iy0 - ix0 ) / 2048;
    ix1 = mod ( iy1, 2048 );
  end

  if ( 0.0 < r )
    ix1 = r4_aint ( mod ( r, 1.0 ) * 4194304.0 + 0.5 );
    ix0 = mod ( ix1, 2048 );
    ix1 = ( ix1 - ix0 ) / 2048;
  end

  value = ix1 * 2048 + ix0;
  value = value / 4194304.0;

  return
end
