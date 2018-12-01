%% MODELADO CINEMATICO DEL ROBOT
% Obtencion del modelo a partir de las ecuaciones dinamicas para cada
% articulacion.

% %%%%%%% MODELO CON REDUCTORAS DEL ROBOT IDEAL %%%%%%%%%%%%%%%
% Ma11=0.088863*cos(2.0*q2 + q3) + 0.1189*cos(2.0*q2) + 0.088863*cos(q3) + 0.029404*cos(2.0*q2 + 2.0*q3) + 1.1525
% Ma22=0.37026*cos(q3) + 5.8299
% Ma33=2.4628
% Para linealizar se tomaran todas las q como cero (Otro modo seria
% despreciar todo lo que no sea termino independiente).

% Va1=-8.6736e-21*qd1*(2.049e19*qd2*sin(2.0*q2 + q3) + 1.0245e19*qd3*sin(2.0*q2 + q3) + 2.7416e19*qd2*sin(2.0*q2) + 1.0245e19*qd3*sin(q3) + 6.7799e18*qd2*sin(2.0*q2 + 2.0*q3) + 6.7799e18*qd3*sin(2.0*q2 + 2.0*q3) - 1.3834e19)
% Va2=0.063796*qd2 - 0.18513*qd3^2*sin(q3) + 0.061258*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.18513*qd1^2*sin(2.0*q2 + q3) + 0.2477*qd1^2*sin(2.0*q2) - 0.37026*qd2*qd3*sin(q3)
% Va3=0.064287*qd3 + 0.21158*qd1^2*sin(q3) + 0.42316*qd2^2*sin(q3) + 0.14003*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.21158*qd1^2*sin(2.0*q2 + q3)
% Para linealizar la matriz V, se tomar�n �nicamente los terminos que
% acompanen la derivada de la componente que se est� hayando, por ejemplo,
% en este caso ser�a
% Va1=0.1200*qd1
% Va2=0.063796*qd2 
% Va3=0.064287*qd3

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

g=9.8;L0=0.6;L1=0.6;L2=1;L3=0.8;
Kt1=0.5; Kt2=0.4; Kt3 =0.35;

% Se decide entre usar reductoras o no
if (flag==1)
    R1=50; R2=30; R3=15;   
elseif (flag==0)
    R1=1; R2=1; R3=1;   
end

%%   % %%%% ROBOT IDEAL CON REDUCTORAS %%%%
% Obtencion del termino de la matriz de inercias simplificado
Ma1=1.4785; %Ma1=eval( subs(subs(subs(Ma(1,1),q1,0),q2,0),q3,0)); 
Ma2=6.2002; %Ma2=eval( subs(subs(subs(Ma(2,2),q1,0),q2,0),q3,0)); 
Ma3=2.4628; %Ma3=eval( subs(subs(subs(Ma(3,3),q1,0),q2,0),q3,0)); 

% Se ha extraido los valores de las Bm_i de los parametros tetha_li
Va1=0.1200;     % Bm*(R^2)
Va2=0.063796;
Va3=0.064287;


% Reductoras y Kt
Kt1=0.5; Kt2=0.4; Kt3 =0.35;
R1=50; R2=30; R3=15;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obtencion de las funciones de transferencia para los controladores ->
% %%%%% PID Y PD MONOARTICULAR. %%%%%%%%%
numG1=Kt1*R1;
denG1=conv([1 0],[Ma1 Va1]);
G1=tf(numG1,denG1);

numG2=Kt2*R2;
denG2=conv([1 0],[Ma2 Va2]);
G2=tf(numG2,denG2);

numG3=Kt3*R3;
denG3=conv([1 0],[Ma3 Va3]);
G3=tf(numG3,denG3);

% PARAMETROS PD IDEAL CON REDUCTORAS
 Kp1=698.59; Td1=0.092; 
 Kp2=3387.6; Td2=0.086;
 Kp3=1044.9;  Td3=0.097;

