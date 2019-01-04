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

% Se grafican resultados
figure();
subplot(331);plot(t,qr(:,1));grid; subplot(332);plot(t,qr(:,2));grid; subplot(333);plot(t,qr(:,3));grid;
subplot(334);plot(t,qdr(:,1));grid; subplot(335);plot(t,qdr(:,2));grid; subplot(336);plot(t,qdr(:,3));grid;
subplot(337);plot(t,qddr(:,1));grid; subplot(338);plot(t,qddr(:,2));grid; subplot(339);plot(t,qddr(:,3));grid;

% Se lanza la simulacion
sim('sl_GDT_PROFESOR');

figure();
subplot(331);plot(t,qr1(:,1));grid; subplot(332);plot(t,qr1(:,2));grid; subplot(333);plot(t,qr1(:,3));grid;
subplot(334);plot(t,qdr1(:,1));grid; subplot(335);plot(t,qdr1(:,2));grid; subplot(336);plot(t,qdr1(:,3));grid;
subplot(337);plot(t,qddr1(:,1));grid; subplot(338);plot(t,qddr1(:,2));grid; subplot(339);plot(t,qddr1(:,3));grid;
%figure();
%plot3(xr,yr,zr);grid;