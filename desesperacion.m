%% REOBTENCION DE LOS PARAMETROS
%DECLARACION DE VARIABLES SIMBOLICAS
syms T1 T2 T3 real          %Par o fuerza efectivo ejercidos sobre la
%barra i en torno a su centro de masas.
%(par motor menos pares de rozamiento o perturbacion)
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
syms Jm1 Jm2 Jm3 Bm1 Bm2 Bm3 real
syms R1 R2 R3 real

pi1 = sym('pi');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se ha definido tetha como
tetha_sim=[I11xx I11yy I11zz Jm1 Bm1 ...
    I22xx I22yy I22zz Jm2 Bm2  ...
    I33xx I33yy I33zz Jm3 Bm3 ...
    m1*(s11z^2) m1*s11z m1 m2*(s22x^2) m2*s22x m2 m3*(s33x^2) m3*s33x m3]';
% Se define gamma sin simplificar nada como
gamma_sim=[ 0, qdd1, 0, R1^2*qdd1, R1^2*qd1, 0.5*qdd1 - 0.5*qdd1*cos(2.0*q2) + qd1*qd2*sin(2.0*q2), 0.5*qdd1 + 0.5*qdd1*cos(2.0*q2) - 1.0*qd1*qd2*sin(2.0*q2),    0,         0,        0, 0.5*qdd1 - 0.5*qdd1*cos(2*q2 + 2*q3) + qd1*qd2*sin(2*q2 + 2*q3) + qd1*qd3*sin(2*q2 + 2*q3), 0.5*qdd1 + 0.5*qdd1*cos(2*q2 + 2*q3) - 1.0*qd1*qd2*sin(2*q2 + 2*q3) - 1.0*qd1*qd3*sin(2*q2 + 2*q3),           0,         0,        0, qdd1, 0, 0, 0.5*qdd1 + 0.5*qdd1*cos(2.0*q2) - 1.0*qd1*qd2*sin(2.0*q2), -1.0*L2*(qdd1 + qdd1*cos(2.0*q2) - 2.0*qd1*qd2*sin(2.0*q2)), (L2^2*(qdd1 + qdd1*cos(2.0*q2) - 2.0*qd1*qd2*sin(2.0*q2)))/2, 0.5*qdd1 + 0.5*qdd1*cos(2*q2 + 2*q3) - 1.0*qd1*qd2*sin(2*q2 + 2*q3) - 1.0*qd1*qd3*sin(2*q2 + 2*q3), 2.0*L3*qd1*qd2*sin(2*q2 + 2*q3) - 1.0*L2*qdd1*cos(2.0*q2 + q3) - 1.0*L3*qdd1*cos(2*q2 + 2*q3) - 1.0*L2*qdd1*cos(q3) - 1.0*L3*qdd1 + 2.0*L3*qd1*qd3*sin(2*q2 + 2*q3) + L2*qd1*qd3*sin(q3) + 2.0*L2*qd1*qd2*sin(2.0*q2 + q3) + L2*qd1*qd3*sin(2.0*q2 + q3), 0.5*L2^2*qdd1 + 0.5*L3^2*qdd1 + 0.5*L3^2*qdd1*cos(2*q2 + 2*q3) + 0.5*L2^2*qdd1*cos(2.0*q2) + L2*L3*qdd1*cos(q3) - 1.0*L3^2*qd1*qd2*sin(2*q2 + 2*q3) - 1.0*L3^2*qd1*qd3*sin(2*q2 + 2*q3) - 1.0*L2^2*qd1*qd2*sin(2.0*q2) + L2*L3*qdd1*cos(2.0*q2 + q3) - 2.0*L2*L3*qd1*qd2*sin(2.0*q2 + q3) - 1.0*L2*L3*qd1*qd3*sin(2.0*q2 + q3) - 1.0*L2*L3*qd1*qd3*sin(q3);
            0,    0, 0,         0,        0,                                -0.5*qd1^2*sin(2.0*q2),                                     0.5*qd1^2*sin(2.0*q2), qdd2, R2^2*qdd2, R2^2*qd2,                                                                -0.5*qd1^2*sin(2*q2 + 2*q3),                                                                         0.5*qd1^2*sin(2*q2 + 2*q3), qdd2 + qdd3,         0,        0,    0, 0, 0,                              0.5*sin(2.0*q2)*qd1^2 + qdd2,        - 1.0*L2*sin(2.0*q2)*qd1^2 - 2.0*L2*qdd2 - g*cos(q2),        0.5*sin(2.0*q2)*L2^2*qd1^2 + qdd2*L2^2 + g*cos(q2)*L2,                                                           0.5*sin(2*q2 + 2*q3)*qd1^2 + qdd2 + qdd3,                                                           L2*qd3^2*sin(q3) - 2.0*L3*qdd3 - g*cos(q2 + q3) - 2.0*L3*qdd2 - 1.0*L2*qd1^2*sin(2.0*q2 + q3) - 1.0*L3*qd1^2*sin(2*q2 + 2*q3) - 2.0*L2*qdd2*cos(q3) - L2*qdd3*cos(q3) + 2.0*L2*qd2*qd3*sin(q3),                                                                                     L2^2*qdd2 + L3^2*qdd2 + L3^2*qdd3 + 0.5*L3^2*qd1^2*sin(2*q2 + 2*q3) + 0.5*L2^2*qd1^2*sin(2.0*q2) + L3*g*cos(q2 + q3) + L2*g*cos(q2) + L2*L3*qd1^2*sin(2.0*q2 + q3) + 2.0*L2*L3*qdd2*cos(q3) + L2*L3*qdd3*cos(q3) - 1.0*L2*L3*qd3^2*sin(q3) - 2.0*L2*L3*qd2*qd3*sin(q3);
            0,    0, 0,         0,        0,                                                     0,                                                         0,    0,         0,        0,                                                                -0.5*qd1^2*sin(2*q2 + 2*q3),                                                                         0.5*qd1^2*sin(2*q2 + 2*q3), qdd2 + qdd3, R3^2*qdd3, R3^2*qd3,    0, 0, 0,                                                         0,                                                           0,                                                            0,                                                           0.5*sin(2*q2 + 2*q3)*qd1^2 + qdd2 + qdd3,                                                                     - 2.0*L3*qdd2 - 2.0*L3*qdd3 - 1.0*g*cos(q2 + q3) - 0.5*L2*qd1^2*sin(q3) - 1.0*L2*qd2^2*sin(q3) - 0.5*L2*qd1^2*sin(2.0*q2 + q3) - 1.0*L3*qd1^2*sin(2*q2 + 2*q3) - 1.0*L2*qdd2*cos(q3),                                                                                                                                                                            (L3*(2.0*L3*qdd2 + 2.0*L3*qdd3 + 2.0*g*cos(q2 + q3) + L2*qd1^2*sin(q3) + 2.0*L2*qd2^2*sin(q3) + L2*qd1^2*sin(2.0*q2 + q3) + L3*qd1^2*sin(2*q2 + 2*q3) + 2.0*L2*qdd2*cos(q3)))/2];

