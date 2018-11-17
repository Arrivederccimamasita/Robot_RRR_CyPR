%% CONTROLADOR IMPLEMENTADO EN DISCRETO
% IMPLEMENTACION DE UN CONTROLADOR PD EN DISCRETO

function [I_control]=controlador(in)
  % Definicion de entradas del controlador
  q1ref_k = in(1);   % Posiciones de referencia
  q2ref_k = in(2);
  q3ref_k = in(3);
    
  q1_k = in(4);   % Posiciones articulares del robot
  q2_k = in(5);
  q3_k = in(6);

  qd1ref_k = in(7);   % Velocidades de referencia
  qd2ref_k = in(8);
  qd3ref_k = in(9);
    
  qd1_k = in(10);   % Velocidades articulares del robot
  qd2_k = in(11);
  qd3_k = in(12);
%   
%   qdd1ref_k = in(13);   % Aceleraciones de referencia
%   qdd2ref_k = in(14);
%   qdd3ref_k = in(15);
%     
%   qdd1_k = in(16);   % Aceleraciones articulares del robot
%   qdd2_k = in(17);
%   qdd3_k = in(18);
  
  
    t = in(13);       % Tiempo de simulacion
  
  % Se emplean variables persistentes para que mantengan su valor cada vez
  % que se entre en la funcion.
    %   persistent I1_k1 I2_k1 I3_k1;             % Se definen las variables anteriores
       persistent e1_k1 e2_k1 e3_k1;            % Se definen los errores anteriores
       persistent e1_k2 e2_k2 e3_k2;
  
  % Definicion del tiempo de subida en bucle cerrado
  ts_bc=50e-3;

  % Definicion de las intensidades de equilibrio
  Im1_eq=0;
  Im2_eq=0;
  Im3_eq=0;
  
  % Tiempo de muestro
  Tm=0.001;
  
  % Inicializacion de variables
 if (t<1e-8) e1_k1=0; e2_k1=0; e3_k1=0; end

  % Calculo de los errores -> No se hasta que punto es mejor hayarlo aqui o
  % que sea la entrada del controlador
  e1_k= q1ref_k - q1_k;
  e2_k= q2ref_k - q2_k;
  e3_k= q3ref_k - q3_k;
  
  ed1_k= qd1ref_k - qd1_k;
  ed2_k= qd2ref_k - qd2_k;
  ed3_k= qd3ref_k - qd3_k;
  
  % ///**ROBOT IDEAL**////
  % Definicion de parametros del controlador PD sin cancelacion 
  % %%///Ts_bc=50ms
%   Kp1=24.911; Td1=0.097; 
%   Kp2=157.48; Td2=0.11;
%   Kp3=187.4; Td3=0.1;
%   
  % ///**ROBOT REAL ENCODERS**////
    % %%///Ts_bc=50ms
  Kp1=1386.4; Td1=0.066; 
  Kp2=4075.9; Td2=0.07;
  Kp3=956.67;  Td3=0.1;
  
%   Kp=[Kp1;Kp2;Kp3]; Td=[Td1;Td2;Td3]; Ti=[Ti1;Ti2;Ti3];
  % Componentes del controlador discreto empleando la aproximacion de 
  % Euler II
  % %%%%%%%%%%%%%%%%%%%%%%%%%%
  %        q0+q1*z+q2*z^2
  %  C(z)= ---------------
  %            (z-1)z
  %%%%%%%%%%%%%%%%%%%%%%%%%%
%   for i=1:3
%     q0(i)=Kp(i)*(1+(Tm/Ti(i))+(Td(i)/Tm));
%     q1(i)=Kp(i)*(-1-2*(Td(i)/Tm));
%     q2(i)=Kp(i)*(Td(i)/Tm);
%   end
% q0=[ 2441.3, 17480.0, 18927.0]';
% q1=[ -4857.6, -34803.0, -37667.0]';
% q2=[ 2416.4, 17323.0, 18740.0]';
  % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  % Se transformara a discreto la funcion de transferencia del controlador
  % continua empleando la aproximacion de Euler II s=(z-1)/(zTm)
  %                  s=(z-1)/(zTm)             z(Tm+Td)-Td  z^-1  |Ya se 
  % C(s)=Kp(Td*s+1) ---------------> C(z)= Kp ------------- ----> |podria
  %                                               Tm*z      z^-1  |implemnt
  %
  % Incremento de la señal de control
  I1_k=(Kp1)*((1+(Td1/Tm))*e1_k - (Td1/Tm)*e1_k1);
  I2_k=(Kp2)*((1+(Td2/Tm))*e2_k - (Td2/Tm)*e2_k1);
  I3_k=(Kp3)*((1+(Td3/Tm))*e3_k - (Td3/Tm)*e3_k1);

%   I1_k=I1_k1+q0(1)*e1_k + q1(1)*e1_k1 + q2(1)*e1_k2;
%   I2_k=I2_k1+q0(2)*e2_k + q1(2)*e2_k1 + q2(2)*e2_k2;
%   I3_k=I3_k1+q0(3)*e3_k + q1(3)*e3_k1 + q2(3)*e3_k2;

% I1_k=Kp1*(Td1*ed1_k+e1_k);
% I2_k=Kp2*(Td2*ed2_k+e2_k);
% I3_k=Kp3*(Td3*ed3_k+e3_k);

  % Actualización de variables
   e1_k2=e1_k1; e1_k1=e1_k;
   e2_k2=e2_k1;  e2_k1=e2_k;
   e3_k2=e3_k1;  e3_k1=e3_k;
%   
%   I1_k1=I1_k; I2_k1=I2_k; I3_k1=I3_k;
  % Calculo de la señal de control abosluta (incremento+Valor de equilibrio)
  Im1_k=I1_k+Im1_eq; 
  Im2_k=I2_k+Im2_eq;
  Im3_k=I3_k+Im3_eq;
  
  % AQUI SE AÑADIRIA LA SATURACION DEL SISTEMA SI FUERA NECESARIO
  
  % Devolvemos como parametro la señal de control absoluta
  I_control=[Im1_k; Im2_k ;Im3_k];
end