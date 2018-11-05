% En primer lugar se debe correr y configurar el script DinamicaNE.m para
% obtener los valores de T1,T2 y T3 en simbolico.
%% DECLARACION DE VARIABLES SIMBOLICAS
% No se declaran porque, debido a que es necesario correr el bloque de
% DinamicaNE_RRR.m, ahi ya se han definido las variables simbolicas.




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ACUERDATE DE QUE ESTO ESTA EN FUNCION DE PARES Y DEBE ESTAR EN FUNCION DE
% INTENSIDADES LOCOOOOOOO
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








DinamicaNE_RRR
% Valores de los partes en las articulaciones(Tau=Kt*R*Im)
T1=simplify(Ma(1,1)*qdd1+Ma(1,2)*qdd2+Ma(1,3)*qdd3+Va(1,1)+Ga(1,1));
T2=simplify(Ma(2,1)*qdd1+Ma(2,2)*qdd2+Ma(2,3)*qdd3+Va(2,1)+Ga(2,1));
T3=simplify(Ma(3,1)*qdd1+Ma(3,2)*qdd2+Ma(3,3)*qdd3+Va(3,1)+Ga(3,1));
% Y=Ma*qdd + Va + Ga;
Y=[T1 T2 T3]'

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tetha_sim sera la matriz de incognitas
tetha_sim=[I11xx I11yy I11zz Jm1 Bm1 ...
           I22xx I22yy I22zz Jm2 Bm2  ...
           I33xx I33yy I33zz Jm3 Bm3 ...
           m1*(s11z^2) m1*s11z m1 m2*(s22x^2) m2*s22x m2 m3*(s33x^2) m3*s33x m3]';
% Se creara esta matriz auxiliar para trabajar con los momentos de inercia       
Mi=[m1 s11z;
    m2 s22x;
    m3 s33x];


% Se rellenara gamma_sim a piñon, posteriormente seria necesario una
% optimizacion y una eleganciacion
gamma_sim = sym('gamma_sim',[length(Y) length(tetha_sim)]);  % Se crea la matriz simbolica objetivo

% Rellenamos la matriz (se rellenara por columnas)
ind2=1;  % Variable para recorrer Mi con los momentos de orden 2
ind1=1;  % Variable para recorrer Mi con los momentos de orden 1
for i=1:length(Y)   % Este bucle recorre las articulaciones
    
    for j=1:length(tetha_sim)   % Este bucle recorre todos los parametros
        
        % Primeros 15 terminos, los cuales seran los "simples" y los
        % momentos inercia de orden 0
        if (j<=15 || j==18 || j==21 || j==24)
            gamma_sim(i,j)=diff(Y(i),tetha_sim(j));
        % Terminos asociados a los momentos de inercia de orden 2
        elseif (j==16 || j==19 || j==22)
            gamma_sim(i,j) =diff(diff( diff(Y(i),Mi(ind2,2)) ,Mi(ind2,2)) ,Mi(ind2,1))/2;
            ind2=ind2+1;
        % Terminos asociados a los momentos de inercia de orden 1
        elseif (j==17 || j==20 || j==23)
            gamma_sim(i,j)=diff( diff(Y(i),Mi(ind1,2)) ,Mi(ind1,1) );
            ind1=ind1+1;
        end
        % Se actualizan los valores de Y
        Y(i)=simplify( Y(i)-(gamma_sim(i,j)*tetha_sim(j)) );   
    end
    ind2=1;ind1=1;  % Se reinicializan los indices
end

gamma_sim=simplify(gamma_sim);
Y;

%% COMPROBACION
Y=[T1 T2 T3]';
simplify(Y-(gamma_sim*tetha_sim))


