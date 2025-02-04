% Put together a list of `n` 2x2 simple geometric transformations
clear
A_lst(:,:,1) = [1 0; 0 1];                           % First matrix
A_lst(:,:,2) = [-1 0; 0 1];                          % Second matrix
A_lst(:,:,3) = [1 0; 0 -1];                          % Third matrix
A_lst(:,:,4) = [cos(pi/2) -sin(pi/2); sin(pi/2) cos(pi/2)]; % Fourth matrix
A_lst(:,:,5) = [1/2 0; 0 1];                         % Fifth matrix
A_lst(:,:,6) = [1 0; 0 1/2];                         % Sixth matrix
A_lst(:,:,7) = [1 0.5; 0 1];                           % Seventh matrix
A_lst(:,:,8) = [1 0; 0.5 1];                           % Eighth matrix

disp(A_lst)

% Define the house
H = [[0;0], [0;1], [1;1.5], [1;1], [1;0], [0;0]];

% Create the first figure
figure(1)

% Plot the house
plot(H(1,:), H(2,:), '-o', 'Color', 'blue', 'MarkerFaceColor', 'red')
title('Original image')

xlim([-2 2])
axis equal

% Get the number of 2x2 matrices
numMatrices = size(A_lst,3);

% Create a second figure
figure(2)

% [TODO BY STUDENT] Do your iteration here
% for ...
% .
% .
% .
% end
