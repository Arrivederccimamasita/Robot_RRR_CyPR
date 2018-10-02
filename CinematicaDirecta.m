function xyz = CinematicaDirecta(in)

q1       = in(1);           % Posición articular
q2       = in(2);           % 
q3       = in(3);

 % Variables necesarias
 L0=1; L1=3; L2=1.5; L3=2;

 % Se define las funciones de la posicion del efector final
 x=cos(q1)*(L3*cos(q2 + q3) + L2*cos(q2));
 y=sin(q1)*(L3*cos(q2 + q3) + L2*cos(q2));
 z=L0 + L1 + L3*sin(q2 + q3) + L2*sin(q2);
  
xyz=[x;y;z];



  