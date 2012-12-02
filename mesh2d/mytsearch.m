function i = mytsearch ( x, y, t, xi, yi, i )

%*****************************************************************************80
%
%  MYTSEARCH: Find the enclosing triangle for points in a 2D plane.
%
%  Discussion:
%
%    The indices of the triangles enclosing the points in [XI,YI] are
%    returned.  The triangulation T of [X,Y] must be convex.  Points lying
%    outside the triangulation are assigned a NaN index.
%
%    IGUESS is an optional initial guess for the indices.  A full search is
%    done using the standard TSEARCH function for points with an invalid
%    initial guess.
%
%  Modified:
%
%    27 October 2011
%
%  Author:
%
%    Darren Engwirda
%

%
%  I/O and error checks
%
  if ( nargin < 5 )
    error('Wrong number of inputs');
  elseif ( nargin < 6 )
    i = [];
  elseif ( 6 < nargin )
    error('Wrong number of inputs');
  end

  if ( 1 < nargout )
    error('Wrong number of outputs');
  end

  ni = size(xi,1);

  if ( numel(xi)~=ni) || ...
     ( numel(yi)~=ni) || ...
     (numel(x)~=numel(y)) || ...
     (~isempty(i) && (numel(i)~=ni))
    error('Wrong input dimensions');
  end
%
%  Translate to the origin and scale the min xy range onto [-1,1]
%  This is absolutely critical to avoid precision issues for large problems!
%
  maxxy = max([x,y]);
  minxy = min([x,y]);
  den = 0.5*min(maxxy-minxy);

  x  = ( x-0.5*(minxy(1)+maxxy(1))) / den;
  y  = ( y-0.5*(minxy(2)+maxxy(2))) / den;
  xi = (xi-0.5*(minxy(1)+maxxy(1))) / den;
  yi = (yi-0.5*(minxy(2)+maxxy(2))) / den;
%
%  Check the initial guess.
%
  if ~isempty(i)

    k = find(i>0 & ~isnan(i));

    tri = i(k);

    n1 = t(tri,1);
    n2 = t(tri,2);
    n3 = t(tri,3);

    ok = sameside(x(n1),y(n1),x(n2),y(n2),xi(k),yi(k),x(n3),y(n3)) & ...
         sameside(x(n2),y(n2),x(n3),y(n3),xi(k),yi(k),x(n1),y(n1)) & ...
         sameside(x(n3),y(n3),x(n1),y(n1),xi(k),yi(k),x(n2),y(n2));

    j = true(ni,1);
    j(k(ok)) = false;

  else

    j = true(ni,1);

  end
%
%  Do a full search for points that failed.
%  Note that MATLAB complains that TSEARCH has been superceded by
%  DelaunayTri/PointLocation.
%
%  Rather than calling TSEARCH and getting hundreds of messages,
%  I have found a TSEARCH_MEX.C file.  You type "mex tsearch_mex.c"
%  inside of MATLAB once to compile the file.
%
  if any ( j )
    i(j) = tsearch_mex ( x, y, t, xi(j), yi(j) );
  end

  return
end
function i = sameside ( xa, ya, xb, yb, x1, y1, x2, y2 )

%*****************************************************************************80
%
% Test if [x1(i),y1(i)] and [x2(i),y2(i)] lie on the same side of the line AB(i).

  dx = xb-xa;
  dy = yb-ya;
  a1 = (x1-xa).*dy-(y1-ya).*dx;
  a2 = (x2-xa).*dy-(y2-ya).*dx;
%
% If sign(a1)=sign(a2) the points lie on the same side
%
  i = false(length(xa),1);
  i(a1.*a2>=0.0) = true;

  return
end
