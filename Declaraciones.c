/* DECLARACIÓN DE VARIABLES */

/*
 * Ya definidas:
 *   - Ureal:    señal de control (salida el controlador)
 *   - Yk:       medida de la salida del sistema (entrada del controlador)
 *   - POutAux : salida auxiliar de libre disposición
 *   - Tm:       tiempo de muestreo
 */

  double tiempo; /* Para tiempo de simulación */
  static double ek1[3]; /* Valores anteriores del error */
  static double uk1[3]; /* Valores anteriores de la señal de control */
  
  /* Valores para el PID absoluto */
  static double Int_e[3],dt_e[3];
  
  /* Valores de los parametros del PID */
  double Ti[3],Td[3],Kp[3];

  
  Ti[0]=0.36; Td[0]=0.09;   Kp[0]=594.7920;
  Ti[1]=0.4;  Td[1]=0.1;     Kp[1]= 2091.12; 
  Ti[2]=0.36; Td[2]=0.09;   Kp[2]=994.1040; 
 /*
 Kp[0]=698.59; Td[0]=0.092; 
 Kp[1]=3387.6; Td[1]=0.086;
 Kp[2]=1044.9;  Td[2]=0.097;
 */
