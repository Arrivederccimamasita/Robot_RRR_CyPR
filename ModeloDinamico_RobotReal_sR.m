%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCIÓN EMPLEADA PARA EJECUTAR LOS DATOS OBTENIDOS A TRAVÉS DEL SCRIPT  %
% "DinamicaRobotNE.m" EN SIMULINK MEDIANTE DEL ARCHIVO                    %
% "sl_R3GDL_Mfunction.mdl"                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [qdd] = ModeloDinamico_RobotReal_sR(in)
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
M=[ 5.7477*cos(2.0*q2) - 0.0074824*cos(2.0*q2 + q3) - 0.0074824*cos(q3) + 2.1857*cos(2.0*q2 + 2.0*q3) - 3.0872,                             0,                              0;
    0,       15.3 - 0.018706*cos(q3), - 0.0093529*cos(q3) - 0.014965;
    0, - 0.010689*cos(q3) - 0.017103,                          66.87];


% Matriz de aceleraciones centrípetas y de Coriolis

V=[1.7347e-19*qd1*(8.6266e16*qd2*sin(2.0*q2 + q3) + 4.3133e16*qd3*sin(2.0*q2 + q3) - 6.6267e19*qd2*sin(2.0*q2) + 4.3133e16*qd3*sin(q3) - 2.5199e19*qd2*sin(2.0*q2 + 2.0*q3) - 2.5199e19*qd3*sin(2.0*q2 + 2.0*q3) + 5.2383e20);
    136.82*qd2 + 0.0093529*qd3^2*sin(q3) + 2.7321*qd1^2*sin(2.0*q2 + 2.0*q3) - 0.0093529*qd1^2*sin(2.0*q2 + q3) + 7.1847*qd1^2*sin(2.0*q2) + 0.018706*qd2*qd3*sin(q3);
    4.1699*qd3 - 0.0053445*qd1^2*sin(q3) - 0.010689*qd2^2*sin(q3) + 3.1224*qd1^2*sin(2.0*q2 + 2.0*q3) - 0.0053445*qd1^2*sin(2.0*q2 + q3)];

% Par gravitatorio
G=[                                               0;
      -3.2526e-18*g*(2.8755e15*cos(q2 + q3) - 5.1888e18*cos(q2));
      -0.010689*g*cos(q2 + q3)];
%M=vpa(M,5); V=vpa(V,5); G=vpa(G,5);

% Ecuación del robot
%    Im = M*qpp + V + G
Im=[Im1;Im2;Im3];


% Por lo que:
% Aceleraciones
%La inversa de M siempore existe porque es simetrica y definida positiva
% qdd = inv(M)*((Im.*(Kt.*R))-V-G);
qdd=inv(M)*(Im-V-G);
