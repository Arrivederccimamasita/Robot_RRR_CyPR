%% Obtencion Numerica Parametros Dinamicos
% %Ejecutar para obtener los datos
% pruebas
% IdentificacParamDinam

%Datos
%gamma_li;
%tetha_li;

%Entradas Vectorizadas

% Im_D;
% qi_D;
% qdi_D;
% qddi_D;

% Valores conocidos
R1=50; R2=30; R3=15;
g=9.8;L0=0.6;L1=0.6;L2=1;L3=0.8;

%DeclaracionVariables

tetha_expr=[];%Valores hallados
tetha_tpc=[]; %Tantos por cientos

gamma_expr=[];
gamma_aux=[];
Y_expr=[];
for i=1:length(t_D)
    % Valores Valores tomados
    q1=qi_D(i,1);qd1=qdi_D(i,1);qdd1=qddi_D(i,1);
    q2=qi_D(i,2);qd2=qdi_D(i,2);qdd2=qddi_D(i,2);
    q3=qi_D(i,3);qd3=qdi_D(i,3);qdd3=qddi_D(i,3);
            
    gamma_aux=eval(gamma_li);
   
    gamma_expr=vertcat(gamma_expr,gamma_aux);
    Y_expr=vertcat(Y_expr,Im_D(i,:)');
    
end
tetha_expr=lscov(gamma_expr,Y_expr);


%% Calculo Varianza estadística
%Calculo covarianza y minimos cuadrados
var_pcuadrado=(norm(Y_expr-(gamma_expr*tetha_expr)).^2)/(length(Y_expr)-length(tetha_expr));
gamma_expr_cuadrada=inv(gamma_expr'*gamma_expr);

%Obtenemos patriz de covarianzas
Cov_tetha=var_pcuadrado*gamma_expr_cuadrada;
%Selecionamos los valores diagonales como las varianzas de los parametros
for i=1:length (Cov_tetha)
var_tetha(i)=sqrt(abs(Cov_tetha(i,i)));
end

for i=1:length(tetha_expr)
    tetha_tpc(i)=100*(var_tetha(i)/abs(tetha_expr(i)));
    if(tetha_tpc(i)<15)
        fprintf('tetha_li(%i)= %i Valido con varianza %i \n',[i tetha_expr(i) tetha_tpc(i)]);
    else
        fprintf('tetha_li(%i) NO Identificado var=%i \n ',[i tetha_tpc(i)]);
    end
end 
