/*
  @author edgar.benedetto@unah.hn N.Cuenta 20171033802
  @date 05/04/2021
  @decription Clases #1 - #5 Unidad III BD II Sección 1400 I PAC 2021 
  @name_file Clase #1-#5.sql
  @version 1.0
  
    Clase #1 
    ---> Introducción a los JOBS
    ---> Definición Job: Un Job es una tarea programada, se utilizan cuando se 
      quiere ejecutar una acción 
      especifica cada cierto tiempo (cada día, mes, semana, etc). 
      El Job se ejecuta para que otro objeto realice la acción necesaria, 
      puede ser procedimiento almacenado o función. 
    ---> Job encargado de convertir todos los caracteres de los valores de 
      la tabla BRANDS a mayusculas.
*/

--------------------------------------------------------------------------------
--- Procedimiento almacenado encargado de convertir los caracteres a mayuscula
--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE SP_NOMB_BRAND_MAYUS
IS

BEGIN
  UPDATE BRANDS SET BRAND_NAME = UPPER(BRAND_NAME);
  COMMIT;
END;

--------------------------------------------------------------------------------
/* 
  Creación del Job con funciones especificas del gestor de bases de datos el cual
    debe estar encapsulado en un bloque anonimo
  Parametros:
    1- JOB_NAME: Nombre del Job
    2- JOB_TYPE: Tipo de Job, especificando el tipo de elemento a ejecutar o 
     llamar(en este caso un procedimiento almacenado)
    3- JOB_ACTION: Indicar el nombre del procedimiento a llamar
    4- NUMBER_OF_ARGUMENTS: Indicar la cantidad de parametros que recibe el SP a 
      llamar
    5- START_DATE: Fecha de ejecución por primera vez usando TO_TIMESTAMP
    6- REPEAT_INTERVAL: La frecuencia con la que se va a ejecutar el JOB (diario,
      semanal, mensual, etc)
    7- ENABLED: Refiere al JOB si está activo o inactivo, si el procedimiento o
      función a llamar desde el JOB tiene parametros se deben definir los mismos
      antes de habilitar el JOB
*/
--------------------------------------------------------------------------------
BEGIN
  DBMS_SCHEDULER.CREATE_JOB(
    JOB_NAME=>'JOB_MAYUS_NAME',
    JOB_TYPE=>'STORED_PROCEDURE',
    JOB_ACTION=>'SP_NOMB_BRAND_MAYUS',
    NUMBER_OF_ARGUMENTS=>0,
    START_DATE=>TO_TIMESTAMP('2021-04-05 12:45;00', 'YYYY-MM-DD HH24:MI:SS'),
    REPEAT_INTERVAL=>'FREQ=DAILY',
    ENABLED=>TRUE
  );
END;
--------------------------------------------------------------------------------
--- Consulta para ver los JOBS creados
--------------------------------------------------------------------------------
SELECT * FROM USER_SCHEDULER_JOBS;

--------------------------------------------------------------------------------
--- Consulta para ver los JOBS ejecutados u si se ejecutaron exitosamente
--------------------------------------------------------------------------------
SELECT JOB_NAME, LOG_DATE, STATUS FROM USER_SCHEDULER_JOB_LOG;

--------------------------------------------------------------------------------
--- Comprobar si el JOB esta funcionando correctamente con RUN_JOB
--------------------------------------------------------------------------------
BEGIN 
  DBMS_SCHEDULER.RUN_JOB(
    JOB_NAME=>'JOB_MAYUS_NAME'
  );
END;

--------------------------------------------------------------------------------
--- Eliminar o borrar algún parametro del JOB DROP_JOB
--------------------------------------------------------------------------------
BEGIN 
  DBMS_SCHEDULER.DROP_JOB(
    JOB_NAME=>'JOB_MAYUS_NAME'
  );
END;

--------------------------------------------------------------------------------
/* 
  Clase #2
  Ejercicio: Crear un campo impuesto en la tabla ORDER_ITEMS de tipo NUMBER(10,2)
  Crear un JOB que llamará a un SP que recibe 2 parametros, uno para indicar el 
  porcentaje del impuesto y el otro que sea un numero que indique a que productos
  actualizar el impuesto, es decir si se actualizaran todos o solo los que tienen 
  un valor de 0 o NULL. El valor 1 indicará que todos los productos se deben 
  actualizar y el valor 0 indicará que se deben actualizar todos los que tengan
  0 o NULL como dato en el campo impuesto.
*/
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--- Agregar el campo impuesto a la tabla ORDER ITEMS
--------------------------------------------------------------------------------
ALTER TABLE ORDER_ITEMS ADD (
  IMPUESTO NUMBER(10,2) DEFAULT NULL
);

--------------------------------------------------------------------------------
--- Creación del procedimiento almacenado encargado de actualizar el valor ISV
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_CALCULA_IMPUESTO(VALOR_IMP NUMBER, PROD_ACTUALIZAR NUMBER)
IS

