%% DEFINICION DE VARIABLES DE SIMUACION

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Experimento 1--> Componentes Inerciales 1 3 4 6 7 8
% Altas aceleraciones  en las articulaciones que se quieran determinar sus
% parametros
% Los valores de atenuacion y de amplitud de la senoide seran altos para
% favorecer un cambio brusco en las posiciones
% Los valores de continua son un poco indiferentes en estos casos
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %/*EXPONENCIALES*/% --> tetha_li(1)
% %Valores de tiempo atenuacion
% tau1=100; tau2=50; tau3=80;
% 
% %%Parametros senoides
% %Senoide I1
% Im_cc1=5000;
% 
% %Senoide I2
% Im_cc2=2000;
% 
% %Senoide I3
% Im_cc3=800;
% 

% %/*EXPONENCIALES*/% --> tetha_li(3)
% %Valores de tiempo atenuacion
% tau1=80; tau2=90; tau3=100;
% 
% %%Parametros senoides
% %Senoide I1
% Im_cc1=8;
% 
% %Senoide I2
% Im_cc2=1000;
% 
% %Senoide I3
% Im_cc3=0.8;

% % /*EXPONENCIALES*/% -- theta li(4)
% %Valores de tiempo atenuacion
% tau1=45; tau2=50; tau3=60;  
% 
% %%Parametros senoides
% %Senoide I1
% Im_cc1=18;
% 
% %Senoide I2
% Im_cc2=1000;
% 
% %Senoide I3
% Im_cc3=200;


% %/*EXPONENCIALES*/% --> tetha_li(6)
% %Valores de tiempo atenuacion
% tau1=600; tau2=500; tau3=80;
% 
% %%Parametros senoides
% %Senoide I1
% Im_cc1=1000;
% 
% %Senoide I2
% Im_cc2=2000;
% 
% %Senoide I3
% Im_cc3=800;

% %Valores de tiempo atenuacion -->tetha_li(7)
% tau1=1; tau2=15; tau3=600;
% 
% %%Parametros senoides
% %Senoide I1
% Aa_1=0.2; Ab_1=0.003;
% wa_1=10; wb_1=3;
% Im_cc1=0;
% 
% %Senoide I2
% Aa_2=3000; Ab_2=-500;
% wa_2=0.5; wb_2=3;
% Im_cc2=50;
% 
% %Senoide I3
% Aa_3=14; Ab_3=50;
% wa_3=0.8; wb_3=0.3;
% Im_cc3=10;


% %Valores de tiempo atenuacion -->tetha_li(8)
% tau1=1; tau2=1; tau3=200;
% 
% %%Parametros senoides
% %Senoide I1
% Aa_1=0.2; Ab_1=0.003;
% wa_1=10; wb_1=3;
% Im_cc1=0;
% 
% %Senoide I2
% Aa_2=0.5; Ab_2=2;
% wa_2=40; wb_2=3;
% Im_cc2=0;
% 
% %Senoide I3
% Aa_3=4; Ab_3=30;
% wa_3=1; wb_3=0.5;
% Im_cc3=1;

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
% tetha_li(1)= -1.107265e+01 Valido con varianza 2.715765e+00 

% tetha_li(3)= 7.753990e+00 Valido con varianza 3.293765e-01 
% tetha_li(4)= -7.375660e+00 Valido con varianza 1.187990e+00 

%  tetha_li(6)= -2.191643e+00 Valido con varianza 1.329618e+00 
%  tetha_li(7)= -1.005242e+00 Valido con varianza 2.889390e+00
% tetha_li(8)= 1.040467e-01 Valido con varianza 4.149944e+00 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Experimento 2--> Componentes Viscosos  2 5 9 
% Velocidades constantes en las articulaciones pertinentes
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Valores de tiempo atenuacion-->tetha_li(2)
% tau1=5; tau2=0.001; tau3=0.001;
% 
% %Parametros senoides
% %Senoide I1
% Aa_1=2; Ab_1=5;
% wa_1=5; wb_1=2;
% Im_cc1=4;
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
% tau1=1; tau2=100; tau3=200;
% 
% %%Parametros senoides
% %Senoide I1
% Aa_1=0.2; Ab_1=0.003;
% wa_1=10; wb_1=3;
% Im_cc1=0;
% 
% %Senoide I2
% Aa_2=0.5; Ab_2=10;
% wa_2=1; wb_2=0.3;
% Im_cc2=500;
% 
% %Senoide I3
% Aa_3=15; Ab_3=20;
% wa_3=0.1; wb_3=0.5;z
% Im_cc3=40;

