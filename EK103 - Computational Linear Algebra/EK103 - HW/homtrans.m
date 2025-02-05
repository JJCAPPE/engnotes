
T0 = [ sqrt(2)/2   sqrt(2)/2   0;
      -sqrt(2)/2   sqrt(2)/2   0;
       0           0           1 ];
T1 = [ sqrt(2)/2  -sqrt(2)/2   1;
       sqrt(2)/2   sqrt(2)/2   0;
       0           0           1 ];
T2 = [ sqrt(2)/2  -sqrt(2)/2   2;
       sqrt(2)/2   sqrt(2)/2   0;
       0           0           1 ];
T3 = [ 1  0  1;
       0  1  0;
       0  0  1 ];

T_ee = T0 * T1 * T2 * T3

disp('T_ee =')
disp(T_ee)
