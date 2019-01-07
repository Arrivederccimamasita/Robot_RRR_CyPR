%% CONTRUCCION DEL MODELO REAL SIN REDUCTORAS A PARTIR DE REALIZAR EXPERIMENTOS
syms q1 q2 q3 qd1 qd2 qd3 qdd1 qdd2 qdd3  g real
L0=0.6; L1=0.6; L2=1; L3=0.8;
Kt1=0.5; Kt2=0.4; Kt3 =0.35; Kt=diag([Kt1; Kt2; Kt3]);
R1=1; R2=1; R3=1; 
R=diag([R1 ;R2 ;R3]);   % Reductoras=1
KtR=Kt*R;
    
% Matriz gamma CON reductoras
gamma_li=[ qdd1, qd1, qdd1/2 - (qdd1*cos(2*q2))/2 + qd1*qd2*sin(2*q2),    0,   0, qdd1/2 - (qdd1*cos(2*q2 + 2*q3))/2 + qd1*qd2*sin(2*q2 + 2*q3) + qd1*qd3*sin(2*q2 + 2*q3),           0,    0,   0, -L2*(qdd1 + qdd1*cos(2*q2) - 2*qd1*qd2*sin(2*q2)), 2*L3*qd1*qd2*sin(2*q2 + 2*q3) - L2*qdd1*cos(2*q2 + q3) - L3*qdd1*cos(2*q2 + 2*q3) - L2*qdd1*cos(q3) - L3*qdd1 + 2*L3*qd1*qd3*sin(2*q2 + 2*q3) + L2*qd1*qd3*sin(q3) + 2*L2*qd1*qd2*sin(2*q2 + q3) + L2*qd1*qd3*sin(2*q2 + q3);
    0,   0,                            -(qd1^2*sin(2*q2))/2, qdd2, qd2,                                                              -(qd1^2*sin(2*q2 + 2*q3))/2, qdd2 + qdd3,    0,   0,      - L2*sin(2*q2)*qd1^2 - 2*L2*qdd2 - g*cos(q2),                                                 L2*qd3^2*sin(q3) - 2*L3*qdd3 - g*cos(q2 + q3) - 2*L3*qdd2 - L2*qd1^2*sin(2*q2 + q3) - L3*qd1^2*sin(2*q2 + 2*q3) - 2*L2*qdd2*cos(q3) - L2*qdd3*cos(q3) + 2*L2*qd2*qd3*sin(q3);
    0,   0,                                               0,    0,   0,                                                              -(qd1^2*sin(2*q2 + 2*q3))/2, qdd2 + qdd3, qdd3, qd3,                                                 0,                                                               - 2*L3*qdd2 - 2*L3*qdd3 - g*cos(q2 + q3) - (L2*qd1^2*sin(q3))/2 - L2*qd2^2*sin(q3) - (L2*qd1^2*sin(2*q2 + q3))/2 - L3*qd1^2*sin(2*q2 + 2*q3) - L2*qdd2*cos(q3)];

% Paramelos obtenidos mediante la sucesion de experimentos
tetha_expr=zeros(11,1);
% SERA NECESARIO RELLENAR TETHA_EXP CON LOS VALORES OBTENIDOS DE LOS 
% EXPERIMENTOS DE LOS PARAMETROS ANTES DE SEGUIR
% 
% tetha_expr(1)= ;
% tetha_expr(2)= ;
% ...
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Intensidades 
Im_estimadas=gamma_li*tetha_expr;
Im_est1=Im_estimadas(1,:);
Im_est2=Im_estimadas(2,:);
Im_est3=Im_estimadas(3,:);

 % Se aplicar� un proceso de derivadas iterativas que nos ayudar�n a
    % dejar el modelo en funcion de aceleraciones, velocidades y posiciones
    % del robot.

    %Primera ecuacion
    %-------------------------------
    %Calculo de los terminos de la matriz de inercia (afines a qdd)
    M11=diff(Im_est1,qdd1);
    Iaux=simplify(Im_est1-M11*qdd1);
    M12=diff(Iaux,qdd2);
    Iaux=simplify(Iaux-M12*qdd2);
    M13=diff(Iaux,qdd3);
    Iaux=simplify(Iaux-M13*qdd3);
    %Iaux restante contiene terminos Centripetos/Coriolis y Gravitatorios
    %Terminos gravitatorios: dependen linealmente de "g"
    G1=diff(Iaux,g)*g;
    Iaux=simplify(Iaux-G1);
    %Iaux restante contiene terminos Centripetos/Coriolis
    V1=Iaux;

    %Segunda ecuacion
    %-------------------------------
    %Calculo de los terminos de la matriz de inercia (afines a qdd)
    M21=diff(Im_est2,qdd1);
    Iaux=simplify(Im_est2-M21*qdd1);
    M22=diff(Iaux,qdd2);
    Iaux=simplify(Iaux-M22*qdd2);
    M23=diff(Iaux,qdd3);
    Iaux=simplify(Iaux-M23*qdd3);
    %Iaux restante contiene terminos Centripetos/Coriolis y Gravitatorios
    %Terminos gravitatorios: dependen linealmente de "g"
    G2=diff(Iaux,g)*g;
    Iaux=simplify(Iaux-G2);
    %Iaux restante contiene terminos Centripetos/Coriolis
    V2=Iaux;

    %Tercera ecuacion
    %-------------------------------
    %Calculo de los terminos de la matriz de inercia (afines a qdd)
    M31=diff(Im_est3,qdd1);
    Iaux=simplify(Im_est3-M31*qdd1);
    M32=diff(Iaux,qdd2);
    Iaux=simplify(Iaux-M32*qdd2);
    M33=diff(Iaux,qdd3);
    Iaux=simplify(Iaux-M33*qdd3);
    %Iaux restante contiene terminos Centripetos/Coriolis y Gravitatorios
    %Terminos gravitatorios: dependen linealmente de "g"
    G3=diff(Iaux,g)*g;
    Iaux=simplify(Iaux-G3);
    %Iaux restante contiene terminos Centripetos/Coriolis
    V3=Iaux;
        
    M11=simplify(M11); M21=simplify(M21); M31=simplify(M31);
    M12=simplify(M12); M22=simplify(M22); M32=simplify(M32);
    M13=simplify(M13); M23=simplify(M23); M33=simplify(M33);

    V1=simplify(V1); V2=simplify(V2); V3=simplify(V3);
    G1=simplify(G1); G2=simplify(G2); G3=simplify(G3);
    
    
    %Apilacion en matrices y vectores
    M=[M11 M12 M13; M21 M22 M23; M31 M32 M33];
    V=[V1; V2; V3];
    G=[G1; G2; G3];
   
    % Una vez obtenida M, V y G, se deben multiplicar por (KtR^)-1, ya que
    % el modelo nos dar� pares, sin embargo, los motores se deben controlar
    % en intensidad, por tanto: tau=Kt*R*Im -> Im=inv(KtR)*tau.
    Ma=vpa(M,5); Ma=inv(KtR)*Ma;
    Va=vpa(V,5); Va=inv(KtR)*Va;
    Ga=vpa(G,5); Ga=inv(KtR)*Ga;
 
   % Valores en funcion de las intensidades.
    Ma=vpa(Ma,5)
    Va=vpa(Va,5)
    Ga=vpa(Ga,5)
