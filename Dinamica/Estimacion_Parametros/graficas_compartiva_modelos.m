figure();
    subplot(331);plot(t_D,qi_D_mod(:,1),t_D,qr_D(:,1) );grid; ylabel('q1_{modelo}-q1_{sistema} [rad]');xlabel('Tiempo [s]'); ...
    subplot(332);plot(t_D,qi_D_mod(:,2),t_D,qr_D(:,2) );grid; ylabel('q2_{modelo}-q2_{sistema} [rad]');xlabel('Tiempo [s]'); ...
    subplot(333);plot(t_D,qi_D_mod(:,3),t_D,qr_D(:,3) );grid; ylabel('q3_{modelo}-q3_{sistema} [rad]');xlabel('Tiempo [s]'); ...
    
    subplot(334);plot(t_D,qdi_D_mod(:,1),t_D,qdr_D(:,1) );grid; ylabel('qd1_{modelo}-qd1_{sistema} [rad/s]');xlabel('Tiempo [s]'); ...
    subplot(335);plot(t_D,qdi_D_mod(:,2),t_D,qdr_D(:,2) );grid; ylabel('qd2_{modelo}-qd2_{sistema} [rad/s]');xlabel('Tiempo [s]'); ...
    subplot(336);plot(t_D,qdi_D_mod(:,3),t_D,qdr_D(:,3) );grid; ylabel('qd3_{modelo}-qd3_{sistema} [rad/s]');xlabel('Tiempo [s]');...
    
     subplot(337);plot(t_D,qddi_D_mod(:,1),t_D,qddr_D(:,1) );grid;ylabel('qdd1_{modelo}-qdd1_{sistema} [rad/s^{2}]');xlabel('Tiempo [s]'); ...
     subplot(338);plot(t_D,qddi_D_mod(:,2),t_D,qddr_D(:,2) );grid;ylabel('qdd2_{modelo}-qdd2_{sistema} [rad/s^{2}]');xlabel('Tiempo [s]'); ...
     subplot(339);plot(t_D,qddi_D_mod(:,3),t_D,qddr_D(:,3) );grid;ylabel('qdd3_{modelo}-qdd3_{sistema} [rad/s^{2}]');xlabel('Tiempo [s]');
 
figure();
    subplot(331);plot(t_D,qi_D_mod(:,1)-qr_D(:,1) );grid; ylabel('error q1 [rad]');xlabel('Tiempo [s]'); ...
    subplot(332);plot(t_D,qi_D_mod(:,2)-qr_D(:,2) );grid; ylabel('error q2 [rad]');xlabel('Tiempo [s]'); ...
    subplot(333);plot(t_D,qi_D_mod(:,3)-qr_D(:,3) );grid; ylabel('error q3 [rad]');xlabel('Tiempo [s]'); ...
    
    subplot(334);plot(t_D,qdi_D_mod(:,1)-qdr_D(:,1));grid; ylabel('error qd1 [rad/s]');xlabel('Tiempo [s]'); ...
    subplot(335);plot(t_D,qdi_D_mod(:,2)-qdr_D(:,2));grid; ylabel('error qd2 [rad/s]');xlabel('Tiempo [s]'); ...
    subplot(336);plot(t_D,qdi_D_mod(:,3)-qdr_D(:,3) );grid; ylabel('error qd3 [rad/s]');xlabel('Tiempo [s]');...
    
     subplot(337);plot(t_D,qddi_D_mod(:,1)-qddr_D(:,1) );grid;ylabel('error qdd1 [rad/s^{2}]');xlabel('Tiempo [s]'); ...
     subplot(338);plot(t_D,qddi_D_mod(:,2)-qddr_D(:,2) );grid;ylabel('error qdd2 [rad/s^{2}]');xlabel('Tiempo [s]'); ...
     subplot(339);plot(t_D,qddi_D_mod(:,3)-qddr_D(:,3) );grid;ylabel('error qdd3 [rad/s^{2}]');xlabel('Tiempo [s]');
  
 % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % En el caso de que el modelo sea obtenido con medidas reales:
 % Aplicacion del FILTRO de Butterworth --> Medidas reales de Posicion 'qr_D'
%         S_Filtr=[];
%         %Asignacion de vbls de diseño
%         Wp=0.0005; %Frecuencia de paso
%         Rp=3; %Rizado caracteristico en zona de paso
%         Ws=0.00150; %Frecuencia de Corte
%         Rs=6; %Rizado permitido en el corte   
%         
%          %Aplicacion Filtro
%         for i=1:3
%             X=qr_D(:,i); %Señal a filtrar
%             Y  = FiltradoButter( X,Wp,Rp,Ws,Rs );
%             S_Filtr(:,i)=Y; %Señal Filtrada
%         end
%         qr_filt=S_Filtr; %Posiciones Filtradas
%         qd_est=filtroNoCausal_derivada(t_D,qr_filt,Tm);   % Obtencion de la derivada
%         
%         % Aplicacion Filtro Butterworth para limpiar ruidos
%         S_Filtr=[];
%         %Asignacion de vbls de diseño
%         Wp=0.0010; %Frecuencia de paso
%         Rp=3; %Rizado caracteristico en zona de paso
%         Ws=0.0020; %Frecuencia de Corte
%         Rs=8; %Rizado permitido en el corte
%         
%         % Aplicacion Filtro Butterworth para limpiar ruidos
%         for i=1:3
%             X=qd_est(:,i); %Se�al a filtrar
%             Y  = FiltradoButter( X,Wp,Rp,Ws,Rs );
%             S_Filtr(:,i)=Y; %Se�al Filtrada
%         end
%         qd_est_filt=S_Filtr;%Velocidades Filtradas
%         
%         % Obtencion de la derivada
%         qdd_est=filtroNoCausal_derivada(t_D,qd_est_filt,Tm); 
%         
%                 % Aplicacion Filtro Butterworth para limpiar ruidos
%         S_Filtr=[];
%         %Asignacion de vbls de diseño
%         Wp=0.0010; %Frecuencia de paso
%         Rp=3; %Rizado caracteristico en zona de paso
%         Ws=0.0020; %Frecuencia de Corte
%         Rs=8; %Rizado permitido en el corte
%         % Aplicacion Filtro Butterworth para limpiar ruidos
%         for i=1:3
%             X=qdd_est(:,i); %Se�al a filtrar
%             Y  = FiltradoButter( X,Wp,Rp,Ws,Rs );
%             S_Filtr(:,i)=Y; %Se�al Filtrada
%         end
%         qdd_est_filt=S_Filtr;%Velocidades Filtradas
        