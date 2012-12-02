function msm_to_mm_coordinate_pattern_symmetric ( output_filename, a, symmetry ) 

%*****************************************************************************80
%
%% MSM_TO_MM_COORDINATE_PATTERN_SYMMETRIC writes a "matrix coordinate pattern symmetric" Matrix Market file.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    02 November 2008
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
  nnzeros = nnz ( a );

  fid = fopen ( output_filename, 'wt+' );

  if ( fid < 0 ); 
    fprintf ( 1, '\n' );
    fprintf ( 1, 'MSM_TO_MM_COORDINATE_PATTERN_SYMMETRIC - Fatal error!\n' );
    fprintf ( 1, '  Cannot open the output file.\n' );
    error ( 'MSM_TO_MM_COORDINATE_PATTERN_SYMMETRIC - Fatal error!'); 
  end;

  fprintf ( fid, '%%%%MatrixMarket matrix coordinate pattern symmetric\n');
  fprintf ( fid, '%%%%  Created by MSM_TO_MM_COORDINATE_PATTERN_SYMMETRIC.M\n' );
  fprintf ( fid, '  %d  %d  %d\n', nrow, ncol, nnzeros );

  for j = 1 : ncol
    rows = find ( a(:,j) );
    sz = size ( rows ); 
    for k2 = 1 : sz
      if ( j <= rows(k2) )
        fprintf ( fid, '  %d  %d\n', rows(k2), j );
      end
    end
    
  end

  fclose ( fid );

  return
end
