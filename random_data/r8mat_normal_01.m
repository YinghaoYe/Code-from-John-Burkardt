function [ r, seed ] = r8mat_normal_01 ( m, n, seed )

%*****************************************************************************80
%
%% R8MAT_NORMAL_01 fills an array with unit pseudonormal numbers.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    17 July 2006
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
%    Input, integer M, N, the number of rows and columns in the array.
%
%    Input/output, integer SEED, the "seed" value, which should NOT be 0.
%    On output, SEED has been updated.
%
%    Output, real R(M,N), the array of pseudonormal values.
%
  for j = 1 : n

    [ v, seed ] = r8vec_normal_01 ( m, seed );
    r(1:m,j) = v';

  end

  return
end
