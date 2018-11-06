%% FILTRO CAUSAL PARA OBTENER LA DERIVADA
% Empleando esta funcion, se aplicara un filtro digital no causal para
% obtener las derivadas. Ya sea las derivadas de la posición o de las
% velocidades.
function qd_est=filtroNoCausal_derivada(t,q,Tm)

qd_est=zeros(size(t));
qd_est(1)=0;    % Condicion inicial de velocidad

% En este bucle se aplica el filtro
for i=1:length(t)
    qd_est(k)=(q(k+1)-q(k-1))/2*Tm;
end

end