%% DEFINICION DE VARIABLES DE SIMUACION

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Experimento 1--> Componentes Inerciales 1 3 4 6 7 8
% Altas aceleraciones  en las articulaciones que se quieran determinar sus
% parametros
% Los valores de atenuacion y de amplitud de la senoide seran altos para
% favorecer un cambio brusco en las posiciones
% Los valores de continua son un poco indiferentes en estos casos
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %/*EXPONENCIALES*/%
% %Valores de tiempo atenuacion
% tau1=80; tau2=90; tau3=100;
% 
% %%Parametros senoides
% %Senoide I1
% Im_cc1=8;
% 
% %Senoide I2
% Im_cc2=2000;
% 
% %Senoide I3
% Im_cc3=0.8;

% close all
% Im_cc=[Im_cc1,Im_cc2,Im_cc3];
% tau=[tau1,tau2,tau3];
% % % 
%  x=1:140;
%  y=exp(x);
%  figure(4)
%  label=120;
% for i=1:3
%     sig1=(Im_cc(i).*y)./(y.*exp(-x./tau(i)));
%  subplot(1,3,i); plot(x(1:label),sig1(1:label)); grid; title(['Forma Onda Im ',num2str(i),' para q ',num2str(i)]); 
%  
% end
% % % Valores de tiempo atenuacion
% tau1=500; tau2=500; tau3=500;
% 
% %Parametros senoides
% % Senoide I1
% Aa_1=-50000; Ab_1=150;
% wa_1=25; wb_1=25;
% Im_cc1=0;
% 
% % Senoide I2
% Aa_2=500; Ab_2=-300;
% wa_2=100; wb_2=5;
% Im_cc2=6.5;
% 
% % Senoide I3
% Aa_3=-500; Ab_3=100;
% wa_3=100; wb_3=15;
% Im_cc3=3.5;

%/*EXPONENCIALES*/% -- theta li 1 y 4
% %Valores de tiempo atenuacion
% tau1=45; tau2=50; tau3=60;  
% 
% %%Parametros senoides
% %Senoide I1
% Im_cc1=14;
% 
% %Senoide I2
% Im_cc2=80;
% 
% %Senoide I3
% Im_cc3=15;

% %/*EXPONENCIALES*/%
% %Valores de tiempo atenuacion
% tau1=80000000; tau2=2500000000000; tau3=25;
% 
% %%Parametros senoides
% %Senoide I1
% Im_cc1=-00.000001;
% 
% %Senoide I2
% Im_cc2=84;
% 
% %Senoide I3
% Im_cc3=40;

% %%%%%%%%%%%%%%%% RESULTADOS CON EL ROBOT 1 %%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tetha_li(1)= 1.699503e+01 Valido con varianza 4.057306e+00 
% 
% tetha_li(3)= 1.239397e+01 Valido con varianza 1.290980e+00 
% tetha_li(4)= 3.828013e+01 Valido con varianza 1.947205e+00 
% tetha_li(6)= 1.434048e+00 Valido con varianza 9.174805e-01 
%  tetha_li(7)= 4.037223e+00 Valido con varianza 4.545900e+00 
% tetha_li(8)= 4.914669e-02 Valido con varianza 1.234847e+00 

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

% %Valores de tiempo atenuacion -->tetha_li(5)
% tau1=1; tau2=60; tau3=0.01;
% 
% %%Parametros senoides
% %Senoide I1
% Aa_1=0.2; Ab_1=0.003;
% wa_1=10; wb_1=3;
% Im_cc1=0;
% 
% %Senoide I2
% Aa_2=5; Ab_2=0.01;
% wa_2=40; wb_2=3;
% Im_cc2=5.39;
% 
% %Senoide I3
% Aa_3=0.5; Ab_3=2;
% wa_3=8; wb_3=3;
% Im_cc3=0;

% % Valores de tiempo atenuacion -->tetha_li(9)
% tau1=1; tau2=201; tau3=1;
% 
% %%Parametros senoides
% %Senoide I1
% Aa_1=0.2; Ab_1=0.003;
% wa_1=10; wb_1=3;
% Im_cc1=0;
% 
% %Senoide I2
% Aa_2=3; Ab_2=4;
% wa_2=10; wb_2=50;
% Im_cc2=0;
% 
% %Senoide I3
% Aa_3=0.5; Ab_3=2;
% wa_3=8; wb_3=3;
% Im_cc3=3;

% %%%%%%%%%%%%%%%% RESULTADOS CON EL ROBOT 1 %%%%%%%%%%%%%%%%%%%%%%%%%%
% tetha_li(2)= 1.223191e-03 Valido con varianza 2.537974e-01 
% tetha_li(5)= 1.292382e-03 Valido con varianza 9.407260e-01 
% tetha_li(9)= 1.511168e-03 Valido con varianza 1.468039e+00 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Experimento 3--> Componentes Gravitacionales  10 11
% Velocidades bajas:
   %    Intensidades constantes y bajas(Poco movimiento)
   
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Valores de tiempo atenuacion
% tau1=1; tau2=3; tau3=0.03;
% 
% %%Parametros senoides
% %Senoide I1
% Aa_1=0.2; Ab_1=0.003;
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
% tetha_li(10)= -6.672244e+00 Valido con varianza 3.858041e-02 
% tetha_li(11)= -2.198972e+00 Valido con varianza 8.916358e-02 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

