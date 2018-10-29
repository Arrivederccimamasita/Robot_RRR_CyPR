%% SCRIPT PARA PINTAR LAS GRAFICAS DEL ERROR ENTRE REAL Y MODELO
% Sera necesario pasarle como parametro los datos obtenidos de la
% simulacion.
% IMPORTANTE: Pasarle UNICAMENTE medidas discretas

function graf_error()
    R1=1; R2=1; R3=1;    % Reductoras
    DatosSimSenoides;
    sim('sl_RobotReal_RRR');
    q_real=qi_D;
    qd_real=qdi_D;
    qdd_real=qddi_D;
    sim('sl_RobotModelo_RRR');
    q_mod=qi_D_mod;
    qd_mod=qdi_D_mod;
    qdd_mod=qddi_D_mod;
    t=t_D;
    Im=Im_D;
    % Graficas de las intensidades
    figure();subplot(3,1,1);plot(t,Im(:,1));title('Intensidades en los motores');xlabel('Tiempo [s]');ylabel('Intesidad [A]');grid;...
        subplot(3,1,2);plot(t,Im(:,2));xlabel('Tiempo [s]');ylabel('Intesidad [A]');grid;...
        subplot(3,1,3);plot(t,Im(:,3));xlabel('Tiempo [s]');ylabel('Intesidad [A]');grid;

    % Graficas de las posiciones
    figure();subplot(3,1,1);plot(t,q_real(:,1)-q_mod(:,1));title('Error en las posiciones de las articulaciones');xlabel('Tiempo [s]');ylabel('qr-qmod [rad]');grid;...
        subplot(3,1,2);plot(t,q_real(:,2)-q_mod(:,2));xlabel('Tiempo [s]');ylabel('qr-qmod [rad]');grid;...
        subplot(3,1,3);plot(t,q_real(:,3)-q_mod(:,3));xlabel('Tiempo [s]');ylabel('qr-qmod [rad]');grid;

    % Graficas de las velocidades
    figure();subplot(3,1,1);plot(t,qd_real(:,1)-qd_mod(:,1));title('Velocidades de las articulaciones');xlabel('Tiempo [s]');ylabel('qdr-qdmod [rad/s]');grid;...
        subplot(3,1,2);plot(t,qd_real(:,2)-qd_mod(:,2));xlabel('Tiempo [s]');ylabel('qdr-qdmod [rad/s]');grid;...
        subplot(3,1,3);plot(t,qd_real(:,3)-qd_mod(:,3));xlabel('Tiempo [s]');ylabel('qdr-qdmod [rad/s]');grid;

    % Graficas de las aceleraciones
    figure();subplot(3,1,1);plot(t,qdd_real(:,1)-qdd_mod(:,1));title('Aceleraciones de las articulaciones');xlabel('Tiempo [s]');ylabel('qddr-qddmod [rad/s^{2}]');grid;...
        subplot(3,1,2);plot(t,qdd_real(:,2)-qdd_mod(:,2));xlabel('Tiempo [s]');ylabel('qddr-qddmod [rad/s^{2}]');grid;...
        subplot(3,1,3);plot(t,qdd_real(:,3)-qdd_mod(:,3));xlabel('Tiempo [s]');ylabel('qddr-qddmod [rad/s^{2}]');grid;
  
end