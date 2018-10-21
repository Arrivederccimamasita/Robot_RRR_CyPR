%% Obtencion Numerica Parametros Dinamicos
%%%%Ejecutar para obtener los datos necesarios
%%%pruebas
%%%IdentificacParamDinam

%%Datos Necesaios
%gamma_li;
%tetha_li;

%Entradas Vectorizadas en funcion del tiempo
% Im_D;
% qi_D;
% qdi_D;
% qddi_D;

%% Algoritmo de obtencion 

%%Valores de simulacion
n=20; %Cada cuantas muestras tomamos los datos
M=floor(length(t_D)/n); %Numero de datos totales

%%Valores conocidos
R1=50; R2=30; R3=15;
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
    q1=qi_D(n*i,1);qd1=qdi_D(n*i,1);qdd1=qddi_D(n*i,1);
    q2=qi_D(n*i,2);qd2=qdi_D(n*i,2);qdd2=qddi_D(n*i,2);
    q3=qi_D(n*i,3);qd3=qdi_D(n*i,3);qdd3=qddi_D(n*i,3);
    
    %Sustituimos los valores experimentales en nuestro modelo del robot
    gamma_aux=eval(gamma_li);
   
    %Se forma el banco de pruebas agrupando Verticalmente 
    gamma_expr=vertcat(gamma_expr,gamma_aux);
    
    %Reagrupamos los valores de intensidad para cuadrar el formato de
    %calculo
    Y_expr=vertcat(Y_expr,Im_D(n*i,:)');
    
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

tolerancia_tpc=15; %Condicion de verificacion en %

for i=1:length(tetha_expr)
    %Calculo de la varianza porcentual para cada relacion de parametros
    %dinamicos
    tetha_tpc(i)=100*(var_tetha(i)/abs(tetha_expr(i)));
    
    %Se comprueba la validez y se muestra por pantalla    
    if(tetha_tpc(i)<tolerancia_tpc)
        fprintf('tetha_li(%i)= %i Valido con varianza %i \n',[i tetha_expr(i) tetha_tpc(i)]);
    else
        fprintf('tetha_li(%i) NO Identificado var=%i \n ',[i tetha_tpc(i)]);
    end
end 
