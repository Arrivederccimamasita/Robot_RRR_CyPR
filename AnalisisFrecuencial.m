%%%%%%%% Robot real solo encoder con Reductoras %%%%%%%%

%Simulacion del Robot con los datos de entrada del experimento
clear all
Tm=0.001; %Tiempo de muestreo
R1=1; R2=1; R3=1;    % Reductoras
DatosSimAcDir_Exp;
sim('sl_RobotReal_RRR');


S=qr_D; %Representacion de Posiciones
% S=Im_D; %Representacion de Intensidades

S1=S(:,1); %Separacion de Componentes
S2=S(:,2); %Separacion de Componentes
S3=S(:,3); %Separacion de Componentes

% qr_D --> Es la unica medida que tenemos para aproximar los paraemtros
% dinamicos; será necesaria su derivación y filtrado para tratar las
% medidas pertinentes

%% Representacion Resultado Experimentos
% Movimiento 3D del Efector Final
figure(1)
plot3(xyz_Gil(:,1),xyz_Gil(:,2),xyz_Gil(:,3)); title('Movimiento 3D Robot'); grid;

% Graficas de las posiciones [Espacio Articular]
figure(2);
subplot(3,1,1);plot(t_D,S1);title('Posiciones de las articulaciones');xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;...
    subplot(3,1,2);plot(t_D,S2);xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;...
    subplot(3,1,3);plot(t_D,S3);xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;

%% Analisis Frecuencial

%Valores de representacion Frecuencial [Psiciones Articulares]
rango_frec = 0.00050*pi;  % Rango de representación de 5*pi.
w = rango_frec*(-1:1/1200:1-1/1200)/2; % Rango de frecuencias a representar.

% %Valores de representacion Frecuencial [Intensidades]
% rango_frec = pi;  % Rango de representación de 5*pi.
% w = rango_frec*(-1:1/1200:1-1/1200)/2; % Rango de frecuencias a representar.

%% Representacion Frecuencial

%Asignacion de la respuesta frecuencial dado el rango de frecuencias.
Signal_1 = freqz(S1, 1, w);
Signal_2 = freqz(S2, 1, w);
Signal_3 = freqz(S3, 1, w);
whitebg('k')
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

%% Tras decidir especificaciones de filtro Butterworth


S=qr_D; %Representacion de Posiciones Encoders
S_Filtr=[];
%Asignacion de vbls de diseño
Wp=0.0005; %Frecuencia de paso
Rp=3; %Rizado caracteristico en zona de paso
Ws=0.000009; %Frecuencia de Corte
Rs=6; %Rizado permitido en el corte

%Aplicacion Filtro
for i=1:3
    X=S(:,i); %Señal a filtrar
    Y  = FiltradoButter( X,Wp,Rp,Ws,Rs );
    S_Filtr(:,i)=Y; %Señal Filtrada
end
qr_filt=S_Filtr; %Posiciones Filtradas

% 
% Aplicacion del filtro no causal para obtener la Velocidad
% estimada
qd_est=filtroNoCausal_derivada(t_D,qr_filt,Tm);   % Obtencion de la derivada

S=qd_est; %Representacion de Velocidades Estimadas
S_Filtr=[];
%Asignacion de vbls de diseño
Wp=0.0010; %Frecuencia de paso
Rp=3; %Rizado caracteristico en zona de paso
Ws=0.0020; %Frecuencia de Corte
Rs=8; %Rizado permitido en el corte
%Aplicacion Filtro
for i=1:3
    X=qd_est(:,i); %Señal a filtrar
    Y  = FiltradoButter( X,Wp,Rp,Ws,Rs );
    S_Filtr(:,i)=Y; %Señal Filtrada
end
qd_est_filt=S_Filtr;


%% Representacion Comparativa Entre señales

%MAGNITUDES
figure();
%Representa magnitudes de la señal Sin filtrar
for i=1:3
    Signal = freqz(S(:,i), 1, w);
    subplot(2,3,i)
    plot(w/pi,abs(Signal));grid
    title(['Magnitud de la DTFT de la Señal q',num2str(i)])
    xlabel('\omega /\pi');
    ylabel('Amplitud');
end
%Representa magnitudes de la señal filtrada
for i=4:6
    Signal = freqz(S_Filtr(:,i-3), 1, w);
    subplot(2,3,i)
    plot(w/pi,abs(Signal));grid
    title(['Magnitud de la DTFT de la Señal filtrada q',num2str(i-3)])
    xlabel('\omega /\pi');
    ylabel('Amplitud');
end


%FASES
figure();
%%Representa Fases de la señal Sin filtrar
for i=1:3
    Signal = freqz(S(:,i), 1, w);
    subplot(2,3,i)
    plot(w/pi,angle(Signal));grid
    title(['Fase de la DTFT de la Señal q',num2str(i)])
    xlabel('\omega /\pi');
    ylabel('Radianes');
end

%Representa Fases de la señal filtrada
for i=4:6
    Signal = freqz(S_Filtr(:,i-3), 1, w);
    subplot(2,3,i)
    plot(w/pi,angle(Signal));grid
    title(['Fase de la DTFT de la Señal filtrada q',num2str(i-3)])
    xlabel('\omega /\pi');
    ylabel('Radianes');
end

%% Ploteo posiciones filtradas-Real

        %Representacion compartiva entre señal filtrada y real [Posicion]
        figure();subplot(311);plot(t_D,qr_D(:,1));title('Posicion real'); grid; subplot(312);plot(t_D,qr_D(:,2));grid;subplot(313);plot(t_D,qr_D(:,3));grid;
        figure();subplot(311);plot(t_D,qr_filt(:,1));title('Posicion Filtrada'); grid; subplot(312);plot(t_D,qr_filt(:,2));grid;subplot(313);plot(t_D,qr_filt(:,3));grid;
        figure();subplot(311);plot(t_D,qr_D(:,1)-qr_filt(:,1)); title('Error Tras Filtrado');grid; subplot(312);plot(t_D,qr_D(:,2)-qr_filt(:,2));grid;subplot(313);plot(t_D,qr_D(:,3)-qr_filt(:,3));grid;
          