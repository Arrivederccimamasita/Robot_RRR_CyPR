%% GENERADOR DE TRAYECTORIAS DEL ROBOT RRR
% En primera instancia se disenara un GDT lineal

function [q_r qd_r qdd_r] = GDT_RRR(in)
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
% t_sim    = in(10);

%% Inicializacion de variables para testear la funcion
x_init=3.5; y_init=0; z_init=4;
x_fin =2.5; y_fin=0 ; z_fin=5;
n_ptos=5; t_tray=1; t_init=0.5;
 t=[0:2/6:2];

%% Obtencion de la trayectoria en el espacio cartesiano
pos_init=[x_init y_init z_init];
pos_fin=[x_fin y_fin z_fin];

x_tray=linspace(x_init,x_fin,n_ptos+2)  % El +2 es para no tener en cuenta en la interpolacion el pto inicial y final
y_tray=linspace(y_init,y_fin,n_ptos+2)
z_tray=linspace(z_init,z_fin,n_ptos+2)

% Grafica de la trayectoria deseada en XYZ
figure();plot3(x_tray,y_tray,z_tray,'b',x_tray,y_tray,z_tray,'*r');...
    legend('Recta interpolada obtenida','Puntos interpolados');grid;

%Una vez se han ontenido los puntos interpolados, se aplica el MCI a dichos
%puntos para pasarlo al espacio articular.
esp_articular=[];

T=t_tray/(n_ptos+1); %Calculo del paso entre muestras de la trayectoria

for i=1:length(x_tray)
    %est_articular=[punto, tiempo, q1, q2, q3]
    esp_articular=[esp_articular; i, (t_init+(i-1)*T),CinematicaInversa([x_tray(i) y_tray(i) z_tray(i)])'];
    
end
esp_articular

% Obtencion de las velocidades articulares intermedias
tiempo=esp_articular(:,2);  % Se guardara el tiempo de inicio de cada intervalo
q2=esp_articular(:,4);
qd2=size(q2);
var_ant=zeros(size(q2));
var_pos=zeros(size(q2));

for i=1:size(q2)
    %Calculo de las variaciones del signo a lo largo del movimiento
    if (i==1)
        var_ant(i)=0;
        var_pos(i)=q2(i+1)-q2(i);
    elseif(i==length(q2))
        var_ant(i)=q2(i)-q2(i-1);
        var_pos(i)=0;
    else
        var_ant(i)=q2(i)-q2(i-1);
        var_pos(i)=q2(i+1)-q2(i);
    end
      
end

% Calculo de velocidades intermedias (Empleando el met. Heuristico) 
for i=1:size(q2)
   sig_ant=sign(var_ant(i));
   sig_pos=sign(var_pos(i));
   
   if(sig_pos==sig_ant)   
    qd2(i)=(var_pos(i)+var_ant(i))/(2*T);
   else
       qd2(i)=0;
   end
end
qd2=qd2'

% Una vez obtenidos los vectores de posiciones y articulaciones
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se define de manera independiente porque T sera cte.
mat_spline=[ 0     0  0 1  ;
            T^3   T^2 T 1  ;
             0     0  1 0  ;
          3*(T^2) 2*T 1 0 ];
mat_spline=inv(mat_spline);
% Si se multiplica esta matriz por [qi_init qi_fin qdi_init qdi_fin] se
% obtendran los coeficientes del polinomio cubico de interpolacion


polinomio=[];

for k=1:(length(q2)-1)

    pol_spline = mat_spline*[q2(k) q2(k+1) qd2(k) qd2(k+1)]';
    % Se define t_int como el tiempo en el que se inicia el subintervalo
    polinomio=[polinomio;tiempo(k) pol_spline'];
    
% Obtencion de la trayectoria en el tramo
  
end
f=splines_trozos(t,q2,t_init,polinomio(:,1),polinomio(:,2),polinomio(:,3),polinomio(:,4),polinomio(:,5),T)

figure();plot(t,f(t));grid

% % Implementacion de una funcion cubica u otra
% figure;
% for t=0:0.01:1
%     if (t>=0 && t<t_tray)
%         selec=(floor(t/T)+1);
%         A=polinomio(selec,2);
%         B=polinomio(selec,3);
%         C=polinomio(selec,4);
%         D=polinomio(selec,5);
%         t_tramo=polinomio(selec,1);
%         
%     end
%         
%     qr_tramo= A*( t-t_tramo ).^3 + B*(t-t_tramo).^2 + C*( t-t_tramo) + D;
%     
%     hold on
%     plot(t,qr_tramo,'*');grid
%     
% end
% 
% hold off
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se devuelve la posicion, velocidad y aceleracion de referencia
% q_r=[q1_r   q2_r   q3_r];
% qd_r=[qd1_r  qd2_r  qd3_r];
% qdd_r=[qdd1_r q2dd_r qdd3_r];


return