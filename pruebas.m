%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% En este script se seleccionara entre los 6 modos de trabajo que se desee
% para obtener el modelo del robot. En concreto se puede dar que:
% -> Robot ideal con Reductoras
% -> Robot ideal sin Reductoras
% -> Robot real solo encoder con Reductoras
% -> Robot real solo encoder sin Reductoras
% -> Robot real encoder y tacometro con Reductoras
% -> Robot real encoder y tacometro sin Reductoras
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;

% Tiempo de muestreo
Tm=0.001;

selection='Seleccione el robot que busca modelar:\n 1.Robot ideal con reductoras.\n 2.Robot ideal sin reductoras.\n 3.Robot real solo encoder con Reductoras.\n 4.Robot real solo encoder sin Reductoras.\n 5.Robot real encoder y tacometro con Reductoras.\n 6.Robot real encoder y tacometro sin Reductoras.\n';
selec=input(selection);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% En el caso 1,2 -> se emplearan las medidas qi_D,qdi_D,qddi_D.
% En el caso 3,4 -> se emplearan las medidas qr_D,qd_fenco_D,qdd_fenco_D.
%                   (fenco = Filtrada del encoder)
% En el caso 5,6 -> se emplearan las medidas qr_D,qdr_D,qdd_ftaco_D.
%                   (ftaco = Filtrada del tacometro)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch selec
    
    % %%%%%%%% Robot ideal con reductoras %%%%%%%%%%%%%%%%%%
    case 1
        R1=50; R2=30; R3=15;    % Reductoras
        DatosSimSenoides;
        sim('sl_RobotReal_RRR');
        sl_RobotReal_RRR.slx = Simulink.exportToVersion(bdroot,'sl_RobotReal_RRR.slx','R2016b','BreakUserLinks',true);
        
        %graficas(t_D,Im_D,qi_D,qdi_D,qddi_D);
        ObtencionNumerica(t_D,Im_D,qi_D,qdi_D,qddi_D,R1,R2,R3);   % FALTA POR DEFINIR QUE LE PASAMOS EN CADA CASO
        % Si las cosas han ido bien, apareceran por terminal las variables
        % Ma,Va y Ga. Si es asi, ahora se deberan modificar las matrices
        % del script "ModeloDinamico_RRR_sl.m". Tras ello, se debera hacer
        % lo siguiente:
        sim('sl_RobotModelo_RRR');
        % graficas(t_D,Im_D,qi_D_mod,qdi_D_mod,qddi_D_mod);
        graf_error(t_D,Im_D,qi_D,qdi_D,qddi_D,qi_D_mod,qdi_D_mod,qddi_D_mod);
        graf_sismod(t_D,qi_D,qdi_D,qddi_D,qi_D_mod,qdi_D_mod,qddi_D_mod,1);
        % Y ANALIZAR LOS RESULTADOS.
        
        % %%%%%%%% Robot ideal sin reductoras %%%%%%%%%%%%%%%%%%
        % (RECORDAR ACTIVAR EL ACCIONAMIENTO DIRECTO)
    case 2
        R1=1; R2=1; R3=1;    % Reductoras
        DatosSimSenoides;
        sim('sl_RobotReal_RRR');
        % graficas(t_D,Im_D,qi_D,qdi_D,qddi_D);
        ObtencionNumerica(t_D,Im_D,qi_D,qdi_D,qddi_D,R1,R2,R3);
        % Si las cosas han ido bien, apareceran por terminal las variables
        % Ma,Va y Ga. Si es asi, ahora se deberan modificar las matrices
        % del script "ModeloDinamico_RRR_sl.m". Tras ello, se debera hacer
        % lo siguiente:
        % sim('sl_RobotModelo_RRR');
        % graficas(t_D,Im_D,qi_D_mod,qdi_D_mod,qddi_D_mod);
        % graf_error(t_D,Im_D,qi_D,qdi_D,qddi_D,qi_D_mod,qdi_D_mod,qddi_D_mod);
        % Y ANALIZAR LOS RESULTADOS.
        
        %  %%%%%%%% Robot real solo encoder con Reductoras %%%%%%%%
    case 3
        R1=50; R2=30; R3=15;    % Reductoras
        DatosSimSenoides_Exp;
        sim('sl_RobotReal_RRR');
        
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
        
        
        % Aplicacion del filtro no causal para obtener la Velocidad
        % estimada
%         
%         %Representacion compartiva entre señal filtrada y real [Posicion]
%         figure();subplot(311);plot(t_D,qr_D(:,1));title('Posicion real'); grid; subplot(312);plot(t_D,qr_D(:,2));grid;subplot(313);plot(t_D,qr_D(:,3));grid;
%         figure();subplot(311);plot(t_D,qr_filt(:,1));title('Posicion Filtrada'); grid; subplot(312);plot(t_D,qr_filt(:,2));grid;subplot(313);plot(t_D,qr_filt(:,3));grid;
%         figure();subplot(311);plot(t_D,qr_D(:,1)-qr_filt(:,1)); title('Error Tras Filtrado');grid; subplot(312);plot(t_D,qr_D(:,2)-qr_filt(:,2));grid;subplot(313);plot(t_D,qr_D(:,3)-qr_filt(:,3));grid;
          
