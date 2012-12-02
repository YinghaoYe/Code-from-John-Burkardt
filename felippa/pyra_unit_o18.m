function [ w, xyz ] = pyra_unit_o18 ( )

%*****************************************************************************80
%
%% PYRA_UNIT_O18 returns an 18 point quadrature rule for the unit pyramid.
%
%  Discussion:
%
%    The integration region is defined as:
%
%    - ( 1 - Z ) <= X <= 1 - Z
%    - ( 1 - Z ) <= Y <= 1 - Z
%              0 <= Z <= 1.
%
%    When Z is zero, the integration region is a square lying in the (X,Y) 
%    plane, centered at (0,0,0) with "radius" 1.  As Z increases to 1, the 
%    radius of the square diminishes, and when Z reaches 1, the square has 
%    contracted to the single point (0,0,1).
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    13 April 2009
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Carlos Felippa,
%    A compendium of FEM integration formulas for symbolic work,
%    Engineering Computation,
%    Volume 21, Number 8, 2004, pages 867-890.
%
%  Parameters:
%
%    Output, real W(18), the weights.
%
%    Output, real XYZ(3,18), the abscissas.
%
  w(1:18) = [ ...
   0.023330065296255886709, ...
   0.037328104474009418735, ...
   0.023330065296255886709, ...
   0.037328104474009418735, ...
   0.059724967158415069975, ...
   0.037328104474009418735, ...
   0.023330065296255886709, ...
   0.037328104474009418735, ...
   0.023330065296255886709, ...
   0.05383042853090460712, ...
   0.08612868564944737139, ...
   0.05383042853090460712, ...
   0.08612868564944737139, ...
   0.13780589703911579422, ...
   0.08612868564944737139, ...
   0.05383042853090460712, ...
   0.08612868564944737139, ...
   0.05383042853090460712 ];

  xyz(1:3,1:18) = [ ...
  -0.35309846330877704481,  -0.35309846330877704481,  0.544151844011225288800; ...
   0.00000000000000000000,  -0.35309846330877704481,  0.544151844011225288800; ...
   0.35309846330877704481,  -0.35309846330877704481,  0.544151844011225288800; ...
  -0.35309846330877704481,   0.00000000000000000000,  0.544151844011225288800; ...
   0.00000000000000000000,   0.00000000000000000000,  0.544151844011225288800; ...
   0.35309846330877704481,   0.00000000000000000000,  0.544151844011225288800; ...
  -0.35309846330877704481,   0.35309846330877704481,  0.544151844011225288800; ...
   0.00000000000000000000,   0.35309846330877704481,  0.544151844011225288800; ...
   0.35309846330877704481,   0.35309846330877704481,  0.544151844011225288800; ...
  -0.67969709567986745790,  -0.67969709567986745790,  0.12251482265544137787; ...
   0.00000000000000000000,  -0.67969709567986745790,  0.12251482265544137787; ...
   0.67969709567986745790,  -0.67969709567986745790,  0.12251482265544137787; ...
  -0.67969709567986745790,   0.00000000000000000000,  0.12251482265544137787; ...
   0.00000000000000000000,   0.00000000000000000000,  0.12251482265544137787; ...
   0.67969709567986745790,   0.00000000000000000000,  0.12251482265544137787; ...
  -0.67969709567986745790,   0.67969709567986745790,  0.12251482265544137787; ...
   0.00000000000000000000,   0.67969709567986745790,  0.12251482265544137787; ...
   0.67969709567986745790,   0.67969709567986745790,  0.12251482265544137787 ]';

  return
end
