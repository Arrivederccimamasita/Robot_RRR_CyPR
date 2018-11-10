%% OBTENCION DE LOS PARAMETROS LINEALMENTE INDEPENDIENTES

function [gamma_li,tetha_li]=Identificacion_ParamLI(R1,R2,R3)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% En este script, tras la diferenciacion del modelo en funciones de
% tetha_sim, se obtendrán las matrices gamma y tetha de parametros
% linealmente independientes.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DECLARACION DE VARIABLES SIMBOLICAS
syms T1 T2 T3 real          %Pares
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
    
    gamma_aux=eval(gamma);
    if (i==7)
        gamma_square=vertcat(gamma_square,gamma_aux(1:2,:));
    else
        gamma_square=vertcat(gamma_square,gamma_aux);
    end
end

[R,jB]=rref(gamma_square); length(jB);

% AÑADIR LO DE LIMPAR NUMEROS

% A continuación, se dejará la matriz R bonita, y se hará que los ceros
% sean realmente ceros
% [ind_fil ind_col]=size(R);
% Raux=zeros(ind_fil,ind_col);
% for i=i:ind_fil
%     for j=1:ind_col
%         if (R(i,j) < 1e-9)
%             Raux(i,j)=0;
%         else
%             Raux(i,j)=R(i,j);
%         end
%     end
% end

% Reagrupando los terminos dinamicos
% Una vez se conocen las relaciones lineales, seria conveniente redefinir
% las ecuaciones gamma y tetha como la combinacion lineal de los parametros

vpa(R*tetha,5);

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
end
%% VERIFICACION
% DinamicaNE_RRR
% L0=0.6;L1=0.6;L2=1;L3=0.8; g=9.8;
% R1=50; R2=30; R3=15;
% 
% Y_init=simplify(eval([T1;T2;T3]));
% Y_fin=simplify(eval(gamma_li*tetha_li));
% 
% test=vpa(simplify(Y_init-Y_fin),5)
% Se verifica que POR COJONES esto está bien