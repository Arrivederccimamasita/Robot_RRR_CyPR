function [udd]=modDinamico_Inverso_Real_SR(in)
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
M=[ 4.434*cos(2.0*q2 + q3) + 5.7477*cos(2.0*q2) + 4.434*cos(q3) + 5.7389*cos(2.0*q2 + 2.0*q3) + 0.46597,                       0,                       0;
                                                                                                   0,  11.085*cos(q3) + 21.67, 5.5425*cos(q3) + 6.3549;
                                                                                                   0, 6.3343*cos(q3) + 7.2628,                    7.56];
 

% Matriz de aceleraciones centr�petas y de Coriolis
V=[ -1.3878e-18*qd1*(6.3901e18*qd2*sin(2.0*q2 + q3) + 3.195e18*qd3*sin(2.0*q2 + q3) + 8.2833e18*qd2*sin(2.0*q2) + 3.195e18*qd3*sin(q3) + 8.2706e18*qd2*sin(2.0*q2 + 2.0*q3) + 8.2706e18*qd3*sin(2.0*q2 + 2.0*q3) - 2.6192e16);
                                                                0.15202*qd2 - 5.5425*qd3^2*sin(q3) + 7.1736*qd1^2*sin(2.0*q2 + 2.0*q3) + 5.5425*qd1^2*sin(2.0*q2 + q3) + 7.1847*qd1^2*sin(2.0*q2) - 11.085*qd2*qd3*sin(q3);
                                                                                            0.018533*qd3 + 3.1671*qd1^2*sin(q3) + 6.3343*qd2^2*sin(q3) + 8.1984*qd1^2*sin(2.0*q2 + 2.0*q3) + 3.1671*qd1^2*sin(2.0*q2 + q3)];

Vaux=[V(1) 0 0; 0 V(2) 0 ; 0 0 V(3)]; 
                                                                                        
% Par gravitatorio                                                          
G=[                                           0;
 2.5*g*(2.217*cos(q2 + q3) + 6.7509*cos(q2));
                       6.3343*g*cos(q2 + q3)];

udd=M*qddr+Vaux*qd+G;
return