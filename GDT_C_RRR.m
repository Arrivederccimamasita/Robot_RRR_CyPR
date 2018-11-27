%% GENERADOR DE TRAYECTORIAS DEL ROBOT RRR Lineal
% Diseño de un GDT Circular.

function [ref] = GDT_C_RRR(in)
% Variables de entrada en la funcion
x_init   = in(1);
y_init   = in(2);
z_init   = in(3);
x_med    = in(4);
y_med    = in(5);
z_med    = in(6);
x_fin    = in(7);
y_fin    = in(8);
z_fin    = in(9);
n_ptos   = in(10);
t_init   = in(11);
t_tray   = in(12);
t    = in(13);

%%Inicializacion de variables para testear la funcion
% x_init=0.7071; y_init=0.7071; z_init=0.4;
% x_med=1.8; y_med=0; z_med=1.2;
% x_fin =0.7071; y_fin=-0.7071; z_fin=2;
% n_ptos=100; t_init=0; t_tray=5;

%%Obtencion de la trayectoria  circular en el espacio cartesiano
P1=[x_init y_init z_init]';
P2=[x_med y_med z_med]';
P3=[x_fin y_fin z_fin]';

v1 = cross(P2-P1,P3-P1);
v1 = v1/norm(v1); %Vector unitario ortogonal al plano definido por los 3 puntos

%Sistema de ecuaciones para hallar el centro de la circuenferencia
% dot(P0-P1,v1) = 0
% dot(P0-(p2+P1)/2,P2-P1) = 0
% dot(P0-(p3+P1)/2,P3-P1) = 0
A=[v1(1) v1(2) v1(3);
   P2(1)-P1(1) P2(2)-P1(2) P2(3)-P1(3);
   P3(1)-P1(1) P3(2)-P1(2) P3(3)-P1(3)];
B=[P1(1)*v1(1)+P1(2)*v1(2)+P1(3)*v1(3);
   ((P2(1)+P1(1))*(P2(1)-P1(1)))/2+((P2(2)+P1(2))*(P2(2)-P1(2)))/2+((P2(3)+P1(3))*(P2(3)-P1(3)))/2;
   ((P3(1)+P1(1))*(P3(1)-P1(1)))/2+((P3(2)+P1(2))*(P3(2)-P1(2)))/2+((P3(3)+P1(3))*(P3(3)-P1(3)))/2];

P0=A\B;

v2 = P1-P0;
R = norm(v2);
v2 = v2/R;
v3 = cross(v2,v1);
v3 = -v3/norm(v3);

g=(P3-P0)/norm(P3-P0);
cos_g=dot(v2,g)/(norm(v2)*norm(g));
sin_g=norm(cross(v2,g))/(norm(v2)*norm(g));
rho_fin=2*pi-atan2(sin_g,cos_g);

rho = linspace(0,rho_fin,n_ptos);
%Conjunto de puntos equidistantes del arco de circunferencia
P = repmat(P0,1,numel(rho)) + R*(v2*cos(rho) + v3*sin(rho));   

x_tray=P(1,:);
y_tray=P(2,:);
z_tray=P(3,:);


% % Grafica de la trayectoria deseada en XYZ
% 
% figure();plot3(x_tray,y_tray,z_tray,'b');hold on;
% plot3(P0(1),P0(2),P0(3),'*b');
% plot3(x_init,y_init,z_init,'*r');
% plot3(x_med,y_med,z_med,'*r');
% plot3(x_fin,y_fin,z_fin,'*r');grid;

%%Una vez se han ontenido los puntos interpolados, se aplica el MCI a dichos
%puntos para pasarlo al espacio articular.
esp_articular=[];

T=t_tray/(n_ptos-2); %Calculo del paso entre muestras de la trayectoria

