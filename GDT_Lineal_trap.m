%% GENERADOR DE TRAYECTORIAS DEL ROBOT RRR Lineal
% En primera instancia se disenara un GDT lineal.

function [ref] = GDT_RRR(in)
% Variables de entrada en la funcion
x_init   = in(1);
y_init   = in(2);
z_init   = in(3);
x_fin    = in(4);
y_fin    = in(5);
z_fin    = in(6);
n_ptos   = in(7);
t_init   = in(8);
t_tray   = in(9);
t    = in(10);

 
%% Inicializacion de variables para testear la funcion
% Puntos iniciales y finales
xyz_init=CinematicaDirecta([0;pi/4;-pi/4]);
xyz_fin=CinematicaDirecta([pi/2;pi/3;-pi/3]);
% Puntos intermedios
n_ptos=4;
% Inicio trayectoria
t_init=2;
% Duracion trayectoria
t_tray=1;
% Tiempo de simulacion completa
t_sim=5;

%% Obtencion de la trayectoria en el espacio cartesiano
% pos_init=[x_init y_init z_init]';
% pos_fin=[x_fin y_fin z_fin]';
pos_init=[xyz_init]';
pos_fin=[xyz_fin]';

x_tray=linspace(pos_init(1),pos_fin(1),n_ptos+2) ; % El +2 es para no tener en cuenta en la interpolacion el pto inicial y final
y_tray=linspace(pos_init(2),pos_fin(2),n_ptos+2);
z_tray=linspace(pos_init(3),pos_fin(3),n_ptos+2);

%Una vez se han ontenido los puntos interpolados, se aplica el MCI a dichos
%puntos para pasarlo al espacio articular.
esp_articular=[];

T=t_tray/(n_ptos+1); %Calculo del paso entre muestras de la trayectoria