% Ahora nuestro objetivo sera reducir la matriz gamma a 11 columnas. Para
% ello, en primer lugar, se separan los terminos no identificables.
% (terminos asociados a columnas de ceros en gamma)
[ind_fil ind_col]=size(gamma_sim);
% param_no_ident=sym('param_no_ident',[size(tetha_sim)]);

j=1; k=1; % Inicializacion de variables para el bucle
%Recorremos las columnas
for i=1:ind_col
    if (gamma_sim(1,i) == 0 && gamma_sim(2,i)==0 && gamma_sim(3,i)==0)
        %param_no_ident(j)=tetha_sim(i);
        %j=j+1;
    else
        gamma(:,k)=gamma_sim(:,i);
        tetha(k)=tetha_sim(i);
        k=k+1;
    end
end
tetha=tetha';

% COMPROBACION
vpa((eval(gamma)*tetha)-( eval(gamma_sim)*tetha_sim ),2);
% HASTA AQUI UNICAMENTE SE HAN QUITADO LOS TERMINOS DE CEROS

gamma_square=[]; gamma_aux=[];
% En estas matrices, se habran quitado las columnas de ceros y los
% terminos asociados a las mismas.
for i=1:1:7
    % Valores aleatorios
    q1=rand;qd1=rand;qdd1=rand;
    q2=rand;qd2=rand;qdd2=rand;
    q3=rand;qd3=rand;qdd3=rand;
    
    % Valores conocidos
    g=9.8;L0=0.6;L1=0.6;L2=1;L3=0.8;
    % Valores de reductoras
    R1=50; R2=30; R3=15; 
     
    gamma_aux=eval(gamma);
    if (i==7)
        gamma_square=vertcat(gamma_square,gamma_aux(1:2,:));
    else
        gamma_square=vertcat(gamma_square,gamma_aux);
    end
end

