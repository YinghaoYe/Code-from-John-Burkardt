function msm_to_mm_array_complex_hermitian ( output_filename, a ) 

%*****************************************************************************80
%
%% MSM_TO_MM_ARRAY_COMPLEX_HERMITIAN writes a "matrix array complex hermitian" Matrix Market file.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    01 November 2008
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, string OUTPUT_FILENAME, the name of the file to which the information
%    should be written.
%
%    Input, sparse matrix A, the NROW by NCOL matrix, stored in MATLAB sparse 
%    matrix format, which is to be written to the file.
%
  [ nrow, ncol ] = size ( a );

  fid = fopen ( output_filename, 'wt+' );

  if ( fid < 0 ); 
    fprintf ( 1, '\n' );
    fprintf ( 1, 'MSM_TO_MM_ARRAY_COMPLEX_HERMITIAN - Fatal error!\n' );
    fprintf ( 1, '  Cannot open the output file.\n' );
    error ( 'MSM_TO_MM_ARRAY_COMPLEX_HERMITIAN - Fatal error!' );
  end

  fprintf ( fid, '%%%%MatrixMarket matrix array complex hermitian\n');
  fprintf ( fid, '%%%%  Created by MSM_TO_MM_ARRAY_COMPLEX_HERMITIAN.M\n' );
  fprintf ( fid, '  %d  %d\n', nrow, ncol );

  for j = 1 : ncol
    for i = j : nrow
      fprintf ( fid, '  %f  %f\n', real ( a(i,j) ), imag ( a(i,j) ) );
    end
  end

  fclose ( fid );

  return
end
