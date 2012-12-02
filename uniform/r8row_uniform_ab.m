function [ r, seed ] = r8row_uniform_ab ( m, n, a, b, seed )

%*****************************************************************************80
%
%% R8ROW_UNIFORM_AB fills an R8ROW with scaled pseudorandom numbers.
%
%  Discussion:
%
%    An R8ROW is an array of R8 values, regarded as a set of row vectors.
%
%    The user specifies a minimum and maximum value for each column.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    15 January 2012
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Paul Bratley, Bennett Fox, Linus Schrage,
%    A Guide to Simulation,
%    Springer Verlag, pages 201-202, 1983.
%
%    Bennett Fox,
%    Algorithm 647:
%    Implementation and Relative Efficiency of Quasirandom
%    Sequence Generators,
%    ACM Transactions on Mathematical Software,
%    Volume 12, Number 4, pages 362-376, 1986.
%
%    Peter Lewis, Allen Goodman, James Miller,
%    A Pseudo-Random Number Generator for the System/360,
%    IBM Systems Journal,
%    Volume 8, pages 136-143, 1969.
%
%  Parameters:
%
%    Input, integer M, N, the number of rows and columns in
%    the array.
%
%    Input, real A(N), B(N), the lower and upper limits.
%
%    Input/output, integer SEED, the "seed" value, which
%    should NOT be 0.  On output, SEED has been updated.
%
%    Output, real R(M,N), the array of pseudorandom values.
%
  i4_huge = 2147483647;

  for i = 1 : m

    for j = 1 : n

      k = floor ( seed / 127773 );

      seed = 16807 * ( seed - k * 127773 ) - k * 2836;

      if ( seed < 0 )
        seed = seed + i4_huge;
      end

      r(i,j) = a(j) + ( b(j) - a(j) ) * seed * 4.656612875E-10;

    end
  end

  return
end
