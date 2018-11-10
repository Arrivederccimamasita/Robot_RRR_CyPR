%% Obtencion de Parametros Inerciales %%
%El siguiente Script tratar� de reestructurar los parametros inerciales
%del modelo dinamico del robot de cara a poder realizar estimaciones de los
%parameros inerciales que deberan aglutinarse en parametros identificables,
%y parcialmetne identificable.


%DECLARACIÓN DE VARIABLES SIMBOLICAS
syms T1 T2 T3 real          %Par o fuerza efectivo ejercidos sobre la
                            %barra i en torno a su centro de masas.
                            %(par motor menos pares de rozamiento o perturbación)
syms q1 qd1 qdd1 real       %Posicion, velocidad y aceleracion de q1
syms q2 qd2 qdd2 real       %Posicion, velocidad y aceleracion de q2
syms q3 qd3 qdd3 real       %Posicion, velocidad y aceleracion de q3
syms g real                 %Gravedad

syms L0 L1 L2 L3 real       % Datos cinematicos del brazo
% Estimacion de los parametros dinamicos robot
syms m0 m1 m2 m3 real       % Masas en simbolico
syms  s11z s22x s33x real  % Distancia al cdm
syms I11xx I11yy I11zz I22xx I22yy I22zz I33xx I33yy I33zz real     % Tensor de inercias
% Estimacion de los parametros de los motores
syms Jm1 Jm2 Jm3 Bm1 Bm2 Bm3 R1 R2 R3 real

pi1 = sym('pi');


%%Matrices del modelo Dinamico de nuestro robot%%
%T= [M(q)+R^2*Jm]qdd+V(q,qd)+(R^2*Bm)*qd+G(q)
% Ma=M+R*R*Jm
% Va=V+R*R*Bm*[qd1; qd2; qd3]
% Ga=G

[m,n,Ma] =  xlsread('MatricesDinamicas.xls','Hoja1','A1:C3');
Ma=cell2sym(Ma);

[m,n,Va] =  xlsread('MatricesDinamicas.xls','Hoja2','A1:A3');
Va=cell2sym(Va);

[m,n,Ga] =  xlsread('MatricesDinamicas.xls','Hoja3','A1:A3');
Ga=cell2sym(Ga);



%% Reconstruccion del modelo en funcion de parametros indeterminados

% REORDENARLO
qdd = [qdd1; qdd2; qdd3];
E = simplify((Ma)*qdd+Va+Ga);
E= vpa( E,5); %Modelo Dinamico

%m1 s11z*m1 s11z^2*m1 I11xx I11zz I11yy Jm1 Bm1 
%m2 s22x*m2 s33x^2*m2 I22xx I22zz I22yy Jm2 Bm2
%m3 s33x*m3 s11z^2*m3 I33xx I33zz I33yy Jm3 Bm3

base = [m1 m2 m3 m1*s11z m2*s22x m3*s33x m1*s11z^2 m2*s22x^2 m3*s33x^2 Jm1 Jm2 Jm3 Bm1 Bm2 Bm3 I11xx I22xx I33xx I11yy I22yy I33yy I11zz I22zz I33zz]';


for i=1:3
% I11xx
I11xx1 = diff(E(i), I11xx);
Eaux = simplify(E(i) - I11xx1*I11xx);
% I22xx
I22xx2 = diff(Eaux, I22xx);
Eaux = simplify(Eaux - I22xx2*I22xx);
% I33xx
I33xx3 = diff(Eaux, I33xx);
Eaux = simplify(Eaux - I33xx3*I33xx);


% I11yy
I11yy1 = diff(Eaux, I11yy);
Eaux = simplify(Eaux - I11yy1*I11yy);
% I11yy
I22yy2 = diff(Eaux, I22yy);
Eaux = simplify(Eaux - I22yy2*I22yy);
% I11yy
I33yy3 = diff(Eaux, I33yy);
Eaux = simplify(Eaux - I33yy3*I33yy);


% I11zz
I11zz1 = diff(Eaux, I11zz);
Eaux = simplify(Eaux - I11zz1*I11zz);
% I11zz
I22zz2 = diff(Eaux, I22zz);
Eaux = simplify(Eaux - I22zz2*I22zz);
% I11zz
I33zz3 = diff(Eaux, I33zz);
Eaux = simplify(Eaux - I33zz3*I33zz);


