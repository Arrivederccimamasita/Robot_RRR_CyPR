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

  

  
  Ti[0]=0.04;  Td[0]=0.1;  Kp[0]=1617.76;
  Ti[1]=0.04;  Td[1]=0.1;  Kp[1]= 2537.76; 
  Ti[2]=0.04;  Td[2]=0.1;  Kp[2]=431.08; 
  
  
 /* PID FeedFoward Robot Ideal SR
  Ti1=0.04; Td1=0.1;   Kp1=40444*Ti1;
  Ti2=0.04; Td2=0.1;   Kp2=63444*Ti2; 
  Ti3=0.04; Td3=0.1;   Kp3=10777*Ti3; 
  */
  
  /*
 Kp[0]=698.59; Td[0]=0.092; 
 Kp[1]=3387.6; Td[1]=0.086;
 Kp[2]=1044.9;  Td[2]=0.097;
 */
