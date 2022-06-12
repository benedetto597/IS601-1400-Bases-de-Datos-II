/*
  @author edgar.benedetto@unah.hn N.Cuenta 20171033802
  @date 05/04/2021
  @decription Tarea N4 BDII Sección 1400 I PAC 2021 
  @name_file Ejercicio_#3_#4.sql
  @version 1.0
  
    Ejercicio #3
    ---> Crear la tabla ANIMALDIETAOBSOLETA
    ---> SP Obtener campos ANIMALID, DIETAID, FECHAINICIO, FECHAFINAL y DESCRIPCION
      de la dieta, que tengan una dieta menor a 1 mes.
    ---> Insertar los datos obtenidos en animalDietaObsoleta (sin PK ni secuencia)
    ---> SP debe aprobar cambios
    ---> MSJ_STATUS = 1 Se produjo un error
    ---> MSJ_STATUS = 0 No se produjo un error
    ---> Habilitar impresion SET SERVEROUTPUT ON;

    !!!! Control de errores incluido
    !!!! Bloque anónimo para pruebas incluido
    
    DATO: Las fechas se pueden restar y obtener un valor numérico que representa 
      los días transcurridos entre una fecha y otra
      
    Ejercicio #4
      ---> JOB que ejecute ANIMALDIETAOBSOLETA el primer día del mes cada mes a las 11:$0
      
      !!!! Incluye bloque anónimo para ejecutar el JOB directamente
      !!!! Incluye bloque anónimo para eliminar el JOB 
      !!!! Incluye bloque anónimo para verificar la ultima ejecución del JOB 
      !!!! Incluye bloque anónimo para ver JOB's creados y su información 
*/

--------------------------------------------------------------------------------
--- Tabla ANIMALDIETAOBSOLETA
--------------------------------------------------------------------------------
CREATE TABLE ANIMALDIETAOBSOLETA (
  ANIMAL_ID VARCHAR2(20),
  DIET_ID VARCHAR2(20),
  START_DATE DATE NOT NULL,
  END_DATE DATE NOT NULL,
  DESCRIPTION VARCHAR2(500),
  CONSTRAINT FK_ANIMALDIETAOBSOLETA_2 FOREIGN KEY (DIET_ID) REFERENCES dieta (dietaId) ON DELETE CASCADE,
  CONSTRAINT FK_ANIMALDIETAOBSOLETA_1 FOREIGN KEY (ANIMAL_ID) REFERENCES animales (animalId) ON DELETE CASCADE
);

--------------------------------------------------------------------------------
/*
  Ejercicio #3
    Procedimiento almacenado SP_INSERTAR_DIETA_OBSOLETA
*/
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_INSERTAR_DIETA_OBSOLETA
IS
  --- Almacenar la cantidad de registros que cumplan la condición de tener una dieta menor a un mes
  COUNT_REG_ANIMALXDIETA NUMBER;
  
  --- Almacenar la cantidad de registros que estén ya almacenados en ANIMALDIETAOBSOLETA
  COUNT_REG_ANIMALDIETAOBSOLETA NUMBER;
  
  REG_ANMLXDIETA SYS_REFCURSOR;
  
  TYPE FILA IS RECORD(
    ANIMAL_ID VARCHAR2(20),
    DIET_ID VARCHAR2(20),
    START_DATE VARCHAR2(20),
    END_DATE VARCHAR2(20),
    DESCRIPTION VARCHAR2(500)
  );
  
  --- Variable para almacenar los registros al recorrer el cursor
  INF_ANMLXDIETA FILA; 

