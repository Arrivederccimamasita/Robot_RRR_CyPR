%% FILTRO NO CAUSAL PARA OBTENER LA DERIVADA
% Empleando esta funcion, se aplicara un filtro digital no causal para
% obtener las derivadas. Ya sea las derivadas de la posición o de las
% velocidades.
function [qd_est]=filtroNoCausal_derivada(t,q,Tm)

qd_est=zeros(size(q));
qd_est(1,:)=0;    % Condicion inicial de velocidad. No se si es necesario

% En este bucle se aplica el filtro
for j=1:3       % Numero de articulaciones
    for i=2:(length(t)-1)
        qd_est(i,j)=(q(i+1,j)-q(i-1,j))/(2*Tm);
    end

end