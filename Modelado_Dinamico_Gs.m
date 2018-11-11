%% MODELADO CINEMATICO DEL ROBOT
% Obtención del modelo a partir de las ecuaciones dinamicas para cada
% articulacion.

% %%%% ROBOT IDEAL CON REDUCTORAS %%%%
Ma1=eval( subs(subs(subs(M(1,1),q1,0),q2,0),q3,0)); 
Ma2=eval( subs(subs(subs(M(2,2),q1,0),q2,0),q3,0)); 
Ma3=eval( subs(subs(subs(M(3,3),q1,0),q2,0),q3,0)); 

Va1=1.200064e-03* (R1^2);
Va2=8.504246e-04* (R2^2);
Va3=1.499010e-03* (R3^2);

numG1=1;
denG1=conv([1 0],[Ma1 Va1]);
G1=tf(numG1,denG1);

numG2=1;
denG2=conv([1 0],[Ma2 Va2]);
G2=tf(numG2,denG2);

numG3=1;
denG3=conv([1 0],[Ma3 Va3]);
G3=tf(numG3,denG3);