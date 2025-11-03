Al_deltaEout_A  = readmatrix('measurements lab 3.xlsx', 'Range', 'C4:C18');
Br_deltaEout_A  = readmatrix('measurements lab 3.xlsx', 'Range', 'E4:E18');
St_deltaEout_A  = readmatrix('measurements lab 3.xlsx', 'Range', 'G4:G18');
Al_deltaEout_T  = readmatrix('measurements lab 3.xlsx', 'Range', 'D4:D18');
Br_deltaEout_T  = readmatrix('measurements lab 3.xlsx', 'Range', 'F4:F18');
St_deltaEout_T  = readmatrix('measurements lab 3.xlsx', 'Range', 'H4:H18');

% Cancel out the reference 
Al_deltaEout_A = Al_deltaEout_A - Al_deltaEout_A(1);
Br_deltaEout_A = Br_deltaEout_A - Br_deltaEout_A(1);
St_deltaEout_A = St_deltaEout_A - St_deltaEout_A(1);
Al_deltaEout_T = Al_deltaEout_T - Al_deltaEout_T(1);
Br_deltaEout_T = Br_deltaEout_T - Br_deltaEout_T(1);
St_deltaEout_T = St_deltaEout_T - St_deltaEout_T(1);


Al_GF = 2.085;   Br_GF = 2.085;   St_GF = 2.07;
Ein   = 5;


Al_Epsilon_Ax = (4 .* Al_deltaEout_A .* 1e-3) ./ (Al_GF .* Ein);  
Br_Epsilon_Ax = (4 .* Br_deltaEout_A .* 1e-3) ./ (Br_GF .* Ein);  
St_Epsilon_Ax = (4 .* St_deltaEout_A .* 1e-3) ./ (St_GF .* Ein);  

Al_Epsilon_T = (4 .* Al_deltaEout_T .* 1e-3) ./ (Al_GF .* Ein);  
Br_Epsilon_T = (4 .* Br_deltaEout_T .* 1e-3) ./ (Br_GF .* Ein);  
St_Epsilon_T = (4 .* St_deltaEout_T .* 1e-3) ./ (St_GF .* Ein);  

% axial vs transverse 
figure;
hold on;
plot(Al_Epsilon_Ax, Al_Epsilon_T, 'b-o', 'LineWidth', 1.5, 'MarkerSize', 6);
plot(Br_Epsilon_Ax, Br_Epsilon_T, 'r-o', 'LineWidth', 1.5, 'MarkerSize', 6);
plot(St_Epsilon_Ax, St_Epsilon_T, 'g-o', 'LineWidth', 1.5, 'MarkerSize', 6);
hold off;
grid on;

xlabel('Axial strain \epsilon_{axial} (in/in)');
ylabel('Transverse strain \epsilon_{trans} (in/in)');
title('Experimental Poisson''s Ratio');

legend('Aluminum, PR=-0.3624±0.00285, R^2=0.99983', ...
    'Brass,PR=-0.3317±0.01025, R^2=0.99735', ...
    'Steel, PR=-0.3149±0.0292, R^2=0.97663', ...
    'Location', 'best');
