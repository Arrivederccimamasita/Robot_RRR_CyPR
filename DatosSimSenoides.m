%% DEFINICION DE VARIABLES DE SIMUACION
% Se asignarán los valores que se le darán a los senos para estimar el
% modelo del robot.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hola mi gente, soy marco. No soy capaz de estimar de una
% tirada todos los parametros con el robot real. He hecho los filtros tanto
% para el caso del robot 3 como para el caso 5. Los errores en
% aceleraciones son un poco movida... :-(
% nananananananana baatman baaaatman (simbolo de batman)
% Pos eso, que no puedo.. solo tenemos robots ideales shurmanos...
% simpsooooooon homer simpsonnnn es el tio mas guai que haaaaaaaay
% Viva españa viva el rey viva el orden y la ley..
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Valores de tiempo atenuacion
tau1=5; tau2=5; tau3=5;

% %%%% Parametros senoides %%%%
% Senoide I1
Aa_1=1; Ab_1=2; % Ab_1=2;
wa_1=10; wb_1=120;
Im_cc1=1;   % Es un poco mejor uno y un poco peor otro

% Senoide I2
Aa_2=3; Ab_2=1;
wa_2=5; wb_2=100;
Im_cc2=2; % Im_cc2=5;

% Senoide I3
Aa_3=2; Ab_3=.1;
wa_3=3; wb_3=10;
Im_cc3=5;
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
