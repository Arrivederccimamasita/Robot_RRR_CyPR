%% SCRIPT PARA PINTAR LAS GRAFICAS
% Sera necesario pasarle como parametro los datos obtenidos de la
% simulacion.
% IMPORTANTE: Pasarle UNICAMENTE medidas discretas

function graficas(t,Im,q,qd,qdd)
    % Graficas de las intensidades
    figure();subplot(3,1,1);plot(t,Im(:,1));title('Intensidades en los motores');xlabel('Tiempo [s]');ylabel('Intesidad [A]');grid;...
        subplot(3,1,2);plot(t,Im(:,2));xlabel('Tiempo [s]');ylabel('Intesidad [A]');grid;...
        subplot(3,1,3);plot(t,Im(:,3));xlabel('Tiempo [s]');ylabel('Intesidad [A]');grid;

    % Graficas de las posiciones
    figure();subplot(3,1,1);plot(t,q(:,1));title('Posiciones de las articulaciones');xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;...
        subplot(3,1,2);plot(t,q(:,2));xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;...
        subplot(3,1,3);plot(t,q(:,3));xlabel('Tiempo [s]');ylabel('Posicion [rad]');grid;

    % Graficas de las velocidades
    figure();subplot(3,1,1);plot(t,qd(:,1));title('Velocidades de las articulaciones');xlabel('Tiempo [s]');ylabel('Velocidad [rad/s]');grid;...
        subplot(3,1,2);plot(t,qd(:,2));xlabel('Tiempo [s]');ylabel('Velocidad [rad/s]');grid;...
        subplot(3,1,3);plot(t,qd(:,3));xlabel('Tiempo [s]');ylabel('Velocidad [rad/s]');grid;

    % Graficas de las aceleraciones
    figure();subplot(3,1,1);plot(t,qdd(:,1));title('Aceleraciones de las articulaciones');xlabel('Tiempo [s]');ylabel('Aceleracion [rad/s^{2}]');grid;...
        subplot(3,1,2);plot(t,qdd(:,2));xlabel('Tiempo [s]');ylabel('Aceleracion [rad/s^{2}]');grid;...
        subplot(3,1,3);plot(t,qdd(:,3));xlabel('Tiempo [s]');ylabel('Aceleracion [rad/s^{2}]');grid;
  
end