% PARAMETROS PID IDEAL CON REDUCTORAS
 Ti1=2*0.18; Td1=(0.18^2)/(0.18*2);   Kp1=1652.2*Ti1;
 Ti2=2*0.2; Td2=(0.2^2)/(0.2*2);   Kp2=5227.8*Ti2; 
 Ti3=2*0.18; Td3=(0.18^2)/(0.18*2);   Kp3=2761.4*Ti3; 

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obtencion de las funciones de transferencia para los controladores ->
% %%%%% PID Y PD FEEDFORWARD. %%%%%%%%%
 numG1_ff=Kt1*R1;
 denG1_ff=[Ma1 0 0];
 G1_ff=tf(numG1_ff,denG1_ff);

 numG2_ff=Kt2*R2;
 denG2_ff=[Ma2 0 0];
 G2_ff=tf(numG2_ff,denG2_ff);

 numG3_ff=Kt3*R3;
 denG3_ff=[Ma3 0 0];
 G3_ff=tf(numG3_ff,denG3_ff);

%PAR�METROS PD IDEAL FEEDFORWARD CON REDUCTORAS
  Td1=0.089; Kp1=747.26;
  Td2=0.096; Kp2=2691.1; 
  Td3=0.1; Kp3=985.12;

%PAR�METROS PID IDEAL FEEDFORWARD CON REDUCTORAS
  Ti1=0.36; Td1=0.09; Kp1=591.264;
  Ti2=0.36; Td2=0.09; Kp2=2474.1; 
  Ti3=0.36; Td3=0.09; Kp3=982.008;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obtencion de las funciones de transferencia para los controladores ->
% %%%%% PID Y PD PAR CALCULADO. %%%%%%%%%
numG1_pc=1;
denG1_pc=[Ma1 0 0];
G1_pc=tf(numG1_pc,denG1_pc);

numG2_pc=1;
denG2_pc=[Ma2 0 0];
G2_pc=tf(numG2_pc,denG2_pc);

numG3_pc=1;
denG3_pc=[Ma3 0 0];
G3_pc=tf(numG3_pc,denG3_pc);
  
%PAR�METROS PD IDEAL PAR CALCULADO CON REDUCTORA
  Td1=0.082; Kp1=1468.3;
  Td2=0.082; Kp2=1468.3; 
  Td3=0.092; Kp3=1468.3;

%PAR�METROS PID IDEAL PAR CALCULADO CON REDUCTORA
  Ti1=0.36; Td1=0.09; Kp1=1107.7;
  Ti2=0.36; Td2=0.09; Kp2=1107.7; 
  Ti3=0.36; Td3=0.09; Kp3=1107.7;


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  %%   % %%%% ROBOT IDEAL SIN REDUCTORAS %%%%
% Obtencion del termino de la matriz de inercias simplificado
Ma1=23.9668; %Ma1=eval( subs(subs(subs(M(1,1),q1,0),q2,0),q3,0)); 
Ma2=30.0770; %Ma2=eval( subs(subs(subs(M(2,2),q1,0),q2,0),q3,0)); 
Ma3=4.4698; %Ma3=eval( subs(subs(subs(M(3,3),q1,0),q2,0),q3,0)); 
% Se ha extraido los valores de las Bm_i de los parametros tetha_li
Va1=0.0023878;     % Bm*(R^2)
Va2=0.003035;
Va3=0.0041829;
% Reductoras y Kt
Kt1=0.5; Kt2=0.4; Kt3 =0.35;
R1=1; R2=1; R3=1; 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obtencion de las funciones de transferencia para los controladores ->
% %%%%% PID Y PD MONOARTICULAR. %%%%%%%%%
numG1=Kt1*R1;
denG1=conv([1 0],[Ma1 Va1]);
G1=tf(numG1,denG1);
numG2=Kt2*R2;
denG2=conv([1 0],[Ma2 Va2]);
G2=tf(numG2,denG2);
numG3=Kt3*R3;
denG3=conv([1 0],[Ma3 Va3]);
G3=tf(numG3,denG3);
% PARAMETROS PD IDEAL SIN REDUCTORAS
 Kp1=19173; Td1=0.1; 
 Kp2=30077; Td2=0.1;
 Kp3=6180.8;  Td3=0.091;
% PARAMETROS PID IDEAL SIN REDUCTORAS
 Ti1=2*0.2; Td1=(0.2^2)/(0.2*2);   Kp1=40444*Ti1;
 Ti2=2*0.2; Td2=(0.2^2)/(0.2*2);   Kp2=63451*Ti2; 
 Ti3=2*0.2; Td3=(0.2^2)/(0.2*2);   Kp3=10775*Ti3; 
  
  
  
  


