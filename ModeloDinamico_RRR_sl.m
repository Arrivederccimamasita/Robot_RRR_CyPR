%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCIÓN EMPLEADA PARA EJECUTAR LOS DATOS OBTENIDOS A TRAVÉS DEL SCRIPT  %
% "DinamicaRobotNE.m" EN SIMULINK MEDIANTE DEL ARCHIVO                    %
% "sl_R3GDL_Mfunction.mdl"                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [qdd] = ModeloDinamico_RRR_sl(in)
% Variables de entrada en la funcion: [q(3)  qd(3)  Tau(3)]
q1        = in(1);
q2        = in(2);
q3        = in(3);
qd1       = in(4);
qd2       = in(5);
qd3       = in(6);
Im1      = in(7);
Im2      = in(8);
Im3      = in(9);

g=9.8;L0=0.6;L1=0.6;L2=1;L3=0.8;
Kt1=0.5; Kt2=0.4; Kt3 =0.35; Kt=[Kt1; Kt2; Kt3];
R1=50; R2=30; R3=15; R=[R1 ;R2 ;R3];   % Reductoras

% Matriz de Inercias
M=[ 0.088811*cos(2.0*q2 + q3) + 0.11889*cos(2.0*q2) + 0.088811*cos(q3) + 0.02941*cos(2.0*q2 + 2.0*q3) + 1.1527,                           0,                       0;
                                                                                                          0,     0.17762*cos(q3) + 2.799, 0.088811*cos(q3) + 0.060613;
                                                                                                          0, 0.088811*cos(q3) + 0.060613,                     0.51732];
% Matriz de aceleraciones centrípetas y de Coriolis
 
 V=[-6.7763e-21*qd1*(2.6212e19*qd2*sin(2.0*q2 + q3) + 1.3106e19*qd3*sin(2.0*q2 + q3) + 3.5091e19*qd2*sin(2.0*q2) + 1.3106e19*qd3*sin(q3) + 8.6796e18*qd2*sin(2.0*q2 + 2.0*q3) + 8.6796e18*qd3*sin(2.0*q2 + 2.0*q3) - 1.7708e19);
                                                          0.030675*qd2 - 0.088811*qd3^2*sin(q3) + 0.02941*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.088811*qd1^2*sin(2.0*q2 + q3) + 0.11889*qd1^2*sin(2.0*q2) - 0.17762*qd2*qd3*sin(q3);
                                                                                       0.013503*qd3 + 0.044406*qd1^2*sin(q3) + 0.088811*qd2^2*sin(q3) + 0.02941*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.044406*qd1^2*sin(2.0*q2 + q3)];
 


% Par gravitatorio
G=[                                          0;
 (0.08879*cos(q2 + q3) + 0.26665*cos(q2));
                     0.08879*cos(q2 + q3)];
%M=vpa(M,5); V=vpa(V,5); G=vpa(G,5);

% Ecuación del robot
%    Im = M*qpp + V + G
  Im=[Im1;Im2;Im3];

  Im_aux=Im.*(Kt.*R);
% Por lo que:  
% Aceleraciones
%La inversa de M siempore existe porque es simetrica y definida positiva
 % qdd = inv(M)*((Im.*(Kt.*R))-V-G);
 qdd=inv(M)*(Im_aux-V-G);
  