BEGIN   
  
  --- Verificar que existan registros que cumplan la condición
  SELECT COUNT(*) INTO COUNT_REG_ANIMALXDIETA FROM ANIMALXDIETA WHERE FECHAFINAL-FECHAINICIO < 30;
  
  IF(COUNT_REG_ANIMALXDIETA>0) THEN
  
  OPEN REG_ANMLXDIETA FOR SELECT ANIMALXDIETA.ANIMALID, ANIMALXDIETA.DIETAID, 
    TO_CHAR(ANIMALXDIETA.FECHAINICIO, 'YYYY-MM-DD'),TO_CHAR(ANIMALXDIETA.FECHAFINAL, 'YYYY-MM-DD'), DIETA.DESCRIPCION
  FROM ANIMALXDIETA INNER JOIN DIETA ON ANIMALXDIETA.DIETAID = DIETA.DIETAID
  WHERE FECHAFINAL-FECHAINICIO < 30;
  
  LOOP
      FETCH REG_ANMLXDIETA INTO INF_ANMLXDIETA;
      EXIT WHEN REG_ANMLXDIETA%NOTFOUND;
      
      COUNT_REG_ANIMALDIETAOBSOLETA:=0;
      
      SELECT COUNT(*) INTO COUNT_REG_ANIMALDIETAOBSOLETA FROM ANIMALDIETAOBSOLETA 
      WHERE ANIMAL_ID = INF_ANMLXDIETA.ANIMAL_ID AND DIET_ID=INF_ANMLXDIETA.DIET_ID AND 
        START_DATE=TO_DATE(INF_ANMLXDIETA.START_DATE,'YYYY-MM-DD') AND END_DATE=TO_DATE(INF_ANMLXDIETA.END_DATE,'YYYY-MM-DD') 
        AND DESCRIPTION=INF_ANMLXDIETA.DESCRIPTION;
        
      --- Verificar que el registro no haya sido almacnado en la tabla ANIMALDIETAOBSOLETA
      IF(COUNT_REG_ANIMALDIETAOBSOLETA=0) THEN
        INSERT INTO ANIMALDIETAOBSOLETA VALUES (INF_ANMLXDIETA.ANIMAL_ID, INF_ANMLXDIETA.DIET_ID, 
          TO_DATE(INF_ANMLXDIETA.START_DATE,'YYYY-MM-DD'),TO_DATE(INF_ANMLXDIETA.END_DATE,'YYYY-MM-DD'), INF_ANMLXDIETA.DESCRIPTION);
      END IF;
    END LOOP;
    
    --- Aprobar cambios 
    COMMIT;
  END IF;
  
  EXCEPTION 
    WHEN OTHERS THEN
      --- Denegar cambios
      ROLLBACK;
END;

--------------------------------------------------------------------------------
--- Bloque anónimo de pruebas
--------------------------------------------------------------------------------
DECLARE 
BEGIN
  SP_INSERTAR_DIETA_OBSOLETA;
END;

--------------------------------------------------------------------------------
/*
  Ejercicio #4
    Job JOB_INSERTAR_DIETA_OBSOLETA
*/
--------------------------------------------------------------------------------
BEGIN
  DBMS_SCHEDULER.CREATE_JOB(
    JOB_NAME=>'JOB_INSERTAR_DIETA_OBSOLETA',
    JOB_TYPE=>'STORED_PROCEDURE',
    JOB_ACTION=>'SP_INSERTAR_DIETA_OBSOLETA',
    NUMBER_OF_ARGUMENTS=>0,
    START_DATE=>TO_TIMESTAMP('2021-04-16 11:50;00', 'YYYY-MM-DD HH24:MI:SS'),
    REPEAT_INTERVAL=>'FREQ=MONTHLY;BYMONTHDAY=1;BYHOUR=11;BYMINUTE=50;BYSECOND=0',
    ENABLED=>TRUE
  );
END;

--------------------------------------------------------------------------------
--- Ejecutar manualmente el JOB con RUN_JOB
--------------------------------------------------------------------------------
BEGIN 
  DBMS_SCHEDULER.RUN_JOB(
    JOB_NAME=>'JOB_INSERTAR_DIETA_OBSOLETA'
  );
END;

--------------------------------------------------------------------------------
--- Eliminar o borrar algún parametro del JOB DROP_JOB
--------------------------------------------------------------------------------
BEGIN 
  DBMS_SCHEDULER.DROP_JOB(
    JOB_NAME=>'JOB_INSERTAR_DIETA_OBSOLETA'
  );
END;

--------------------------------------------------------------------------------
--- Consulta para ver los JOBS ejecutados o si se ejecutaron exitosamente
--------------------------------------------------------------------------------
SELECT JOB_NAME, LOG_DATE, STATUS FROM USER_SCHEDULER_JOB_LOG;

--------------------------------------------------------------------------------
--- Consulta para ver los JOBS creados
--------------------------------------------------------------------------------
SELECT * FROM USER_SCHEDULER_JOBS;