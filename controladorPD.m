%% CONTROLADOR IMPLEMENTADO EN DISCRETO
% IMPLEMENTACION DE UN CONTROLADOR PD EN DISCRETO

function [I_control]=controladorPD(in)
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
    %   persistent e1_k1 e2_k1 e3_k1;            % Se definen los errores anteriores
  
  % Definicion del tiempo de subida en bucle cerrado
  ts_bc=50e-3;

  % Definicion de las intensidades de equilibrio
  Im1_eq=0;
  Im2_eq=0;
  Im3_eq=0;
  
  % Tiempo de muestro
  Tm=0.001;
  
  % Inicializacion de variables
 % if (t<1e-8) e1_k1=0; e2_k1=0; e3_k1=0; end

  % Calculo de los errores -> No se hasta que punto es mejor hayarlo aqui o
  % que sea la entrada del controlador
  e1_k= q1ref_k - q1_k;
  e2_k= q2ref_k - q2_k;
  e3_k= q3ref_k - q3_k;
  
  ed1_k= qd1ref_k - qd1_k;
  ed2_k= qd2ref_k - qd2_k;
  ed3_k= qd3ref_k - qd3_k;
  
  % Definicion de parametros del controlador PD sin cancelacion 
  % %%///Ts_bc=50ms
 Kp1=19173; Td1=0.1; 
 Kp2=30077; Td2=0.1;
 Kp3=6180.8;  Td3=0.091;
  % Incremento de la se�al de control

    I1_k=Kp1*(Td1*ed1_k+e1_k);
    I2_k=Kp2*(Td2*ed2_k+e2_k);
    I3_k=Kp3*(Td3*ed3_k+e3_k);


  % Calculo de la se�al de control abosluta (incremento+Valor de equilibrio)
  Im1_k=I1_k+Im1_eq; 
  Im2_k=I2_k+Im2_eq;
  Im3_k=I3_k+Im3_eq;
  
  % AQUI SE A�ADIRIA LA SATURACION DEL SISTEMA SI FUERA NECESARIO
  
  % Devolvemos como parametro la se�al de control absoluta
  I_control=[Im1_k; Im2_k ;Im3_k];
end