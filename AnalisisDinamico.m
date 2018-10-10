% En primer lugar se debe correr y configurar el script DinamicaNE.m para
% obtener los valores de T1,T2 y T3 en simbolico.
%% DECLARACION DE VARIABLES SIMBOLICAS
syms T1 T2 T3 real          %Par o fuerza efectivo ejercidos sobre la
                            %barra i en torno a su centro de masas.
                            %(par motor menos pares de rozamiento o perturbaciÃ³n)
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
% T1=simplify(Ma(1,1)*qdd1+Ma(1,2)*qdd2+Ma(1,3)*qdd3+Va(1,1)+Ga(1,1));
% T2=simplify(Ma(2,1)*qdd1+Ma(2,2)*qdd2+Ma(2,3)*qdd3+Va(2,1)+Ga(2,1));
% T3=simplify(Ma(3,1)*qdd1+Ma(3,2)*qdd2+Ma(3,3)*qdd3+Va(3,1)+Ga(3,1));
Y=[T1 T2 T3]';

% Se debera ir derivando respecto diversas variables para ir obteniendo la
% la ecuacion matricial del robot (lineal con los parametros dinamicos)
  
% tetha=[m1 s11z I11xx I11yy I11zz Jm1 Bm1...
%     m2 s22x I22xx I22yy I22zz Jm2 Bm2...
%     m3 s33x I33xx I33yy I33zz Jm3 Bm3]';    % Vector columna de incognitas 
% 
% 
% % Habra que definir la variable phi, la cual es la ecuacion matricial del
% % robot. Se sabe que tendra una dimension de 3x21.
% gamma = sym('gamma',[length(Y) length(tetha)]);  % Se crea la matriz simbolica objetivo
% 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % OBTENCION DE LA MATRIZ PHI POR BUCLE. VERIFICAR CORRECTO FUNCIONAMIENTO!
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Recorremos la matriz Y
% for j=1:length(Y)
%     % Recorremos la matriz theta
%     for i=1:length(tetha)
%         gamma(j,i)= diff(Y(j),tetha(i)) ;
%     end
% end
% gamma

% Una vez que se ha obtenido phi, seria necesario trabajarla en una serie
% de terminos, otros ya estarian definidos.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Seria sino, conveniente, redefinir la matriz tetha, con las combinaciones
% lineales de los parametros
% tetha_sim sera la matriz de incognitas simplificada con las comb lineales

tetha_sim=[m1*(s11z^2) m1*s11z m1 I11xx I11yy I11zz Jm1 Bm1  ...
           m2*(s22x^2) m2*s22x m2 I22xx I22yy I22zz Jm2 Bm2  ...
           m3*(s33x^2) m3*s33x m3 I33xx I33yy I33zz Jm3 Bm3 ]';

% Se rellenara gamma_sim a piñon, posteriormente seria necesario una
% optimizacion y una eleganciacion
gamma_sim = sym('gamma_sim',[length(Y) length(tetha_sim)]);  % Se crea la matriz simbolica objetivo

% Rellenamos la matriz (se rellenara por columnas)

% %%%%%% Momento inercia orden 2 del eslabon 1 %%%%%% 
gamma_sim(1,1)=diff(0.5*diff( diff(T1,s11z),s11z ),m1);
gamma_sim(2,1)=diff(0.5*diff( diff(T2,s11z),s11z ),m1);
gamma_sim(3,1)=diff(0.5*diff( diff(T3,s11z),s11z ),m1);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1-(gamma_sim(1,1)*(m1*(s11z^2))) );
T2_aux=simplify( T2-(gamma_sim(2,1)*(m1*(s11z^2))) );
T3_aux=simplify( T3-(gamma_sim(3,1)*(m1*(s11z^2))) );

