function b = r8ge_fss ( n, a, nb, b )

%*****************************************************************************80
%
%% R8GE_FSS factors and solves a R8GE system.
%
%  Discussion:
%
%    The R8GE storage format is used for a general M by N matrix.  A storage 
%    space is made for each logical entry.  The two dimensional logical
%    array is mapped to a vector, in which storage is by columns.
%
%    This routine does not save the LU factors of the matrix, and hence cannot
%    be used to efficiently solve multiple linear systems, or even to
%    factor A at one time, and solve a single linear system at a later time.
%
%    This routine uses partial pivoting, but no pivot vector is required.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    23 June 2009
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer N, the order of the matrix.
%    N must be positive.
%
%    Input, real A(N,N), the coefficient matrix of the linear system.
%
%    Input, integer NB, the number of right hand sides.
%
%    Input, real B(N,NB), the right hand side of the linear system.
%
%    Output, real B(N,NB), the solution of the linear system.
%
  info = 0;

  for jcol = 1 : n
%
%  Find the maximum element in column I.
%
    piv = abs ( a(jcol,jcol) );
    ipiv = jcol;
    for i = jcol+1 : n
      if ( piv < abs ( a(i,jcol) ) )
        piv = abs ( a(i,jcol) );
        ipiv = i;
      end
    end

    if ( piv == 0.0 )
      info = jcol;
      fprintf ( 1, '\n' );
      fprintf ( 1, 'R8GE_FSS - Fatal error!\n' );
      fprintf ( 1, '  Zero pivot on step %d\n', info );
      return
    end
%
%  Switch rows JCOL and IPIV, and B.
%
    if ( jcol ~= ipiv )

      for j = 1 : n
        t         = a(jcol,j);
        a(jcol,j) = a(ipiv,j);
        a(ipiv,j) = t;
      end

      t(1,1:nb)    = b(jcol,1:nb);
      b(jcol,1:nb) = b(ipiv,1:nb);
      b(ipiv,1:nb) = t(1,1:nb);

    end
%
%  Scale the pivot row.
%
    temp = a(jcol,jcol);
    a(jcol,jcol) = 1.0E+00;
    a(jcol,jcol+1:n) = a(jcol,jcol+1:n) / temp;
    b(jcol,1:nb) = b(jcol,1:nb) / temp;
%
%  Use the pivot row to eliminate lower entries in that column.
%
    for i = jcol+1 : n
      if ( a(i,jcol) ~= 0.0E+00 )
        temp = - a(i,jcol);
        a(i,jcol) = 0.0E+00;
        a(i,jcol+1:n) = a(i,jcol+1:n) + temp * a(jcol,jcol+1:n);
        b(i,1:nb) = b(i,1:nb) + temp * b(jcol,1:nb);
      end
    end

  end
%
%  Back solve.
%
  for j = 1 : nb
    for jcol = n : -1 : 2
      b(1:jcol-1,j) = b(1:jcol-1,j) - a(1:jcol-1,jcol) * b(jcol,j);
    end
  end

  return
end
