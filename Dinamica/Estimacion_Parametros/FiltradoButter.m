function [ Y ] = FiltradoButter( X,Wp,Rp,Ws,Rs )
%FiltradoButter--> Funcion de ayuda al filtrado segun butterworth


% Wp=[];%Frecuencia de paso
% Rp=[];%Rizado en el paso [Rp=3 Rizado caracteristico en zona de paso]
% Ws=[];%Frecuencia de Corte
% Rs=[];%Rizado permitido en el corte
% X=[];%Señal a filtrar
% Y=[];%Señal Filtrada

% %Asignacion de vbls de diseño
% Wp=0.00018; %Frecuencia de paso
% Rp=3; %Rizado caracteristico en zona de paso
% Ws=0.00026; %Frecuencia de Corte
% Rs=8; %Rizado permitido en el corte

%Declaracion Vbls.
N=[];%Orden del filtro
Wn=[];%Frecuencia caracteristica del filtro

A=[]; %Denominador del Filtro
B=[]; %Numerador del Filtro


[N, Wn] = buttord(Wp, Ws, Rp, Rs);
[B,A] = butter(N,Wn);
Y = filter(B,A,X);
end

