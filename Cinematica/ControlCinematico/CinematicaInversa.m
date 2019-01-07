% Sera necesario a�adir condiciones que verifiquen que la trayectoria es
% valida, es decir, se debera tener en cuenta que q1,q2 y q3 deben ser
% numeros reales, dentro del rango [0-2pi] y que la atan2 de un numero real

% Ademas de ello, el brazo no puede bailar, es decir, para una misma
% posicion del efector articular el brazo puede llegar de varios modos
% posibles, sera necesario asegurar la continuidad del movimiento.

% A�adir un flag para ver si el punto es alcanzable/valido a la salida de
% esta funcion, es decir, debe devolver q1,q2 y q3 y el flag.

function [q] = CinematicaInversa(in)

x       = in(1);           % Posici�n cartesianas
y       = in(2);           % 
z       = in(3);           % 

% Variables necesarias
L0=0.6;L1=0.6;L2=1;L3=0.8;

A=sqrt(x^2+y^2);
B=z-L0-L1;
C=A^2+B^2;

% Se podr� definir la primera variable articular, q1, como
q1=atan2( (y/A) , (x/A) );

% Por lo tanto, se definir� la variable articular q3 como
q3=atan2( -sqrt( 1-( (C-L2^2-L3^2)/(2*L2*L3) )^2 ) , (C-L2^2-L3^2)/(2*L2*L3) );

rho = sqrt( (L3*cos(q3)+L2)^2 + (L3*sin(q3))^2 );
alpha=atan2( L3*sin(q3) , L3*cos(q3)+L2 );

% Se define, la variable articular q2 como
if (z>1.2) % 1.2 es el valor de la posici�n de Z inicial ([0;0;0])
    q2=atan2( sqrt(1-(A/rho)^2) , A/rho ) - alpha;
else
    q2=atan2( -sqrt(1-(A/rho)^2) , A/rho ) - alpha;
end

q=[q1;q2;q3];

% if ( (isreal(q1) AND isreal(q2) AND isreal(q3))==1  )
% flag=0;
return