%         %Representacion compartiva entre señal ideal y real [Posicion]
%         figure();subplot(311);plot(t_D,qr_D(:,1));title('Posicion real [Encoders]'); grid; subplot(312);plot(t_D,qr_D(:,2));grid;subplot(313);plot(t_D,qr_D(:,3));grid;
%         figure();subplot(311);plot(t_D,qi_D(:,1));title('Posicion Ideal'); grid; subplot(312);plot(t_D,qi_D(:,2));grid;subplot(313);plot(t_D,qi_D(:,3));grid;
%         figure();subplot(311);plot(t_D,qr_D(:,1)-qi_D(:,1)); title('Error Posicion ideal-Real');grid; subplot(312);plot(t_D,qr_D(:,2)-qi_D(:,2));grid;subplot(313);plot(t_D,qr_D(:,3)-qi_D(:,3));grid;
        
        qd_est=filtroNoCausal_derivada(t_D,qr_filt,Tm);   % Obtencion de la derivada
        
%         %Representacion compartiva entre el Estimado y el Ideal [Velocidad]
        figure();subplot(311);plot(t_D,qdi_D(:,1));title('Velocidad ideal'); grid; subplot(312);plot(t_D,qdi_D(:,2));grid;subplot(313);plot(t_D,qdi_D(:,3));grid;
        figure();subplot(311);plot(t_D,qd_est(:,1));title('Velocidad estimada'); grid; subplot(312);plot(t_D,qd_est(:,2));grid;subplot(313);plot(t_D,qd_est(:,3));grid;
        figure();subplot(311);plot(t_D,qdi_D(:,1)-qd_est(:,1)); title('Error Velocidad');grid; subplot(312);plot(t_D,qdi_D(:,2)-qd_est(:,2));grid;subplot(313);plot(t_D,qdi_D(:,3)-qd_est(:,3));grid;
        
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
        
%         
%         %Representacion compartiva entre el filtrado y el original [Velocidad]
%         figure();subplot(311);plot(t_D,qd_est(:,1));title('Velocidad Estimada'); grid; subplot(312);plot(t_D,qd_est(:,2));grid;subplot(313);plot(t_D,qd_est(:,3));grid;
%         figure();subplot(311);plot(t_D,qd_est_filt(:,1));title('Velocidad Filtrada'); grid; subplot(312);plot(t_D,qd_est_filt(:,2));grid;subplot(313);plot(t_D,qd_est_filt(:,3));grid;
%         figure();subplot(311);plot(t_D,qd_est(:,1)-qd_est_filt(:,1)); title('Error Tras Filtrado');grid; subplot(312);plot(t_D,qd_est(:,2)-qd_est_filt(:,2));grid;subplot(313);plot(t_D,qd_est(:,3)-qd_est_filt(:,3));grid;
%         
           
        % Aplicacion del filtro no causal para obtener la Aceleracion
        % estimada
        qdd_est=filtroNoCausal_derivada(t_D,qd_est_filt,Tm);   % Obtencion de la derivada
         