[R,jB]=rref(gamma_square); length(jB);

% AÑADIR LO DE LIMPAR NUMEROS

vpa(R*tetha,5);

% Reagrupando los terminos dinamicos

% Una vez se conocen las relaciones lineales, seria conveniente redefinir
% las ecuaciones gamma y tetha como la combinacion lineal de los parametros

% Obtenemos los parametros agrupados
tetha_li_Zeros=vpa(R*tetha,5);

% Eliminamos los parametros igual a ceros obteniendo nuestro vector de
% parametros agrupados
tetha_li=vpa( simplify( tetha_li_Zeros(1:length(jB))) ,5);


%Eliminamos las columnas linealmente dependientes de la matriz gamma

[ind_fil, ind_col]=size(gamma);
z=1; k=1; % Inicializacion de variables para el bucle

%Recorremos las columnas
for i=1:ind_col
    for k=1:length(jB)
        
        if (i==jB(k))
            gamma_li(:,z)=gamma(:,i);
            z=z+1;
        end
        
    end
end
gamma_li= simplify(gamma_li);

% VERIFICACION
DinamicaNE_RRR
L0=0.6;L1=0.6;L2=1;L3=0.8; g=9.8;
R1=50; R2=30; R3=15;

Y_init=simplify(eval([T1;T2;T3]));
Y_fin=simplify(eval(gamma_li*tetha_li));

test=vpa(simplify(Y_init-Y_fin),5)
% Se verifica que POR COJONES esto está bien

%% SCRIPT DONDE SE HAYA UNICAMENTE EL ROBOT IDEAL
%
% EL ERROR DEBE ESTAR ENTRE AQUISSSSSSSSSSSSSSS
%
%

% Una vez se tetha_li y gamma_li se hacen los experimentos.

Tm=0.001;
% %%%%%%% EXCITACION A LOS SENOS %%%%%%%%%%%%%%%%
% Valores de reductoras
R1=50; R2=30; R3=15;
%Valores de tiempo atenuacion
tau1=5; tau2=5; tau3=5;

% %%Parametros senoides
% %Senoide I1
% Aa_1=.01; Ab_1=.1;
% wa_1=100; wb_1=30;
% Im_cc1=3;
% 
% %Senoide I2
% Aa_2=0; Ab_2=0;
% wa_2=100; wb_2=20;
% Im_cc2=.001;
% 
% %Senoide I3
% Aa_3=0; Ab_3=0;
% wa_3=100; wb_3=10;
% Im_cc3=.001;

%%Parametros senoides
%Senoide I1
Aa_1=4; Ab_1=2;
wa_1=50; wb_1=1;
Im_cc1=0;

%Senoide I2
Aa_2=1; Ab_2=1;
wa_2=5; wb_2=10;
Im_cc2=2;

%Senoide I3
Aa_3=.5; Ab_3=.1;
wa_3=3; wb_3=10;
Im_cc3=1;

% %%%%%%% SIMULACION DEL ROBOT REAL %%%%%%%%%%%%
sim('sl_RobotReal_RRR');   

% %% ESTIMACION DE LOS PARAMETROS DINAMICOS %%%%%% 
% Valores de simulacion
n=10; %Cada cuantas muestras tomamos los datos
M=floor(length(t_D)/n); %Numero de datos totales

% Valores conocidos
g=9.8;L0=0.6;L1=0.6;L2=1;L3=0.8;
Kt1=0.5; Kt2=0.4; Kt3 =0.35; Kt=diag([Kt1; Kt2; Kt3]);
R1=50; R2=30; R3=15; R=diag([R1 ;R2 ;R3]);   % Reductoras
KtR=Kt*R;

%Declaracion de variables necesarias
tetha_expr=[]; %Valores hallados de los Parametros dinamicos
tetha_tpc=[];  %Tantos por cientos de la desviacion del parámetro

gamma_expr=[]; %Matriz Gamma concatenada
gamma_aux=[];  %Vble Auxiliar para procedimiento
Y_expr=[];     %Vector agrupado de valores de intensidad

%Obtencion del banco de pruebas y aproximacion de los parametos dinamicos
Y_expr=[];
for i=2000:n:length(t_D)  % Se toma a partir del segundo 2
    % Valores articulares tomados
    q1=qi_D(i,1); qd1=qdi_D(i,1); qdd1=qddi_D(i,1);
    q2=qi_D(i,2); qd2=qdi_D(i,2); qdd2=qddi_D(i,2);
    q3=qi_D(i,3); qd3=qdi_D(i,3); qdd3=qddi_D(i,3);
    
    %Sustituimos los valores experimentales en nuestro modelo del robot
    gamma_aux=eval(gamma_li);
   
    %Se forma el banco de pruebas agrupando Verticalmente 
    gamma_expr=vertcat(gamma_expr,gamma_aux);
    
    %Reagrupamos los valores de intensidad para cuadrar el formato de
    %calculo
