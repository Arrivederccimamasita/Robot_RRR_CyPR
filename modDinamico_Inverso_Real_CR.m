function [udd]=modDinamico_Inverso_Real_CR(in)
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
R1=50; R2=30; R3=15;

% Matriz de Inercias
M=[ 0.087959*cos(2.0*q2 + q3) + 0.01901*cos(2.0*q2) + 0.087959*cos(q3) + 0.041686*cos(2.0*q2 + 2.0*q3) + 1.2936,                         0,                        0;
    0,   0.3665*cos(q3) + 4.5952, 0.18325*cos(q3) + 0.2932;
    0, 0.41885*cos(q3) + 0.67016,                   2.7764];


% Matriz de aceleraciones centr�petas y de Coriolis

V=[-2.2204e-24*qd1*(7.9226e22*qd2*sin(2.0*q2 + q3) + 3.9613e22*qd3*sin(2.0*q2 + q3) + 1.7123e22*qd2*sin(2.0*q2) + 3.9613e22*qd3*sin(q3) + 3.7548e22*qd2*sin(2.0*q2 + 2.0*q3) + 3.7548e22*qd3*sin(2.0*q2 + 2.0*q3) - 5.5088e22);
        0.096929*qd2 - 0.18325*qd3^2*sin(q3) + 0.086846*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.18325*qd1^2*sin(2.0*q2 + q3) + 0.039605*qd1^2*sin(2.0*q2) - 0.3665*qd2*qd3*sin(q3);
    0.064764*qd3 + 0.20943*qd1^2*sin(q3) + 0.41885*qd2^2*sin(q3) + 0.19851*qd1^2*sin(2.0*q2 + 2.0*q3) + 0.20943*qd1^2*sin(2.0*q2 + q3)];

Vaux=[V(1) 0 0; 0 V(2) 0 ; 0 0 V(3)]; 
% Par gravitatorio
G=[                                               0;
     0.083333*g*(2.199*cos(q2 + q3) + 6.6722*cos(q2));
      0.41885*g*cos(q2 + q3)];
  
  
udd=M*qddr+Vaux*qd+G;
                                                                                                                                                                                                udd=[M(1,1)*qddr1 M(2,2)*qddr2 M(3,3)*qddr3];                       
return