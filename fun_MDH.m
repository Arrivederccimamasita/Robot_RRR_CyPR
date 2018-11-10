%% FUNCI�N PARA OBTENER LA MATRIZ HOMOGENEA DE TRANSFORMACION D-H
%Esta funci�n devolver� en A la matriz de transformaci�n homogenea 4x4 a
%partir de los par�metros tetha,d,a y alpha de Denavit-Hartemberg.

function A=fun_MDH(theta, d, a, alfa)
A =[cos(theta)            -cos(alfa)*sin(theta)   sin(alfa)*sin(theta)      a*cos(theta) ;
    sin(theta)             cos(alfa)*cos(theta)  -sin(alfa)*cos(theta)      a*sin(theta) ;
           0                   sin(alfa)            cos(alfa)                   d        ;
           0                     0                     0                        1       ];