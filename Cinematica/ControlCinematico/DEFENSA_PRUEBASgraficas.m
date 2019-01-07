%% RESULTADO DEL GENERADOR DE TRAYECTORIA DE LA PEDIDA
% Trayectoria solicitada para la defensa
%      POS INIT ->  q1=0;    q2=pi/4; q3=-pi/4
%      POS FINAL -> q1=pi/2; q2=pi/3; q3=-pi/3
% Duracion mov -> 1s
% Tiempo inicio movimiento -> 2s
% Duracion simulacion -> 5s
% Numero ptos intermedios -> 4

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

% Se lanza la simulacion
sim('sl_GDT_RRR');

% figure(4);
%  subplot(331);plot(t,qr1(:,1));grid; subplot(332);plot(t,qr1(:,2));grid; subplot(333);plot(t,qr1(:,3));grid;
%  subplot(334);plot(t,qdr1(:,1));grid; subplot(335);plot(t,qdr1(:,2));grid; subplot(336);plot(t,qdr1(:,3));grid;
%  subplot(337);plot(t,qddr1(:,1));grid; subplot(338);plot(t,qddr1(:,2));grid; subplot(339);plot(t,qddr1(:,3));grid;
% figure();
% plot3(xr,yr,zr);grid;

 % Error entre ambas graficas
%  
%  figure();
%  subplot(331);plot(t,qr(:,1)- qr1(:,1));grid; subplot(332);plot(t,qr(:,2)-qr1(:,2));grid; subplot(333);plot(t,qr(:,3)-qr1(:,3));grid;
%  subplot(334);plot(t,qdr(:,1)-qdr1(:,1));grid; subplot(335);plot(t,qdr(:,2)-qdr1(:,2));grid; subplot(336);plot(t,qdr(:,3)-qdr1(:,3));grid;
%  subplot(337);plot(t,qddr(:,1)-qddr1(:,1));grid; subplot(338);plot(t,qddr(:,2)-qddr1(:,2));grid; subplot(339);plot(t,qddr(:,3)-qddr1(:,3));grid;
figure(1);

plot3(xr,yr,zr); title(['Nº puntos intermedios = ',int2str(n_ptos)]);xlabel('Posicion X');  ylabel('Posicion Y'); zlabel('Posicion Z'); grid;

%Grafica DEFENSA
figure(2);

for i=1:9
    
    if(i<4) 
        { subplot(3,3,i); plot(t,qr(:,i)); xlabel('Tiempo [s]');  title([' Articulacion \theta_{',num2str(i),'}']);ylabel('Pos[rad]');};grid;
        
    elseif(i<7)
        { subplot(3,3,i);  plot(t,qdr(:,i-3)); xlabel('Tiempo [s]');ylabel('Vel[rad/s]');};grid;
        
    elseif(i<10)
        { subplot(3,3,i) ; plot(t,qddr(:,i-6)); xlabel('Tiempo [s]');  ylabel('Acel[rad/s^{2}]'); };grid;
        
    end
    
end




