/* CODIGO DEL CONTROLADOR */
/* Las variables utilizadas deben haber sido DECLARADAS PREVIAMENTE en "Declaraciones.c" */ 
/* La medida del error ya est� declarada como ek */
/* La se�al de control ya est� declarado como Ireal */
/* Hay disponible una salida auxiliar ya declarada como POutAux */
/* El tiempo de muestreo ya est� declarado como Tm */
tiempo = ssGetT(S);  /* Tiempo de la simulaci�n */
  

/* La entrada del sistema sera un vector columna de 3 componentes. */

/* Definicion de los terminos absolutos del PID */
int i;
for (i=0;i<3;i++){	
	Int_e[i]+=ek[i]*Tm;
	dt_e[i]=(ek[i]-ek1[i])/Tm;
  }

/* Calculo de la senal de control del PID */

for (i=0;i<3;i++){	
	Ireal[i]=Kp[i]*( ek[i] + (Td[i]*dt_e[i]) + (1/Ti[i])*Int_e[i] );
  }

/* Calculo de la senal de control del PD */
/*
for (i=0;i<3;i++){	
	Ireal[i]=Kp[i]*( ek[i] + (Td[i]*dt_e[i]));
  }
*/

/* Actualizacion de las variables anteriores */
for (i=0;i<3;i++){
	ek1[i]=ek[i];
	}
/* NO ES NECESARIO INCLUIR return */
/* BASTA CON DEJAR EN LA VARIABLE Ureal EL VALOR FINAL DE SALIDA */
 
 
  