BEGIN
  --- Verificar los registros a actualizar a partir del parametro PROD_ACTUALIZAR
  IF (PROD_ACTUALIZAR = 0) THEN
    UPDATE ORDER_ITEMS SET IMPUESTO =(QUANTITY*LIST_PRICE)*VALOR_IMP WHERE IMPUESTO = 0 OR IMPUESTO IS NULL;
    COMMIT;
  ELSE
    IF (PROD_ACTUALIZAR = 1) THEN
      UPDATE ORDER_ITEMS SET IMPUESTO =(QUANTITY*LIST_PRICE)*VALOR_IMP;
      COMMIT;
    END IF;
  END IF;
END;

--------------------------------------------------------------------------------
--- Creación del JOB encapsulado en un bloque anonimo con ejecución mensual
--------------------------------------------------------------------------------
BEGIN
  DBMS_SCHEDULER.CREATE_JOB(
    JOB_NAME=>'JOB_ACTUALIZA_IMPUESTO',
    JOB_TYPE=>'STORED_PROCEDURE',
    JOB_ACTION=>'SP_CALCULA_IMPUESTO',
    NUMBER_OF_ARGUMENTS=>2,
    START_DATE=>TO_TIMESTAMP('2021-04-05 14:40;00', 'YYYY-MM-DD HH24:MI:SS'),
    REPEAT_INTERVAL=>'FREQ=MONTHLY;BYMONTHDAY=5;BYHOUR=14;BYMINUTE=40;BYSECOND=0',
    ENABLED=>FALSE
  );
END;

--------------------------------------------------------------------------------
/*
  Configurar valores de los parametros del JOB JOB_ACTUALIZA_IMPUESTO
  con la función SET_JOB_ARGUMENT_VALUE que recibe como parámetros:
  ---> JOB_NAME: Nombre del JOB donde están los parámetros a configurar
  ---> ARGUMENT_POSITION: Posición del argumento que se está configurando
  ---> ARGUMENT_VALUE: Valor de dicho parametro
  
  Si se quiere cambiar el valor de los argumentos o parámetros debe eliminarse
  y volver a crearse el JOB puesto que esos valores son valores fijos
*/
--------------------------------------------------------------------------------
BEGIN
  --- Primer Parámetro
  DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE(
    JOB_NAME=>'JOB_ACTUALIZA_IMPUESTO',
    ARGUMENT_POSITION=>1, 
    ARGUMENT_VALUE=>0.15
  );
  
  --- Segundo Parámetros
  DBMS_SCHEDULER.SET_JOB_ARGUMENT_VALUE(
    JOB_NAME=>'JOB_ACTUALIZA_IMPUESTO',
    ARGUMENT_POSITION=>2, 
    ARGUMENT_VALUE=>0
  );
END;

--------------------------------------------------------------------------------
--- Habilitar el JOB para que pueda ser ejecutado
--------------------------------------------------------------------------------
BEGIN
  DBMS_SCHEDULER.ENABLE('JOB_ACTUALIZA_IMPUESTO');
END;

--------------------------------------------------------------------------------
--- Eliminar el JOB para Cambiar la hora del JOB
--------------------------------------------------------------------------------
BEGIN 
  DBMS_SCHEDULER.DROP_JOB(
    JOB_NAME=>'JOB_ACTUALIZA_IMPUESTO'
  );
END;

--------------------------------------------------------------------------------
--- Consulta para ver los JOBS creados
--------------------------------------------------------------------------------
SELECT * FROM USER_SCHEDULER_JOBS;

--------------------------------------------------------------------------------
--- Consulta para ver los JOBS ejecutados u si se ejecutaron exitosamente
--------------------------------------------------------------------------------
SELECT JOB_NAME, LOG_DATE, STATUS FROM USER_SCHEDULER_JOB_LOG;

--------------------------------------------------------------------------------
--- Ejecutar manualmente el JOB con RUN_JOB
--------------------------------------------------------------------------------
BEGIN 
  DBMS_SCHEDULER.RUN_JOB(
    JOB_NAME=>'JOB_MAYUS_NAME'
  );
END;

--------------------------------------------------------------------------------
/* 
  Clase #3
  SQL Loader --> Herramienta utilizada para cargar datos de forma masiva desde 
    un archivo, cargandolos a una tabla dentro de la base de datos. Con SQL 
    Loader no será necesario seguir insertando datos usando INSERT sino solo 
    se deberá establecer un formato en representación de los datos a cargar en 
    una tabla. La creación se divide en 3 pasos:
    
    1. Crear archivo de datos con formato .csv
    2. Crear un archivo de control .ctl
    3. Ejecutar el comando de SQL Loader --> Se necesita conocer la ruta de los
    archivos creados en los pasos 1 y 2.
*/
--------------------------------------------------------------------------------

