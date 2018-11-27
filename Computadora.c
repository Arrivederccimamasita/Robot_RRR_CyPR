/*
 *  Modelo para un Controlador monovariable implementado en tiempo discreto
 *  
 *  El modelo tiene una entrada:
 *  -  Señal de la salida del sistema: Yk
 *
 *  La salida del controlador se denominara: Ureal
 *  El puerto de salida auxiliar se llamara: POutAux
 *
 *  ESTOS NOMBRE NO DEBERAN SER MODIFICADOS
 *
 *  El tiempo de muestreo se especifica mediante el �nico par�metro que se introduce desde Simulink
 *  En caso de ser utilizado en el c�digo, su nombre ser� Tm.
 *
 *  M.G. Ortega  @2017
 */

#define S_FUNCTION_NAME Computadora
#define S_FUNCTION_LEVEL 2

#include "simstruc.h"
#include <math.h>

/* Variables del espacio de trabajo */
#define FLAG_INIT iwork[ 0]

/* Entradas y estados */
/* Se define el puntero a partir de donde se tomaran los 3 datos que componen el
 * vector de entradas.*/
#define ek *uPtrs0  /* Entradas al sistema */
#define Ireal   yPtrs0   /* Salidas de sistema */ 

/* Se define el puntero diciendo que unicamente quiero tomar el dato de esa direccion */  
//#define POutAux (yPtrs1[0])

/****** LUGAR DONDE EL ALUMNO DEBE INCLUIR SUS DIRECTIVAS TIPO #define  ******/
#include "Directivas.c"

/*****************************************************************************/


static void mdlInitializeSizes(SimStruct *S)
{
    ssSetNumSFcnParams(S, 1);       /* Numero de parametros esperados: 1 */
    if (ssGetNumSFcnParams(S) != ssGetSFcnParamsCount(S)) {
        return; /*Si faltan parametros se da mensaje */
    }
    
    ssSetNumContStates(S,0);      /* Numero de estados continuos: 0 */
    ssSetNumDiscStates(S,0);      /* Numero de estados discretos: 0 */

    if (!ssSetNumInputPorts(S,1)) return;      /* 1 puerto de entrada */
	    ssSetInputPortWidth(S,0,3);               /* Dimension del puerto de entrada 0: 3 entradas */
	    ssSetInputPortDirectFeedThrough(S,0,1);   /* y 1 salida directa desde el puerto 0 */
	
    if (!ssSetNumOutputPorts(S,1)) return;      /* 1 puertos de salida */
    ssSetOutputPortWidth(S,0,3);          /* Dimension del puerto de salida 0: 3 salidas */
    
    ssSetNumSampleTimes(S,1);      /* Numero de muestreos */
    ssSetNumRWork(S,0);      /* Vector de numeros reales (rwork) */
    ssSetNumIWork(S,1);      /* Vector de numeros enteros (iwork) */
    ssSetNumPWork(S,0);      /* Vector de punteros */
    ssSetNumModes(S,0);      /* Vector de modos de trabajo */
    ssSetNumNonsampledZCs(S,0);      /* N�mero de paso por cero sin muestreo */
    ssSetOptions(S, SS_OPTION_EXCEPTION_FREE_CODE);
 }


/* FUNCION EMPLEADA PARA INICIALIZAR LOS MUESTREOS */
static void mdlInitializeSampleTimes(SimStruct *S)
{
    real_T  Tm = mxGetPr(ssGetSFcnParam(S,0))[0];  /* Parametro 1 */
    if (Tm<1.e-8)
    {
     printf("\n\n Valor del tiempo de muestreo no valido\n\n");
     ssSetStopRequested(S,1);
    }
    ssSetSampleTime(S, 0, Tm );  /* Automatico segun bloque anterior */
    ssSetOffsetTime(S, 0, 0.0);
}


#define MDL_INITIALIZE_CONDITIONS
static void mdlInitializeConditions(SimStruct *S)
{
 int_T  *iwork = ssGetIWork(S); /* Puntero al vector de n. enteros */
 FLAG_INIT = 1;   
}



/* FUNCION QUE CONFIGURA LAS SALIDAS EN FUNCION DE LAS ENTRADAS */
static void mdlOutputs(SimStruct *S, int_T tid)
{
	/* Acceso a la salida via puntero*/
	  real_T *yPtrs0 = ssGetOutputPortRealSignal(S,0);                   
 	/* Accede a la entrada 0 via un puntero */
  	  InputRealPtrsType uPtrs0 = ssGetInputPortRealSignalPtrs(S,0);

	  int_T  *iwork = ssGetIWork(S); /* Puntero al vector de n. enteros */
	  real_T  Tm = mxGetPr(ssGetSFcnParam(S,0))[0];  /* Tiempo de muestreo */

	  #include "Declaraciones.c"
   
	 if (FLAG_INIT){
	   #include "Inicializaciones.c"
	    FLAG_INIT=0;
	 }

	/* Se incluye la funcion del controlador */
	 #include "Controlador.c" 
}


static void mdlTerminate(SimStruct *S)
{
}


#ifdef  MATLAB_MEX_FILE    
#include "simulink.c"      
#else
#include "cg_sfun.h"       
#endif
