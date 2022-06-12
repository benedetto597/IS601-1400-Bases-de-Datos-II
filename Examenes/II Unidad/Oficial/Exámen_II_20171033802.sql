/*
  @author edgar.benedetto@unah.hn N.Cuenta 20171033802
  @date 26/03/2021
  @decription Examen Práctico #2 BDII Sección 1400 I PAC 2021 
  @name_file Exámen_II_20171033802.sql
  @version 1.0
    
    
  * Ejercicios 
    1. Procedimiento almacenado que retorna un cursor con la info de LOCATIONS que 
    tenga asignadas al país “US”, retornar el total de Locations que cumplen
    con la condición indicada. Probar con bloque anonimo.
      
    2. Paquete con SP y FN
      SP Inserta nueva región y aprueba cambios
      SP Valores como parametros
      FN Recibe ID_COUNTRY como parametro
      FN Retorna nombre del COUNTRY
      
    3. Campos como parametro FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
       Validar DEPARTMENT_ID, JOB_ID y MANAGER_ID existan con funciones que retornen un NUMBER (1)
       Validar que la fecha de contratacion sea mayor o igual al 18 de marzo de 2021
       Verificar que el salario esté entre 1000 y 2500
       Verificar cual es el ultimo valor guardado y sumarle una unidad, esto se debe realizar mediante una consulta que obtenga el último valor y luego sumarle la cantidad indicada
       Control de errores mandando mensajes de exito y error en cada función de comprobaci?n 
      
    Habiltar impresi?n en pantalla
      ---> SET SERVEROUTPUT ON;

*/
--- Ejercicio #1
CREATE OR REPLACE PROCEDURE SP_LOCATIONS_20171033802(INFO_LOCATIONS OUT SYS_REFCURSOR, US_LOCATION OUT NUMBER)
IS
  
BEGIN
  --- Apertura y llenado del cursor
  OPEN INFO_LOCATIONS FOR SELECT * FROM LOCATIONS WHERE COUNTRY_ID = 'US';
  
  --- Cantidad total de locaciones que tienen el identificador de país = US
  SELECT COUNT(*) INTO US_LOCATION FROM LOCATIONS WHERE COUNTRY_ID = 'US';

END;

DECLARE
  --- Variable tipo cursor para obtener el cursor retornado por el SP_LOCATIONS_20171033802
  CLOCATIONS SYS_REFCURSOR;
  
  --- Variable tipo NUMBER para obtener el total de locaciones que tienen el identificador de país = US en SP_LOCATIONS_20171033802
  US_LOCATIONS NUMBER;
  
  --- Variable para imprimir los registros obtenidos en el cursor CLOCATIONS
  REG_LOCATION LOCATIONS%ROWTYPE;

BEGIN 
  --- Ejecución del procedimiento almacenado
  SP_LOCATIONS_20171033802(CLOCATIONS, US_LOCATIONS);
  
  --- Ciclo para imprimir datos
  LOOP
    FETCH CLOCATIONS INTO REG_LOCATION;
    EXIT WHEN CLOCATIONS%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('El identificador de la locación es: '||REG_LOCATION.LOCATION_ID);
    DBMS_OUTPUT.PUT_LINE('La dirección de la locación es: '||REG_LOCATION.STREET_ADDRESS);
    DBMS_OUTPUT.PUT_LINE('El código postal de la locación es: '||REG_LOCATION.POSTAL_CODE);
    DBMS_OUTPUT.PUT_LINE('La ciudad de la locación es: '||REG_LOCATION.CITY);
    DBMS_OUTPUT.PUT_LINE('El estado o provincia de la locación es: '||REG_LOCATION.STATE_PROVINCE);
    DBMS_OUTPUT.PUT_LINE('El identificador del país de la locación es: '||REG_LOCATION.COUNTRY_ID);
    
    --- Salto de linea 
    DBMS_OUTPUT.PUT_LINE(CHR(13));
  END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('El Total de registros que cumplen la condición son : '||US_LOCATIONS);
    --- Salto de linea 
    DBMS_OUTPUT.PUT_LINE(CHR(13));
END;

-----------------------------------------------------------------------------------------------------------------------------------

