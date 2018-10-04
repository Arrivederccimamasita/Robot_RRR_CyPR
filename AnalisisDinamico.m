% En primer lugar se debe correr y configurar el script DinamicaNE.m para
% obtener los valores de T1,T2 y T3 en simbolico.
%% DECLARACION DE VARIABLES SIMBOLICAS
syms T1 T2 T3 real          %Par o fuerza efectivo ejercidos sobre la
                            %barra i en torno a su centro de masas.
                            %(par motor menos pares de rozamiento o perturbación)
syms q1 qd1 qdd1 real       %Posicion, velocidad y aceleracion de q1
syms q2 qd2 qdd2 real       %Posicion, velocidad y aceleracion de q2
syms q3 qd3 qdd3 real       %Posicion, velocidad y aceleracion de q3
syms g real                 %Gravedad

syms L0 L1 L2 L3 real       % Datos cinematicos del brazo

% Estimacion de los parametros dinamicos robot
syms m0 m1 m2 m3 real       % Masas en simbolico
syms s11x s11y s11z s22x s22y s22z s33x s33y s33z real  % Distancia al cdm
syms I11xx I11yy I11zz I22xx I22yy I22zz I33xx I33yy I33zz real     % Tensor de inercias
% Estimacion de los parametros de los motores
syms Jm1 Jm2 Jm3 Bm1 Bm2 Bm3 R1 R2 R3 real
% Los valores de R1,R2 y R3 son conocidos, por eso no aparece en theta


