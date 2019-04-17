% Occupncy grid and obstacle definitions

% Occupancy grid definitions
cellsize = [0.30, 0.30];    % size of grid cell in meters
gridorig = [-0.5, -0.5];    % origin of the grid in meters
griddim = [30, 30];         % dimensionality of the occupancy grid

% OccGrid : Matrix nXm 
% Occupancy information:  0 = free, 1 = obstacle, 2 = expansion obstacle, 3 = goal
OccGrid = [0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,2,1,1,2,0,0,0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,2,1,1,2,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,2,1,1,2,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,2,1,1,2,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,2,1,1,2,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,2,2,2,2,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
           0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
      

