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
R1=50; R2=30; R3=15;    

% Matriz de Inercias
M=[ 0.088863*L3 - 0.14773*cos(2.0*q2) - 0.041686*cos(2.0*q2 + 2.0*q3) + 0.088863*L2*cos(q3) + 0.088863*L3*cos(2.0*q2 + 2.0*q3) + 0.26663*L2*(cos(2.0*q2) + 1.0) + 0.088863*L2*cos(2.0*q2 + q3) + 0.81476,                                                    0,                                    0;
                                                                                                                                                                                                    0, 1.1109*L2 + 0.37026*L3 + 0.37026*L2*cos(q3) + 4.4228, 0.37026*L3 + 0.18513*L2*cos(q3) - 0.1702;
                                                                                                                                                                                                    0,            0.84631*L3 + 0.42316*L2*cos(q3) - 0.38902,    0.0096655*R3^2 + 0.84631*L3 - 0.38902];


% Matriz de aceleraciones centrípetas y de Coriolis
V=[-8.6736e-21*qd1*(- 5.5336e15*R1^2 - 3.4064e19*qd2*sin(2.0*q2) - 9.6121e18*qd2*sin(2.0*q2 + 2.0*q3) - 9.6121e18*qd3*sin(2.0*q2 + 2.0*q3) + 1.0245e19*L2*qd3*sin(q3) + 2.049e19*L3*qd2*sin(2.0*q2 + 2.0*q3) + 2.049e19*L3*qd3*sin(2.0*q2 + 2.0*q3) + 2.049e19*L2*qd2*sin(2.0*q2 + q3) + 1.0245e19*L2*qd3*sin(2.0*q2 + q3) + 6.148e19*L2*qd2*sin(2.0*q2));
                                                                                              0.000070885*R2^2*qd2 - 0.086846*qd1^2*sin(2.0*q2 + 2.0*q3) - 0.30777*qd1^2*sin(2.0*q2) + 0.55547*L2*qd1^2*sin(2.0*q2) - 0.18513*L2*qd3^2*sin(q3) + 0.18513*L3*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.18513*L2*qd1^2*sin(2.0*q2 + q3) - 0.37026*L2*qd2*qd3*sin(q3);
                                                                                                                                                              0.00028572*R3^2*qd3 - 0.1985*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.21158*L2*qd1^2*sin(q3) + 0.42316*L2*qd2^2*sin(q3) + 0.42316*L3*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.21158*L2*qd1^2*sin(2.0*q2 + q3)];
 
 
% Par gravitatorio
G=[                                              0 ;
 0.083333*g*(2.2216*cos(q2 + q3) + 6.6657*cos(q2)) ;
                            0.42316*g*cos(q2 + q3)];
%M=vpa(M,5); V=vpa(V,5); G=vpa(G,5);

% Ecuación del robot
%    Im = M*qpp + V + G
  Im=[Im1;Im2;Im3];


  % Por lo que:  
% Aceleraciones
%La inversa de M siempore existe porque es simetrica y definida positiva
 % qdd = inv(M)*((Im.*(Kt.*R))-V-G);
 qdd=inv(M)*(Im-V-G);
  