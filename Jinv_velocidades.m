%% Script para aplicar el jacobiano
% MODO ELEGANTE DE OBTENCION DEL JACOBIANO
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% syms J q1 q2 q3 L0 L1 L2 L3 real     %Definimos el jacobiano como simbolico
% 
%  % Se define las funciones de la posicion del efector final
%  px=cos(q1)*(L3*cos(q2 + q3) + L2*cos(q2));
%  py=sin(q1)*(L3*cos(q2 + q3) + L2*cos(q2));
%  pz=L0 + L1 + L3*sin(q2 + q3) + L2*sin(q2);
%  
% PosEf=[px py pz]';
% q=[q1 q2 q3]';
% n=3;        %Donde n es el numero de variables articulares
% for i=1:n
%     J(1:size(PosEf,1),i)=jacobian(PosEf,q(i));
% end
% %Donde el jacobiano se define como
% J=simplify(J)
% Jinv=inv(J)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRAS EL CALCULO SIMBOLICO, LA MATRIZ JACOBIANA INVERSA OBTENIDA ES
function  qd = Jinv_velocidades(in)
q1=in(1);
q2=in(2);
q3=in(3);
vx=in(4);
vy=in(5);
vz=in(6);

% Definicion de las longitudes de las barras

% Declaracion del jacobiano inverso
Jinv=[ -sin(q1)/(L3*cos(q2 + q3)*cos(q1)^2 + L3*cos(q2 + q3)*sin(q1)^2 + L2*cos(q1)^2*cos(q2) + L2*cos(q2)*sin(q1)^2),                                                                                         cos(q1)/(L3*cos(q2 + q3)*cos(q1)^2 + L3*cos(q2 + q3)*sin(q1)^2 + L2*cos(q1)^2*cos(q2) + L2*cos(q2)*sin(q1)^2)                                                                                      ,                                                 0                                       ; 
       -(cos(q2 + q3)*cos(q1))/(L2*cos(q2 + q3)*cos(q1)^2*sin(q2) - L2*sin(q2 + q3)*cos(q1)^2*cos(q2) + L2*cos(q2 + q3)*sin(q1)^2*sin(q2) - L2*sin(q2 + q3)*cos(q2)*sin(q1)^2),                              -(cos(q2 + q3)*sin(q1))/(L2*cos(q2 + q3)*cos(q1)^2*sin(q2) - L2*sin(q2 + q3)*cos(q1)^2*cos(q2) + L2*cos(q2 + q3)*sin(q1)^2*sin(q2) - L2*sin(q2 + q3)*cos(q2)*sin(q1)^2)                              ,                        -sin(q2 + q3)/(L2*cos(q2 + q3)*sin(q2) - L2*sin(q2 + q3)*cos(q2));
      (cos(q1)*(L3*cos(q2 + q3) + L2*cos(q2)))/(L2*L3*cos(q2 + q3)*cos(q1)^2*sin(q2) - L2*L3*sin(q2 + q3)*cos(q1)^2*cos(q2) + L2*L3*cos(q2 + q3)*sin(q1)^2*sin(q2) - L2*L3*sin(q2 + q3)*cos(q2)*sin(q1)^2),   (sin(q1)*(L3*cos(q2 + q3) + L2*cos(q2)))/(L2*L3*cos(q2 + q3)*cos(q1)^2*sin(q2) - L2*L3*sin(q2 + q3)*cos(q1)^2*cos(q2) + L2*L3*cos(q2 + q3)*sin(q1)^2*sin(q2) - L2*L3*sin(q2 + q3)*cos(q2)*sin(q1)^2), (L3*sin(q2 + q3) + L2*sin(q2))/(L2*L3*cos(q2 + q3)*sin(q2) - L2*L3*sin(q2 + q3)*cos(q2))];

% Obtencion de las variables articulares
V=[vx;vy;vz];
qd=Jinv*V;
end