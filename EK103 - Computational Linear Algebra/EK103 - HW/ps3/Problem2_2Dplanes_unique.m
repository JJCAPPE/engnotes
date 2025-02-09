






% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%     Problem 2:  Plotting 3 intersecting planes 
%
% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


% -- Suppose we have an Ax = b equation, where A = (3 x 3), and it 
%    representes these 3 equations:


%   Plane #1:        x1  +  x2  +  x3  = 2
%   Plane #2:        x1  -  x2  + 2x3  = 3
%   Plane #3:       -x1  + 2x2  + 4x3  = 3

% -- Define matrix A 

A = [ 1  1  1 ;       % -- row vector r1
      1 -3  0 ;       % -- row vector r2
     -1  2  6 ]       % -- row vector r3

%    a1 a2 a3         % -- Column vectors a1, a2, a3


% -- Define target vector b
b = [ 2 1 5 ]'


% -- We can solve for x by using the \  command:

disp('The solution to our Ax = b problem is');
x = A\b


% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%
%   Task 1:    Drawing the 3 planes of interest
%
%   We will learn how to do this later when we talk about nullspace
%   solutions.  For now, just trust the code here =) 
%
%
%   Sub-tasks:
% ---------------------------------------------------
%
% -- 1.  Extract the row vectors r1, r2, r3 from matrix A
%
% -- 2.  Then, we will find the nullspace vectors to the equation
%                 r' * xn1  = 0
%                 r' * xn2  = 0 
%
% -- 3.  Then, will draw the plane spanned by the 2 nullspace vectors
%        xn1 and xn2
%
% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


% -- Define my own color pallet

my_colormap = [ 1  0.6  0     ;   % --- orange
                0   1   0     ;   % --  green
                0   0   1 ];      % --  blue


% -- Create a new figure
figure;


% -- Forcing the new figure to have a certain size on your screen
%    and at a certain position
set(gcf, 'Position',  [100, 100, 700, 600])


% --  Iterate over each row vector r1, r2, r3

for count = 1:1:3

    r1 = A(count,:);    % -- Extract the row vector (r1, r2, r3)

    % -- First, we will auto-calculate the:
    %    a)  Particular solution:  my_xp
    %    b)  Nullspace vector #1:  my_xn1
    %    c)  Nullspace vector #2:  my_xn2
    
    
    xp  = [ b(count)       0  0 ]' / r1(1);
    xn1 = [ -r1(2)/r1(1)   1  0 ]' ;
    xn2 = [ -r1(3)/r1(1)   0  1 ]' ;


    % -- Then, we will plot the plane spanned by my_xn1
    %                                            my_xn2
    %    with the centroid of the plane at:      xp
     
    % -- Now, we will use the "patch" command to draw a 2D plane that
    %    represents the span{xn1, xn2}
    %
    %    These are the coordinates for the 4 corners of the plane
    %   
    %
    %    Point Q                                                Point M
    %
    %   2*(-xn1+xn2)       ----------------------------- 2*(xn1 + xn2)
    %                     |            |              |
    %                     |            |              |
    %                      <--------   xp --------------->   
    %                     |            |              |
    %    Point P          |            |              |         Point N
    %                     |            |              |    
    %  2*(-xn1-xn2)      -----------------------------2*(xn1 - xn22)
    %


    % -- We can change the size + scale of our plane by using this
    %    magnification factor
    
    my_scale = 2;


    % -- Compute the cooridnates for the 4 corners.  The data structure
    %    here looks like this:
    % 
    %                 Points: [   M       N        P          Q   ]  + xp
    % --------------------------------------------------------------------
    my_corners = my_scale .* [ xn1+xn2  xn1-xn2 -xn1-xn2  -xn1+xn2 ] + xp;

    % -- Plot the plane using the patch command  (# of vertices = 4)
    %
    % 
    % Syntax:  my_plothandle = patch( 'XData', [ xcoords ], 
    %                                 'YData', [ ycoords ],
    %                                 'ZData', [ zcoords ] );

    my_plane_plothandle(count) = patch('XData', my_corners(1,:), 'YData', my_corners(2,:), 'ZData', my_corners(3,:));
    set(my_plane_plothandle(count), 'FaceColor', my_colormap(count,:), 'FaceAlpha', 0.2)

    hold on;

end


% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%  
%   Task #2:  Plot the solution vector x  (the answer) as a 
%             big black dot
%
%   ** You will have to change the "my_x" vector to have it
%      plotted correctly !!
%
% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

% -- Define solution vector
x_solution = [ 1  0  1 ]';   %  <---  you need to change this !!


% -- Plot it as a black dot using the "plot3" command:

x_solution_plothandle = plot3( x_solution(1), x_solution(2), x_solution(3), '.');
set(x_solution_plothandle, 'Color', 'black', 'Markersize', 30);


% -- cosmetics for the plot
xmin = -5;
xmax = 5;
ymin = -5;
ymax = 5;
zmin = -5;
zmax = 5;

% -- Using "axis square" will ensure equally-spaced grid lines 
%    across all 3 axes x, y, z !! 

grid on;
axis([xmin xmax ymin ymax zmin zmax]);
axis square;

xlabel('x1-axis');
ylabel('x2-axis');
zlabel('x3-axis');
title('Problem 1:  3 intersecting planes (unique solution)');


% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% -- Create legend strings
% 
% -- We will extract the row vector numbers from matrix A using the
%    num2str( ) command !!
%                       
% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

my_legend_strings = { };  % -- Initialize string matrix

for count = 1:1:3

    % -- Creat the legend strings for each plan
    %    Note:  "32"  =  space bar (in ASCII code)

    my_legend_strings{count} = strcat( 'Plane #', num2str(count), ':', 32, num2str(A(count,1)), 'x_1 + ', num2str(A(count,2)), 'x_2 + ', num2str(A(count,3)), 'x_3 = ', 32, num2str(b(count)));

end

% -- Then, add the 4th legend (the x = solution black dot)
 my_legend_strings{count+1}  = strcat( 'x_{solution} = [ ', 32, num2str(x_solution'), 32, ']^T'  );

% -- Plot the legend itself
%
%                                 plothandles         , string matrix
%                      -------------------------------------------------
my_legend_plothandle = legend( [ my_plane_plothandle   x_solution_plothandle  ], my_legend_strings);
set(my_legend_plothandle, 'FontName', 'Arial', 'Fontsize', 9);

% -- Release the hold on the plot
hold off;


% -- 3D camera position (so that you can view the 3D planes at a 
%    convenient perpsective)

campos([66.5824   49.0335   25.7390]);

