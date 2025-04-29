function plot_potatoes(pot_orig, pot_transformed, label)
% plot_potato(pot1, pot2)
%
%   Plots two sets of points in a 2xN matrices nicely. Real simple. Lots of
%   hard-coded stuff here.
%   
%   pot_orig = 2xN matrix of points (first potato)
%
%   pot_transformed = another 2xN matrix of points (presumably your transformed
%   potato)
%
%   label = string appended to plot title
%
%   (C) Andrew Sabelhaus and Andy Fan, 2022

% setup
figure;
hold on;
xylims = [-8, 8];
xlim(xylims);
ylim(xylims);
title('Transformations of the Engineering Potato: ' + label);
xlabel('x_1');
ylabel('x_2');
xline(0);
yline(0);

% first potato (dots only)
dots1 = plot(pot_orig(1,:), pot_orig(2,:), '.');
set(dots1, 'Color', 'blue', 'Markersize', 10);
% first potato hashing
potato1_hashing = plot(pot_orig(1,:), pot_orig(2,:));
set(potato1_hashing, 'Color', 'blue', 'Linewidth', 1);

% second potato (dots only)
dots2 = plot(pot_transformed(1,:), pot_transformed(2,:), '.');
set(dots2, 'Color', 'red', 'Markersize', 10);

% -- Set up legends
my_legend_strings = {'pre-image'
                     'post-transformed image'};
                 
% -- Create the legends
my_legend_plothandle = legend([dots1  dots2  ], my_legend_strings, 'location', 'northeast');
set(my_legend_plothandle, 'FontName', 'Arial', 'Fontsize', 10);

end