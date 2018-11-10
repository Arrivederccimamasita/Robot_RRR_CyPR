%% PROYECTO FUNDAMENTOS DE ROBÓTICA
% Robot RRR 
clear;clc;startup_rvc;
%% ANALISIS CINEMÁTICO DIRECTO (SIMBOLICO)
% Definicion variables simbolicas
syms L0 L1 L2 L3 q1 q2 q3 real
pi1=sym('pi');

% Matriz DH para Robotics Toolbox
L(1)= Link([  0   L0+L1   0   pi1/2 , 0]);  
L(2)= Link([  0     0    L2    0   , 0]);
L(3)= Link([  0     0    L3    0   , 0]);

% Se unen las articulaciones
robot=SerialLink(L);

T=simplify( robot.fkine( [q1 q2 q3] ) )
% Se pinta el robot para verificar los parámetros obtenidos visualmente
robot.teach();

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ahora se obtendrán las matrices de manera matematica para comparar la
% matriz de transformacion directa matematica con la obtenida mediante el
% toolbox.

% Definicion de la matriz de DH para obtener el Modelo Cinematico Directo
L(1)= Link([  0   L0+L1   0   pi1/2 , 0]);  
L(2)= Link([  0     0    L2     0   , 0]);
L(3)= Link([  0     0    L3     0   , 0]);
robot=SerialLink(L);

% Obtencion de la MCD a partir de las matrices de transformacion homogeneas
A01=fun_MDH( q1 , L0+L1 , 0  , pi1/2 )
A12=fun_MDH( q2 ,   0   , L2 ,   0   )
A23=fun_MDH( q3 ,   0   , L3 ,   0   )

mT=simplify(A01*A12*A23)

% Se definira la solucion del problema cinematico directo
p=mT(1:3,4)

%% ANALISIS CINEMÁTICO INVERSO (SIMBOLICO)
clc;clear;
syms L0 L1 L2 L3 q1 q2 q3 real

% Definicion de las posiciones obtenidas del MCD
px=cos(q1)*(L3*cos(q2 + q3) + L2*cos(q2));
py=sin(q1)*(L3*cos(q2 + q3) + L2*cos(q2));
pz=L0 + L1 + L3*sin(q2 + q3) + L2*sin(q2);

% A=simplify( sqrt(px.^2+py.^2) );
A=L3*cos(q2 + q3) + L2*cos(q2);

% Se podrá definir la primera variable articular, q1, como
qi1=atan2( (py/A) , (px/A) );

% Definimos unas nuevas varables para obtener la variable q3
B=pz-L0-L1;

C=simplify(A.^2+B.^2);
% Despejando de C se obtendrá que
% cos(q3)=(C-L2^2-L3^2)/2*L2*L3

% Por lo tanto, se definirá la variable articular q3 como
qi3=atan2( sqrt( 1-( (C-L2^2-L3^2)/2*L2*L3 )^2 ) , (C-L2^2-L3^2)/2*L2*L3 )
% donde el primer termino llevara delante un signo +-.

% Por último, se obtendra la variable articular q2. Para ello, se
% desarrollará el coseno del angulo suma de la expresion A
% A=L3*(cos(q2)*cos(q3)-sin(q2)*sin(q3)) + L2*cos(q2)
Ades = cos(q2)*( L3*cos(q3)+L2 ) - sin(q2)*( L3*sin(q3) );
% Para poder aplicar el coseno de la resta de dos angulos, sera necesario
% realizar un cambio a polares, dónde:
% rho*cos(alpha)=L3*cos(q3)+L2
% rho*sin(alpha)=L3*sin(q3)
syms rho alpha real
rho = sqrt( (L3*cos(q3)+L2)^2 + (L3*sin(q3))^2 );
alpha=atan2( L3*sin(q3) , L3*cos(q3)+L2 );

% De ese modo, sustituyendo en Ades se tendrá
% Ades=rho*( cos(alpha)*cos(q2) - sin(alpha)*sin(q2) )
% Lo cual se podra sustituir por la formula de la suma de alpha+q2
% FORMULA ->  cos(a+b) = cos(a)*cos(b) - sin(a)*sin(b)
% Por lo tanto: A/rho=cos(alpha+q2) ;  sin(alpha+q2)=+-sqrt(1-(A/rho)^2)
% Se define, la variable articular q2 como
qi2=atan2( sqrt(1-(A/rho)^2) , A/rho ) - alpha;

%% DATOS DEL ROBOT
% Parametros geometricos
L0=1; L1=3; L2=1.5; L3=2;


%% ANALISIS CINEMATICO DIRECTO (NUMERICO)
% Se introduce el valor de las variables articulares
q1=input('Introduzca la variable articular q1:\n')
q2=input('Introduzca la variable articular q2:\n')
q3=input('Introduzca la variable articular q3:\n')

A01=fun_MDH( q1 , L0+L1 , 0  , pi/2 );
A12=fun_MDH( q2 ,   0   , L2 ,  0   );
A23=fun_MDH( q3 ,   0   , L3 ,  0   );

mT=A01*A12*A23;

% Se definira la solucion del problema cinematico directo
p=mT(1:3,4)

%% ANALISIS CINEMATICO INVERSO (NUMERICO)
% A partir de una posicion se obtendra el valor de las var articulares
% px=p(1);
% py=p(2);
% pz=p(3);
px=3.5;py=0;pz=4;
% Se definen las variables auxiliares necesarias
A=sqrt(px^2+py^2);
B=pz-L0-L1;
C=A^2+B^2;

% Se podrá definir la primera variable articular, q1, como
qi1=atan2( (py/A) , (px/A) )

% Por lo tanto, se definirá la variable articular q3 como
qi3=atan2( sqrt( 1-( (C-L2^2-L3^2)/(2*L2*L3) )^2 ) , (C-L2^2-L3^2)/(2*L2*L3) )

rho = sqrt( (L3*cos(qi3)+L2)^2 + (L3*sin(qi3))^2 );
alpha=atan2( L3*sin(qi3) , L3*cos(qi3)+L2 );

% Se define, la variable articular q2 como
qi2=atan2( sqrt(1-(A/rho)^2) , A/rho ) - alpha


