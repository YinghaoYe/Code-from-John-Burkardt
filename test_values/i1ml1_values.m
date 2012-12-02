function [ n_data, x, fx ] = i1ml1_values ( n_data )

%*****************************************************************************80
%
%% I1ML1_VALUES returns some values of the I1ML1 function.
%
%  Discussion:
%
%    The function is defined by:
%
%      I1ML1(x) = I1(x) - L1(x)
%
%    I1(x) is the modified Bessel function of the first kind of order 1, 
%    L1(x) is the modified Struve function of order 1.
%
%    The data was reported by McLeod.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    16 September 2004
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Allan McLeod,
%    Algorithm 757, MISCFUN: A software package to compute uncommon
%      special functions,
%    ACM Transactions on Mathematical Software,
%    Volume 22, Number 3, September 1996, pages 288-301.
%
%  Parameters:
%
%    Input/output, integer N_DATA.  The user sets N_DATA to 0 before the
%    first call.  On each call, the routine increments N_DATA by 1, and
%    returns the corresponding data; when there is no more data, the
%    output value of N_DATA will be 0 again.
%
%    Output, real X, the argument of the function.
%
%    Output, real FX, the value of the function.
%
  n_max = 20;

  fx_vec = [ ...
     0.97575346155386267134E-03, ...
     0.77609293280609272733E-02, ...
     0.59302966404545373770E-01, ...
     0.20395212276737365307E+00, ...
     0.33839472293667639038E+00, ...
     0.48787706726961324579E+00, ...
     0.59018734196576517506E+00, ...
     0.62604539530312149476E+00, ...
     0.63209315274909764698E+00, ...
     0.63410179313235359215E+00, ...
     0.63417966797578128188E+00, ...
     0.63439268632392089434E+00, ...
     0.63501579073257770690E+00, ...
     0.63559616677359459337E+00, ...
     0.63591001826697110312E+00, ...
     0.63622113181751073643E+00, ...
     0.63636481702133606597E+00, ...
     0.63650653499619902120E+00, ...
     0.63655609126300261851E+00, ...
     0.63657902087183929223E+00 ];

  x_vec = [ ...
       0.0019531250E+00, ...
       0.0156250000E+00, ...
       0.1250000000E+00, ...
       0.5000000000E+00, ...
       1.0000000000E+00, ...
       2.0000000000E+00, ...
       4.0000000000E+00, ...
       8.0000000000E+00, ...
      12.0000000000E+00, ...
      16.0000000000E+00, ...
      16.2500000000E+00, ...
      17.0000000000E+00, ...
      20.0000000000E+00, ...
      25.0000000000E+00, ...
      30.0000000000E+00, ...
      40.0000000000E+00, ...
      50.0000000000E+00, ...
      75.0000000000E+00, ...
     100.0000000000E+00, ...
     125.0000000000E+00 ]; 

  if ( n_data < 0 )
    n_data = 0;
  end

  n_data = n_data + 1;

  if ( n_max < n_data )
    n_data = 0;
    x = 0.0;
    fx = 0.0;
  else
    x = x_vec(n_data);
    fx = fx_vec(n_data);
  end

  return
end