--- Ejercicio #2
CREATE OR REPLACE PACKAGE PK_INFO_COUNTRY_20171033802
IS
  --- Prototipo de función
  FUNCTION FN_NCOUNTRY_20171033802(ID_COUNTRY COUNTRIES.COUNTRY_ID%TYPE) RETURN VARCHAR2;
  
  --- Prototipo de procedimientos almacenados
  --- Procedimientos para insertar en la tabla REGIONS y aprobar cambios
  PROCEDURE SP_REG_20171033802(REGION_ID REGIONS.REGION_ID%TYPE, REGION_NAME REGIONS.REGION_NAME%TYPE, MSJ_EXITO OUT VARCHAR2, MSJ_ERROR OUT VARCHAR2);
  
  PROCEDURE SP_INST_20171033802(REGION_ID REGIONS.REGION_ID%TYPE, REGION_NAME REGIONS.REGION_NAME%TYPE, MSJ OUT VARCHAR2, MSJ_ERROR OUT VARCHAR2);
END;

CREATE OR REPLACE PACKAGE BODY PK_INFO_COUNTRY_20171033802
IS
  --- Retornar nombre de país a partir de su ID
  FUNCTION FN_NCOUNTRY_20171033802(ID_COUNTRY COUNTRIES.COUNTRY_ID%TYPE) RETURN VARCHAR2
  IS 
    --- Variable para almacenar el nombre del país
    NAME_COUNTRY COUNTRIES.COUNTRY_NAME%TYPE;
  BEGIN
    SELECT COUNTRY_NAME INTO NAME_COUNTRY FROM COUNTRIES WHERE COUNTRY_ID = ID_COUNTRY;
    RETURN NAME_COUNTRY;
  END;
  
  --- Insersion con control de errores
  PROCEDURE SP_REG_20171033802(REGION_ID REGIONS.REGION_ID%TYPE, REGION_NAME REGIONS.REGION_NAME%TYPE, MSJ_EXITO OUT VARCHAR2, MSJ_ERROR OUT VARCHAR2)
  IS 
    --- Variable para detectar errores en la insersion
    MSJ NUMBER;
  BEGIN
    SP_INST_20171033802(REGION_ID, REGION_NAME, MSJ, MSJ_ERROR);
  
    IF(MSJ=0) THEN
      --- Mensaje a mostrar de la operación exitosa
      MSJ_EXITO:='La insersión en la tabla REGIONS fue exitosa';
      --- Subir cambios
      COMMIT;
    ELSIF(MSJ=1) THEN
      --- Revertir los cambios 
      ROLLBACK;
    END IF;
  END;

  PROCEDURE SP_INST_20171033802(REGION_ID REGIONS.REGION_ID%TYPE, REGION_NAME REGIONS.REGION_NAME%TYPE, MSJ OUT VARCHAR2, MSJ_ERROR OUT VARCHAR2)
  IS 
  BEGIN
     --- Insersión de los campos
    INSERT INTO REGIONS VALUES(REGION_ID, REGION_NAME);
    
    MSJ:=0;
    EXCEPTION
      WHEN OTHERS THEN
        MSJ:=1;
        MSJ_ERROR:=('Se produjo un error al insertar en la tabla REGIONS, el error es: '||SQLERRM);
    END;  
--- Fin de paquete
END;

--- Ejecución de la FN y SP del PK
DECLARE
   MSJ_EXITO VARCHAR2(500);
   MSJ_ERROR VARCHAR2(500);
BEGIN
  --- Ejecución de los procedimientos almacenados
  --- Insersión sin error
  PK_INFO_COUNTRY_20171033802.SP_REG_20171033802(5, 'Antartida',MSJ_EXITO, MSJ_ERROR);
  DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERROR);
  
  --- Insersión con error
  PK_INFO_COUNTRY_20171033802.SP_REG_20171033802(4, 'Antartida',MSJ_EXITO, MSJ_ERROR);
  DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERROR);

END;

DECLARE
   NAME_COUNTRY COUNTRIES.COUNTRY_NAME%TYPE;
BEGIN
  --- Ejecución de la función
  NAME_COUNTRY:=PK_INFO_COUNTRY_20171033802.FN_NCOUNTRY_20171033802('CA');
  DBMS_OUTPUT.PUT_LINE('El país con el id CA es: '||NAME_COUNTRY);
END;

-----------------------------------------------------------------------------------------------------------------------------------


