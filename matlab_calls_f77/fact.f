      subroutine mexFunction ( nlhs, plhs, nrhs, prhs )

c*********************************************************************72
c
cc MEXFUNCTION is a MATLAB/F77 interface for the factorial function.
c
c  Discussion:
c
c    The MATLAB user types
c
c      y = fact ( x )
c
c    This routine carries out the computation of the factorial of X,
c    whose value is returned in Y.
c
c  Modified:
c
c    17 July 2006
c
c  Author:
c
c    Duane Hanselman, Bruce Littlefield
c
c  Reference:
c
c    Duane Hanselman, Bruce Littlefield,
c    Mastering MATLAB 7,
c    Pearson Prentice Hall, 2005,
c    ISBN: 0-13-143018-1.
c
c  Parameters:
c
c    Input, integer NLHS, the number of output arguments.
c
c    Input, integer PLHS(NLHS), pointers to the output arguments.
c
c    Input, integer NRHS, the number of input arguments.
c
c    Input, integer PRHS(NRHS), pointers to the input arguments.
c
      implicit none

      integer nlhs
      integer nrhs

      integer i
      integer mxCreateDoubleMatrix
      integer mxGetPr
      double precision mxGetScalar
      integer plhs(nlhs)
      integer prhs(nrhs)
      double precision x
      double precision y
      integer y_pointer
c
c  Retrieve the (first) (scalar) input argument from the line
c
c    y = fact ( x )
c
      x = mxGetScalar ( prhs(1) )
c
c  Make space for the output argument, and
c  retrieve the value of the pointer to that space.
c
      plhs(1) = mxCreateDoubleMatrix ( 1, 1, 0 )
      y_pointer = mxGetPR ( plhs(1) )
c
c  Compute the value of the output argument.
c
      y = 1.0D+00
      do i = 1, int ( x )
        y = y * dble ( i )
      end do
c
c  Copy the value of Y into the address for the output.
c
      call mxCopyReal8ToPtr ( y, y_pointer, 1 )

      return
      end