for i=1:length(x_tray)
    %est_articular=[punto, tiempo, q1, q2, q3]
    esp_articular=[esp_articular; i, (t_init+(i-1)*T),CinematicaInversa([x_tray(i) y_tray(i) z_tray(i)])'];
    
end

% Obtencion de las velocidades articulares intermedias
tiempo=esp_articular(:,2);
% q2=esp_articular(:,4);
% qd2=size(q2);
q1=esp_articular(:,3);
q2=esp_articular(:,4);
q3=esp_articular(:,5);
q_r=[q1  q2  q3];
qd=[];

%Preparamos interpolador Trapezoidal
 %Aceleracion maxima permitida

var1=q1(1)-q1(length(q1));
var2=q2(1)-q2(length(q2));
var3=q3(1)-q3(length(q3));
s1=sign(var1);
s2=sign(var2);
s3=sign(var3);

tau=t_tray/(n_ptos+1);

v1_crucero=s1*var1/(t_tray-tau);
v2_crucero=s2*var2/(t_tray-tau);
v3_crucero=s3*var3/(t_tray-tau);

a_max1=v1_crucero/tau;
a_max2=v2_crucero/tau;
a_max3=v3_crucero/tau;

a_max=max([a_max1, a_max2 , a_max3]);

% tau1=v_crucero1/a_max;
% tau2=v_crucero2/a_max;
% tau3=v_crucero3/a_max;



% for k=1:3
%     
%     qaux=q_r(:,k);
%     qdaux=zeros(size(qaux));
%     var_ant=zeros(size(qaux));
%     var_pos=zeros(size(qaux));
%     
%     %Calculo de las variaciones del signo a lo largo del movimiento
%     for i=1:length(qaux)
%         
%         if (i==1)
%             var_ant(i)=0;
%             var_pos(i)=qaux(i+1)-qaux(i);
%         elseif(i==length(qaux))
%             var_ant(i)=qaux(i)-qaux(i-1);
%             var_pos(i)=0;
%         else
%             var_ant(i)=qaux(i)-qaux(i-1);
%             var_pos(i)=qaux(i+1)-qaux(i);
%         end
%         
%     end
%     
%     %Asignacion de velocidades intermedias en funcion del signo de la
%     %variacion
%     for i=1:length(qaux)
%         sig_ant=sign(var_ant(i));
%         sig_pos=sign(var_pos(i));
%         
%         if(sig_pos==sig_ant)
%             qdaux(i)=(var_pos(i)+var_ant(i))/(2*T);
%         else
%             qdaux(i)=0;
%         end
%     end
%     qd=[qd qdaux];
% end

% poliq1=[];
% poliq2=[];
% poliq3=[];
%
% for k=1:(length(qd)-1)
%
%     %Articulacion 1
%     pol_spline_q1 = mat_spline*[q1(k) q1(k+1) qd(k,1) qd(k+1,1)]';
%     % Se define t_int como el tiempo en el que se inicia el subintervalo
%     poliq1=[poliq1;tiempo(k) pol_spline_q1'];
%
%     %Articulacion 2
%     pol_spline_q2 = mat_spline*[q2(k) q2(k+1) qd(k,2) qd(k+1,2)]';
%     % Se define t_int como el tiempo en el que se inicia el subintervalo
%     poliq2=[poliq2;tiempo(k) pol_spline_q2'];
%
%     %Articulacion 3
%     pol_spline_q3 = mat_spline*[q3(k) q3(k+1) qd(k,3) qd(k+1,3)]';
%     % Se define t_int como el tiempo en el que se inicia el subintervalo
%     poliq3=[poliq3;tiempo(k) pol_spline_q3'];
% end


%Seleccionamos los coeficientes del polinomio dependiento del momento
%temporal en el que nos enctontremos
% 
%  figure;
%   Tm=0.001;
%   for t=0:Tm:t_sim % La instruccion 'for' solo es valida para plotear el resultado, se debe eliminar al tener l entrada de reloj

if(t>=t_init && t<(t_init+tau)) %Arranque
    Aq1=s1*(a_max1/2)*(t-t_init)^2; Dq1=q1(1);
    Aq2=s2*(a_max2/2)*(t-t_init)^2; Dq2=q2(2);
    Aq3=s3*(a_max3/2)*(t-t_init)^2; Dq3=q3(3);
    
    Bq1=s1*a_max1*(t-t_init); Cq1=s1*a_max1;
    Bq2=s2*a_max2*(t-t_init); Cq2=s2*a_max2;
    Bq3=s3*a_max3*(t-t_init); Cq3=s3*a_max3;
    
elseif(t>=(t_init+tau) && t<(t_init+(t_tray-tau)))%Velocidad Lineal
    %     selec=length(poliq1);
    Aq1=-s1*(((v1_crucero)^2)/(2*a_max1))+(s1*v1_crucero*(t-t_init)); Dq1=q1(1);
    Aq2=-s2*(((v2_crucero)^2)/(2*a_max2))+(s2*v2_crucero*(t-t_init)); Dq2=q2(1);
    Aq3=-s3*(((v3_crucero)^2)/(2*a_max3))+(s3*v3_crucero*(t-t_init)); Dq3=q3(1);
    Bq1=s1*v1_crucero; Cq1=0;
    Bq2=s2*v2_crucero; Cq2=0;
    Bq3=s3*v3_crucero; Cq3=0;
    
    %     Aq1=poliq1(selec,2); Bq1=poliq1(selec,3); Cq1=poliq1(selec,4); Dq1=poliq1(selec,5);
    %     Aq2=poliq2(selec,2); Bq2=poliq2(selec,3); Cq2=poliq2(selec,4); Dq2=poliq2(selec,5);
    %     Aq3=poliq3(selec,2); Bq3=poliq3(selec,3); Cq3=poliq3(selec,4); Dq3=poliq3(selec,5);
    %     t_tramo=t-((t_init+t_tray)-poliq2(selec,1));
    
elseif (t>=(t_init+(t_tray-tau)) &&  t<(t_init+t_tray)) %Frenado
    Aq1=s1*(-((a_max1/2)*(t_tray)^2)+ a_max1*t_tray*(t-t_init) - (a_max1/2)*(t-t_init)^2); Dq1=q1(length(q1));
    Aq2=s2*(-((a_max2/2)*(t_tray)^2)+ a_max2*t_tray*(t-t_init) - (a_max2/2)*(t-t_init)^2); Dq2=q2(length(q2));
    Aq3=s3*(-((a_max3/2)*(t_tray)^2)+ a_max3*t_tray*(t-t_init) - (a_max3/2)*(t-t_init)^2); Dq3=q3(length(q3));
    Bq1=s1*a_max1*(t_tray-(t-t_init)); Cq1=-s1*a_max1;
    Bq2=s2*a_max2*(t_tray-(t-t_init)); Cq2=-s2*a_max2;
    Bq3=s1*a_max3*(t_tray-(t-t_init)); Cq3=-s3*a_max3;
    %     t_tramo=t; %Esto hara que el polinomio al evaluarlo de 0
    %
elseif (t>=(t_init+t_tray))
    Aq1=0; Dq1= q1(length(q1));
    Aq2=0; Dq2= q2(length(q2));
    Aq3=0; Dq3= q3(length(q3));
    
    Bq1=0; Cq1=0;
    Bq2=0; Cq2=0;
    Bq3=0; Cq3=0;
    
else 
    Aq1=0; Dq1= q1(1);
    Aq2=0; Dq2= q2(1);
    Aq3=0; Dq3= q3(1);
    
    Bq1=0; Cq1=0;
    Bq2=0; Cq2=0;
    Bq3=0; Cq3=0;
end

% Obtencion de los polinomios en cada intervalo de la trayectoria y para
% todas las variables articulares.
% Calculo de Posiciones
q1_r = Aq1 + Dq1;
q2_r = Aq2 + Dq2;
q3_r = Aq3 + Dq3;

% Calculo de Velocidades
qd1_r = Bq1;
qd2_r = Bq2;
qd3_r = Bq3;

% Calculo de Aceleraciones
qdd1_r = Cq1;
qdd2_r = Cq2;
qdd3_r = Cq3;

% %//Testeo//%
%     hold on;
%
% %     Ploteo Posiciones
%     plot(t,q1_r,'*');grid
%     plot(t,q2_r,'*');grid
%     plot(t,q3_r,'*');grid

% %      Ploteo Velocidades
%     plot(t,qd1_r,'*');grid
%     plot(t,qd2_r,'*');grid
%     plot(t,qd3_r,'*');grid

     %Ploteo Aceleraciones
%     plot(t,qdd1_r,'*');grid
%     plot(t,qdd2_r,'*');grid
%     plot(t,qdd3_r,'*');grid
% % %
%  end % [Fin bucle para Testeo]

% Se devuelve la posicion, velocidad y aceleracion de referencia
q_r  =[q1_r   ;q2_r   ;q3_r];
qd_r =[qd1_r  ;qd2_r  ;qd3_r];
qdd_r=[qdd1_r ;qdd2_r ;qdd3_r];
ref=[q_r; qd_r; qdd_r];