--- Ejercicio #3
CREATE OR REPLACE PROCEDURE REG_EMP_20171033802 (FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE, LAST_NAME EMPLOYEES.LAST_NAME%TYPE, EMAIL EMPLOYEES.EMAIL%TYPE, PHONE_NUMBER EMPLOYEES.PHONE_NUMBER%TYPE, 
HIRE_DATE EMPLOYEES.HIRE_DATE%TYPE, JOB_ID EMPLOYEES.JOB_ID%TYPE, SALARY EMPLOYEES.SALARY%TYPE, COMMISSION_PCT EMPLOYEES.COMMISSION_PCT%TYPE, 
MANAGER_ID EMPLOYEES.MANAGER_ID%TYPE, DEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE, MSJ_EXITO OUT VARCHAR2, MSJ_ERROR_ID_DEP OUT VARCHAR2, MSJ_ERROR_ID_JOB OUT VARCHAR2,
MSJ_ERROR_ID_MAN OUT VARCHAR2, MSJ_ERROR_DATE OUT VARCHAR2, MSJ_ERROR_SALARY OUT VARCHAR2, MSJ_ERROR_EMPLOYEE_INSERT OUT VARCHAR2)
IS 
  --- Variables para el control de errores en las funciones
  MSJ_FN_DEP NUMBER;
  MSJ_FN_JOB NUMBER;
  MSJ_FN_MAN NUMBER;
  
  --- Variables para el control de errores en los procedimientos
  MSJ_SP_EMP NUMBER;
  
  --- Variable para controlar identificador primario
  ID_EMPLOYEE EMPLOYEES.EMPLOYEE_ID%TYPE;
BEGIN
  --- Validación de llaves foraneas
  MSJ_FN_DEP:=FN_VDEP_20171033802(DEPARTMENT_ID, MSJ_ERROR_ID_DEP);
  MSJ_FN_JOB:=FN_VJOB_20171033802(JOB_ID, MSJ_ERROR_ID_JOB);  
  MSJ_FN_MAN:=FN_VMAN_20171033802(MANAGER_ID, MSJ_ERROR_ID_MAN);
  
  --- Verificación de fecha 
  IF (HIRE_DATE >= '18-MAR-2021') THEN
    --- Verificación de salario
    IF (SALARY >= 1000 AND SALARY <=2500) THEN
      --- Comprobar si DEPARTMENT_ID, JOB_ID y MANAGER_ID existen
      IF(MSJ_FN_DEP=1 AND MSJ_FN_JOB=1 AND MSJ_FN_MAN=1) THEN
          --- Obtener el valor siguiente de la llave foranea de la tabla EMPLOYEES
          SELECT (MAX(EMPLOYEE_ID)+1) INTO ID_EMPLOYEE FROM EMPLOYEES;
          
          --- Llamado al procedimiento almacenado que realizará la insersión
          SP_INST_EMP_20171033802(ID_EMPLOYEE, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID, MSJ_SP_EMP, MSJ_ERROR_EMPLOYEE_INSERT);
          
          --- Validar que la insersión se haya realizado correctamente
          IF(MSJ_SP_EMP=1)THEN
            MSJ_EXITO:=('La insersión en la tabla EMPLOYEES fue exitosa');
            --- Subir los cambios
            COMMIT;
          ELSE
            --- Revertir los cambios en caso de haber detectado algún error en la insersión
            ROLLBACK;
          END IF;
      END IF;
    ELSE 
       MSJ_ERROR_SALARY:=('Error en el campo del salario, Debe ser entre 1000 y 2500');
    END IF;
  ELSE
    MSJ_ERROR_DATE:=('Fecha de contratación incorrecta, debe ser mayor al 18-MAR-2021');
  END IF;
  
END;

/* FUNCIONES DE VALIDACIÓN
  * Validar con funciones DEPARTMENT_ID, JOB_ID y MANAGER_ID
  * Retornar un 1 si se encuentra y un 0 sino 
*/

CREATE OR REPLACE FUNCTION FN_VDEP_20171033802(ID_DEP DEPARTMENTS.DEPARTMENT_ID%TYPE, MSJ_ERROR_ID_DEP OUT VARCHAR2)
RETURN NUMBER
IS
  --- Variable para almacenar la cantidad de registros obtenidos 
  REG_DPT NUMBER;
BEGIN
  SELECT COUNT(*) INTO REG_DPT FROM DEPARTMENTS WHERE DEPARTMENT_ID = ID_DEP;
  IF(REG_DPT = 0) THEN
    MSJ_ERROR_ID_DEP:=('No se encontro el registro del departamento en la tabla DEPARTMENTS con el id: '||ID_DEP);
    RETURN 0;
  ELSE
    RETURN 1;
  END IF;
END;

CREATE OR REPLACE FUNCTION FN_VJOB_20171033802(ID_JOB JOBS.JOB_ID%TYPE, MSJ_ERROR_ID_JOB OUT VARCHAR2)
RETURN NUMBER
IS
  --- Variable para almacenar la cantidad de registros obtenidos 
  REG_JOB NUMBER;
