function [comp]=compensador_gravedad(in)
q1=in(1);
q2=in(2);
q3=in(3);

g=9.8;

G=[                                              0 ;
 0.083333*g*(2.2216*cos(q2 + q3) + 6.6657*cos(q2)) ;
                            0.42316*g*cos(q2 + q3)];
comp=G';                        
end