% %%%%%% Momento inercia orden 1 del eslabon 1 %%%%%% 
gamma_sim(1,2)=diff( diff(T1_aux,s11z) , m1);
gamma_sim(2,2)=diff( diff(T2_aux,s11z) , m1);
gamma_sim(3,2)=diff( diff(T3_aux,s11z) , m1);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,2)*(m1*s11z)) );
T2_aux=simplify( T2_aux-(gamma_sim(2,2)*(m1*s11z)) );
T3_aux=simplify( T3_aux-(gamma_sim(3,2)*(m1*s11z)) );

% %%%%%% Momento inercia orden 0 del eslabon 1 %%%%%% 
gamma_sim(1,3)=diff( T1_aux , m1);
gamma_sim(2,3)=diff( T2_aux , m1);
gamma_sim(3,3)=diff( T3_aux , m1);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,3)*m1) );
T2_aux=simplify( T2_aux-(gamma_sim(2,3)*m1) );
T3_aux=simplify( T3_aux-(gamma_sim(3,3)*m1) );

% %%%%%% Componente Ixx del eslabon 1 %%%%%% 
gamma_sim(1,4)=diff(T1_aux,I11xx);
gamma_sim(2,4)=diff(T2_aux,I11xx);
gamma_sim(3,4)=diff(T3_aux,I11xx);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,4)*I11xx) );
T2_aux=simplify( T2_aux-(gamma_sim(2,4)*I11xx) );
T3_aux=simplify( T3_aux-(gamma_sim(3,4)*I11xx) );

% %%%%%% Componente Iyy del eslabon 1 %%%%%% 
gamma_sim(1,5)=diff(T1_aux,I11yy);
gamma_sim(2,5)=diff(T2_aux,I11yy);
gamma_sim(3,5)=diff(T3_aux,I11yy);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,5)*I11yy) );
T2_aux=simplify( T2_aux-(gamma_sim(2,5)*I11yy) );
T3_aux=simplify( T3_aux-(gamma_sim(3,5)*I11yy) );

% %%%%%% Componente Izz del eslabon 1 %%%%%% 
gamma_sim(1,6)=diff(T1_aux,I11zz);
gamma_sim(2,6)=diff(T2_aux,I11zz);
gamma_sim(3,6)=diff(T3_aux,I11zz);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,6)*I11zz) );
T2_aux=simplify( T2_aux-(gamma_sim(2,6)*I11zz) );
T3_aux=simplify( T3_aux-(gamma_sim(3,6)*I11zz) );

% %%%%%% Inercia motor del eslabon 1 %%%%%% 
gamma_sim(1,7)=diff(T1_aux,Jm1);
gamma_sim(2,7)=diff(T2_aux,Jm1);
gamma_sim(3,7)=diff(T3_aux,Jm1);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,7)*Jm1) );
T2_aux=simplify( T2_aux-(gamma_sim(2,7)*Jm1) );
T3_aux=simplify( T3_aux-(gamma_sim(3,7)*Jm1) );

% %%%%%% Viscosidad motor del eslabon 1 %%%%%% 
gamma_sim(1,8)=diff(T1_aux,Bm1);
gamma_sim(2,8)=diff(T2_aux,Bm1);
gamma_sim(3,8)=diff(T3_aux,Bm1);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,8)*Bm1) );
T2_aux=simplify( T2_aux-(gamma_sim(2,8)*Bm1) );
T3_aux=simplify( T3_aux-(gamma_sim(3,8)*Bm1) );

%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%% Momento inercia orden 2 del eslabon 2 %%%%%% 
gamma_sim(1,9)=diff(0.5*diff( diff(T1_aux,s22x),s22x ),m2);
gamma_sim(2,9)=diff(0.5*diff( diff(T2_aux,s22x),s22x ),m2);
gamma_sim(3,9)=diff(0.5*diff( diff(T3_aux,s22x),s22x ),m2);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,9)*(m2*(s22x^2))));
T2_aux=simplify( T2_aux-(gamma_sim(2,9)*(m2*(s22x^2))));
T3_aux=simplify( T3_aux-(gamma_sim(3,9)*(m2*(s22x^2))));

