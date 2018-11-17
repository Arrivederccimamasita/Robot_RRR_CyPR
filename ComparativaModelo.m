R1=50; R2=30; R3=15;    % Reductoras
L0=0.6; L1=0.6; L2=1; L3=0.8;
Kt1=0.5; Kt2=0.4; Kt3 =0.35;
Tm=0.001;
DatosSimSenoides_Exp;
sim('sl_RobotModelo_RRR');

% Aplicacion del FILTRO de Butterworth --> Medidas reales de
% Posicion 'qr_D'
S_Filtr=[];
%Asignacion de vbls de diseño
Wp=0.0005; %Frecuencia de paso
Rp=3; %Rizado caracteristico en zona de paso
Ws=0.00150; %Frecuencia de Corte
Rs=6; %Rizado permitido en el corte

%Aplicacion Filtro
for i=1:3
    X=qr_D(:,i); %Señal a filtrar
    Y  = FiltradoButter( X,Wp,Rp,Ws,Rs );
    S_Filtr(:,i)=Y; %Señal Filtrada
end
qr_filt=S_Filtr; %Posiciones Filtradas

qd_est=filtroNoCausal_derivada(t_D,qr_filt,Tm);   % Obtencion de la derivada


% Aplicacion del FILTRO de Butterworth --> Medidas estimadas de
% Velocidad
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
qd_est_filt=S_Filtr;%Velocidades Filtradas

qdd_est=filtroNoCausal_derivada(t_D,qd_est_filt,Tm);   % Obtencion de la derivada


% Aplicacion del FILTRO de Butterworth --> Medidas reales de
% Posicion 'qr_D'
S_Filtr=[];
%Asignacion de vbls de diseño
Wp=0.0005; %Frecuencia de paso
Rp=3; %Rizado caracteristico en zona de paso
Ws=0.00150; %Frecuencia de Corte
Rs=6; %Rizado permitido en el corte

%Aplicacion Filtro
for i=1:3
    X=qi_D_mod(:,i); %Señal a filtrar
    Y  = FiltradoButter( X,Wp,Rp,Ws,Rs );
    S_Filtr(:,i)=Y; %Señal Filtrada
end
qr_Mod_filt=S_Filtr; %Posiciones Filtradas

qd_Mod_est=filtroNoCausal_derivada(t_D,qr_Mod_filt,Tm);   % Obtencion de la derivada


% Aplicacion del FILTRO de Butterworth --> Medidas estimadas de
% Velocidad
S_Filtr=[];
%Asignacion de vbls de diseño
Wp=0.0010; %Frecuencia de paso
Rp=3; %Rizado caracteristico en zona de paso
Ws=0.0020; %Frecuencia de Corte
Rs=8; %Rizado permitido en el corte

%Aplicacion Filtro
for i=1:3
    X=qd_Mod_est(:,i); %Señal a filtrar
    Y  = FiltradoButter( X,Wp,Rp,Ws,Rs );
    S_Filtr(:,i)=Y; %Señal Filtrada
end
qd_Mod_est_filt=S_Filtr;%Velocidades Filtradas

qdd_Mod_est=filtroNoCausal_derivada(t_D,qd_Mod_est_filt,Tm);   % Obtencion de la derivada




%% Verificacion
whitebg('k')

figure(); %Representacion de las variables para la estimacion de parametros [Posicion/velocidad/aceleracion]
subplot(331);plot(t_D,qr_D(:,1));title('Posicion GIL'); grid; subplot(332);plot(t_D,qr_D(:,2));grid;subplot(333);plot(t_D,qr_D(:,3));grid;
subplot(334);plot(t_D,qd_est(:,1));title('Velocidad GIL'); grid; subplot(335);plot(t_D,qd_est(:,2));grid;subplot(336);plot(t_D,qd_est(:,3));grid;
subplot(337);plot(t_D,qdd_est(:,1));title('Aceleracion GIL'); grid; subplot(338);plot(t_D,qdd_est(:,2));grid;subplot(339);plot(t_D,qdd_est(:,3));grid;

figure(); %Representacion de las variables para la estimacion de parametros [Posicion/velocidad/aceleracion]
subplot(331);plot(t_D,qi_D_mod(:,1));title('Posicion Modelo'); grid; subplot(332);plot(t_D,qi_D_mod(:,2));grid;subplot(333);plot(t_D,qi_D_mod(:,3));grid;
subplot(334);plot(t_D,qd_Mod_est(:,1));title('Velocidad Modelo'); grid; subplot(335);plot(t_D,qd_Mod_est(:,2));grid;subplot(336);plot(t_D,qd_Mod_est(:,3));grid;
subplot(337);plot(t_D,qdd_Mod_est(:,1));title('Aceleracion Modelo'); grid; subplot(338);plot(t_D,qdd_Mod_est(:,2));grid;subplot(339);plot(t_D,qdd_Mod_est(:,3));grid;

figure(); %Representacion de las variables para la estimacion de parametros [Posicion/velocidad/aceleracion]
subplot(331);plot(t_D,qi_D_mod(:,1)-qr_D(:,1));title('Error Posicion'); grid; subplot(332);plot(t_D,qi_D_mod(:,2)-qr_D(:,2));grid;subplot(333);plot(t_D,qi_D_mod(:,3)-qr_D(:,3));grid;
subplot(334);plot(t_D,qd_Mod_est(:,1)-qd_est(:,1));title('Error Velocidad'); grid; subplot(335);plot(t_D,qd_Mod_est(:,2)-qd_est(:,2));grid;subplot(336);plot(t_D,qd_Mod_est(:,3)-qd_est(:,3));grid;
subplot(337);plot(t_D,qdd_Mod_est(:,1)-qdd_est(:,1));title('Error Aceleracion'); grid; subplot(338);plot(t_D,qdd_Mod_est(:,2)-qdd_est(:,2));grid;subplot(339);plot(t_D,qdd_Mod_est(:,3)-qdd_est(:,3));grid;