%% %%%% ROBOT REAL CON REDUCTORAS %%%%
Ma1=1.530232687999876; %Ma1=eval( subs(subs(subs(Ma(1,1),q1,0),q2,0),q3,0)); 
Ma2=4.961743100000301; %Ma2=eval( subs(subs(subs(Ma(2,2),q1,0),q2,0),q3,0)); 
Ma3=2.4628; %Ma3=eval( subs(subs(subs(Ma(3,3),q1,0),q2,0),q3,0)); 

% Se ha extraido los valores de las Bm_i de los parametros tetha_li
Va1= 0.1223;     % Bm*(R^2)
Va2=0.096929;
Va3=0.064764;

% Reductoras y Kt
Kt1=0.5; Kt2=0.4; Kt3 =0.35;
R1=50; R2=30; R3=15;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obtencion de las funciones de transferencia para los controladores ->
% %%%%% PID Y PD MONOARTICULAR. %%%%%%%%%
numG1=Kt1*R1;
denG1=conv([1 0],[Ma1 Va1]);
G1=tf(numG1,denG1);

numG2=Kt2*R2;
denG2=conv([1 0],[Ma2 Va2]);
G2=tf(numG2,denG2);

numG3=Kt3*R3;
denG3=conv([1 0],[Ma3 Va3]);
G3=tf(numG3,denG3);

% PARAMETROS PD REAL CON REDUCTORAS
  Kp1=1386.4; Td1=0.066; 
  Kp2=4075.9; Td2=0.07;
  Kp3=956.67;  Td3=0.1;

% PARAMETROS PID REAL  CON REDUCTORAS
% -> (CUANDO FUNCIONEN LOS PID EN DISCRETO SE DISE�AR�, MIENTRAS TANTO DA
% PEREZA Y ES INNECESARIO.)
  Ti1=0.36; Td1=0.18;   Kp1=68.115*Ti1;
  Ti2=0.36; Td2=0.18;   Kp2=513.04*Ti2; 
  Ti3=0.36; Td3=0.18;   Kp3=542.09*Ti3; 
  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obtencion de las funciones de transferencia para los controladores ->
% %%%%% PID Y PD FEEDFORWARD. %%%%%%%%%
numG1_ff=Kt1*R1;
denG1_ff=[Ma1 0 0];
G1_ff=tf(numG1_ff,denG1_ff);

numG2_ff=Kt2*R2;
denG2_ff=[Ma2 0 0];
G2_ff=tf(numG2_ff,denG2_ff);

numG3_ff=Kt3*R3;
denG3_ff=[Ma3 0 0];
G3_ff=tf(numG3_ff,denG3_ff);

%PAR�METROS PID REAL  FEEDFORWARD CON REDUCTORAS
  Td1=0.082; Kp1=1468.3;
  Td2=0.098; Kp2=2085.2; 
  Td3=0.096; Kp3=1078.4;

%PAR�METROS PID REAL  FEEDFORWARD CON REDUCTORAS
  Ti1=0.36; Td1=0.09; Kp1=591.264;
  Ti2=0.36; Td2=0.09; Kp2=2474.1; 
  Ti3=0.36; Td3=0.09; Kp3=982.008;
  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obtencion de las funciones de transferencia para los controladores ->
% %%%%% PID Y PD PAR CALCULADO. %%%%%%%%%
numG1_pc=1;
denG1_pc=[1 0 0];
G1_pc=tf(numG1_pc,denG1_pc);

numG2_pc=1;
denG2_pc=[1 0 0];
G2_pc=tf(numG2_pc,denG2_pc);

numG3_pc=1;
denG3_pc=[1 0 0];
G3_pc=tf(numG3_pc,denG3_pc);
  
%PAR�METROS PD REAL  PAR CALCULADO CON REDUCTORA
  Td1=0.1; Kp1=400;
  Td2=0.1; Kp2=400; 
  Td3=0.1; Kp3=400;

%PAR�METROS PID REAL  PAR CALCULADO CON REDUCTORA
  Ti1=0.36; Td1=0.09; Kp1=1107.7;
  Ti2=0.36; Td2=0.09; Kp2=1107.7; 
  Ti3=0.36; Td3=0.09; Kp3=1107.7;
