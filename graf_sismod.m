%% SCRIPT PARA PINTAR LAS GRAFICAS DEL ERROR ENTRE REAL Y MODELO
% Sera necesario pasarle como parametro los datos obtenidos de la
% simulacion.
% IMPORTANTE: Pasarle UNICAMENTE medidas discretas

function graf_sismod(t,q_real,qd_real,qdd_real,q_mod,qd_mod,qdd_mod,flag)
    if(flag==0)
    % Graficas de las posiciones
    figure();subplot(3,1,1);plot(t,q_real(:,1),'c',t,q_mod(:,1),'r');title('posiciones de las articulaciones');xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;legend('Robot real','Robot Modelo');...
        subplot(3,1,2);plot(t,q_real(:,2),'c',t,q_mod(:,2),'r');xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;legend('Robot real','Robot Modelo');...
        subplot(3,1,3);plot(t,q_real(:,3),'c',t,q_mod(:,3),'r');xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;legend('Robot real','Robot Modelo');

    % Graficas de las velocidades
    figure();subplot(3,1,1);plot(t,qd_real(:,1),'c',t,qd_mod(:,1),'r');title('Velocidades de las articulaciones');xlabel('Tiempo [s]');ylabel('Velocidad [rad/s]');legend('Robot real','Robot Modelo');grid;...
        subplot(3,1,2);plot(t,qd_real(:,2),'c',t,qd_mod(:,2),'r');xlabel('Tiempo [s]');ylabel('Velocidad [rad/s]');legend('Robot real','Robot Modelo');grid;...
        subplot(3,1,3);plot(t,qd_real(:,3),'c',t,qd_mod(:,3),'r');xlabel('Tiempo [s]');ylabel('Velocidad [rad/s]');legend('Robot real','Robot Modelo');grid;

    % Graficas de las aceleraciones
    figure();subplot(3,1,1);plot(t,qdd_real(:,1),'c',t,qdd_mod(:,1),'r');title('Aceleraciones de las articulaciones');xlabel('Tiempo [s]');ylabel('Aceleracion [rad/s^{2}]');grid;legend('Robot real','Robot Modelo');...
        subplot(3,1,2);plot(t,qdd_real(:,2),'c',t,qdd_mod(:,2),'r');xlabel('Tiempo [s]');ylabel('Aceleracion [rad/s^{2}]');grid;legend('Robot real','Robot Modelo');...
        subplot(3,1,3);plot(t,qdd_real(:,3),'c',t,qdd_mod(:,3),'r');xlabel('Tiempo [s]');ylabel('Aceleracion [rad/s^{2}]');grid;legend('Robot real','Robot Modelo');
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    else if (flag==1)
      % Graficas de las posiciones
    figure();subplot(3,1,1);plot(t,q_real(:,1),'c',t,q_mod(:,1),'r');title('posiciones de las articulaciones');xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;legend('Robot real','Robot Modelo');xlim([0 7]);...
        subplot(3,1,2);plot(t,q_real(:,2),'c',t,q_mod(:,2),'r');xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;legend('Robot real','Robot Modelo');xlim([0 7]);...
        subplot(3,1,3);plot(t,q_real(:,3),'c',t,q_mod(:,3),'r');xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;legend('Robot real','Robot Modelo');xlim([0 7]);

    % Graficas de las velocidades
    figure();subplot(3,1,1);plot(t,qd_real(:,1),'c',t,qd_mod(:,1),'r');title('Velocidades de las articulaciones');xlabel('Tiempo [s]');ylabel('Velocidad [rad/s]');legend('Robot real','Robot Modelo');grid;xlim([0 7]);...
        subplot(3,1,2);plot(t,qd_real(:,2),'c',t,qd_mod(:,2),'r');xlabel('Tiempo [s]');ylabel('Velocidad [rad/s]');legend('Robot real','Robot Modelo');grid;xlim([0 7]);...
        subplot(3,1,3);plot(t,qd_real(:,3),'c',t,qd_mod(:,3),'r');xlabel('Tiempo [s]');ylabel('Velocidad [rad/s]');legend('Robot real','Robot Modelo');grid;xlim([0 7]);

    % Graficas de las aceleraciones
    figure();subplot(3,1,1);plot(t,qdd_real(:,1),'c',t,qdd_mod(:,1),'r');title('Aceleraciones de las articulaciones');xlabel('Tiempo [s]');ylabel('Aceleracion [rad/s^{2}]');grid;legend('Robot real','Robot Modelo');xlim([0 7]);...
        subplot(3,1,2);plot(t,qdd_real(:,2),'c',t,qdd_mod(:,2),'r');xlabel('Tiempo [s]');ylabel('Aceleracion [rad/s^{2}]');grid;legend('Robot real','Robot Modelo');xlim([0 7]);...
        subplot(3,1,3);plot(t,qdd_real(:,3),'c',t,qdd_mod(:,3),'r');xlabel('Tiempo [s]');ylabel('Aceleracion [rad/s^{2}]');grid;legend('Robot real','Robot Modelo');xlim([0 7]);
        end
end


