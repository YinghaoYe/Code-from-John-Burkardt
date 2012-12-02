function [ cluster, cluster_center, cluster_population, cluster_energy, ...
  it_num, seed ] = hmeans_02 ( dim_num, point_num, cluster_num, it_max, ...
  point, cluster, cluster_center, seed )

%*****************************************************************************80
%
%% HMEANS_02 applies the H-Means algorithm.
%
%  Discussion:
%
%    This is a simple routine to group a set of points into K clusters,
%    each with a center point, in such a way that the total cluster 
%    energy is minimized.  The total cluster energy is the sum of the
%    squares of the distances of each point to the center of its cluster.
%
%    The algorithm begins with an initial estimate for the cluster centers:
%
%    1. The points are assigned to the nearest cluster centers.
%
%    2. The iteration stops if the total energy has not changed 
%        significantly, or we have reached the maximum number of iterations.
%
%    3. Each cluster center is replaced by the centroid of the points
%       in the cluster.
%
%    4. Return to step 1.
%
%    The algorithm may fail to find the best solution.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    04 October 2009
%
%  Author:
%
%    John Burkardt
%
%  Parameters:
%
%    Input, integer DIM_NUM, the number of spatial dimensions.
%
%    Input, integer POINT_NUM, the number of points.
%
%    Input, integer CLUSTER_NUM, the number of clusters.
%
%    Input, integer IT_MAX, the maximum number of iterations.
%
%    Input, real POINT(DIM_NUM,POINT_NUM), the coordinates 
%    of the points.
%
%    Input, integer CLUSTER(POINT_NUM).  On input, the user 
%    may specify an initial cluster for each point, or leave all entrie of
%    CLUSTER set to 0.  On output, CLUSTER contains the index of the
%    cluster to which each data point belongs.
%
%    Input real CLUSTER_CENTER(DIM_NUM,CLUSTER_NUM),
%    the coordinates of the cluster centers.
%
%    Input, integer SEED, a seed for the random
%    number generator.
%
%    Output, integer CLUSTER(POINT_NUM).  On input, the user 
%    may specify an initial cluster for each point, or leave all entrie of
%    CLUSTER set to 0.  On output, CLUSTER contains the index of the
%    cluster to which each data point belongs.
%
%    Output, real CLUSTER_CENTER(DIM_NUM,CLUSTER_NUM),
%    the coordinates of the cluster centers.
%
%    Output, integer CLUSTER_POPULATION(CLUSTER_NUM), the number of
%    points assigned to each cluster.
%
%    Output, real CLUSTER_ENERGY(CLUSTER_NUM), the energy of 
%    the clusters.
%
%    Output, integer IT_NUM, the number of iterations taken.
%
%    Output, integer SEED, a seed for the random
%    number generator.
%

%
%  Data checks.
%
  if ( cluster_num < 1 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'HMEANS_02 - Fatal error!\n' );
    fprintf ( 1, '  CLUSTER_NUM < 1.\n' );
    error ( 'HMEANS_02 - Fatal error!' )
  end

  if ( dim_num < 1 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'HMEANS_02 - Fatal error!\n' );
    fprintf ( 1, '  DIM_NUM < 1.\n' );
    error ( 'HMEANS_02 - Fatal error!' )
  end

  if ( point_num < 1 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'HMEANS_02 - Fatal error!\n' );
    fprintf ( 1, '  POINT_NUM < 1.\n' );
    error ( 'HMEANS_02 - Fatal error!' )
  end

  if ( it_max < 0 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'HMEANS_02 - Fatal error!\n' );
    fprintf ( 1, '  IT_MAX < 0.\n' );
    error ( 'HMEANS_02 - Fatal error!' )
  end
%
%  On input, legal entries in CLUSTER are preserved, but
%  otherwise, each point is assigned to its nearest cluster.
%
  for i = 1 : point_num

    if ( cluster(i) <= 0 | cluster_num < cluster(i) )

      point_energy_min = Inf;

      for j = 1 : cluster_num

        point_energy = sum ( ...
          ( point(1:dim_num,i) - cluster_center(1:dim_num,j) ).^2 );

        if ( point_energy < point_energy_min )
          point_energy_min = point_energy;
          cluster(i) = j;
        end

      end

    end
  end

  it_num = 0;

  while ( 1 )
%
%  Given centers, assign points to nearest center.
%
    cluster_population(1:cluster_num) = 0;
    cluster_energy(1:cluster_num) = 0.0;

    swap = 0;

    for i = 1 : point_num

      for j = 1 : cluster_num
        energy(j) = sum ( ...
          ( point(1:dim_num,i) - cluster_center(1:dim_num,j) ).^2 );
      end

      [ dummy, c ] = min ( energy(1:cluster_num) );

      if ( c ~= cluster(i) )
        swap = swap + 1;
      end

      cluster(i) = c;
      cluster_energy(c) = cluster_energy(c) + energy(c);
      cluster_population(c) = cluster_population(c) + 1;

    end

    if ( 0 < it_num )
      if ( swap == 0 )
        break
      end
    end

    if ( it_max <= it_num )
      break
    end

    it_num = it_num + 1;
%
%  Given points in cluster, replace center by centroid.
%
    cluster_center(1:dim_num,1:cluster_num) = 0.0;
  
    for i = 1 : point_num
      c = cluster(i);
      cluster_center(1:dim_num,c) = cluster_center(1:dim_num,c) ...
        + point(1:dim_num,i);
    end

    for i = 1 : cluster_num
      if ( cluster_population(i) ~= 0 )
        cluster_center(1:dim_num,i) = cluster_center(1:dim_num,i) / ...
          cluster_population(i);
      else
        [ j, seed ] = i4_uniform ( 1, point_num, seed );
        cluster_center(1:dim_num,i) = point(1:dim_num,j);
      end
    end

  end
%
%  Compute the energy based on the final value of the cluster centers.
%
  cluster_energy(1:cluster_num) = 0.0;

  for i = 1 : point_num

    c = cluster(i);

    cluster_energy(c) = cluster_energy(c) + sum ( ...
      ( point(1:dim_num,i) - cluster_center(1:dim_num,c) ).^2 );

  end

  return
end
