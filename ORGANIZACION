En el directorio Cinematica habrá 2 subdirectorios:
  -AnalisisCinematico  -> Obtencion de los modelos cinematicos directos e inversos del robot
  -ControlCinematico   -> Todo lo relacionado con el generador de trayectorias del robot.

En el directorio Dinamica habrá 4 subdirectorios:
  -Obtenion_Matrices_LI  -> Todo lo asociado a la obtencion de las matrices de parametros linealmente independientes que permitiran estimar los 
                            parametros dinamicos del robot a partir de la aplicacion del algoritmo de N-E simbolico.
  -Estimacion_Parametros -> Todo lo relacionado con los experimentos realizados al robot con diferentes configuraciones, así como los filtros 
			    diseñados para la estimacion de las medidas del robot que fueron pertienentes.
  -Modelos_Dinamicos	 -> Modelos dinamicos obtenidos para los robots con las diferentes configuracioens y scripts para realizar analisis en 
			    frecuencia de las señales del robot y realizar comparativas de sistema y modelos.
  -ControlDinamico	 -> Todo lo relacionado con el control dinamico.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Organizacion Datos MATLAB %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Funciones ==> ()
Ficheros ==> *

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CINEMATICA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

-->Analisis:
*AnalisisCinematico.m

()fun_MDH.m
()CinematicaInversa.m
()CinematicaDirecta.m

-->Control:
()GDT_RRR.m
()GDT_C_RRR.m

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DINAMICA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-->Analisis:
*pruebas.m //--> Simulink: sl_RobotReal_RRR.slx
    |
     ->*DatosSimSenoides.m
    |
     ->*DatosSimSenoides_Exp.m
    |
     ->*DatosSimAcDir_Exp.m
    |
     ->()ObtencionNumerica.m
    |    |
    |     ->()Identificacion_ParamLI.m
    |
     ->()FiltradoButter.m
    |
     ->()filtroNoCausal_derivada.m

*ComparativaModelo.m //--> Simulink: sl_RobotModelo_RRR.slx


*ObtencionParamDinam.m
    |
     -> *DinamicaNE_RRR.m

*AnalisisFrecuencial.m

*ModeloReal_SR_Construccion.m
*ModeloReal_Construccion.m

()ModeladoDinamico.m
()ModeloDinamico_RobotIdeal_cR.m
()ModeloDinamico_RobotIdeal_sR.m
()ModeloDinamico_RobotReal_cR.m
()ModeloDinamico_RobotReal_sR.m

-->Control:

*Modelado_Dinamico_Gs.m
*Inicializaciones.c
*Directivas.c
*Declaraciones.c
*Controlador.c
*Computadora.c

()controladorPID.m
()controladorPD.m
()compensador_gravedad.m

()precompensador_dinamica.m
()par_calculado.m
()graficas_controladores.m