BEGIN
  SELECT COUNT(*) INTO REG_JOB FROM JOBS WHERE JOB_ID = ID_JOB;
  IF(REG_JOB = 0) THEN
    MSJ_ERROR_ID_JOB:=('No se encontro el registro del trabajo en la tabla JOBS con el id: '||ID_JOB);
    RETURN 0;
  ELSE
    RETURN 1;
  END IF;
END;

CREATE OR REPLACE FUNCTION FN_VMAN_20171033802(ID_MAN EMPLOYEES.MANAGER_ID%TYPE, MSJ_ERROR_ID_MAN OUT VARCHAR2)
RETURN NUMBER
IS
  --- Variable para almacenar la cantidad de registros obtenidos 
  REG_MAN NUMBER;
BEGIN
  SELECT COUNT(*) INTO REG_MAN FROM EMPLOYEES WHERE EMPLOYEE_ID = ID_MAN;
  IF(REG_MAN = 0) THEN
    MSJ_ERROR_ID_MAN:=('No se encontro el registro del manager en la tabla EMPLOYEES con el id: '||ID_MAN);
    RETURN 0;
  ELSE
    RETURN 1;
  END IF;
END;

--- PROCEDIMIENTO ALMACENADO
--- Insersión en la tabla EMPLOYEES
CREATE OR REPLACE PROCEDURE SP_INST_EMP_20171033802(ID_EMPLOYEE EMPLOYEES.EMPLOYEE_ID%TYPE, FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE, LAST_NAME EMPLOYEES.LAST_NAME%TYPE, EMAIL EMPLOYEES.EMAIL%TYPE, PHONE_NUMBER EMPLOYEES.PHONE_NUMBER%TYPE, 
HIRE_DATE EMPLOYEES.HIRE_DATE%TYPE, JOB_ID EMPLOYEES.JOB_ID%TYPE, SALARY EMPLOYEES.SALARY%TYPE, COMMISSION_PCT EMPLOYEES.COMMISSION_PCT%TYPE, 
MANAGER_ID EMPLOYEES.MANAGER_ID%TYPE, DEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE, MSJ_SP_EMP OUT NUMBER, MSJ_ERROR_EMPLOYEE_INSERT OUT VARCHAR2)
IS
BEGIN
  INSERT INTO EMPLOYEES VALUES (ID_EMPLOYEE, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID);
  
  MSJ_SP_EMP:=1;
  EXCEPTION
    --- Control de cualquier error usando OTHERS informando sobre el error al bloque anonimo
    WHEN OTHERS THEN
      MSJ_ERROR_EMPLOYEE_INSERT:=('Se produjo un error al insertar en la tabla EMPLOYEES, el error es:'||SQLERRM);
END; 

--- Ejeción del procedimiento almacenado REG_EMP_20171033802 
DECLARE
  --- Variables para los mensajes de error
  MSJ_EXITO VARCHAR2(500);
  MSJ_ERROR_ID_DEP VARCHAR2(500);
  MSJ_ERROR_ID_JOB VARCHAR2(500);
  MSJ_ERROR_ID_MAN VARCHAR2(500);
  MSJ_ERROR_DATE VARCHAR2(500);
  MSJ_ERROR_SALARY VARCHAR2(500);
  MSJ_ERROR_EMPLOYEE_INSERT VARCHAR2(500);
  
