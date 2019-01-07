%% OBTENCION DE LOS MODELOS DE LAS ARTICULACIONES 
% Se asume declarada en el codigo las matrices dinamicas del modelo 
% del robot que se busque en simbolico

% Obtencion del termino de la matriz de inercias simplificado
% Ma1=eval( subs(subs(subs(Ma(1,1),q1,0),q2,0),q3,0)); 
% Ma2=eval( subs(subs(subs(Ma(2,2),q1,0),q2,0),q3,0)); 
% Ma3=eval( subs(subs(subs(Ma(3,3),q1,0),q2,0),q3,0)); 

% Para conocer Va, se tomará el término de la matriz Va el termino que % tenga el q_i asociado a cada articulacion

% Reductoras
% R1=50; R2=30; R3=15;
% R1=1; R2=1; R3=1;
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
