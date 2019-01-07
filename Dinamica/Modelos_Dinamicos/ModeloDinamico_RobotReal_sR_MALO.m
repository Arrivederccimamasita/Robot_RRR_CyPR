function [udd]=modDinamico_Inverso_Real_sR_MALO(in)
q1=in(1);
q2=in(2);
q3=in(3);

qd1=in(4);
qd2=in(5);
qd3=in(6);

qddr1=in(7);
qddr2=in(8);
qddr3=in(9);

qddr=[qddr1 qddr2 qddr3]';
qd=[qd1 qd2 qd3]';


g=9.8;L0=0.6;L1=0.6;L2=1;L3=0.8;
R1=1; R2=1; R3=1;    

% Matriz de Inercias
M=[ 5.7477*cos(2.0*q2) - 0.0074824*cos(2.0*q2 + q3) - 0.0074824*cos(q3) + 2.1857*cos(2.0*q2 + 2.0*q3) - 3.0872,                           0,                            0;
                                                                                                          0,   12.787 - 0.018706*cos(q3), - 0.0093529*cos(q3) - 2.5281;
                                                                                                          0, - 0.010689*cos(q3) - 2.8892,                      -2.5919];
                                                                                                                                                                            
 % Matriz de aceleraciones centr�petas y de Coriolis
 
 V=[1.7347e-19*qd1*(8.6266e16*qd2*sin(2.0*q2 + q3) + 4.3133e16*qd3*sin(2.0*q2 + q3) - 6.6267e19*qd2*sin(2.0*q2) + 4.3133e16*qd3*sin(q3) - 2.5199e19*qd2*sin(2.0*q2 + 2.0*q3) - 2.5199e19*qd3*sin(2.0*q2 + 2.0*q3) + 2.0953e17);
                                                         0.15202*qd2 + 0.0093529*qd3^2*sin(q3) + 2.7321*qd1^2*sin(2.0*q2 + 2.0*q3) - 0.0093529*qd1^2*sin(2.0*q2 + q3) + 7.1847*qd1^2*sin(2.0*q2) + 0.018706*qd2*qd3*sin(q3);
                                                                                     0.018533*qd3 - 0.0053445*qd1^2*sin(q3) - 0.010689*qd2^2*sin(q3) + 3.1224*qd1^2*sin(2.0*q2 + 2.0*q3) - 0.0053445*qd1^2*sin(2.0*q2 + q3)];
 
 Vaux=[V(1) 0 0 ; 0 V(2) 0 ; 0 0 V(3)];
% Par gravitatorio
G=[                                                           0;
 -3.2526e-18*g*(2.8755e15*cos(q2 + q3) - 5.1888e18*cos(q2));
                                   -0.010689*g*cos(q2 + q3)];


udd=M*qddr+Vaux*qd+G;
return