%     Y_expr=vertcat(Y_expr,(Im_D(i,:)*Kt*R));
Y_expr=[Y_expr;Im_D(i,1)*KtR(1,1);Im_D(i,2)*KtR(2,2);Im_D(i,3)*KtR(3,3)];
    
end
%Obtencion de los parametros dinamicos por minimos cuadrados
tetha_expr=lscov(gamma_expr,Y_expr);


%% Calculo Varianza estadística de Parametros Dinamicos[VALIDACION]

%Calculo covarianza y minimos cuadrados
rn=length(Y_expr); %Numero de valores de intensidad al realizar M experimentos(En nuestro caso 3*M)
m=length(tetha_expr); %Numero de parametros dinamicos a hallar 

%Calculo de la varianza del error asociado rho
var_pcuadrado=(norm(Y_expr-(gamma_expr*tetha_expr)).^2)/(rn-m);

%Obtenemos Matriz de covarianzas de tetha a partir del banco de pruebas de
%Gamma y de la varianza de rho.
gamma_expr_cuadrada=inv(gamma_expr'*gamma_expr); %Pseudo inversa de la matriz cuadrada del banco de pruebas
Cov_tetha=var_pcuadrado*gamma_expr_cuadrada;     %Matriz de covarianzas de tetha

%Selecionamos los valores diagonales como las varianzas de los parametros
for i=1:length (Cov_tetha)
var_tetha(i)=sqrt(abs(Cov_tetha(i,i)));
end


%Se comprueva la validez del parametro

tolerancia_tpc=5; %Condicion de verificacion en %
flag=0;     % Flag creado para que si todos los valores sin validos, se obtenga el modelo.

for i=1:length(tetha_expr)
    %Calculo de la varianza porcentual para cada relacion de parametros
    %dinamicos
    tetha_tpc(i)=100*(var_tetha(i)/abs(tetha_expr(i)));
    
    %Se comprueba la validez y se muestra por pantalla    
    if(tetha_tpc(i)<tolerancia_tpc)
        fprintf('tetha_li(%i)= %i Valido con varianza %i \n',[i tetha_expr(i) tetha_tpc(i)]);
    else
        fprintf('tetha_li(%i) NO Identificado var=%i \n ',[i tetha_tpc(i)]);
        flag=1;
    end
end 

%
% Y AQUISSSSSSSSSSSSSSSS
%
%

if (flag==1)
    fprintf('Algun parametro estimado no es valido.\n');
else    
    Im_estimadas=gamma_li*tetha_expr;
    Im_est1=Im_estimadas(1,:);
    Im_est2=Im_estimadas(2,:);
    Im_est3=Im_estimadas(3,:);

    syms q1 q2 q3 qd1 qd2 qd3 qdd1 qdd2 qdd3  g real
    L0=0.6; L1=0.6; L2=1; L3=0.8;
%   Kt1=0.5; Kt2=0.4; Kt3 =0.35;

    % Tau=Kt*R*Im= M(q)qdd+V(q,qd)+G(q)=M(q)qdd+VG(q,qd) ->
    % Im=

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
    
    Kt1=0.5; Kt2=0.4; Kt3 =0.35; Kt=diag([Kt1; Kt2; Kt3]);
    R1=50; R2=30; R3=15; R=diag([R1 ;R2 ;R3]);   % Reductoras
    KtR=Kt*R;
    
    
    Ma=vpa(M,5); Ma=inv(KtR)*Ma;
    Va=vpa(V,5); Va=inv(KtR)*Va;
    Ga=vpa(G,5); Ga=inv(KtR)*Ga;
    
    % Definicion de las matrices del modelo. El modelo, por tanto, tendria la
    % forma: Im=Ma*qdd + Va*qd +Ga
   % Ma=((Kt*R)^(-1))*M;
   % Va=((Kt*R)^(-1))*V;
   % Ga=((Kt*R)^(-1))*G;
    
   % Valores en funcion de los pares.
    Ma=vpa(Ma,5)
    Va=vpa(Va,5)
    Ga=vpa(Ga,5)


end