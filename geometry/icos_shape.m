function [ point_coord, edge_point, face_order, face_point ] = ...
  icos_shape ( point_num, edge_num, face_num, face_order_max )

%*****************************************************************************80
%
%% ICOS_SHAPE describes an icosahedron.
%
%  Discussion:
%
%    The input data required for this routine can be retrieved from ICOS_SIZE.
%
%    The vertices lie on the unit sphere.
%
%    The dual of an icosahedron is a dodecahedron.
%
%    The data has been rearranged from a previous assignment.  
%    The STRIPACK program refuses to triangulate data if the first
%    three nodes are "collinear" on the sphere.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    21 July 2007
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer POINT_NUM, the number of points (12).
%
%    Input, integer EDGE_NUM, the number of edges (30).
%
%    Input, integer FACE_NUM, the number of faces (20).
%
%    Input, integer FACE_ORDER_MAX, the maximum number of vertices per face (3).
%
%    Output, real POINT_COORD(3,POINT_NUM); the points.
%
%    Output, integer EDGE_POINT(2,EDGE_NUM), the points that make up each 
%    edge, listed in ascending order of their indexes.
%
%    Output, integer FACE_ORDER(FACE_NUM), the number of vertices per face.
%
%    Output, integer FACE_POINT(FACE_ORDER_MAX,FACE_NUM); FACE_POINT(I,J)
%    is the index of the I-th point in the J-th face.  The points are listed 
%    in the counter-clockwise direction defined by the outward normal at the 
%    face.  The nodes of each face are ordered so that the lowest index 
%    occurs first.  The faces are then sorted by nodes.
%
  dim_num = 3;
%
%  Set point coordinates.
%
  phi = 0.5 * ( sqrt ( 5.0 ) + 1.0 );
  b = 1.0 / sqrt ( 1.0 + phi * phi );
  a = phi * b;
  z = 0.0;
%
%  Set the points.
%
  point_coord(1:dim_num,1:point_num) = [ ...
      a,  b,  z; ...
      a, -b,  z; ...
      b,  z,  a; ...
      b,  z, -a; ...
      z,  a,  b; ...
      z,  a, -b; ...
      z, -a,  b; ...
      z, -a, -b; ...
     -b,  z,  a; ...
     -b,  z, -a; ...
     -a,  b,  z; ...
     -a, -b,  z ]';
%
%  Set the edges.
%
  edge_point(1:2,1:edge_num) = [ ...
     1,  2; ...
     1,  3; ...
     1,  4; ...
     1,  5; ...
     1,  6; ...
     2,  3; ...
     2,  4; ...
     2,  7; ...
     2,  8; ...
     3,  5; ...
     3,  7; ...
     3,  9; ...
     4,  6; ...
     4,  8; ...
     4, 10; ...
     5,  6; ...
     5,  9; ...
     5, 11; ...
     6, 10; ...
     6, 11; ...
     7,  8; ...
     7,  9; ...
     7, 12; ...
     8, 10; ...
     8, 12; ...
     9, 11; ...
     9, 12; ...
    10, 11; ...
    10, 12; ...
    11, 12 ]';
%
%  Set the face orders.
%
  face_order(1:face_num) = [ ...
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3, ...
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3 ]';
%
%  Set the faces.
%
  face_point(1:face_order_max,1:face_num) = [ ...
     1,  2,  4; ...
     1,  3,  2; ...
     1,  4,  6; ...
     1,  5,  3; ...
     1,  6,  5; ...
     2,  3,  7; ...
     2,  7,  8; ...
     2,  8,  4; ...
     3,  5,  9; ...
     3,  9,  7; ...
     4,  8, 10; ...
     4, 10,  6; ...
     5,  6, 11; ...
     5, 11,  9; ...
     6, 10, 11; ...
     7,  9, 12; ...
     7, 12,  8; ...
     8, 12, 10; ...
     9, 11, 12; ...
    10, 12, 11 ]';

  return
end