BEGIN

  --- Insersión sin error
  REG_EMP_20171033802('Edgar', 'Benedetto', 'egar.benedetto@unah.hn', '504.9999.9999', '20-MAR-2021', 'AD_PRES', 2200, 0.15, 205, 90, 
  MSJ_EXITO, MSJ_ERROR_ID_DEP, MSJ_ERROR_ID_JOB, MSJ_ERROR_ID_MAN, MSJ_ERROR_DATE, MSJ_ERROR_SALARY, MSJ_ERROR_EMPLOYEE_INSERT);
  DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERROR_ID_DEP||' '||MSJ_ERROR_ID_JOB||' '||MSJ_ERROR_ID_MAN||' '||MSJ_ERROR_DATE||' '||MSJ_ERROR_SALARY||' '||MSJ_ERROR_EMPLOYEE_INSERT);
  --- Salto de linea 
  DBMS_OUTPUT.PUT_LINE(CHR(13));
  --- Insersines con cada tipo de error
  --- Insersión 1 error JOBS
  REG_EMP_20171033802('Edgar', 'Benedetto', 'egar.benedetto@unah.hn', '504.9999.9999', '20-MAR-2021', 'ASDF', 2200, 0.15, 205, 90, 
  MSJ_EXITO, MSJ_ERROR_ID_DEP, MSJ_ERROR_ID_JOB, MSJ_ERROR_ID_MAN, MSJ_ERROR_DATE, MSJ_ERROR_SALARY, MSJ_ERROR_EMPLOYEE_INSERT);
  
  DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERROR_ID_DEP||' '||MSJ_ERROR_ID_JOB||' '||MSJ_ERROR_ID_MAN||' '||MSJ_ERROR_DATE||' '||MSJ_ERROR_SALARY||' '||MSJ_ERROR_EMPLOYEE_INSERT);
  --- Salto de linea 
  DBMS_OUTPUT.PUT_LINE(CHR(13));
  
  --- Insersión 2 error DEPARTMENTS
  REG_EMP_20171033802('Edgar', 'Benedetto', 'egar.benedetto@unah.hn', '504.9999.9999', '20-MAR-2021', 'AD_PRES', 2200, 0.15, 205, 911, 
  MSJ_EXITO, MSJ_ERROR_ID_DEP, MSJ_ERROR_ID_JOB, MSJ_ERROR_ID_MAN, MSJ_ERROR_DATE, MSJ_ERROR_SALARY, MSJ_ERROR_EMPLOYEE_INSERT);
  
  DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERROR_ID_DEP||' '||MSJ_ERROR_ID_JOB||' '||MSJ_ERROR_ID_MAN||' '||MSJ_ERROR_DATE||' '||MSJ_ERROR_SALARY||' '||MSJ_ERROR_EMPLOYEE_INSERT);
  --- Salto de linea 
  DBMS_OUTPUT.PUT_LINE(CHR(13)); 
  
  --- Insersión 3 error MANAGER
  REG_EMP_20171033802('Edgar', 'Benedetto', 'egar.benedetto@unah.hn', '504.9999.9999', '20-MAR-2021', 'AD_PRES', 2200, 0.15, 265, 90, 
  MSJ_EXITO, MSJ_ERROR_ID_DEP, MSJ_ERROR_ID_JOB, MSJ_ERROR_ID_MAN, MSJ_ERROR_DATE, MSJ_ERROR_SALARY, MSJ_ERROR_EMPLOYEE_INSERT);
  
  DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERROR_ID_DEP||' '||MSJ_ERROR_ID_JOB||' '||MSJ_ERROR_ID_MAN||' '||MSJ_ERROR_DATE||' '||MSJ_ERROR_SALARY||' '||MSJ_ERROR_EMPLOYEE_INSERT);
  --- Salto de linea 
  DBMS_OUTPUT.PUT_LINE(CHR(13)); 
  
  --- Insersión 4 error Fecha Incorrecta
  REG_EMP_20171033802('Edgar', 'Benedetto', 'egar.benedetto@unah.hn', '504.9999.9999', '20-MAR-2020', 'AD_PRES', 2200, 0.15, 205, 90, 
  MSJ_EXITO, MSJ_ERROR_ID_DEP, MSJ_ERROR_ID_JOB, MSJ_ERROR_ID_MAN, MSJ_ERROR_DATE, MSJ_ERROR_SALARY, MSJ_ERROR_EMPLOYEE_INSERT);
  
  DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERROR_ID_DEP||' '||MSJ_ERROR_ID_JOB||' '||MSJ_ERROR_ID_MAN||' '||MSJ_ERROR_DATE||' '||MSJ_ERROR_SALARY||' '||MSJ_ERROR_EMPLOYEE_INSERT);
  --- Salto de linea 
  DBMS_OUTPUT.PUT_LINE(CHR(13));
  
  --- Insersión 5 error Salario fuera de rango
  REG_EMP_20171033802('Edgar', 'Benedetto', 'egar.benedetto@unah.hn', '504.9999.9999', '20-MAR-2021', 'AD_PRES', 2800, 0.15, 205, 90, 
  MSJ_EXITO, MSJ_ERROR_ID_DEP, MSJ_ERROR_ID_JOB, MSJ_ERROR_ID_MAN, MSJ_ERROR_DATE, MSJ_ERROR_SALARY, MSJ_ERROR_EMPLOYEE_INSERT);
  
  DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERROR_ID_DEP||' '||MSJ_ERROR_ID_JOB||' '||MSJ_ERROR_ID_MAN||' '||MSJ_ERROR_DATE||' '||MSJ_ERROR_SALARY||' '||MSJ_ERROR_EMPLOYEE_INSERT);
  --- Salto de linea 
  DBMS_OUTPUT.PUT_LINE(CHR(13));
END;