% %Valores de tiempo atenuacion -->tetha_li(5?)
% tau1=1; tau2=15; tau3=600;
% 
% %%Parametros senoides
% %Senoide I1
% Aa_1=0.2; Ab_1=0.003;
% wa_1=10; wb_1=3;
% Im_cc1=0;
% 
% %Senoide I2
% Aa_2=3000; Ab_2=-500;
% wa_2=0.5; wb_2=3;
% Im_cc2=1000;
% 
% %Senoide I3
% Aa_3=14; Ab_3=150;
% wa_3=0.8; wb_3=0.8;
% Im_cc3=90;

% %Valores de tiempo atenuacion -->tetha_li(9)
% tau1=1; tau2=1; tau3=150;
% 
% %%Parametros senoides
% %Senoide I1
% Aa_1=0.2; Ab_1=0.003;
% wa_1=10; wb_1=3;
% Im_cc1=0;
% 
% %Senoide I2
% Aa_2=0.5; Ab_2=2;
% wa_2=40; wb_2=3;
% Im_cc2=0;
% 
% %Senoide I3
% Aa_3=4; Ab_3=10;
% wa_3=8; wb_3=0.09;
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
% tetha_li(2)= 1.817417e-02 Valido con varianza 5.484565e-01 

% tetha_li(5)= 6.080764e-02 Valido con varianza 3.259390e+00 

% tetha_li(9)= 6.486531e-03 Valido con varianza 4.030778e+00 
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

% %Valores de tiempo atenuacion -->tetha_li(10)
% tau1=1; tau2=100; tau3=6;
% 
% %%Parametros senoides
% %Senoide I1
% Aa_1=0.2; Ab_1=0.003;
% wa_1=10; wb_1=3;
% Im_cc1=0;
% 
% %Senoide I2
% Aa_2=50; Ab_2=50;
% wa_2=40; wb_2=3;
% Im_cc2=2900;
% 
% %Senoide I3
% Aa_3=4; Ab_3=15;
% wa_3=8; wb_3=3;
% Im_cc3=10;

% %Valores de tiempo atenuacion -->tetha_li(11)
% tau1=1; tau2=1; tau3=100;
% 
% %%Parametros senoides
% %Senoide I1
% Aa_1=0.2; Ab_1=0.003;
% wa_1=10; wb_1=3;
% Im_cc1=0;
% 
% %Senoide I2
% Aa_2=3000; Ab_2=-500;
% wa_2=0.5; wb_2=3;
% Im_cc2=53;
% 
% %Senoide I3
% Aa_3=15; Ab_3=10;
% wa_3=0.05; wb_3=0.3;
% Im_cc3=4;

% %%%%%%%%%%%%%%%% RESULTADOS CON EL ROBOT 1 %%%%%%%%%%%%%%%%%%%%%%%%%%
% tetha_li(10)= -6.750857e+00 Valido con varianza 1.217596e-01 
% tetha_li(11)= 3.741175e-03 Valido con varianza 4.972433e+00 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


tau1=10; tau2=201; tau3=10;

%%Parametros senoides
%Senoide I1
Aa_1=0.2; Ab_1=0.003;
wa_1=10; wb_1=3;
Im_cc1=1;

%Senoide I2
Aa_2=3; Ab_2=4;
wa_2=10; wb_2=50;
Im_cc2=10;

%Senoide I3
Aa_3=0.5; Ab_3=2;
wa_3=8; wb_3=3;
Im_cc3=3;


%Parametros senoides
%Senoide I1
Aa_1=Aa_1/50; Ab_1=Ab_1/50;
Im_cc1=Im_cc1/50;
%Senoide I2
Aa_2=Aa_2/30; Ab_2=Ab_2/30;
Im_cc2=Im_cc2/30;
%Senoide I3
Aa_3=Aa_3/15; Ab_3=Ab_3/15;
Im_cc3=Im_cc3/15;

% %%%%%%%%%%%%%%%% Apuntes Experimentos %%%%%%%%%%%%%%%%%%%%%%%%%%
%  Aunque se realicen los mismos experimentos que con el robot real con
%  reductoras, ya que se ha tomado de base ls experimentos realizados en
%  este, y dividiendo los valores de intensidad entre las reductoras, el
%  modelo de robot cambia; en este caso, la dependencia entre los eslabones
%  es mayor--> sera necesaria mayores valores de intensidad para reducir
%  este efecto.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
