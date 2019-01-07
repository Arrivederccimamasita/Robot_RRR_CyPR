%% COMPENSADOR DE GRAVEDAD PARA EL ROBOT REAL CON REDUCTORAS
function [comp]=compensador_gravedad(in)
q1=in(1);
q2=in(2);
q3=in(3);

g=9.8;
% Matriz de gravedad del robot real sin reductoras
G=[                                           0;
 2.5*g*(2.217*cos(q2 + q3) + 6.7509*cos(q2));
                       6.3343*g*cos(q2 + q3)];
comp=G';                        
end
