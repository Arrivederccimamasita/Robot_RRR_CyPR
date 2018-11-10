%%%%%%%% Robot real solo encoder con Reductoras %%%%%%%%

%Simulacion del Robot con los datos de entrada del experimento
clear all
Tm=0.001; %Tiempo de muestreo
R1=50; R2=30; R3=15;    % Reductoras
DatosSimSenoides_Exp;
sim('sl_RobotReal_RRR');

% Representacion del movimiento 3D
figure()
plot3(xyz_Gil(:,1),xyz_Gil(:,2),xyz_Gil(:,3)); title('Movimiento 3D Robot'); grid;

S=qr_D; %Representacion de Posiciones
% S=Im_D; %Representacion de Intensidades
S1=S(:,1);
S2=S(:,2);
S3=S(:,3);

% Graficas de las posiciones
figure();
subplot(3,1,1);plot(t_D,S1);title('Posiciones de las articulaciones');xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;...
    subplot(3,1,2);plot(t_D,S2);xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;...
    subplot(3,1,3);plot(t_D,S3);xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;



% qr_D --> Es la unica medida que tenemos para aproximar los paraemtros
% dinamicos; será necesaria su derivación y filtrado para tratar las
% medidas pertinentes

%% Analisis Frecuencial
%Asignacion de señales a estudiar
% S=qr_D;
% S1=S(:,1);
% S2=S(:,2);
% S3=S(:,3);
% %Valores de representacion Frecuencial
% rango_frec = 0.001*pi;  % Rango de representación de 5*pi.
% w = rango_frec*(-1:1/1200:1-1/1200)/2; % Rango de frecuencias a representar.


S1=Im_D(:,1);
S2=Im_D(:,2);
S3=Im_D(:,3);

%Valores de representacion
rango_frec = pi;  % Rango de representación de 5*pi.
w = rango_frec*(-1:1/1200:1-1/1200)/2; % Rango de frecuencias a representar.

%% Representacion

%Asignacion de la respuesta frecuencial dado el rango de frecuencias.
Signal_1 = freqz(S1, 1, w);
Signal_2 = freqz(S2, 1, w);
Signal_3 = freqz(S3, 1, w);

figure
subplot(2,3,1)
plot(w/pi,abs(Signal_1));grid
title('Magnitud de la DTFT de la Señal 1')
xlabel('\omega /\pi');
ylabel('Amplitud');

subplot(2,3,2)
plot(w/pi,abs(Signal_2));grid
title('Magnitud de la DTFT de la Señal 2')
xlabel('\omega /\pi');
ylabel('Amplitud');

subplot(2,3,3)
plot(w/pi,abs(Signal_3));grid
title('Magnitud de la DTFT de la Señal 3')
xlabel('\omega /\pi');
ylabel('Amplitud');

subplot(2,3,4)
plot(w/pi,angle(Signal_1));grid
title('Fase de la DTFT de la Señal 1')
xlabel('\omega /\pi');
ylabel('Radianes');

subplot(2,3,5)
plot(w/pi,angle(Signal_2));grid
title('Fase de la DTFT de la Señal 2')
xlabel('\omega /\pi');
ylabel('Radianes');


subplot(2,3,6)
plot(w/pi,angle(Signal_3));grid
title('Fase de la DTFT de la Señal 3')
xlabel('\omega /\pi');
ylabel('Radianes');
