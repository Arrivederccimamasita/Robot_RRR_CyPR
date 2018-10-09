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
tetha=[m1 s11z I11xx I11yy I11zz Jm1 Bm1...
    m2 s22x I22xx I22yy I22zz Jm2 Bm2...
    m3 s33x I33xx I33yy I33zz Jm3 Bm3]';    % Vector columna de incognitas 
% Habra que definir la variable phi, la cual es la ecuacion matricial del
% robot. Se sabe que tendra una dimension de 3x21.
phi = sym('phi',[length(Y) length(tetha)]);  % Se crea la matriz simbolica objetivo

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OBTENCION DE LA MATRIZ PHI POR BUCLE. VERIFICAR CORRECTO FUNCIONAMIENTO!
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Recorremos la matriz Y
for j=1:length(Y)
    % Recorremos la matriz theta
    for i=1:length(tetha)
        phi(j,i)=diff(Y(j),tetha(i));
    end
end
phi

% Una vez que se ha obtenido phi, seria necesario trabajarla en una serie
% de terminos, otros ya estarian definidos.