% Valores de los partes en las articulaciones(Tau=Kt*R*Im)
T1=I11yy*qdd1 + (I22xx*qdd1)/2 + (I22yy*qdd1)/2 + (I33xx*qdd1)/2 + (I33yy*qdd1)/2 + L2^2*qdd1 + L3^2*qdd1 + qdd1*s33x^2 + qdd1*s33x^2*cos(2*q2 + 2*q3) + m1*qdd1*s11z^2 + (m2*qdd1*s22x^2)/2 - (I22xx*qdd1*cos(2*q2))/2 + (I22yy*qdd1*cos(2*q2))/2 - (I33xx*qdd1*cos(2*q2 + 2*q3))/2 + (I33yy*qdd1*cos(2*q2 + 2*q3))/2 + 2*L3*qdd1*s33x + L2^2*qdd1*cos(2*q2) + L3^2*qdd1*cos(2*q2 + 2*q3) + (L2^2*m2*qdd1)/2 + (L2^2*m2*qdd1*cos(2*q2))/2 - 2*L2^2*qd1*qd2*sin(2*q2) + 2*L2*L3*qdd1*cos(q3) + (m2*qdd1*s22x^2*cos(2*q2))/2 - 2*L3^2*qd1*qd2*sin(2*q2 + 2*q3) - 2*L3^2*qd1*qd3*sin(2*q2 + 2*q3) + 2*L2*qdd1*s33x*cos(q3) + 2*L2*L3*qdd1*cos(2*q2 + q3) - 2*qd1*qd2*s33x^2*sin(2*q2 + 2*q3) - 2*qd1*qd3*s33x^2*sin(2*q2 + 2*q3) + 2*L2*qdd1*s33x*cos(2*q2 + q3) + I22xx*qd1*qd2*sin(2*q2) - I22yy*qd1*qd2*sin(2*q2) + 2*L3*qdd1*s33x*cos(2*q2 + 2*q3) + L2*m2*qdd1*s22x + I33xx*qd1*qd2*sin(2*q2 + 2*q3) + I33xx*qd1*qd3*sin(2*q2 + 2*q3) - I33yy*qd1*qd2*sin(2*q2 + 2*q3) - I33yy*qd1*qd3*sin(2*q2 + 2*q3) - 4*L2*qd1*qd2*s33x*sin(2*q2 + q3) - 2*L2*qd1*qd3*s33x*sin(2*q2 + q3) + L2*m2*qdd1*s22x*cos(2*q2) - 4*L3*qd1*qd2*s33x*sin(2*q2 + 2*q3) - 4*L3*qd1*qd3*s33x*sin(2*q2 + 2*q3) - L2^2*m2*qd1*qd2*sin(2*q2) - 2*L2*L3*qd1*qd3*sin(q3) - m2*qd1*qd2*s22x^2*sin(2*q2) - 2*L2*qd1*qd3*s33x*sin(q3) - 4*L2*L3*qd1*qd2*sin(2*q2 + q3) - 2*L2*L3*qd1*qd3*sin(2*q2 + q3) - 2*L2*m2*qd1*qd2*s22x*sin(2*q2);
T2=I22zz*qdd2 + I33zz*qdd2 + I33zz*qdd3 + 2*L2^2*qdd2 + 2*L3^2*qdd2 + 2*L3^2*qdd3 + 2*qdd2*s33x^2 + 2*qdd3*s33x^2 + m2*qdd2*s22x^2 + L2^2*qd1^2*sin(2*q2) + L3^2*qd1^2*sin(2*q2 + 2*q3) + qd1^2*s33x^2*sin(2*q2 + 2*q3) + 4*L3*qdd2*s33x + 4*L3*qdd3*s33x + 2*L3*g*cos(q2 + q3) - (I22xx*qd1^2*sin(2*q2))/2 + (I22yy*qd1^2*sin(2*q2))/2 + 2*g*s33x*cos(q2 + q3) + 2*L2*g*cos(q2) + L2^2*m2*qdd2 - (I33xx*qd1^2*sin(2*q2 + 2*q3))/2 + (I33yy*qd1^2*sin(2*q2 + 2*q3))/2 + 2*L2*qd1^2*s33x*sin(2*q2 + q3) + 4*L2*L3*qdd2*cos(q3) + 2*L2*L3*qdd3*cos(q3) + L2*g*m2*cos(q2) + 2*L3*qd1^2*s33x*sin(2*q2 + 2*q3) + 4*L2*qdd2*s33x*cos(q3) + 2*L2*qdd3*s33x*cos(q3) + g*m2*s22x*cos(q2) + (L2^2*m2*qd1^2*sin(2*q2))/2 - 2*L2*L3*qd3^2*sin(q3) + (m2*qd1^2*s22x^2*sin(2*q2))/2 - 2*L2*qd3^2*s33x*sin(q3) + 2*L2*L3*qd1^2*sin(2*q2 + q3) + 2*L2*m2*qdd2*s22x + L2*m2*qd1^2*s22x*sin(2*q2) - 4*L2*L3*qd2*qd3*sin(q3) - 4*L2*qd2*qd3*s33x*sin(q3);  
T3=(L3 + s33x)*(2*L3*qdd2 + 2*L3*qdd3 + 2*qdd2*s33x + 2*qdd3*s33x + 2*g*cos(q2 + q3) + qd1^2*s33x*sin(2*q2 + 2*q3) + L2*qd1^2*sin(q3) + 2*L2*qd2^2*sin(q3) + L2*qd1^2*sin(2*q2 + q3) + L3*qd1^2*sin(2*q2 + 2*q3) + 2*L2*qdd2*cos(q3)) + I33zz*(qdd2 + qdd3) - (I33xx*qd1^2*sin(2*q2 + 2*q3))/2 + (I33yy*qd1^2*sin(2*q2 + 2*q3))/2;  

% Se debera ir derivando respecto diversas variables para ir obteniendo la
% la ecuacion matricial del robot (lineal con los parametros dinamicos)
Y=[T1 T2 T3]';  
thetha=[m1 s11z I11xx I11yy I11zz Jm1 Bm1...
    m2 s22x I22xx I22yy I22zz Jm2 Bm2...
    m3 s33x I33xx I33yy I33zz Jm3 Bm3]';    % Vector columna de incognitas 
% Habra que definir la variable phi, la cual es la ecuacion matricial del
% robot. Se sabe que tendra una dimension de 3x21.

% Derivadas respecto las incognitas del primer eslabon
dT1_m1=diff(T1,m1)
dT2_m1=diff(T2,m1)
dT3_m1=diff(T3,m1)

dT1_s11z=diff(T1,s11z)
dT2_s11z=diff(T2,s11z)
dT3_s11z=diff(T3,s11z)

dT1_I11xx=diff(T1,I11xx)
dT2_I11xx=diff(T2,I11xx)
dT3_I11xx=diff(T3,I11xx)

dT1_I11yy=diff(T1,I11yy)
dT2_I11yy=diff(T2,I11yy)
dT3_I11yy=diff(T3,I11yy)