for i=1:length(x_tray)
    %est_articular=[punto, tiempo, q1, q2, q3]
    esp_articular=[esp_articular; i, (t_init+(i-1)*T),CinematicaInversa([x_tray(i) y_tray(i) z_tray(i)])'];
    
end
esp_articular;

% Obtencion de las velocidades articulares intermedias
tiempo=esp_articular(:,2);
% q2=esp_articular(:,4);
% qd2=size(q2);
q1=esp_articular(:,3);
q2=esp_articular(:,4);
q3=esp_articular(:,5);
q_r=[q1  q2  q3];
qd=[];


for k=1:3
 
    qaux=q_r(:,k);
    qdaux=zeros(size(qaux));
    var_ant=zeros(size(qaux));
    var_pos=zeros(size(qaux));
    
    %Calculo de las variaciones del signo a lo largo del movimiento
    for i=1:length(qaux)
        
        if (i==1)
            var_ant(i)=0;
            var_pos(i)=qaux(i+1)-qaux(i);
        elseif(i==length(qaux))
            var_ant(i)=qaux(i)-qaux(i-1);
            var_pos(i)=0;
        else
            var_ant(i)=qaux(i)-qaux(i-1);
            var_pos(i)=qaux(i+1)-qaux(i);
        end
        
    end
    
    %Asignacion de velocidades intermedias en funcion del signo de la
    %variacion
    for i=1:length(qaux)
        sig_ant=sign(var_ant(i));
        sig_pos=sign(var_pos(i));
        
        if(sig_pos==sig_ant)
            qdaux(i)=(var_pos(i)+var_ant(i))/(2*T);
        else
            qdaux(i)=0;
        end
    end
    qd=[qd qdaux];
end


% Una vez obtenidos los vectores de posiciones y velocidades
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se define de manera independiente porque T sera cte.
mat_spline=[ 0       0  0 1  ;
            T^3     T^2 T 1  ;
             0       0  1 0  ;
            3*(T^2) 2*T 1 0 ];
mat_spline=inv(mat_spline);
% Si se multiplica esta matriz por [qi_init qi_fin qdi_init qdi_fin] se
% obtendran los coeficientes del polinomio cubico de interpolacion

poliq1=[];
poliq2=[];
poliq3=[];

for k=1:(length(qd)-1)
    
    %Articulacion 1
    pol_spline_q1 = mat_spline*[q1(k) q1(k+1) qd(k,1) qd(k+1,1)]';
    % Se define t_int como el tiempo en el que se inicia el subintervalo
    poliq1=[poliq1;tiempo(k) pol_spline_q1'];
    
    %Articulacion 2
    pol_spline_q2 = mat_spline*[q2(k) q2(k+1) qd(k,2) qd(k+1,2)]';
    % Se define t_int como el tiempo en el que se inicia el subintervalo
    poliq2=[poliq2;tiempo(k) pol_spline_q2'];
    
    %Articulacion 3
    pol_spline_q3 = mat_spline*[q3(k) q3(k+1) qd(k,3) qd(k+1,3)]';
    % Se define t_int como el tiempo en el que se inicia el subintervalo
    poliq3=[poliq3;tiempo(k) pol_spline_q3'];    
end

%Seleccionamos los coeficientes del polinomio dependiento del momento
%temporal en el que nos enctontremos

%  figure;
  Tm=0.001;
for t=0:Tm:(t_init+t_tray) % La instruccion 'for' solo es valida para plotear el resultado, se debe eliminar al tener l entrada de reloj

if((t>=t_init) && (t<(t_init+t_tray+T)))
    offset=(floor(t_init/T)-1);
    selec=(floor(t/T)-offset);    
    Aq1=poliq1(selec,2); Bq1=poliq1(selec,3); Cq1=poliq1(selec,4); Dq1=poliq1(selec,5);
    Aq2=poliq2(selec,2); Bq2=poliq2(selec,3); Cq2=poliq2(selec,4); Dq2=poliq2(selec,5);
    Aq3=poliq3(selec,2); Bq3=poliq3(selec,3); Cq3=poliq3(selec,4); Dq3=poliq3(selec,5);
    t_tramo=poliq2(selec,1);
    
elseif(t>=(t_init+t_tray+T))
    selec=length(poliq1);
    Aq1=poliq1(selec,2); Bq1=poliq1(selec,3); Cq1=poliq1(selec,4); Dq1=poliq1(selec,5);
    Aq2=poliq2(selec,2); Bq2=poliq2(selec,3); Cq2=poliq2(selec,4); Dq2=poliq2(selec,5);
    Aq3=poliq3(selec,2); Bq3=poliq3(selec,3); Cq3=poliq3(selec,4); Dq3=poliq3(selec,5);
    t_tramo=t-((t_init+t_tray)-poliq2(selec,1));
    
elseif (t<(t_init+t_tray))
    Aq1=poliq1(1,2); Bq1=poliq1(1,3); Cq1=poliq1(1,4); Dq1=poliq1(1,5);
    Aq2=poliq2(1,2); Bq2=poliq2(1,3); Cq2=poliq2(1,4); Dq2=poliq2(1,5);
    Aq3=poliq3(1,2); Bq3=poliq3(1,3); Cq3=poliq3(1,4); Dq3=poliq3(1,5);
    t_tramo=t; %Esto hará que el polinomio al evaluarlo de 0
        
 end


% Obtencion de los polinomios en cada intervalo de la trayectoria y para
% todas las variables articulares.
% Calculo de Posiciones
q1_r = Aq1*( t-t_tramo ).^3 + Bq1*(t-t_tramo).^2 + Cq1*( t-t_tramo) + Dq1;
q2_r = Aq2*( t-t_tramo ).^3 + Bq2*(t-t_tramo).^2 + Cq2*( t-t_tramo) + Dq2;
q3_r = Aq3*( t-t_tramo ).^3 + Bq3*(t-t_tramo).^2 + Cq3*( t-t_tramo) + Dq3;

% Calculo de Velocidades
qd1_r = 3*Aq1*( t-t_tramo ).^2 + 2*Bq1*(t-t_tramo) + Cq1;
qd2_r = 3*Aq2*( t-t_tramo ).^2 + 2*Bq2*(t-t_tramo) + Cq2;
qd3_r = 3*Aq3*( t-t_tramo ).^2 + 2*Bq3*(t-t_tramo) + Cq3;

% Calculo de Aceleraciones
qdd1_r = 6*Aq1*( t-t_tramo ) + 2*Bq1;
qdd2_r = 6*Aq2*( t-t_tramo ) + 2*Bq2;
qdd3_r = 6*Aq3*( t-t_tramo ) + 2*Bq3;
% if (t>t_init+t_tray-0.1)
% t
% pause()
% end
% %//Testeo//%
    hold on; 
    
% %     Ploteo Posiciones 
%     plot(t,q1_r,'*');grid
%     plot(t,q2_r,'*');grid
%     plot(t,q3_r,'*');grid
%     
% %      Ploteo Velocidades
%     plot(t,qd1_r,'*');grid
%     plot(t,qd2_r,'*');grid
%     plot(t,qd3_r,'*');grid
    
%      %Ploteo Aceleraciones
%     plot(t,qdd1_r,'*');grid
%     plot(t,qdd2_r,'*');grid
%     plot(t,qdd3_r,'*');grid
    
 end % [Fin bucle para Testeo]

%%Se devuelve la posicion, velocidad y aceleracion de referencia
q_r  =[q1_r   ;q2_r   ;q3_r];
qd_r =[qd1_r  ;qd2_r  ;qd3_r];
qdd_r=[qdd1_r ;qdd2_r ;qdd3_r];
ref=[q_r; qd_r; qdd_r];

