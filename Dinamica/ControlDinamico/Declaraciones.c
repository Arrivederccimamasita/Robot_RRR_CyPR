/* DECLARACI�N DE VARIABLES */

/*
 * Ya definidas:
 *   - Ureal:    se�al de control (salida el controlador)
 *   - Yk:       medida de la salida del sistema (entrada del controlador)
 *   - POutAux : salida auxiliar de libre disposici�n
 *   - Tm:       tiempo de muestreo
 */

  double tiempo; /* Para tiempo de simulaci�n */
  static double ek1[3]; /* Valores anteriores del error */
  static double uk1[3]; /* Valores anteriores de la se�al de control */
  
  /* Valores para el PID absoluto */
  static double Int_e[3],dt_e[3];
  
  /* Valores de los parametros del PID */
  double Ti[3],Td[3],Kp[3];

/* ***************** ROBOT IDEAL ********************* */ 
 /* PD Robot Ideal CR */  
/*
 Kp[0]=698.59;  Td[0]=0.092;
 Kp[1]=3387.6;  Td[1]=0.086;
 Kp[2]=1044.9;  Td[2]=0.097;
*/
	
 /* PID Robot Ideal CR */  
/*
 Ti[0]=2.*0.18; Td[0]=(0.18*0.18)/(0.18*2.); Kp[0]=1652.2*Ti[0];
 Ti[1]=2.*0.2;  Td[1]=(0.2*0.2)/(0.2*2.);    Kp[1]=5227.8*Ti[1]; 
 Ti[2]=2.*0.18; Td[2]=(0.18*0.18)/(0.18*2.); Kp[2]=2761.4*Ti[2]; 	 
*/

/* PD FeedForward Robot Ideal CR */
/*
  Td[0]=0.089; Kp[0]=747.26;
  Td[1]=0.096; Kp[1]=2691.1; 
  Td[2]=0.1;   Kp[2]=985.12;
*/

/* PD Par Calculado Robot Ideal SR */

  Kp[0]=400.; Td[0]=0.1; 
  Kp[1]=400.; Td[1]=0.1;
  Kp[2]=400.; Td[2]=0.1;
/* ***************************************************** */

/* ******************* ROBOT REAL ********************** */
/* PD Robot Real CR */
/*
  Kp[0]=1386.4; Td[0]=0.066; 
  Kp[1]=4075.9; Td[1]=0.07;
  Kp[2]=956.67; Td[2]=0.1;
*/

/* PID Robot Real CR -> ESTE CONTROLADOR DA UN RESULTADO BASTANTE FEO. NO DEBERIA*/
/*
  Ti[0]=0.18*2.; Td[0]=(0.18*0.18)/(0.18*2); Kp[0]=70.504*Ti[0];
  Ti[1]=0.17*2.; Td[1]=(0.17*0.18)/(0.17*2); Kp[1]=566.77*Ti[1]; 
  Ti[2]=0.34;    Td[2]=(0.17*0.18)/(0.17*2); Kp[2]=724.74*Ti[2]; 
*/

/* PD FeedForward Robot Real CR */
/*
  Td[0]=0.082; Kp[0]=1468.3;
  Td[1]=0.098; Kp[1]=2085.2; 
  Td[2]=0.096; Kp[2]=1078.4;
*/

/* PD Robot Real SR */
/*
 Kp[0]=16655.;  Td[0]=0.1; 
 Kp[1]=32753.;  Td[1]=0.1;
 Kp[2]=8638.9;  Td[2]=0.1;
*/

/* PD Par Calculado Robot Real SR */
/*
 * Kp[0]=400.; Td[0]=0.1; 
 * Kp[1]=400.; Td[1]=0.1;
 * Kp[2]=400.; Td[2]=0.1;
 */

  /* PID Par Calculado Robot Real SR */
  
  Ti[0]=0.3600; Td[0]=0.0900; Kp[0]=1185.6*Ti[0];
  Ti[1]=0.3800; Td[1]=0.0950;   Kp[1]=1062.9*Ti[1]; 
  Ti[2]=0.3800; Td[2]=0.0950;   Kp[2]=1061.6*Ti[2]; 
  
/* ***************************************************** */

