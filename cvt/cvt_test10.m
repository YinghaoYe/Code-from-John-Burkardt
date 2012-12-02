function cvt_test10 ( )

%*****************************************************************************80
%
%% CVT_TEST10 generates 100 points in 3D.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    08 November 2006
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST10\n' );
  fprintf ( 1, '  CVT computes a Centroidal Voronoi Tessellation.\n' );
  fprintf ( 1, '  Compute 100 points in 3D.\n' );

  dim_num = 3;
  n = 100;
  batch = 1000;
  init = 0;
  init_string = 'uniform';
  it_max = 40;
  it_fixed = 1;
  sample = 0;
  sample_num = 10000;
  sample_string = 'uniform';
  seed = 123456789;
  r = [];

  seed_init = seed;

  [ r, seed, it_num, it_diff, energy ] = cvt ( dim_num, n, batch, init, ...
    sample, sample_num, it_max, it_fixed, seed, r );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Dimension DIM_NUM =        %12d\n', dim_num );
  fprintf ( 1, '  Number of points N =       %12d\n', n );
  fprintf ( 1, '  Initial SEED =             %12d\n', seed_init );
  fprintf ( 1, '  Current SEED =             %12d\n', seed );
  fprintf ( 1, '  INIT =                    "%s".\n', init_string );
  fprintf ( 1, '  Max iterations IT_MAX =    %12d\n', it_max );
  fprintf ( 1, '  IT_FIXED (fixed samples) = %12d\n', it_fixed );
  fprintf ( 1, '  Iterations IT_NUM =        %12d\n', it_num );
  fprintf ( 1, '  Difference IT_DIFF =       %14f\n', it_diff );
  fprintf ( 1, '  CVT ENERGY =               %14f\n', energy );
  fprintf ( 1, '  SAMPLE =                  "%s".\n', sample_string );
  fprintf ( 1, '  Samples SAMPLE_NUM    =    %12d\n', sample_num );
  fprintf ( 1, '  Sampling BATCH size =      %12d\n', batch );
  fprintf ( 1, '  EPSILON (unit roundoff) =  %12e\n', eps );

  r8mat_transpose_print_some ( dim_num, n, r, 1, 1, dim_num, 10, ...
    '  First 10 generators (rows)' );

  return
end