dT1_I11zz=diff(T1,I11zz)
dT2_I11zz=diff(T2,I11zz)
dT3_I11zz=diff(T3,I11zz)

dT1_Jm1=diff(T1,Jm1)
dT2_Jm1=diff(T2,Jm1)
dT3_Jm1=diff(T3,Jm1)

dT1_Bm1=diff(T1,Bm1)
dT2_Bm1=diff(T2,Bm1)
dT3_Bm1=diff(T3,Bm1)

% Derivadas respecto las incognitas del segundo eslabon
dT1_m2=diff(T1,m2)
dT2_m2=diff(T2,m2)
dT3_m2=diff(T3,m2)

dT1_s22x=diff(T1,s22x)
dT2_s22x=diff(T2,s22x)
dT3_s22x=diff(T3,s22x)

dT1_I22xx=diff(T1,I22xx)
dT2_I22xx=diff(T2,I22xx)
dT3_I22xx=diff(T3,I22xx)

dT1_I22yy=diff(T1,I22yy)
dT2_I22yy=diff(T2,I22yy)
dT3_I22yy=diff(T3,I22yy)

dT1_I22zz=diff(T1,I22zz)
dT2_I22zz=diff(T2,I22zz)
dT3_I22zz=diff(T3,I22zz)

dT1_Jm2=diff(T1,Jm2)
dT2_Jm2=diff(T2,Jm2)
dT3_Jm2=diff(T3,Jm2)

dT1_Bm2=diff(T1,Bm2)
dT2_Bm2=diff(T2,Bm2)
dT3_Bm2=diff(T3,Bm2)

% Derivadas respecto las incognitas del tercer eslabon
dT1_m3=diff(T1,m3)
dT2_m3=diff(T2,m3)
dT3_m3=diff(T3,m3)

dT1_s33x=diff(T1,s33x)
dT2_s33x=diff(T2,s33x)
dT3_s33x=diff(T3,s33x)

dT1_I33xx=diff(T1,I33xx)
dT2_I33xx=diff(T2,I33xx)
dT3_I33xx=diff(T3,I33xx)

dT1_I33yy=diff(T1,I33yy)
dT2_I33yy=diff(T2,I33yy)
dT3_I33yy=diff(T3,I33yy)

dT1_I33zz=diff(T1,I33zz)
dT2_I33zz=diff(T2,I33zz)
dT3_I33zz=diff(T3,I33zz)

dT1_Jm3=diff(T1,Jm3)
dT2_Jm3=diff(T2,Jm3)
dT3_Jm3=diff(T3,Jm3)

dT1_Bm3=diff(T1,Bm3)
dT2_Bm3=diff(T2,Bm3)
dT3_Bm3=diff(T3,Bm3)

% La ecuacion matricial del robot se definiria como: (Se definira por columnas)
theta=[dT1_m1 dT2_m1 dT3_m1;...
    dT1_s11z dT2_s11z dT3_s11z;...
    dT1_I11xx dT2_I11xx dT3_I11xx;...
    dT1_I11yy dT2_I11yy dT3_I11yy;...
    dT1_I11zz dT2_I11zz dT3_I11zz;...
    dT1_Jm1 dT2_Jm1 dT3_Jm1;...
    dT1_Bm1 dT2_Bm1 dT3_Bm1;...
    
    dT1_m2 dT2_m2 dT3_m2;...
    dT1_s22x dT2_s22x dT3_s22x;...
    dT1_I22xx dT2_I22xx dT3_I22xx;...
    dT1_I22yy dT2_I22yy dT3_I22yy;...
    dT1_I22zz dT2_I22zz dT3_I22zz;...
    dT1_Jm2 dT2_Jm2 dT3_Jm2;...
    dT1_Bm2 dT2_Bm2 dT3_Bm2;...
    
    dT1_m3 dT2_m3 dT3_m3;...    
    dT1_s33x dT2_s33x dT3_s33x;...
    dT1_I33xx dT2_I33xx dT3_I33xx;...
    dT1_I33yy dT2_I33yy dT3_I33yy;...
    dT1_I33zz dT2_I33zz dT3_I33zz;...
    dT1_Jm3 dT2_Jm3 dT3_Jm3;...
    dT1_Bm3 dT2_Bm3 dT3_Bm3]';