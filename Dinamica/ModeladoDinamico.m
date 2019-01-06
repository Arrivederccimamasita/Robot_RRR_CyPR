%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% OBTENCION DEL MODELO DINAMICO A PARTIR DE LOS PARAMETROS OBTENIDOS %%%

function [ Ma, Va, Ga ] = ModeladoDinamico( gamma, tetha,R1,R2,R3)
%Modelado Dinamico
%   Se obtienen los valores de las matrices del modelo a partir de los
%   resultados experimentales de los parametros dinamicos

gamma_li= gamma;
tetha_expr=tetha;

 Im_estimadas=gamma_li*tetha_expr;
    Im_est1=Im_estimadas(1,:);
    Im_est2=Im_estimadas(2,:);
    Im_est3=Im_estimadas(3,:);

    syms q1 q2 q3 qd1 qd2 qd3 qdd1 qdd2 qdd3  g real
    L0=0.6; L1=0.6; L2=1; L3=0.8;
    Kt1=0.5; Kt2=0.4; Kt3 =0.35;

    % Tau=Kt*R*Im= M(q)qdd+V(q,qd)+G(q)=M(q)qdd+VG(q,qd) ->
    % Im=

    %Primera ecuacion
    %-------------------------------
    %Calculo de los terminos de la matriz de inercia (afines a qdd)
    M11=diff(Im_est1,qdd1);
    Taux=simplify(Im_est1-M11*qdd1);
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
    M21=diff(Im_est2,qdd1);
    Taux=simplify(Im_est2-M21*qdd1);
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
    M31=diff(Im_est3,qdd1);
    Taux=simplify(Im_est3-M31*qdd1);
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
        
    M11=simplify(M11); M21=simplify(M21); M31=simplify(M31);
    M12=simplify(M12); M22=simplify(M22); M32=simplify(M32);
    M13=simplify(M13); M23=simplify(M23); M33=simplify(M33);

    V1=simplify(V1); V2=simplify(V2); V3=simplify(V3);
    G1=simplify(G1); G2=simplify(G2); G3=simplify(G3);
    
    
    %Apilacion en matrices y vectores
    M=[M11 M12 M13; M21 M22 M23; M31 M32 M33];
    V=[V1; V2; V3];
    G=[G1; G2; G3];
    
    M=vpa(M,5);
    V=vpa(V,5);
    G=vpa(G,5);
    
    % Definicion de los terminos necesarios para pasar de pares a intensidades
    R=[R1 0 0;0 R2 0; 0 0 R3];
    Kt=[Kt1 0 0;0 Kt2 0;0 0 Kt3];

    % Definicion de las matrices del modelo. El modelo, por tanto, tendria la
    % forma: Im=Ma*qdd + Va*qd +Ga
    Ma=((Kt*R)^(-1))*M;
    Va=((Kt*R)^(-1))*V;
    Ga=((Kt*R)^(-1))*G;
    
    Ma=vpa(Ma,5)
    Va=vpa(Va,5)
    Ga=vpa(Ga,5)

[Ma,Va,Ga];

