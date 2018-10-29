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
Tau1      = in(7);
Tau2      = in(8);
Tau3      = in(9);

g=9.8;L0=0.6;L1=0.6;L2=1;L3=0.8;

% Matriz de Inercias(Copiada y pegada de lo obtenido de "NE_R3GDL.m")
M=[ 0.0044433*L3 - 0.013643*cos(2.0*q2) - 0.0020749*cos(2.0*q2 + 2.0*q3) + 0.0044433*L2*cos(q3) + 0.0044433*L3*cos(2.0*q2 + 2.0*q3) + 0.020142*L2*(cos(2.0*q2) + 1.0) + 0.0044433*L2*cos(2.0*q2 + q3) + 0.030764,                                                         0,                                             0;
                                                                                                                                                                                                            0, 0.083927*L2 + 0.018514*L3 + 0.018514*L2*cos(q3) + 0.21408, 0.018514*L3 + 0.0092569*L2*cos(q3) - 0.011047;
                                                                                                                                                                                                            0,               0.042317*L3 + 0.021159*L2*cos(q3) - 0.02525,                        0.042317*L3 + 0.090868];
 
% Matriz de aceleraciones centrípetas y de Coriolis
V=[-1.0842e-21*qd1*(4.0982e18*L2*qd3*sin(q3) - 3.8276e18*qd2*sin(2.0*q2 + 2.0*q3) - 3.8276e18*qd3*sin(2.0*q2 + 2.0*q3) - 2.5166e19*qd2*sin(2.0*q2) + 8.1964e18*L3*qd2*sin(2.0*q2 + 2.0*q3) + 8.1964e18*L3*qd3*sin(2.0*q2 + 2.0*q3) + 8.1964e18*L2*qd2*sin(2.0*q2 + q3) + 4.0982e18*L2*qd3*sin(2.0*q2 + q3) + 3.7156e19*L2*qd2*sin(2.0*q2) - 4.4158e18) ;
                                                                                         0.002689*qd2 - 0.0043228*qd1^2*sin(2.0*q2 + 2.0*q3) - 0.028422*qd1^2*sin(2.0*q2) + 0.041963*L2*qd1^2*sin(2.0*q2) - 0.0092569*L2*qd3^2*sin(q3) + 0.0092569*L3*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.0092569*L2*qd1^2*sin(2.0*q2 + q3) - 0.018514*L2*qd2*qd3*sin(q3) ;
                                                                                                                                                          0.0029276*qd3 - 0.0098806*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.010579*L2*qd1^2*sin(q3) + 0.021159*L2*qd2^2*sin(q3) + 0.021159*L3*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.010579*L2*qd1^2*sin(2.0*q2 + q3)];
 
 
% Par gravitatorio                
  G =9.8*[ 0;
 0.083333*(0.11108*cos(q2 + q3) + 0.50356*cos(q2));
                             0.021159*cos(q2 + q3)];
% Ecuación del robot
%    Tau = M*qpp + V + G
  Tau=[Tau1;Tau2;Tau3];

% Por lo que:  
% Aceleraciones
%La inversa de M siempore existe porque es simetrica y definida positiva
  qdd = inv(M)*(Tau-V-G);
  