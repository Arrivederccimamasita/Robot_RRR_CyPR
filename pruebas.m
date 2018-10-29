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
clear all;close all; clc;

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
        graficas(t_D,Im_D,qi_D,qdi_D,qddi_D);
        ObtencionNumerica(t_D,Im_D,qi_D,qdi_D,qddi_D,R1,R2,R3);   % FALTA POR DEFINIR QUE LE PASAMOS EN CADA CASO
    
    % %%%%%%%% Robot ideal sin reductoras %%%%%%%%%%%%%%%%%%
    % (RECORDAR ACTIVAR EL ACCIONAMIENTO DIRECTO)
    case 2
        R1=1; R2=1; R3=1;    % Reductoras
        DatosSimSenoides;
        sim('sl_RobotReal_RRR');
        graficas(t_D,Im_D,qi_D,qdi_D,qddi_D);
        ObtencionNumerica(t_D,Im_D,qi_D,qdi_D,qddi_D,R1,R2,R3);
    
    %  %%%%%%%% Robot real solo encoder con Reductoras %%%%%%%%
    case 3
        R1=50; R2=30; R3=15;    % Reductoras
        DatosSimSenoides;
        sim('sl_RobotReal_RRR');
        graficas(t_D,Im_D,qr_D,qd_fenco_D,qdd_fenco_D);
        ObtencionNumerica(t_D,Im_D,qr_D,qd_fenco_D,qdd_fenco_D,R1,R2,R3);
    
    % %%%%%%%% Robot real solo encoder sin Reductoras %%%%%%%% 
    % (RECORDAR ACTIVAR EL ACCIONAMIENTO DIRECTO)
    case 4
        R1=1; R2=1; R3=1;    % Reductoras
        DatosSimSenoides;
        sim('sl_RobotReal_RRR');
        graficas(t_D,Im_D,qr_D,qd_fenco_D,qdd_fenco_D);
        ObtencionNumerica(t_D,Im_D,qr_D,qd_fenco_D,qdd_fenco_D,R1,R2,R3);
        
    %  %%%%%%%% Robot real encoder y tacometro con Reductoras %%%%%%%%   
    case 5
        R1=50   ; R2=30; R3=15;    % Reductoras
        DatosSimSenoides;
        sim('sl_RobotReal_RRR');
        graficas(t_D,Im_D,qr_D,qdr_D,qdd_ftaco_D);
        ObtencionNumerica(t_D,Im_D,qr_D,qdr_D,qdd_ftaco_D,R1,R2,R3);
    
    % %%%%%%%% Robot real encoder y tacometro sin Reductoras %%%%%%%%
    % (RECORDAR ACTIVAR EL ACCIONAMIENTO DIRECTO)
    case 6
        R1=1; R2=1; R3=1;    % Reductoras
        DatosSimSenoides;
        sim('sl_RobotReal_RRR');
        graficas(t_D,Im_D,qr_D,qdr_D,qdd_ftaco_D);
        ObtencionNumerica(t_D,Im_D,qr_D,qdr_D,qdd_ftaco_D,R1,R2,R3);
end