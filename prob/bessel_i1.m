function value = bessel_i1 ( arg )

%*****************************************************************************80
%
%% BESSEL_I1 evaluates the Bessel I function of order I.
%
%  Discussion:
%
%    The main computation evaluates slightly modified forms of
%    minimax approximations generated by Blair and Edwards.
%    This transportable program is patterned after the machine-dependent
%    FUNPACK packet NATSI1, but cannot match that version for efficiency
%    or accuracy.  This version uses rational functions that theoretically
%    approximate I-SUB-1(X) to at least 18 significant decimal digits.
%    The accuracy achieved depends on the arithmetic system, the compiler,
%    the intrinsic functions, and proper selection of the machine-dependent
%    constants.
%
%  Machine-dependent constants:
%
%    beta   = Radix for the floating-point system.
%    maxexp = Smallest power of beta that overflows.
%    XMAX =   Largest argument acceptable to BESI1;  Solution to
%             equation:
%               EXP(X) * (1-3/(8*X)) / SQRT(2*PI*X) = beta**maxexp
%
%
%    Approximate values for some important machines are:
%
%                            beta       maxexp    XMAX
%
%    CRAY-1        (S.P.)       2         8191    5682.810
%    Cyber 180/855
%      under NOS   (S.P.)       2         1070     745.894
%    IEEE (IBM/XT,
%      SUN, etc.)  (S.P.)       2          128      91.906
%    IEEE (IBM/XT,
%      SUN, etc.)  (D.P.)       2         1024     713.987
%    IBM 3033      (D.P.)      16           63     178.185
%    VAX           (S.P.)       2          127      91.209
%    VAX D-Format  (D.P.)       2          127      91.209
%    VAX G-Format  (D.P.)       2         1023     713.293
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    27 October 2004
%
%  Author:
%
%    Original FORTRAN77 version by William Cody, Laura Stoltz;
%    MATLAB version by John Burkardt.
%
%  Reference:
%
%    Blair and Edwards,
%    Chalk River Report AECL-4928,
%    Atomic Energy of Canada, Limited,
%    October, 1974.
%
%  Parameters:
%
%    Input, real ARG, the argument.
%
%    Output, real VALUE, the value of the Bessel I1 function.
%
  exp40 = 2.353852668370199854E+17;
  forty = 40.0E+00;
  half = 0.5E+00;
  one = 1.0E+00;
  one5 = 15.0E+00;
  p = [ ...
    -1.9705291802535139930E-19, ...
    -6.5245515583151902910E-16, ...
    -1.1928788903603238754E-12, ...
    -1.4831904935994647675E-09, ...
    -1.3466829827635152875E-06, ...
    -9.1746443287817501309E-04, ...
    -4.7207090827310162436E-01, ...
    -1.8225946631657315931E+02, ...
    -5.1894091982308017540E+04, ...
    -1.0588550724769347106E+07, ...
    -1.4828267606612366099E+09, ...
    -1.3357437682275493024E+11, ...
    -6.9876779648010090070E+12, ...
    -1.7732037840791591320E+14, ...
    -1.4577180278143463643E+15 ];
  pbar = 3.98437500E-01;
  pp = [ ...
    -6.0437159056137600000E-02, ...
     4.5748122901933459000E-01, ...
    -4.2843766903304806403E-01, ...
     9.7356000150886612134E-02, ...
    -3.2457723974465568321E-03, ...
    -3.6395264712121795296E-04, ...
     1.6258661867440836395E-05, ...
    -3.6347578404608223492E-07 ];
  q = [ ...
    -4.0076864679904189921E+03, ...
     7.4810580356655069138E+06, ...
    -8.0059518998619764991E+09, ...
     4.8544714258273622913E+12, ...
    -1.3218168307321442305E+15 ];
  qq = [ ...
    -3.8806586721556593450E+00, ...
     3.2593714889036996297E+00, ...
    -8.5017476463217924408E-01, ...
     7.4212010813186530069E-02, ...
    -2.2835624489492512649E-03, ...
     3.7510433111922824643E-05 ];
  rec15 = 6.6666666666666666666E-02;
  two25 = 225.0E+00;
  xmax = 713.987E+00;
  zero = 0.0E+00;

  x = abs ( arg );
%
%  ABS(ARG) < EPSILON ( ARG )
%
  if ( x < r8_epsilon ( ) ) 

    value = half * x;
%
%  EPSILON ( ARG ) <= ABS(ARG) < 15.0
%
  elseif ( x < one5 )

    xx = x * x;
    sump = p(1);
    for j = 2 : 15
      sump = sump * xx + p(j);
    end

    xx = xx - two25;

    sumq = ((((     ...
          xx + q(1) ...
      ) * xx + q(2) ...
      ) * xx + q(3) ...
      ) * xx + q(4) ...
      ) * xx + q(5);

    value = ( sump / sumq ) * x;

  elseif ( xmax < x )

    value = r8_huge ( );
%
%  15.0 <= ABS(ARG)
%
  else

    xx = one / x - rec15;

    sump = ((((((    ...
               pp(1) ...
        * xx + pp(2) ...
      ) * xx + pp(3) ...
      ) * xx + pp(4) ...
      ) * xx + pp(5) ...
      ) * xx + pp(6) ...
      ) * xx + pp(7) ...
      ) * xx + pp(8);

    sumq = (((((     ...
          xx + qq(1) ...
      ) * xx + qq(2) ...
      ) * xx + qq(3) ...
      ) * xx + qq(4) ...
      ) * xx + qq(5) ...
      ) * xx + qq(6);

    value = sump / sumq;

    if ( xmax - one5 < x )
      a = exp ( x - forty );
      b = exp40;
    else
      a = exp ( x );
      b = one;
    end

    value = ( ( value * a + pbar * a ) / sqrt ( x ) ) * b;

  end

  if ( arg < zero )
    value = -value;
  end

  return
end
