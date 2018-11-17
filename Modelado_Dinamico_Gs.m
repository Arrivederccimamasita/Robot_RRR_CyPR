%% MODELADO CINEMATICO DEL ROBOT
% Obtención del modelo a partir de las ecuaciones dinamicas para cada
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
% Para linealizar la matriz V, se tomarán únicamente los terminos que
% acompañen la derivada de la componente que se esté hayando, por ejemplo,
% en este caso sería
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
% % Obtencion del termino de la matriz de inercias simplificado
% Ma1=1.4785; %Ma1=eval( subs(subs(subs(Ma(1,1),q1,0),q2,0),q3,0)); 
% Ma2=6.2002; %Ma2=eval( subs(subs(subs(Ma(2,2),q1,0),q2,0),q3,0)); 
% Ma3=2.4628; %Ma3=eval( subs(subs(subs(Ma(3,3),q1,0),q2,0),q3,0)); 
% 
% % Se ha extraido los valores de las Bm_i de los parametros tetha_li
% Va1=0.1200;     % Bm*(R^2)
% Va2=0.063796;
% Va3=0.064287;


%% %%%% ROBOT REAL CON REDUCTORAS %%%%
Ma1=1.530232687999876; %Ma1=eval( subs(subs(subs(Ma(1,1),q1,0),q2,0),q3,0)); 
Ma2=4.961743100000301; %Ma2=eval( subs(subs(subs(Ma(2,2),q1,0),q2,0),q3,0)); 
Ma3=2.4628; %Ma3=eval( subs(subs(subs(Ma(3,3),q1,0),q2,0),q3,0)); 

% Se ha extraido los valores de las Bm_i de los parametros tetha_li
Va1= 0.1223;     % Bm*(R^2)
Va2=0.096929;
Va3=0.064764;

% Obtencion de las funciones de transferencia para los controladores PID Y
% PD.
numG1=1;
denG1=conv([1 0],[Ma1 Va1]);
G1=tf(numG1,denG1);

numG2=1;
denG2=conv([1 0],[Ma2 Va2]);
G2=tf(numG2,denG2);

numG3=1;
denG3=conv([1 0],[Ma3 Va3]);
G3=tf(numG3,denG3);

% PARAMETROS PD CON REDUCTORAS
  Kp1=1386.4; Td1=0.066; 
  Kp2=4075.9; Td2=0.07;
  Kp3=956.67;  Td3=0.1;

% PARAMETROS PID CON REDUCTORAS
  Ti1=2*0.18; Td1=(2*(0.18^2))/Ti1;   Kp1=68.115*Ti1;
  Ti2=2*0.19; Td2=(2*(0.19^2))/Ti2;   Kp2=513.04*Ti2; 
  Ti3=2*0.18; Td3=(2*(0.18^2))/Ti3;   Kp3=542.09*Ti3; 

% Obtencion de las funciones de transferencia para los controladores ->
% Feedforward
numG1_ff=1;
denG1_ff=[1 0 0];
G1_ff=tf(numG1_ff,denG1_ff);

numG2_ff=1;
denG2_ff=[1 0 0];
G2_ff=tf(numG2_ff,denG2_ff);

<<<<<<< HEAD


numG3_ff=1;
denG3_ff=[1 0 0];
=======
numG3_ff=Kt3*R3;
denG3_ff=[1 0 0]*Ma3;
>>>>>>> d8c44c8f62d2d99eea4afdcc31b78b7dcb92209a
G3_ff=tf(numG3_ff,denG3_ff);


%PARÁMETROS PID PRECOMPENSADOR DINAMICA CON REDUCTORAS
  Ti1=0.36; Td1=0.09; Kp1=591.264;
  Ti2=0.36; Td2=0.09; Kp2=2474.1; 
  Ti3=0.36; Td3=0.09; Kp3=982.008;
  
%PARÁMETROS PID PAR CALCULADO CON REDUCTORA
  Ti1=0.36; Td1=0.09; Kp1=1107.7;
  Ti2=0.36; Td2=0.09; Kp2=1107.7; 
  Ti3=0.36; Td3=0.09; Kp3=1107.7;
  