% %%%%%% Momento inercia orden 1 del eslabon 2 %%%%%% 
gamma_sim(1,10)=diff( diff(T1_aux,s22x) , m2);
gamma_sim(2,10)=diff( diff(T2_aux,s22x) , m2);
gamma_sim(3,10)=diff( diff(T3_aux,s22x) , m2);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,10)*(m2*s22x)));
T2_aux=simplify( T2_aux-(gamma_sim(2,10)*(m2*s22x)));
T3_aux=simplify( T3_aux-(gamma_sim(3,10)*(m2*s22x)));

% %%%%%% Momento inercia orden 0 del eslabon 2 %%%%%% 
gamma_sim(1,11)=diff( T1_aux , m2);
gamma_sim(2,11)=diff( T2_aux , m2);
gamma_sim(3,11)=diff( T3_aux , m2);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,11)*m2));
T2_aux=simplify( T2_aux-(gamma_sim(2,11)*m2));
T3_aux=simplify( T3_aux-(gamma_sim(3,11)*m2));

% %%%%%% Componente Ixx del eslabon 2 %%%%%% 
gamma_sim(1,12)=diff(T1_aux,I22xx);
gamma_sim(2,12)=diff(T2_aux,I22xx);
gamma_sim(3,12)=diff(T3_aux,I22xx);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,12)*I22xx));
T2_aux=simplify( T2_aux-(gamma_sim(2,12)*I22xx));
T3_aux=simplify( T3_aux-(gamma_sim(3,12)*I22xx));

% %%%%%% Componente Iyy del eslabon 2 %%%%%% 
gamma_sim(1,13)=diff(T1_aux,I22yy);
gamma_sim(2,13)=diff(T2_aux,I22yy);
gamma_sim(3,13)=diff(T3_aux,I22yy);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,13)*I22yy));
T2_aux=simplify( T2_aux-(gamma_sim(2,13)*I22yy));
T3_aux=simplify( T3_aux-(gamma_sim(3,13)*I22yy));

% %%%%%% Componente Izz del eslabon 2 %%%%%% 
gamma_sim(1,14)=diff(T1_aux,I22zz);
gamma_sim(2,14)=diff(T2_aux,I22zz);
gamma_sim(3,14)=diff(T3_aux,I22zz);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,14)*I22zz));
T2_aux=simplify( T2_aux-(gamma_sim(2,14)*I22zz));
T3_aux=simplify( T3_aux-(gamma_sim(3,14)*I22zz));

% %%%%%% Inercia motor del eslabon 2 %%%%%% 
gamma_sim(1,15)=diff(T1_aux,Jm2);
gamma_sim(2,15)=diff(T2_aux,Jm2);
gamma_sim(3,15)=diff(T3_aux,Jm2);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,15)*Jm2));
T2_aux=simplify( T2_aux-(gamma_sim(2,15)*Jm2));
T3_aux=simplify( T3_aux-(gamma_sim(3,15)*Jm2));

% %%%%%% Viscosidad motor del eslabon 2 %%%%%% 
gamma_sim(1,16)=diff(T1_aux,Bm2);
gamma_sim(2,16)=diff(T2_aux,Bm2);
gamma_sim(3,16)=diff(T3_aux,Bm2);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,16)*Bm2));
T2_aux=simplify( T2_aux-(gamma_sim(2,16)*Bm2));
T3_aux=simplify( T3_aux-(gamma_sim(3,16)*Bm2));

%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%% Momento inercia orden 2 del eslabon 3 %%%%%% 
gamma_sim(1,17)=diff(0.5*diff( diff(T1_aux,s33x),s33x ),m3);
gamma_sim(2,17)=diff(0.5*diff( diff(T2_aux,s33x),s33x ),m3);
gamma_sim(3,17)=diff(0.5*diff( diff(T3_aux,s33x),s33x ),m3);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,17)*(m3*(s33x^2))));
T2_aux=simplify( T2_aux-(gamma_sim(2,17)*(m3*(s33x^2))));
T3_aux=simplify( T3_aux-(gamma_sim(3,17)*(m3*(s33x^2))));

