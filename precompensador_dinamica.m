function [udd]=precompensador_dinamica(in)
q1=in(1);
q2=in(2);
q3=in(3);

qd1=in(4);
qd2=in(5);
qd3=in(6);

qddr1=in(7);
qddr2=in(8);
qddr3=in(9);

qddr=diag([qddr1;qddr2;qddr3]);

g=9.8;L0=0.6;L1=0.6;L2=1;L3=0.8;
R1=50; R2=30; R3=15;    

% Matriz de Inercias
M=[ 0.088863*L3 - 0.14773*cos(2.0*q2) - 0.041686*cos(2.0*q2 + 2.0*q3) + 0.088863*L2*cos(q3) + 0.088863*L3*cos(2.0*q2 + 2.0*q3) + 0.26663*L2*(cos(2.0*q2) + 1.0) + 0.088863*L2*cos(2.0*q2 + q3) + 0.81476,            0,                                              0;
                                                                                                                                                                                                    0, 1.1109*L2 + 0.37026*L3 + 0.37026*L2*cos(q3) + 4.4228,             0;
                                                                                                                                                                                                    0,               0,                                    0.0096655*R3^2 + 0.84631*L3 - 0.38902];
udd=[(1/M(1,1))*qddr1 (1/M(2,2))*qddr2 (1/M(3,3))*qddr3];                       
return