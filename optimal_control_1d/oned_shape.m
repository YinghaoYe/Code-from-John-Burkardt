function [ x_g, w_g, phi, p_x, p_xx ] = oned_shape ( x, r, w )

%*****************************************************************************80
%
%% ONED_SHAPE evaluates finite element data at Gauss points.
%
%  Discussion:
%
%    It is assumed that the nodes in the element are evenly spaced.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    10 March 2011
%
%  Author:
%
%    Jeff Borggaard
%
%  Parameters:
%
%    Input, real X(N), coordinates of the element nodes.
%
%    r, Coordinates of Gauss points in (-1,1)
%
%    w, Gauss weights associated with r.
%
%    x_g, Coordinates of Gauss points in the element
%
%    w_g, Gauss weights scaled by the element Jacobian.
%
%    phi, Value of element shape functions at x_g.
%
%    p_x, First spatial derivatives of phi.
%
%    p_xx, Second spatial derivatives of phi
%
%  Local Parameters:
%
%    Local, integer N, the order of X.  This indicates the
%    kind of element.
%
  [ n, t1 ] = size ( x );
%
%  A linear element.
%
  if ( n == 2 )

    c0 = ( x(n,1)-x(1,1) )/2;
    c1 = ( x(n,1)+x(1,1) )/2;

    x_g = c0*r + c1;

    phi(:,2) = ( 1+r )/2;
    phi(:,1) = ( 1-r )/2;

    p_x(:,2) = .5*ones(size(r))/c0;
    p_x(:,1) =-p_x(:,2);

    djac = c0;

    w_g = djac*w;

    if (nargout == 5)
      p_xx = zeros(size(r),2);
    end
%
%  A quadratic element.
%
  elseif ( n == 3 )

    c0 = ( x(n,1)-x(1,1) )/2;
    c1 = ( x(n,1)+x(1,1) )/2;
    
    x_g = c0*r + c1;

    phi(:,3) = .5*r.*( r+1 );
    phi(:,2) =-( r+1 ).*( r-1 );
    phi(:,1) = .5*r.*( r-1 );

    p_x(:,3) = ( r+.5 )/c0;
    p_x(:,2) =-2*r/c0;
    p_x(:,1) = ( r-.5 )/c0;

    djac = c0;

    w_g = djac*w;

    if (nargout == 5)
      p_xx(:,3) = ones(size(r))/c0^2;
      p_xx(:,2) =-2*p_xx(:,3);
      p_xx(:,1) = p_xx(:,3);
    end
%
%  A cubic element.
%
  elseif ( n == 4 )

    c0 = ( x(n,1)-x(1,1) )/2;
    c1 = ( x(n,1)+x(1,1) )/2;
    
    x_g = c0*r + c1;
    
    r2  = r.*r;
    r3  = r.*r2;

    phi(:,4) =  9*( r3+r2-r/9-1/9 )/16;
    phi(:,3) =-27*( r3+r2/3-r-1/3 )/16;
    phi(:,2) = 27*( r3-r2/3-r+1/3 )/16;
    phi(:,1) =- 9*( r3-r2-r/9+1/9 )/16;

    p_r(:,4) =  9*( 3*r2+2*r-1/9 )/16;
    p_r(:,3) =-27*( 3*r2+2*r/3-1 )/16;
    p_r(:,2) = 27*( 3*r2-2*r/3-1 )/16;
    p_r(:,1) =- 9*( 3*r2-2*r-1/9 )/16;

    p_rr(:,4) =  9*( 6*r+2   )/16;
    p_rr(:,3) =-27*( 6*r+2/3 )/16;
    p_rr(:,2) = 27*( 6*r-2/3 )/16;
    p_rr(:,1) =- 9*( 6*r-2   )/16;

    dxdr = p_r*x(:,1);
    djac = dxdr;
    drdx = 1./djac;

    p_x(:,4) = p_r(:,4).*drdx;
    p_x(:,3) = p_r(:,3).*drdx;
    p_x(:,2) = p_r(:,2).*drdx;
    p_x(:,1) = p_r(:,1).*drdx;
    w_g = djac.*w;

  else

    error('Elements higher than cubic not currently supported')
    keyboard

  end

  return
end

