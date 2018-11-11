%% CONTROLADOR IMPLEMENTADO EN DISCRETO
% Como salida el controlador nos va a dar el incremento de la se�al de
% control �nicamente.

function [Ik]=controlador(ek)
  % Se emplean variables persistentes para que mantengan su valor cada vez
  % que se entre en la funcion.
  persistent Ik1 ek1 ek2 % Se definen los errores y la SC anteriores
  persistent Ti Kp Td     % Parametros del controlador

  % Parametros del PID
  Ti=
  Kp=
  Td=

  % Componentes del controlador discreto empleando la aproximacion de 
  % Euler II
  % %%%%%%%%%%%%%%%%%%%%%%%%%%
  %        q0+q1*z+q2*z^2
  %  C(z)= ---------------
  %            (z-1)z
  % %%%%%%%%%%%%%%%%%%%%%%%%%%
  q0=Kp*(1+(Tm/Ti)+(Td/Tm));
  q1=Kp*(-1-2*(Td/Tm));
  q2=Kp*(Td/Tm);

  % Incremento de la se�al de control
  Ik=Ik1+(q0*ek)+(q1*ek1)+(q2*ek2);

  % Actualizaci�n de variables
  uk1=uk;
  ek2=ek1; ek1=ek;
    
end

