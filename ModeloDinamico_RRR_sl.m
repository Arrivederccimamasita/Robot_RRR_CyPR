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

% Matriz de Inercias(Copiada y pegada de lo obtenido de "NE_R3GDL.m")
M=[0.003702*L3 - 0.0082026*cos(2.0*q2) - 0.0018136*cos(2.0*q2 + 2.0*q3) + 0.003702*L2*cos(q3) + 0.003702*L3*cos(2.0*q2 + 2.0*q3) + 0.013021*L2*(cos(2.0*q2) + 1.0) + 0.003702*L2*cos(2.0*q2 + q3) + 0.030679,                                                         0,                                              0;
                                                                                                                                                                                                      0, 0.054256*L2 + 0.015425*L3 + 0.015425*L2*cos(q3) + 0.17118, 0.015425*L3 + 0.0077124*L2*cos(q3) - 0.0075172;
                                                                                                                                                                                                         0,              0.035257*L3 + 0.017628*L2*cos(q3) - 0.017182,                         0.035257*L3 + 0.071995];
 
 % Matriz de aceleraciones centrípetas y de Coriolis
V =[-3.4694e-20*qd1*(1.067e17*L2*qd3*sin(q3) - 1.0455e17*qd2*sin(2.0*q2 + 2.0*q3) - 1.0455e17*qd3*sin(2.0*q2 + 2.0*q3) - 4.7285e17*qd2*sin(2.0*q2) + 2.134e17*L3*qd2*sin(2.0*q2 + 2.0*q3) + 2.134e17*L3*qd3*sin(2.0*q2 + 2.0*q3) + 2.134e17*L2*qd2*sin(2.0*q2 + q3) + 1.067e17*L2*qd3*sin(2.0*q2 + q3) + 7.5064e17*L2*qd2*sin(2.0*q2) - 1.3757e17);
                                                                                   0.0023768*qd2 - 0.0037783*qd1^2*sin(2.0*q2 + 2.0*q3) - 0.017089*qd1^2*sin(2.0*q2) + 0.027128*L2*qd1^2*sin(2.0*q2) - 0.0077124*L2*qd3^2*sin(q3) + 0.0077124*L3*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.0077124*L2*qd1^2*sin(2.0*q2 + q3) - 0.015425*L2*qd2*qd3*sin(q3);
                                                                                                                                                   0.0024485*qd3 - 0.0086362*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.0088142*L2*qd1^2*sin(q3) + 0.017628*L2*qd2^2*sin(q3) + 0.017628*L3*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.0088142*L2*qd1^2*sin(2.0*q2 + q3)];
 
% Par gravitatorio
G =g*[                                          0;
 0.083333*(0.092549*cos(q2 + q3) + 0.32554*cos(q2));
                              0.017628*cos(q2 + q3)];
 

% Ecuación del robot
%    Tau = M*qpp + V + G
  Im=[Im1;Im2;Im3];

% Por lo que:  
% Aceleraciones
%La inversa de M siempore existe porque es simetrica y definida positiva
  qdd = inv(M)*(Im-V-G);
  