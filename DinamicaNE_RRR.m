%% ANALISIS DINÃ?MICO DEL ROBOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UTILIZACION DEL METODO DE NEWTON-EULER PARA LA DINAMICA DEL ROBOT    %
% M.G. Ortega (2017)                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DECLARACIÃ“N DE VARIABLES SIMBOLICAS
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

pi1 = sym('pi');

% DATOS CINEMÃ?TICOS DEL BRAZO DEL ROBOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dimensiones (m)
% L0=1; L1=3; L2=1.5; L3=2;

% Parametros de Denavit-Hartenberg (utilizado en primera regla de Newton-Euler)
  theta0=0;  d0=0;     a0=0;   alpha0=0;
  theta1=q1; d1=L0+L1; a1=0;   alpha1=pi1/2;
  theta2=q2; d2=0;     a2=L2;  alpha2=0;
  theta3=q3; d3=0;     a3=L3;  alpha3=0;
% Entre eslabon 3 y marco donde se ejerce la fuerza (a definir segun
% experimento).Si queremos ejercer una fuerza, esa fuerza hay que
% espresarlas a unos marcos de referencia.
  theta4=0; d4=0; a4=0; alpha4=0;

% DATOS DINAMICOS DEL BRAZO DEL ROBOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eslabones 0 y 1
  m1=m1; % [kg] Esta masa será la suma de m0 y m1
  s11 = [s11x s11y s11z]'; % m
  I11 = [I11xx    0      0   ;...
           0    I11yy    0   ;...
           0      0    I11zz]; % kg.m2

% Eslabon 2
  m2 =m2; % kg
  s22 = [s22x s22y s22z]'; % m
  I22 = [I22xx    0      0   ;...
           0    I22yy    0   ;...
           0      0    I22zz]; % kg.m2

% Eslabon 3
  m3 = 2; % kg
  s33 = [s33x s33y s33z]'; % m
  I33 = [I33xx    0      0   ;...
           0    I33yy    0   ;...
           0      0    I33zz]; % kg.m2



% DATOS DE LOS MOTORES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inercias
  Jm1= Jm1 ; Jm2= Jm2 ; Jm3= Jm3 ; % kg.m2
% Coeficientes de friccion viscosa
  Bm1= Bm1; Bm2= Bm2; Bm3= Bm3; % N.m / (rad/s)
% Factores de reduccion
  R1= R1; R2= R2; R3= R3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ALGORITMO DE NEWTON-EULER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% wij : velocidad angular absoluta de eje j expresada en i
% wdij : aceleracion angular absoluta de eje j expresada en i
% vij : velocidad lineal absoluta del origen del marco j expresada en i
% vdij : aceleracion lineal absoluta del origen del marco j expresada en i
% aii : aceleracion del centro de gravedad del eslabon i, expresado en i

% fij : fuerza ejercida sobre la articulacion j-1 (union barra j-1 con j),
% expresada en i-1
%
% nij : par ejercido sobre la articulacion j-1 (union barra j-1 con j),
% expresada en i-1

% pii : vector (libre) que une el origen de coordenadas de i-1 con el de i,
% expresadas en i : [ai, di*sin(alphai), di*cos(alphai)] (a,d,aplha: parametros de DH)
%
% Sii : coordenadas del centro de masas del eslabon i, expresada en el sistema
% i

