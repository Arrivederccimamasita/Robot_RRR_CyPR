%% DEFINICION DE VARIABLES DE SIMUACION
% Se asignarán los valores que se le darán a los senos para estimar el
% modelo del robot.

% Valores de tiempo atenuacion
tau1=5; tau2=5; tau3=5;

% %%%% Parametros senoides %%%%
% Senoide I1
Aa_1=10; Ab_1=20;
wa_1=50; wb_1=1;
Im_cc1=0;

% Senoide I2
Aa_2=20; Ab_2=5;
wa_2=5; wb_2=10;
Im_cc2=10;

% Senoide I3
Aa_3=5; Ab_3=1;
wa_3=10; wb_3=3;
Im_cc3=8;

% %%%%%%%%%%%%%%% VALORES DE PALOMA %%%%%%%%%%%%%
% % Parametros senoides
% % Senoide I1
% Aa_1=.01; Ab_1=.1;
% wa_1=100; wb_1=30;
% Im_cc1=3;
% 
% % Senoide I2
% Aa_2=0; Ab_2=0;
% wa_2=100; wb_2=20;
% Im_cc2=.001;
% 
% % Senoide I3
% Aa_3=0; Ab_3=0;
% wa_3=100; wb_3=10;
% Im_cc3=.001;