mid   = readmatrix('measurements lab 3.xlsx', 'Range', 'C26:C30');
left  = readmatrix('measurements lab 3.xlsx', 'Range', 'D26:D30');
right = readmatrix('measurements lab 3.xlsx', 'Range', 'E26:E30');
deflection = [0,0.1,0.2,0.3,0.4];

pr = 0.33; 
E  = 10460000; 
l = 10; x = 9; h = 0.123; b = 1.001;

mid   = (mid   - mid(1))   * 1e-6;
left  = (left  - left(1))  * 1e-6;
right = (right - right(1)) * 1e-6;

strainMax = (left - right)/2 + sqrt(((left - mid).^2)/2 + ((right - mid).^2)/2);
strainMin = (left - right)/2 - sqrt(((left - mid).^2)/2 + ((right - mid).^2)/2);

I = b*h^3/12;
c = h/2;

F = 3*E*I*deflection/l^3;
Sigma_flex = F*x*c/I;
stress1 = (E/(1-pr^2))*(strainMax + pr*strainMin);
stress2 = (E/(1-pr^2))*(strainMin + pr*strainMax);

syms left1 right1 mid1
strainMax1 = (left1 - right1)/2 + sqrt(((left1 - mid1)^2)/2 + ((right1 - mid1)^2)/2);
strainMin1 = (left1 - right1)/2 - sqrt(((left1 - mid1)^2)/2 + ((right1 - mid1)^2)/2);

dMax_left1  = diff(strainMax1, left1);
dMax_right1 = diff(strainMax1, right1);
dMax_mid1   = diff(strainMax1, mid1);
dMin_left1  = diff(strainMin1, left1);
dMin_right1 = diff(strainMin1, right1);
dMin_mid1   = diff(strainMin1, mid1);

f_dMax_left  = matlabFunction(dMax_left1,  'Vars', [left1 right1 mid1]);
f_dMax_right = matlabFunction(dMax_right1, 'Vars', [left1 right1 mid1]);
f_dMax_mid   = matlabFunction(dMax_mid1,   'Vars', [left1 right1 mid1]);
f_dMin_left  = matlabFunction(dMin_left1,  'Vars', [left1 right1 mid1]);
f_dMin_right = matlabFunction(dMin_right1, 'Vars', [left1 right1 mid1]);
f_dMin_mid   = matlabFunction(dMin_mid1,   'Vars', [left1 right1 mid1]);

dMax_left_eval  = arrayfun(f_dMax_left,  left, right, mid);
dMax_right_eval = arrayfun(f_dMax_right, left, right, mid);
dMax_mid_eval   = arrayfun(f_dMax_mid,   left, right, mid);
dMin_left_eval  = arrayfun(f_dMin_left,  left, right, mid);
dMin_right_eval = arrayfun(f_dMin_right, left, right, mid);
dMin_mid_eval   = arrayfun(f_dMin_mid,   left, right, mid);

variableUncertainty = @(x) 1e-6*ones(size(x));

Usys_PrincipalMax = sqrt((dMax_left_eval  .* variableUncertainty(left)).^2 + ...
               (dMax_right_eval .* variableUncertainty(right)).^2 + ...
               (dMax_mid_eval   .* variableUncertainty(mid)).^2);

Usys_PrincipalMin = sqrt((dMin_left_eval  .* variableUncertainty(left)).^2 + ...
               (dMin_right_eval .* variableUncertainty(right)).^2 + ...
               (dMin_mid_eval   .* variableUncertainty(mid)).^2); 

Usys_principal = sqrt((dMax_left_eval  .* variableUncertainty(left)).^2 + ...
            (dMax_right_eval .* variableUncertainty(right)).^2 + ...
            (dMax_mid_eval   .* variableUncertainty(mid)).^2 + ...
            (dMin_left_eval  .* variableUncertainty(left)).^2 + ...
            (dMin_right_eval .* variableUncertainty(right)).^2 + ...
            (dMin_mid_eval   .* variableUncertainty(mid)).^2);

syms deflection1
F1 = 3*E*I*deflection1/l^3;
dF1  = diff(F1, deflection1);
df1p = matlabFunction(dF1, 'Vars', [deflection1]);
dF1_eval = arrayfun(df1p, deflection);
Sigma_flex1 = dF1*x*c/I;

Usys_flexural = sqrt((dF1_eval .* variableUncertainty(deflection)).^2);

Usys_principal=Usys_principal*100;
Usys_flexural=Usys_flexural*100;
Usys_PrincipalMax=Usys_PrincipalMax*100;
Usys_PrincipalMin=Usys_PrincipalMin*100;

Results = table(stress1(:), stress2(:), Sigma_flex(:), Usys_PrincipalMax(:), Usys_PrincipalMin(:), Usys_principal(:), Usys_flexural(:), ...
                'VariableNames', {'Stress1(psi)','Stress2(psi)','FlexuralStress(psi)','PrincipalMaxUncertainty(%)', 'PrincipalMinUncertainty(%)', 'PrincipalUncertainty(%)','FlexuralUncertainty(%)'});

disp(Results)
