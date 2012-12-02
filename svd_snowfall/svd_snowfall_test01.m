function x = svd_snowfall_test01 ( )

%*****************************************************************************80
%
%% SVD_SNOWFALL_TEST01 reads and processes the snowfall data.
%
%  Discussion:
%
%    The data file contains monthly snowfall records from 1890 to 2010.
%    Column 1 is the year, columns 2 through 9 are the snowfall for
%    October, November, December, January, February, March, April, May,
%    and column 10 is the total snowfall for that season.
%
%    After the LOAD command is executed, the data is stored as
%    8 rows and 121 columns, with the first column of X the
%    1890 data, and the last column is 2010!
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    20 March 2012
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Output, real X(8,121), the snowfall data.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'SVD_SNOWFALL_TEST01\n' );
  fprintf ( 1, '  Read and process the snowfall data.\n' );

  x = load ( 'snowfall.txt' );

  [ m, n ] = size ( x );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  Initial data rows    M = %d\n', m );
  fprintf ( 1, '  Initial data columns N = %d\n', n );
%
%  Remove columns 1 (year) and 10 (total snowfall).
%
  x = x(:,2:9);
%
%  Transpose.
%
  x = x';

  [ m, n ] = size ( x );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  After removing columns 1 and 10,\n' );
  fprintf ( 1, '  and transposing the matrix, we have:\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  Revised data rows    M = %d\n', m );
  fprintf ( 1, '  Revised data columns N = %d\n', n );

  return
end

