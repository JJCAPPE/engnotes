C = [3  5  -2  -1  1;
     2  0   2   4  2;
    -2  7  -9  -5  4];

R = rref(C);
disp(R);

null_vec = null(sym(C));
disp(null_vec);

disp('C * (nullspace vector) = 0:');
[nRows, nVec] = size(null_vec);
for i = 1:nVec
    xn = null_vec(:, i);
    product = C * xn;
    fprintf('Result for nullspace vector %d:\n', i);
    disp(product);
end
