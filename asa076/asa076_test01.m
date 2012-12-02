function asa076_test01 ( )

%*****************************************************************************80
%
%% TEST01 demonstrates the use of TFN.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    14 February 2003
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'TEST01:\n' );
  fprintf ( 1, '  TFN evaluates Owen''s T function.\n' );
  fprintf ( 1, '  Compare to tabulated values.\n' );
  fprintf ( 1, '\n' );
  fprintf ( 1, '          H            A        ' );
  fprintf ( 1, '  T                       T\n' );
  fprintf ( 1, '                                ' );
  fprintf ( 1, '  (Tabulated)             (TFN)                   DIFF\n' );
  fprintf ( 1, '\n' );

  n_data = 0;

  while ( 1 )

    [ n_data, h, a, t1 ] = owen_values ( n_data );

    if ( n_data == 0 )
      break
    end

    t2 = tfn ( h, a );

    fprintf ( 1, '  %12.8f  %12.8f  %24.16e  %24.16e  %10.4e\n', ...
    h, a, t1, t2, abs ( t1 - t2 ) );

  end

  return
end
