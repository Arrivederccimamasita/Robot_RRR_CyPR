%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCI�N EMPLEADA PARA EJECUTAR LOS DATOS OBTENIDOS A TRAV�S DEL SCRIPT  %
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
R1=1; R2=1; R3=1;    

% Matriz de Inercias
M=[ 4.434*L3 - 7.3803*cos(2.0*q2) - 2.0785*cos(2.0*q2 + 2.0*q3) + 4.434*L2*cos(q3) + 4.434*L3*cos(2.0*q2 + 2.0*q3) + 13.317*L2*(cos(2.0*q2) + 1.0) + 4.434*L2*cos(2.0*q2 + q3) - 9.1708,                                                  0,                                      0;
                                                                                                                                                                                0, 33.293*L2 + 11.085*L3 + 11.085*L2*cos(q3) - 23.169, 11.085*L3 + 5.5425*L2*cos(q3) - 5.0839;
                                                                                                                                                                                   0,             12.669*L3 + 6.3343*L2*cos(q3) - 5.8101,                     12.669*L3 - 5.6654];
 % Matriz de aceleraciones centr�petas y de Coriolis
 
 V=[-1.7347e-18*qd1*(2.556e18*L2*qd3*sin(q3) - 2.3963e18*qd2*sin(2.0*q2 + 2.0*q3) - 2.3963e18*qd3*sin(2.0*q2 + 2.0*q3) - 8.5089e18*qd2*sin(2.0*q2) + 5.1121e18*L3*qd2*sin(2.0*q2 + 2.0*q3) + 5.1121e18*L3*qd3*sin(2.0*q2 + 2.0*q3) + 5.1121e18*L2*qd2*sin(2.0*q2 + q3) + 2.556e18*L2*qd3*sin(2.0*q2 + q3) + 1.5354e19*L2*qd2*sin(2.0*q2) - 1.3765e15);
                                                                                                         0.003035*qd2 - 2.5981*qd1^2*sin(2.0*q2 + 2.0*q3) - 9.2254*qd1^2*sin(2.0*q2) + 16.646*L2*qd1^2*sin(2.0*q2) - 5.5425*L2*qd3^2*sin(q3) + 5.5425*L3*qd1^2*sin(2.0*q2 + 2.0*q3) + 5.5425*L2*qd1^2*sin(2.0*q2 + q3) - 11.085*L2*qd2*qd3*sin(q3);
                                                                                                                                                                   0.0041829*qd3 - 2.9692*qd1^2*sin(2.0*q2 + 2.0*q3) + 3.1671*L2*qd1^2*sin(q3) + 6.3343*L2*qd2^2*sin(q3) + 6.3343*L3*qd1^2*sin(2.0*q2 + 2.0*q3) + 3.1671*L2*qd1^2*sin(2.0*q2 + q3)];
 
 
% Par gravitatorio
G= [-                           0;
 2.5*g*(2.217*cos(q2 + q3) + 6.6586*cos(q2));
                       6.3343*g*cos(q2 + q3)];
%M=vpa(M,5); V=vpa(V,5); G=vpa(G,5);

% Ecuaci�n del robot
%    Im = M*qpp + V + G
  Im=[Im1;Im2;Im3];


  % Por lo que:  
% Aceleraciones
%La inversa de M siempore existe porque es simetrica y definida positiva
 % qdd = inv(M)*((Im.*(Kt.*R))-V-G);
 qdd=inv(M)*(Im-V-G);
  