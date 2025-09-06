% Computational Linear Algebra (EK 103), Spring 2025, Boston University
% Problem Set 7, Question 3(d) code to help with finding eigenvalues/vectors
% March 2025

% Set up the workspace
clear all; close all; clc;



%% YOUR CODE HERE

A = [3,-1;-3,5]

[V, D] = eig(A);
V
diag(D)