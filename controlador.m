x%% CONTROLADOR IMPLEMENTADO EN DISCRETO
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
  % persistent Im1k_1 Im2k_1 Im3k_1;             % Se definen las variables anteriores
  persistent e1_k1 e2_k1 e3_k1;            % Se definen los errores anteriores

  % Definicion del tiempo de subida en bucle cerrado
  ts_bc=1e-3;
  % Inicializacion de variables
  if (t<1e-8) e1_k1=0; e2_k1=0; e3_k1=0; end

  % Calculo de los errores -> No se hasta que punto es mejor hayarlo aqui o
  % que sea la entrada del controlador
  e1k= q1ref_k - q1_k;
  e2k= q2ref_k - q2_k;
  e3k= q3ref_k - q3_k;
  
  % Definicion de parametros del controlador PD
  Kc=3/ts_bc;
  
  Kp1=Kc/Va1; Td1=Ma1/Va1;
  Kp2=Kc/Va2; Td2=Ma2/Va2;
  Kp3=Kc/Va3; Td3=Ma3/Va3;
  
  % Componentes del controlador discreto empleando la aproximacion de 
  % Euler II
  % %%%%%%%%%%%%%%%%%%%%%%%%%%
  %        q0+q1*z+q2*z^2
  %  C(z)= ---------------
  %            (z-1)z
  % %%%%%%%%%%%%%%%%%%%%%%%%%%
  %   q0=Kp*(1+(Tm/Ti)+(Td/Tm));
  %   q1=Kp*(-1-2*(Td/Tm));
  %   q2=Kp*(Td/Tm);
  % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  % Se transformara a discreto la funcion de transferencia del controlador
  % continua empleando la aproximacion de Euler II s=(z-1)/(zTm)
  %                  s=(z-1)/(zTm)             z(Tm+Td)-Td  z^-1  |Ya se 
  % C(s)=Kp(Td*s+1) ---------------> C(z)= Kp ------------- ----> |podria
  %                                               Tm*z      z^-1  |implemnt
  %
  % Incremento de la señal de control
  I1_k=(Kp1/Tm)*((Tm+Td1)*e1_k - Td1*e1_k1);
  I2_k=(Kp2/Tm)*((Tm+Td2)*e2_k - Td2*e2_k1);
  I3_k=(Kp3/Tm)*((Tm+Td3)*e3_k - Td3*e3_k1);
  
  % Actualización de variables
  e1_k1=e1_k;
  e2_k1=e2_k;
  e3_k1=e3_k;
  
  % Calculo de la señal de control abosluta (incremento+Valor de equilibrio)
  Im1_k=I1_k+Im1_eq; 
  Im2_k=I2_k+Im2_eq;
  Im3_k=I3_k+Im3_eq;
  
  % AQUI SE AÑADIRIA LA SATURACION DEL SISTEMA SI FUERA NECESARIO
  
  % Devolvemos como parametro la señal de control absoluta
  I_control=[Im1_k;Im2_k;Im3_k]
end