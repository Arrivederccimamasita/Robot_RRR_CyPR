# PROYECTO ROBOTICA MANIPULADORA ROBOT RRR EN MATLAB
En el directorio Cinematica habrá 2 subdirectorios:

* AnalisisCinematico

  Obtencion de los modelos cinematicos directos e inversos del robot

* ControlCinematico 
  Todo lo relacionado con el generador de trayectorias del robot.

En el directorio Dinamica habrá 4 subdirectorios:

* Obtenion_Matrices_LI

  Todo lo asociado a la obtencion de las matrices de parametros linealmente independientes que permitiran estimar los parametros dinamicos del robot a partir de la aplicacion del algoritmo de N-E simbolico.
  
* Estimacion_Parametros

   Todo lo relacionado con los experimentos realizados al robot con diferentes configuraciones, así como los filtros diseñados para la estimacion de las medidas del robot que fueron pertienentes,
   
* Modelos_Dinamicos

  Modelos dinamicos obtenidos para los robots con las diferentes configuracioens y scripts para realizar analisis en frecuencia de las señales del robot y realizar comparativas de sistema y modelos.
  
* ControlDinamico

  Todo lo relacionado con el control dinamico e implentacion de controladores discretos en C
