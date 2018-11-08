%% Analisis Frecuencial Comparativo
%%Ininicializacion de Vbles

S1=qd_est(:,2);
S2=qd_est_filt(:,2);

%% Evaluación de la DFT de una señal.

x = S1;           % Señal en el tiempo.
N = length(x);
n = 0:N-1;

f1 = figure('units','normalized','outerposition',[0 0 0.5 1]);
subplot(2,1,1),stem(n,x)
xlabel('n'),ylabel('Amplitud')
title('Señal original x(n)')
axis([-1 N -inf inf])

X = fft(x);                         % DFT de la señal.

f2 = figure('units','normalized','outerposition',[0.5 0 0.5 1]);
subplot(2,1,1),stem(abs(X))
xlabel('k'),ylabel('Amplitud')
title(['Magnitud de X(k), N = ' num2str(N) ' muestras'])
subplot(2,1,2),stem(angle(X))
xlabel('k'),ylabel('Radianes')
title(['Fase de X(k), N = ' num2str(N) ' muestras'])

%% Evaluacion de la DTFT de una señal filtrada 

% Rango de representación de 10*pi.
rango_frec = 10*pi;         % Rango de frecuencias a representar.
w = rango_frec*(-1:1/1200:1-1/1200)/2;

% Cálculo de las muestras de frecuencia de la DTFT
Signal_1 = freqz(S1, 1, w);
Signal_2 = freqz(S2, 1, w);


figure
subplot(2,2,1)
plot(w/pi,abs(Signal_1));grid
title('Magnitud de la DTFT de la Señal 1')
xlabel('\omega /\pi');
ylabel('Amplitud');

subplot(2,2,3)
plot(w/pi,abs(Signal_2));grid
title('Magnitud de la DTFT de la Señal 2')
xlabel('\omega /\pi');
ylabel('Amplitud');

subplot(2,2,2)
plot(w/pi,angle(Signal_1));grid
title('Fase de la DTFT de la Señal 1')
xlabel('\omega /\pi');
ylabel('Radianes');

subplot(2,2,4)
plot(w/pi,angle(Signal_2));grid
title('Fase de la DTFT de la Señal 2')
xlabel('\omega /\pi');
ylabel('Radianes');