% %%%%%% Momento inercia orden 1 del eslabon 3 %%%%%% 
gamma_sim(1,18)=diff( diff(T1_aux,s33x) , m3);
gamma_sim(2,18)=diff( diff(T2_aux,s33x) , m3);
gamma_sim(3,18)=diff( diff(T3_aux,s33x) , m3);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,18)*(m3*s33x)));
T2_aux=simplify( T2_aux-(gamma_sim(2,18)*(m3*s33x)));
T3_aux=simplify( T3_aux-(gamma_sim(3,18)*(m3*s33x)));

% %%%%%% Momento inercia orden 0 del eslabon 3 %%%%%% 
gamma_sim(1,19)=diff( T1_aux , m3);
gamma_sim(2,19)=diff( T2_aux , m3);
gamma_sim(3,19)=diff( T3_aux , m3);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,19)*m3));
T2_aux=simplify( T2_aux-(gamma_sim(2,19)*m3));
T3_aux=simplify( T3_aux-(gamma_sim(3,19)*m3));


% %%%%%% Componente Ixx del eslabon 3 %%%%%% 
gamma_sim(1,20)=diff(T1_aux,I33xx);
gamma_sim(2,20)=diff(T2_aux,I33xx);
gamma_sim(3,20)=diff(T3_aux,I33xx);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,20)*I33xx));
T2_aux=simplify( T2_aux-(gamma_sim(2,20)*I33xx));
T3_aux=simplify( T3_aux-(gamma_sim(3,20)*I33xx));

% %%%%%% Componente Iyy del eslabon 3 %%%%%% 
gamma_sim(1,21)=diff(T1_aux,I33yy);
gamma_sim(2,21)=diff(T2_aux,I33yy);
gamma_sim(3,21)=diff(T3_aux,I33yy);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,21)*I33yy));
T2_aux=simplify( T2_aux-(gamma_sim(2,21)*I33yy));
T3_aux=simplify( T3_aux-(gamma_sim(3,21)*I33yy));

% %%%%%% Componente Izz del eslabon 3 %%%%%% 
gamma_sim(1,22)=diff(T1_aux,I33zz);
gamma_sim(2,22)=diff(T2_aux,I33zz);
gamma_sim(3,22)=diff(T3_aux,I33zz);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,22)*I33zz));
T2_aux=simplify( T2_aux-(gamma_sim(2,22)*I33zz));
T3_aux=simplify( T3_aux-(gamma_sim(3,22)*I33zz));

% %%%%%% Inercia motor del eslabon 3 %%%%%% 
gamma_sim(1,23)=diff(T1_aux,Jm3);
gamma_sim(2,23)=diff(T2_aux,Jm3);
gamma_sim(3,23)=diff(T3_aux,Jm3);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,23)*Jm3));
T2_aux=simplify( T2_aux-(gamma_sim(2,23)*Jm3));
T3_aux=simplify( T3_aux-(gamma_sim(3,23)*Jm3));

% %%%%%% Viscosidad motor del eslabon 3 %%%%%% 
gamma_sim(1,24)=diff(T1_aux,Bm3);
gamma_sim(2,24)=diff(T2_aux,Bm3);
gamma_sim(3,24)=diff(T3_aux,Bm3);
% Se redefine tau para el siguiente diff
T1_aux=simplify( T1_aux-(gamma_sim(1,24)*Bm3));
T2_aux=simplify( T2_aux-(gamma_sim(2,24)*Bm3));
T3_aux=simplify( T3_aux-(gamma_sim(3,24)*Bm3));

gamma_sim=simplify(gamma_sim)

%% COMPROBACION
simplify(Y-(gamma_sim*tetha_sim))