% Iii : matriz de inercia del eslabon i expresado en un sistema paralelo al
% i y con el origen en el centro de masas del eslabon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% N-E 1: Asignacion a cada eslabon de sistema de referencia de acuerdo con las normas de D-H.
  % Eslabon 1:
    p11 = [a1, d1*sin(alpha1), d1*cos(alpha1)]';   
  % Eslabon 2:
    p22 = [a2, d2*sin(alpha2), d2*cos(alpha2)]'; 
  % Eslabon 3:
    p33 = [a3, d3*sin(alpha3), d3*cos(alpha3)]'; 
  % Entre eslabon 2 y marco donde se ejerce la fuerza (supongo que el mismo
  % que el Z0
    p44 = [a4, d4*sin(alpha4), d4*cos(alpha4)]'; 

    
% N-E 2: Condiciones iniciales de la base
  w00=[0 0 0]';
  wd00 = [0 0 0]';
  v00 = [0 0 0]';
  vd00 = [0 0 g]'; % Aceleracion de la gravedad en el eje Z0 negativo
% Condiciones iniciales para el extremo del robot
  f44= [0 0 0]';
  n44= [0 0 0]';
% Definicion de vector local Z
  Z=[0 0 1]';


% N-E 3: Obtencion de las matrices de rotacion (i)R(i-1) y de sus inversas
  R01=[cos(theta1) -cos(alpha1)*sin(theta1) sin(alpha1)*sin(theta1);
      sin(theta1)  cos(alpha1)*cos(theta1)  -sin(alpha1)*cos(theta1);
      0            sin(alpha1)                cos(alpha1)           ];
  R10= R01';

  R12=[cos(theta2) -cos(alpha2)*sin(theta2) sin(alpha2)*sin(theta2);
      sin(theta2)  cos(alpha2)*cos(theta2)  -sin(alpha2)*cos(theta2);
      0            sin(alpha2)              cos(alpha2)           ];
  R21= R12';

  R23=[cos(theta3) -cos(alpha3)*sin(theta3) sin(alpha3)*sin(theta3);
      sin(theta3)  cos(alpha3)*cos(theta3)  -sin(alpha3)*cos(theta3);
      0            sin(alpha3)              cos(alpha3)           ];
  R32= R23';

  R34=[cos(theta4) -cos(alpha4)*sin(theta4) sin(alpha4)*sin(theta4);
      sin(theta4)  cos(alpha4)*cos(theta4)  -sin(alpha4)*cos(theta4);
      0            sin(alpha4)              cos(alpha4)           ];
  R43= R34';


%%%%%%% ITERACION HACIA EL EXTERIOR (CINEMATICA) %%%%%%%
% N-E 4: Obtencion de las velocidades angulares absolutas
% (Se obtendran todas del mismo modo debido a que son de rotacion todas)
 % Articulacion 1
    w11= R10*(w00+Z*qd1); 
 % Articulacion 2
    w22= R21*(w11+Z*qd2); 
 % Articulacion 3
    w33= R32*(w22+Z*qd3);  

    
% N-E 5: Obtencion de las aceleraciones angulares absolutas
% (Se obtendran todas del mismo modo debido a que son de rotacion todas)
 % Articulacion 1
    wd11 = R10*(wd00+Z*qdd1+cross(w00,Z*qd1)); 
 % Articulacion 2
    wd22 = R21*(wd11+Z*qdd2+cross(w11,Z*qd2));  
 % Articulacion 3
    wd33 = R32*(wd22+Z*qdd3+cross(w22,Z*qd3));

    
% N-E 6: Obtencion de las aceleraciones lineales de los origenes de los
% sistemas.
% (Se obtendran todas del mismo modo debido a que son de rotacion todas)
 % Articulacion 1
    vd11 = cross(wd11,p11)+cross(w11,cross(w11,p11))+R10*vd00; 
 % Articulacion 2
    vd22 = cross(wd22,p22)+cross(w22,cross(w22,p22))+R21*vd11; 
 % Articulacion 3
    vd33 = cross(wd33,p33)+cross(w33,cross(w33,p33))+R32*vd22; 

    
% N-E 7: Obtencion de las aceleraciones lineales de los centros de gravedad
    a11 = cross(wd11,s11)+cross(w11,cross(w11,s11))+vd11;
    a22 = cross(wd22,s22)+cross(w22,cross(w22,s22))+vd22;
    a33 = cross(wd33,s33)+cross(w33,cross(w33,s33))+vd33;

    
%%%%%%% ITERACION HACIA EL INTERIOR (DINAMICA) %%%%%%%
% N-E 8: Obtencion de las fuerzas ejercidas sobre los eslabones
  f33=R34*f44+m3*a33;
  f22=R23*f33+m2*a22;
  f11=R12*f22+m1*a11;

  
% N-E 9: Obtencion de los pares ejercidas sobre los eslabones
  n33 = R34*(n44+cross(R43*p33,f44))+cross(p33+s33,m3*a33)+I33*wd33+cross(w33,I33*w33);
  n22 = R23*(n33+cross(R32*p22,f33))+cross(p22+s22,m2*a22)+I22*wd22+cross(w22,I22*w22);
  n11 = R12*(n22+cross(R21*p11,f22))+cross(p11+s11,m1*a11)+I11*wd11+cross(w11,I11*w11);

  
% N-E 10: Obtener la fuerza o par aplicado sobre la articulacion
  N3z = n33'*R32*Z;  % Si es de rotacion
  N3  = n33'*R32;    % Para ver todos los pares, no solo el del eje Z
  F3z = f33'*R32*Z;  % Si es de translacion;
  F3  = f33'*R32;    % Para ver todas las fuerzas, no solo la del eje Z
  N2z = n22'*R21*Z;  % Si es de rotacion
  N2  = n22'*R21;    % Para ver todos los pares, no solo el del eje Z
  F2z = f22'*R21*Z;  % Si es de translacion;
  F2  = f22'*R21;    % Para ver todas las fuerzas, no solo la del eje Z
  N1z = n11'*R10*Z;  % Si es de rotacion
  N1  = n11'*R10;    % Para ver todos los pares, no solo el del eje Z
  F1z = f11'*R10*Z;  % Si es de translacion;
  F1  = f11'*R10;    % Para ver todas las fuerzas, no solo la del eje Z

% Robot RRR (descomentar los que procedan)
%(F=fuerza y N=par)
  % T1=simplify(F1z);
   T1=simplify(N1z);
  % T2=simplify(F2z);
   T2=simplify(N2z);
  % T3=simplify(F3z);
   T3=simplify(N3z);

 %En el metodo N-E puedo añadir las condiciones de contorno(por ejemplo, 
 %colgar un peso al robot) mientras que en la Lagrangiana no.
 %N-E nos permite medir los esfuerzos, es decir, para calculo de la
 %estructura del robot.

 %Conviene ordenar las ecuaciones a nivel simbolico, es decir, T2 y T3 son
 %una putada. Cómo se ordenan??
 %Si lo que yo manejo son pares generalzados en las articulaciones y
 %olvidandonos de los motores.
 %El par se va a invertir en => T = M(q)*q'' + V(q,q') + G(q)
    %M(q) matriz dinamica definida positiva que depende de donde este el
    %robot
    %V(q,q)=C(q,q')*(q)
    %Si no tengo muelles ni nada raro, lo unico que habra en G(q) es la
    %gravedad.
    
%¿Como montamos la ecuacion T?
%T1= M11(q)qdd1 + M12(q)qdd2 + M13(q)qdd3  + V(q,q) + G(q)
%donde M11=diff(T1,qdd1) 
%           y Taux=T1-M11qdd1
%      M12=diff(Taux,qdd2) 
%           y Taux=T2-M12qdd2
%      M13=diff(Taux,qdd3) 
%           y Taux=T3-M13qdd
%Por ultimo, para obtener G(q) debemos G(s)=diff(Taux,g)*g
%Para obtener V(q,qd1)=aux-G
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%SI TENGO MOTORES Y REDUCTORAS, HAY QUE AÑADIRLO A LA ECUACION T.
%A continuacion, veremos como se odifica la ecuacion T cuando empleo
%reductora.
%T=[M(q)+R^2*Jm]qdd+V(q,qd)+(R^2*Bm)*qd+G(q)

%% Calculos simbolicos modelo directo

%T= M(q)qdd+V(q,qd)+G(q)=M(q)qdd+VG(q,qd)

%Primera ecuacion
%-------------------------------
%Calculo de los terminos de la matriz de inercia (afines a qdd)
M11=diff(T1,qdd1);
Taux=simplify(T1-M11*qdd1);
M12=diff(Taux,qdd2);
Taux=simplify(Taux-M12*qdd2);
M13=diff(Taux,qdd3);
Taux=simplify(Taux-M13*qdd3);
%Taux restante contiene terminos Centripetos/Coriolis y Gravitatorios
%Terminos gravitatorios: dependen linealmente de "g"
G1=diff(Taux,g)*g;
Taux=simplify(Taux-G1);
%Taux restante contiene terminos Centripetos/Coriolis
V1=Taux;

%Segunda ecuacion
%-------------------------------
%Calculo de los terminos de la matriz de inercia (afines a qdd)
M21=diff(T2,qdd1);
Taux=simplify(T2-M21*qdd1);
M22=diff(Taux,qdd2);
Taux=simplify(Taux-M22*qdd2);
M23=diff(Taux,qdd3);
Taux=simplify(Taux-M23*qdd3);
%Taux restante contiene terminos Centripetos/Coriolis y Gravitatorios
%Terminos gravitatorios: dependen linealmente de "g"
G2=diff(Taux,g)*g;
Taux=simplify(Taux-G2);
%Taux restante contiene terminos Centripetos/Coriolis
V2=Taux;

%Tercera ecuacion
%-------------------------------
%Calculo de los terminos de la matriz de inercia (afines a qdd)
M31=diff(T3,qdd1);
Taux=simplify(T3-M31*qdd1);
M32=diff(Taux,qdd2);
Taux=simplify(Taux-M32*qdd2);
M33=diff(Taux,qdd3);
Taux=simplify(Taux-M33*qdd3);
%Taux restante contiene terminos Centripetos/Coriolis y Gravitatorios
%Terminos gravitatorios: dependen linealmente de "g"
G3=diff(Taux,g)*g;
Taux=simplify(Taux-G3);
%Taux restante contiene terminos Centripetos/Coriolis
V3=Taux;

%% Simplificacion de expresiones
M11=simplify(M11); M21=simplify(M21); M31=simplify(M31);
M12=simplify(M12); M22=simplify(M22); M32=simplify(M32);
M13=simplify(M13); M23=simplify(M23); M33=simplify(M33);

V1=simplify(V1); V2=simplify(V2); V3=simplify(V3);
G1=simplify(G1); G2=simplify(G2); G3=simplify(G3);

%Apilacion en matrices y vectores
M=[M11 M12 M13; M21 M22 M23; M31 M32 M33];
V=[V1; V2; V3];
G=[G1; G2; G3];

%Inclusion de los motores en las ecuaciones dinamicas
%
% T= [M(q)+R^2*Jm]qdd+V(q,qd)+(R^2*Bm)*qd+G(q)
%
% Ma= M+ R^2
R=diag([R1 R2 R3]);
Jm=diag([Jm1 Jm2 Jm3]);
Bm=diag([Bm1 Bm2 Bm3]);
%Kt=diag([Kt1 Kt2 Kt3]);    No utilizado

Ma=M+R*R*Jm;
Va=V+R*R*Bm*[qd1; qd2; qd3];
Ga=G;

%La funcion vpa del Symbolics ToolBox evalua las expresiones de Ã±as
%fracciones de una funcion simbolica, redondeandolas con la precision que
%podria pasarse como segundo argumento
Ma=vpa(Ma,5)
Va=vpa(Va,5)
Ga=vpa(G,5)

% Ahora se deben introducir las matrices Ma,Va y Ga en el script
% "ModeloDinamico_R3GDL.m"
% La salida sera qdd, es decir, aceleracion ya que de ese modo se podra
% integrar para obtener velocidad y posicion.

%Es necesario las condiciones iniciales del robot, para ello, debemos
%ponerlas en los integradores de Simulink. (Seran cond iniciales de
%posicion)