% Jm1
Jm11 = diff(Eaux, Jm1);
Eaux = simplify(Eaux - Jm11*Jm1);
% Jm2
Jm22 = diff(Eaux, Jm2);
Eaux = simplify(Eaux - Jm22*Jm2);
% Jm3
Jm33 = diff(Eaux, Jm3);
Eaux = simplify(Eaux - Jm33*Jm3);


% Bm1
Bm11 = diff(Eaux, Bm1);
Eaux = simplify(Eaux - Bm11*Bm1);
% Bm2
Bm22 = diff(Eaux, Bm2);
Eaux = simplify(Eaux - Bm22*Bm2);
% Bm3
Bm33 = diff(Eaux, Bm3);
Eaux = simplify(Eaux - Bm33*Bm3);

Eaux = vpa(Eaux);

% s11z^2*m1 (_2 por estar al cuadrado)
s11zm1_2 = diff((diff(diff(Eaux, s11z), s11z)/2),m1);
Eaux = simplify(Eaux - s11zm1_2*m1*s11z^2);
% s22x^2*m2
s22xm2_2 = diff((diff(diff(Eaux, s22x), s22x)/2),m2);
Eaux = simplify(Eaux - s22xm2_2*m2*s22x^2);
% %s33x^2*m3
s33xm3_2 = diff((diff(diff(Eaux, s33x), s33x)/2),m3);
Eaux = simplify(Eaux - s33xm3_2*m3*s33x^2);


% s11z*m1
s11zm1_1 = diff((diff(Eaux, s11z)), m1);
Eaux = simplify(Eaux - s11zm1_1*m1*s11z);
% s22x*m2
s22xm2_1 = diff((diff(Eaux, s22x)), m2);
Eaux = simplify(Eaux - s22xm2_1*m2*s22x);
% %s33x*m3
s33xm3_1 = diff((diff(Eaux, s33x)), m3);
Eaux = simplify(Eaux - s33xm3_1*m3*s33x);


% m1
m11 = diff(Eaux, m1);
Eaux = simplify(Eaux - m11*m1);
% m2
m22 = diff(Eaux, m2);
Eaux = simplify(Eaux - m22*m2);
% m3
m33 = diff(Eaux, m3);
Eaux = simplify(Eaux - m33*m3);



E(i) = m11*m1 + m22*m2 + m33*m3 + s11zm1_1*m1*s11z + s22xm2_1*m2*s22x + s33xm3_1*m3*s33x + s11zm1_2*m1*s11z^2 + s22xm2_2*m2*s22x^2 + s33xm3_2*m3*s33x^2 + Jm11*Jm1 + Jm22*Jm2 + Jm33*Jm3 + Bm11*Bm1 + Bm22*Bm2 + Bm33*Bm3 + I11xx1*I11xx + I22xx2*I22xx + I33xx3*I33xx + I11yy1*I11yy + I22yy2*I22yy + I33yy3*I33yy + I11zz1*I11zz + I22zz2*I22zz + I33zz3*I33zz;
coef = [m11 m22 m33 s11zm1_1 s22xm2_1 s33xm3_1 s11zm1_2 s22xm2_2 s33xm3_2 Jm11 Jm22 Jm33 Bm11 Bm22 Bm33 I11xx1 I22xx2 I33xx3 I11yy1 I22yy2 I33yy3 I11zz1 I22zz2 I33zz3];
vect = [m1 m2 m3 m1*s11z m2*s22x m3*s33x m1*s11z^2 m2*s22x^2 m3*s33x^2 Jm1 Jm2 Jm3 Bm1 Bm2 Bm3 I11xx I22xx I33xx I11yy I22yy I33yy I11zz I22zz I33zz]';

for k=1:24
    matriz(i,k)=coef(k);
end
end

matriz_r=vpa(matriz,5);

save ('matriz_r.mat','matriz_r','matriz','vect')


%% Comprobacion
%La estructura reultante no es mas que una reordenacion del
%modelo dinamico, por lo que al restar ambas estructuras debe salir un
%resultado igual a 0

Mod_Parametros=matriz_r*base;
Comprobacion=E-Mod_Parametros;
simplify(Comprobacion) %Debe devolver un 0 en caso de que haya funcionado nuestra reestructuracion