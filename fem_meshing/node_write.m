function node_write ( outfile, m, n, table )

  outunit = fopen ( outfile, 'wt' );
  
  for j = 1 : n
    for i = 1 : m
      fprintf ( outunit, '  %12g', table(i,j) );
    end
    fprintf ( outunit, '\n' );
  end
  
  fclose ( outunit );
  
  return
end
