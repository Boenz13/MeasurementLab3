load   = readmatrix('measurements lab 3.xlsx', 'Range', 'B4:B18');
Al_deltaEout  = readmatrix('measurements lab 3.xlsx', 'Range', 'C4:C18');
Br_deltaEout  = readmatrix('measurements lab 3.xlsx', 'Range', 'E4:E18');
St_deltaEout  = readmatrix('measurements lab 3.xlsx', 'Range', 'G4:G18');
SGI_axialStrain = readmatrix('measurements lab 3.xlsx', 'Range', 'I4:I18');

% Cancel out the reference
Al_deltaEout = Al_deltaEout - Al_deltaEout(1);
Br_deltaEout = Br_deltaEout - Br_deltaEout(1);
St_deltaEout = St_deltaEout - St_deltaEout(1);
SGI_axialStrain = SGI_axialStrain - SGI_axialStrain(1);
SGI_axialStrain=SGI_axialStrain*1e-6;

Al_x  = 7.717;   Br_x  = 7.875;   St_x  = 5.9375;
Al_h  = 0.301;   Br_h  = 0.315;   St_h  = 0.316;
Al_b  = 2.495;   Br_b  = 2.631;   St_b  = 1.89;
Al_GF = 2.085;   Br_GF = 2.085;   St_GF = 2.07;
Ein   = 5;


Al_Epsilon = (4 .* Al_deltaEout .* 1e-3) ./ (Al_GF .* Ein);  
Br_Epsilon = (4 .* Br_deltaEout .* 1e-3) ./ (Br_GF .* Ein);  
St_Epsilon = (4 .* St_deltaEout .* 1e-3) ./ (St_GF .* Ein);  

Al_AxSigma = (6 .* load .* Al_x) ./ (Al_b .* Al_h.^2);
Br_AxSigma = (6 .* load .* Br_x) ./ (Br_b .* Br_h.^2);
St_AxSigma = (6 .* load .* St_x) ./ (St_b .* St_h.^2);

figure;
hold on;
plot(Al_Epsilon, Al_AxSigma, 'b-o', 'LineWidth', 1.5, 'MarkerSize', 6);
plot(Br_Epsilon, Br_AxSigma, 'r-o', 'LineWidth', 1.5, 'MarkerSize', 6);
plot(St_Epsilon, St_AxSigma, 'g-o', 'LineWidth', 1.5, 'MarkerSize', 6);
plot(SGI_axialStrain, St_AxSigma, 'black-o', 'LineWidth', 1.5, 'MarkerSize', 6);
hold off;
grid on;

xlabel('Axial strain \epsilon (in/in)');
ylabel('Axial stress \sigma (psi)');
title('Experimental Young''s Modulus');


legend('Aluminum, E=9.1439e+06(±0.0365e+06), R^2=0.99996', ...
    'Brass, E=1.3654e+07(±0.00915e+07), R^2=0.99987', ...
    'Steel, E=3.0363e+07(±0.13115e+07), R^2=0.99483', ...
    'Steel SGI, E=2.9111e+07(±0.0525e+07), R^2=0.99909','Location', 'best');
