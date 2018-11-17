%% %%%%%%%%%%% OBTENCION NUMERICA DE LOS PARAMETROS DINAMICOS %%%%%%%%%%%%
% Sera necesario correr el montaje de simulink para tener datos reales del
% robot. Ademas de ello, es necesario tener definidas las matrices gamma y
% tetha.

%%Datos Necesaios
%gamma_li;
%tetha_li;

%Entradas Vectorizadas en funcion del tiempo
% Im_D;
% qi_D;
% qdi_D;
% qddi_D;

% La funcion recibira un vector de intensidades, otro de posiciones y otro
% de aceleraciones. En funcion del modo de trabajo seleccionado, se le
% pasaran unos parametros u otros.
% %%%%%% SIEMPRE HAY QUE PASARLE VALORES DISCRETOS %%%%%%%
function ObtencionNumerica(t,Im,q,qd,qdd,R1,R2,R3)

% Seria conveniente optimizar el codigo para no tener que correr siempre
% este script al inicio de esta ejecucion.
[gamma_li,tetha_li]=Identificacion_ParamLI(R1,R2,R3)   % Se corre este script para obtener tetha_li y gamma_li


% %% ESTIMACION DE LOS PARAMETROS DINAMICOS %%%%%% 
% Valores de simulacion
n=15; %Cada cuantas muestras tomamos los datos
M=floor(length(t)/n); %Numero de datos totales

% Valores conocidos
g=9.8;L0=0.6;L1=0.6;L2=1;L3=0.8;
Kt1=0.5; Kt2=0.4; Kt3 =0.35; Kt=diag([Kt1; Kt2; Kt3]);
% R1=50; R2=30; R3=15; 
R=diag([R1 ;R2 ;R3]);   % Reductoras
KtR=Kt*R;


%Declaracion de variables necesarias
tetha_expr=[]; %Valores hallados de los Parametros dinamicos
tetha_tpc=[];  %Tantos por cientos de la desviacion del parámetro

gamma_expr=[]; %Matriz Gamma concatenada
gamma_aux=[];  %Vble Auxiliar para procedimiento
Y_expr=[];     %Vector agrupado de valores de intensidad

%Obtencion del banco de pruebas y aproximacion de los parametos dinamicos
Y_expr=[];
for i=1:n:length(t)  % Se toma a partir del segundo 2
    % Valores articulares tomados
    q1=q(i,1); qd1=qd(i,1); qdd1=qdd(i,1);
    q2=q(i,2); qd2=qd(i,2); qdd2=qdd(i,2);
    q3=q(i,3); qd3=qd(i,3); qdd3=qdd(i,3);
    
    % Sustituimos los valores experimentales en nuestro modelo del robot
    gamma_aux=eval(gamma_li);
   
    % Se forma el banco de pruebas agrupando Verticalmente 
    gamma_expr=vertcat(gamma_expr,gamma_aux);
    
    % Reagrupamos los valores de intensidad para cuadrar el formato de
    % calculo
    %     Y_expr=vertcat(Y_expr,(Im_D(i,:)*Kt*R));
    format long;
    Y_expr=[Y_expr;Im(i,1)*KtR(1,1);Im(i,2)*KtR(2,2);Im(i,3)*KtR(3,3)];
    
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

tolerancia_tpc=6; %Condicion de verificacion en %
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

%% OBTENCIÓN DEL MODELO DINAMICO
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se obtendrá, a continuación, el modelo dinamico del robot obtenido para
% los parametros estimados anteriormente. La salida de correr esta parte
% del codigo serán 3 matrices, Ma, Va y Ga. Esas matrices ya estarán en
% funcion de las intensidades y, por tanto, basta con copiarlas tal cual al
% script que se correrá en el montaje de Simulink de nuestro robot, en
% concreto, "ModeloDinamico_RRR_sl.m".
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (flag==1)
    fprintf('Algun parametro estimado no es valido.\n');
else    
    Im_estimadas=gamma_li*tetha_expr;
    Im_est1=Im_estimadas(1,:);
    Im_est2=Im_estimadas(2,:);
    Im_est3=Im_estimadas(3,:);

    syms q1 q2 q3 qd1 qd2 qd3 qdd1 qdd2 qdd3  g real
    L0=0.6; L1=0.6; L2=1; L3=0.8;

    % Se aplicará un proceso de derivadas iterativas que nos ayudarán a
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
    % el modelo nos dará pares, sin embargo, los motores se deben controlar
    % en intensidad, por tanto: tau=Kt*R*Im -> Im=inv(KtR)*tau.
    Ma=vpa(M,5); Ma=inv(KtR)*Ma;
    Va=vpa(V,5); Va=inv(KtR)*Va;
    Ga=vpa(G,5); Ga=inv(KtR)*Ga;
 
   % Valores en funcion de las intensidades.
    Ma=vpa(Ma,5)
    Va=vpa(Va,5)
    Ga=vpa(Ga,5)
end