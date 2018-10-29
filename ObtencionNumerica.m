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
IdentificacParamDinam   % Se corre este script para obtener tetha_li y gamma_li



%%Valores de simulacion
n=10; %Cada cuantas muestras tomamos los datos
M=floor(length(t)/n); %Numero de datos totales

%%Valores conocidos
g=9.8;L0=0.6;L1=0.6;L2=1;L3=0.8;

%DeclaracionVariables

tetha_expr=[]; %Valores hallados de los Parametros dinamicos
tetha_tpc=[];  %Tantos por cientos de la desviacion del parámetro

gamma_expr=[]; %Matriz Gamma concatenada
gamma_aux=[];  %Vble Auxiliar para procedimiento
Y_expr=[];     %Vector agrupado de valores de intensidad


%Obtencion del banco de pruebas y aproximacion de los parametos dinamicos
for i=1:M
    % Valores articulares tomados
    q1=q(n*i,1); qd1=qd(n*i,1); qdd1=qdd(n*i,1);
    q2=q(n*i,2); qd2=qd(n*i,2); qdd2=qdd(n*i,2);
    q3=q(n*i,3); qd3=qd(n*i,3); qdd3=qdd(n*i,3);
    
    %Sustituimos los valores experimentales en nuestro modelo del robot
    gamma_aux=eval(gamma_li);
   
    %Se forma el banco de pruebas agrupando Verticalmente 
    gamma_expr=vertcat(gamma_expr,gamma_aux);
    
    %Reagrupamos los valores de intensidad para cuadrar el formato de
    %calculo
    Y_expr=vertcat(Y_expr,Im(n*i,:)');
    
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

tolerancia_tpc=10; %Condicion de verificacion en %
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

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% OBTENCION DEL MODELO DINAMICO A PARTIR DE LOS PARAMETROS OBTENIDOS %%%
% Se debera reconstruir el modelo a partir de los valores numericos
% estimados
if (flag==1)
    fprintf('Algun parametro estimado no es valido.\n');
else    
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
end