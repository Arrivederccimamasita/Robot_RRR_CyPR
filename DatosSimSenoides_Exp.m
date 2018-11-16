%% DEFINICION DE VARIABLES DE SIMUACION

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Experimento 1--> Componentes Inerciales 1 3 4 6 7 8
% Altas aceleraciones  en las articulaciones que se quieran determinar sus
% parametros
% Los valores de atenuacion y de amplitud de la senoide seran altos para
% favorecer un cambio brusco en las posiciones
% Los valores de continua son un poco indiferentes en estos casos
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Valores de tiempo atenuacion
% tau1=50; tau2=50; tau3=50;
% 
% %%Parametros senoides
% %Senoide I1
% Aa_1=30; Ab_1=-15;
% wa_1=50; wb_1=25;
% Im_cc1=0;
% 
% %Senoide I2
% Aa_2=500; Ab_2=3000;
% wa_2=1000; wb_2=500;
% Im_cc2=4;
% 
% %Senoide I3
% Aa_3=500; Ab_3=-200;
% wa_3=2500; wb_3=180;
% Im_cc3=0;
% %%%%%%%%%%%%%%%% RESULTADOS CON EL ROBOT 1 %%%%%%%%%%%%%%%%%%%%%%%%%%
% tetha_li(1)= 5.177741e-01 Valido con varianza 3.050563e-01 

% tetha_li(3)= 4.111864e-01 Valido con varianza 1.482583e-01 
% tetha_li(4)= 2.155435e+00 Valido con varianza 2.327592e-01

% tetha_li(6)= 9.144416e-02 Valido con varianza 5.494563e-01 
% tetha_li(7)= -9.123942e-02 Valido con varianza 6.849432e-01 
% tetha_li(8)= 2.091029e-03 Valido con varianza 2.066678e-01 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Experimento 2--> Componentes Viscosos  2 5 9 
% Velocidades constantes en las articulaciones pertinentes
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Valores de tiempo atenuacion-->tetha_li(2)
% tau1=5; tau2=1; tau3=1;
% 
% %Parametros senoides
% %Senoide I1
% Aa_1=2; Ab_1=5;
% wa_1=5; wb_1=2;
% Im_cc1=2;
% 
% %Senoide I2
% Aa_2=0.5; Ab_2=2;
% wa_2=15; wb_2=3;
% Im_cc2=0;
% 
% %Senoide I3
% Aa_3=0.5; Ab_3=2;
% wa_3=8; wb_3=3;
% Im_cc3=0;

%Valores de tiempo atenuacion -->tetha_li(5)
tau1=0.00001; tau2=0.5; tau3=0.01;

%%Parametros senoides
%Senoide I1
Aa_1=2; Ab_1=3;
wa_1=10; wb_1=3;
Im_cc1=0;

%Senoide I2
Aa_2=2; Ab_2=5;
wa_2=15; wb_2=3;
Im_cc2=7;

%Senoide I3
Aa_3=0.5; Ab_3=2;
wa_3=8; wb_3=3;
Im_cc3=2;

% % Valores de tiempo atenuacion -->tetha_li(9)
% tau1=0.0001; tau2=0.0001; tau3=1;
% 
% %%Parametros senoides
% %Senoide I1
% Aa_1=2; Ab_1=3;
% wa_1=10; wb_1=3;
% Im_cc1=0;
% 
% %Senoide I2
% Aa_2=0.5; Ab_2=2;
% wa_2=15; wb_2=3;
% Im_cc2=2;
% 
% %Senoide I3
% Aa_3=0.5; Ab_3=2;
% wa_3=8; wb_3=3;
% Im_cc3=4;

% %%%%%%%%%%%%%%%% RESULTADOS CON EL ROBOT 1 %%%%%%%%%%%%%%%%%%%%%%%%%%
% tetha_li(2)= 4.772908e-05 Valido con varianza 1.192384e-01 

% tetha_li(5)= 3.169089e-05 Valido con varianza 7.682833e+00 

% tetha_li(9)= 5.713235e-05 Valido con varianza 6.331003e+00 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Experimento 3--> Componentes Gravitacionales  10 11
% Velocidades bajas:
   %    Intensidades constantes y bajas(Poco movimiento)
   
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Valores de tiempo atenuacion
% tau1=0.00001; tau2=3; tau3=0.03;
% 
% %%Parametros senoides
% %Senoide I1
% Aa_1=2; Ab_1=3;
% wa_1=10; wb_1=3;
% Im_cc1=0;
% 
% %Senoide I2
% Aa_2=1; Ab_2=3;
% wa_2=15; wb_2=3;
% Im_cc2=6.5;
% 
% %Senoide I3
% Aa_3=0.5; Ab_3=2;
% wa_3=15; wb_3=3;
% Im_cc3=3.5;

% %%%%%%%%%%%%%%%% RESULTADOS CON EL ROBOT 1 %%%%%%%%%%%%%%%%%%%%%%%%%%
% tetha_li(10)= -3.255365e-01 Valido con varianza 1.490022e-01 
% tetha_li(11)= -9.254916e-02 Valido con varianza 2.492286e-01
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