%         %Representacion compartiva entre el Estimado y el Ideal [Aceleracion]
%         figure();subplot(311);plot(t_D,qddi_D(:,1));title('Aceleracion ideal'); grid; subplot(312);plot(t_D,qddi_D(:,2));grid;subplot(313);plot(t_D,qddi_D(:,3));grid;
%         figure();subplot(311);plot(t_D,qdd_est(:,1));title('Aceleracion estimada'); grid; subplot(312);plot(t_D,qdd_est(:,2));grid;subplot(313);plot(t_D,qdd_est(:,3));grid;
%         figure();subplot(311);plot(t_D,qddi_D(:,1)-qdd_est(:,1)); title('Error Aceleracion');grid; subplot(312);plot(t_D,qddi_D(:,2)-qdd_est(:,2));grid;subplot(313);plot(t_D,qddi_D(:,3)-qdd_est(:,3));grid;
%         
%          
        ObtencionNumerica(t_D,Im_D,qr_D,qd_est,qdd_est,R1,R2,R3);
        % Si las cosas han ido bien, apareceran por terminal las variables
        % Ma,Va y Ga. Si es asi, ahora se deberan modificar las matrices
        % del script "ModeloDinamico_RRR_sl.m". Tras ello, se debera hacer
        % lo siguiente:
        % sim('sl_RobotReal_RRR');
        % graficas(t_D,Im_D,qi_D_mod,qdi_D_mod,qddi_D_mod);
        % graf_error(t_D,Im_D,qi_D,qdi_D,qddi_D,qi_D_mod,qdi_D_mod,qddi_D_mod);
        % Y ANALIZAR LOS RESULTADOS.
        
        %Debido a la fresencia de los filtros se prudoce una atenuacion en
        %aquellos experimentos que tengan asociados aceleraciones fuertes;
        %debido a esto los terminos de theta_li asociados a estos estaran
        %peor identificados
        
        
        % %%%%%%%% Robot real solo encoder sin Reductoras %%%%%%%%
        % (RECORDAR ACTIVAR EL ACCIONAMIENTO DIRECTO)
    case 4
        R1=1; R2=1; R3=1;    % Reductoras
        DatosSimSenoides;
        sim('sl_RobotReal_RRR');
        graficas(t_D,Im_D,qr_D,qd_fenco_D,qdd_fenco_D);
        ObtencionNumerica(t_D,Im_D,qr_D,qd_fenco_D,qdd_fenco_D,R1,R2,R3);
        % Si las cosas han ido bien, apareceran por terminal las variables
        % Ma,Va y Ga. Si es asi, ahora se deberan modificar las matrices
        % del script "ModeloDinamico_RRR_sl.m". Tras ello, se debera hacer
        % lo siguiente:
        % sim('sl_RobotReal_RRR');
        % graficas(t_D,Im_D,qi_D_mod,qdi_D_mod,qddi_D_mod);
        % graf_error(t_D,Im_D,qi_D,qdi_D,qddi_D,qi_D_mod,qdi_D_mod,qddi_D_mod);
        % Y ANALIZAR LOS RESULTADOS.
        
        %  %%%%%%%% Robot real encoder y tacometro con Reductoras %%%%%%%%
    case 5
        R1=50   ; R2=30; R3=15;    % Reductoras
        DatosSimSenoides;
        sim('sl_RobotReal_RRR');
        
        ord_fil=4;          % Orden del filtro Butterworth
        wc=5/(1/Tm);    % Frecuencia de corte del Butterworth.
        % Aplicacion del filtro de Butterworth a la medida estimada de
        % velocidad para estimar la aceleracion
        [b,a]=butter(ord_fil,wc);
        qdr_filt=filter(b,a,qdr_D);
        
        % Aplicacion del filtro no causal para obtener la velocidad
        % estimada
        qdd_est=filtroNoCausal_derivada(t_D,qdr_filt,Tm);   % Obtencion de la derivada
        
        figure();subplot(311);plot(t_D,qddi_D(:,1));title('Aceleracion ideal'); grid; subplot(312);plot(t_D,qddi_D(:,2));grid;subplot(313);plot(t_D,qddi_D(:,3));grid;
        figure();subplot(311);plot(t_D,qdd_est(:,1));title('Aceleracion estimada'); grid; subplot(312);plot(t_D,qdd_est(:,2));grid;subplot(313);plot(t_D,qdd_est(:,3));grid;
        figure();subplot(311);plot(t_D,qddi_D(:,1)-qdd_est(:,1)); title('Error Aceleracion');grid; subplot(312);plot(t_D,qddi_D(:,2)-qdd_est(:,2));grid;subplot(313);plot(t_D,qddi_D(:,3)-qdd_est(:,3));grid;
        
        
        % graficas(t_D,Im_D,qr_D,qdr_D,qdd_ftaco_D);
        % ObtencionNumerica(t_D,Im_D,qr_D,qdr_D,qdd_ftaco_D,R1,R2,R3);
        % Si las cosas han ido bien, apareceran por terminal las variables
        % Ma,Va y Ga. Si es asi, ahora se deberan modificar las matrices
        % del script "ModeloDinamico_RRR_sl.m". Tras ello, se debera hacer
        % lo siguiente:
        % sim('sl_RobotReal_RRR');
        % graficas(t_D,Im_D,qi_D_mod,qdi_D_mod,qddi_D_mod);
        % graf_error(t_D,Im_D,qi_D,qdi_D,qddi_D,qi_D_mod,qdi_D_mod,qddi_D_mod);
        % Y ANALIZAR LOS RESULTADOS.
        
        % %%%%%%%% Robot real encoder y tacometro sin Reductoras %%%%%%%%
        % (RECORDAR ACTIVAR EL ACCIONAMIENTO DIRECTO)
    case 6
        R1=1; R2=1; R3=1;    % Reductoras
        DatosSimSenoides;
        sim('sl_RobotReal_RRR');
        graficas(t_D,Im_D,qr_D,qdr_D,qdd_ftaco_D);
        ObtencionNumerica(t_D,Im_D,qr_D,qdr_D,qdd_ftaco_D,R1,R2,R3);
        % Si las cosas han ido bien, apareceran por terminal las variables
        % Ma,Va y Ga. Si es asi, ahora se deberan modificar las matrices
        % del script "ModeloDinamico_RRR_sl.m". Tras ello, se debera hacer
        % lo siguiente:
        % sim('sl_RobotReal_RRR');
        % graficas(t_D,Im_D,qi_D_mod,qdi_D_mod,qddi_D_mod);
        % graf_error(t_D,Im_D,qi_D,qdi_D,qddi_D,qi_D_mod,qdi_D_mod,qddi_D_mod);
        % Y ANALIZAR LOS RESULTADOS.
        
end