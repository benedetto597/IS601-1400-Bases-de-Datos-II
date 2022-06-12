/*
  @author edgar.benedetto@unah.hn N.Cuenta 20171033802
  @date 23/03/2021
  @decription Tarea N3 BDII Secci�n 1400 I PAC 2021 
  @name_file Ejercicios 4-7.sql
  @version 1.0
  
  * Funciones, y procedimientos almacenados encapsulados en un paquete 
    para la realizaci�n de los ejercicios 4, 5, 6, y 7 de la Tarea N3 
  
  * La ejecuci�n de las funciones y procedimientos almacenados encapsulados en el 
    paquete se encuentra al final en bloques an�nimos
    
  * Ejercicios 
    4. Procedimiento almacenado para insertar registros en la tabla empleados,
      datos como parametros y con control de errores (COMMIT y ROLLBACK)
      
    5. Funci�n para obtener el mayor salario pagado en la empresa mas los datos 
      de los empleados que ganen dicho salario, retornar datos en un cursor meidante
      un parametro de salida
    
    6. Procedimiento almacenado que imprima de la funci�n anterior el nombre completo
      del empleado, el identificador, el salario y el id del departamento

    7.1 Procedimiento para insertar registros en las tablas locations y countries
      con control de errores (COMMIT y ROLLBACK)
      
    7.2 Funci�n para obtener los empleados que ganan entre 9000 y 20000, se debe
      retornar un varchar que diga "La cantidad de empleados con un salario 
      entre 9000 y 20000 es: x" 
      
    Habiltar impresi�n en pantalla
      ---> SET SERVEROUTPUT ON;

*/

CREATE OR REPLACE PACKAGE INF_EMPRESA_TAREA_N3
IS 
--- Prototipo de procedimientos almacenados
--- Procedimiento para controlar los errores al insertar registros en la tabla de empleados
  PROCEDURE SP_REG_EMPLOYEES(EMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE, FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE,
  LAST_NAME EMPLOYEES.LAST_NAME%TYPE, EMAIL EMPLOYEES.EMAIL%TYPE, PHONE_NUMBER EMPLOYEES.PHONE_NUMBER%TYPE, 
  HIRE_DATE EMPLOYEES.HIRE_DATE%TYPE, JOB_ID EMPLOYEES.JOB_ID%TYPE, SALARY EMPLOYEES.SALARY%TYPE, 
  COMMISSION_PCT EMPLOYEES.COMMISSION_PCT%TYPE, MANAGER_ID EMPLOYEES.MANAGER_ID%TYPE, DEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE,
  MSJ_EXITO OUT VARCHAR2, MSJ_ERROR OUT VARCHAR2);

--- Procedimiento para insertar registros en la tabla de empleados
  PROCEDURE SP_INSERT_EMPLOYEES(EMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE, FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE,
  LAST_NAME EMPLOYEES.LAST_NAME%TYPE, EMAIL EMPLOYEES.EMAIL%TYPE, PHONE_NUMBER EMPLOYEES.PHONE_NUMBER%TYPE, 
  HIRE_DATE EMPLOYEES.HIRE_DATE%TYPE, JOB_ID EMPLOYEES.JOB_ID%TYPE, SALARY EMPLOYEES.SALARY%TYPE, 
  COMMISSION_PCT EMPLOYEES.COMMISSION_PCT%TYPE, MANAGER_ID EMPLOYEES.MANAGER_ID%TYPE, DEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE,
  MSJ OUT NUMBER, MSJ_ERROR OUT VARCHAR2);

--- Prototipo de funcion
--- Funci�n que retorna el mayor salario
  FUNCTION FN_HIGHER_SALARY(CEMPLOYEE OUT SYS_REFCURSOR) RETURN NUMBER;
  
--- Procedimiento que imprime los campos solicitados del empleado
  PROCEDURE SP_SHOW_EMPLOYEE_HIGHER_SALARY;
  
--- Procedimiento para controlar errores al insertar datos en las tablas LOCATIONS y COUNTRIES
  PROCEDURE SP_REG_COUNTRY_LOCATION(COUNTRY_ID COUNTRIES.COUNTRY_ID%TYPE,COUNTRY_NAME COUNTRIES.COUNTRY_NAME%TYPE, REGION_ID COUNTRIES.REGION_ID%TYPE,
  LOCATION_ID LOCATIONS.LOCATION_ID%TYPE, STREET_ADDRESS LOCATIONS.STREET_ADDRESS%TYPE, POSTAL_CODE LOCATIONS.POSTAL_CODE%TYPE, CITY LOCATIONS.CITY%TYPE,
  STATE_PROVINCE LOCATIONS.STATE_PROVINCE%TYPE, MSJ_EXITO OUT VARCHAR2, MSJ_ERR_COUNTRIES OUT VARCHAR2, MSJ_ERR_LOCATIONS OUT VARCHAR2);
  
--- Procedimiento para insertar datos en la tabla COUNTRIES
  PROCEDURE SP_INSERT_COUNTRY(COUNTRY_ID COUNTRIES.COUNTRY_ID%TYPE,COUNTRY_NAME COUNTRIES.COUNTRY_NAME%TYPE, REGION_ID COUNTRIES.REGION_ID%TYPE, 
  MSJ_C OUT NUMBER, MSJ_ERR_COUNTRIES OUT VARCHAR2);
  
--- Procedimiento para insertar datos en la tabla LOCATIONS
  PROCEDURE SP_INSERT_LOCATION(LOCATION_ID LOCATIONS.LOCATION_ID%TYPE, STREET_ADDRESS LOCATIONS.STREET_ADDRESS%TYPE, POSTAL_CODE LOCATIONS.POSTAL_CODE%TYPE, 
  CITY LOCATIONS.CITY%TYPE, STATE_PROVINCE LOCATIONS.STATE_PROVINCE%TYPE, COUNTRY_ID COUNTRIES.COUNTRY_ID%TYPE, MSJ_L OUT NUMBER, MSJ_ERR_LOCATIONS OUT VARCHAR2);
  
--- Funci�n para obtener la cantidad de empleados que ganan entre entre 9000 y 20000
  FUNCTION FN_QUANTITY_EMP RETURN VARCHAR2;
END;

CREATE OR REPLACE PACKAGE BODY INF_EMPRESA_TAREA_N3
IS
  /* Ejercicio 4
    Soluci�n: Procedimiento de insersi�n aparte al de control de errores
      Encapsulaci�n del mensaje de error o exito
      MSJ = 0 significa SIN ERROR
      MSJ = 1 significa ERROR
  */
  PROCEDURE SP_REG_EMPLOYEES(EMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE, FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE,
  LAST_NAME EMPLOYEES.LAST_NAME%TYPE, EMAIL EMPLOYEES.EMAIL%TYPE, PHONE_NUMBER EMPLOYEES.PHONE_NUMBER%TYPE, 
  HIRE_DATE EMPLOYEES.HIRE_DATE%TYPE, JOB_ID EMPLOYEES.JOB_ID%TYPE, SALARY EMPLOYEES.SALARY%TYPE, 
  COMMISSION_PCT EMPLOYEES.COMMISSION_PCT%TYPE, MANAGER_ID EMPLOYEES.MANAGER_ID%TYPE, DEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE,
  MSJ_EXITO OUT VARCHAR2, MSJ_ERROR OUT VARCHAR2)
  IS
    --- Variable para detectar errores
    MSJ NUMBER;
  BEGIN
    SP_INSERT_EMPLOYEES(EMPLOYEE_ID, FIRST_NAME, LAST_NAME , EMAIL , PHONE_NUMBER, 
    HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID, MSJ, MSJ_ERROR);
    
    IF(MSJ=0) THEN
      --- Mensaje a mostrar de la operaci�n exitosa
      MSJ_EXITO:='La insersi�n en la tabla EMPLOYEES fue exitosa';
      --- Subir cambios
      COMMIT;
    ELSIF(MSJ=1) THEN
      --- Revertir los cambios 
      ROLLBACK;
    END IF;
  END;
  
  PROCEDURE SP_INSERT_EMPLOYEES(EMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE, FIRST_NAME EMPLOYEES.FIRST_NAME%TYPE,
  LAST_NAME EMPLOYEES.LAST_NAME%TYPE, EMAIL EMPLOYEES.EMAIL%TYPE, PHONE_NUMBER EMPLOYEES.PHONE_NUMBER%TYPE, 
  HIRE_DATE EMPLOYEES.HIRE_DATE%TYPE, JOB_ID EMPLOYEES.JOB_ID%TYPE, SALARY EMPLOYEES.SALARY%TYPE, 
  COMMISSION_PCT EMPLOYEES.COMMISSION_PCT%TYPE, MANAGER_ID EMPLOYEES.MANAGER_ID%TYPE, DEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE,
  MSJ OUT NUMBER, MSJ_ERROR OUT VARCHAR2)
  IS
  BEGIN
    --- Insersi�n de los campos
    INSERT INTO EMPLOYEES VALUES(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, 
    JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID);
    
    MSJ:=0;
    EXCEPTION
      WHEN OTHERS THEN
        MSJ:=1;
        MSJ_ERROR:=('Se produjo un error al insertar en la tabla EMPLOYEES: '||SQLERRM);

  END;
  
  /* Ejercicio 5
    Soluci�n: Usar la funci�n MAX para obtener el valor m�ximo de la taabla EMPLOYEE
      Usar cursor para obtener los datos del empleado
  */
  FUNCTION FN_HIGHER_SALARY(CEMPLOYEE OUT SYS_REFCURSOR) RETURN NUMBER
  IS
    --- Variable para almacenar el salario mayor
    HIGHER_PAY EMPLOYEES.SALARY%TYPE;
  BEGIN
    --- Consutlta para obtener el salario mayor almacenando el resultado en HIGHER_PAY
    SELECT MAX(SALARY)INTO HIGHER_PAY FROM EMPLOYEES;
    
    --- Apertura y llenado del cursor que almacena la informaci�n del empleado con el salario m�s alto
    OPEN CEMPLOYEE FOR SELECT * FROM EMPLOYEES WHERE SALARY = HIGHER_PAY;
    
    RETURN HIGHER_PAY;
  END;
  
   /* Ejercicio 6
    Soluci�n: Cursor para obtener los campos requeridos
      Usar cursor para obtener los datos del empleado
  */
  PROCEDURE SP_SHOW_EMPLOYEE_HIGHER_SALARY
  IS
    --- Variable que almacena el salario mayor
    SALARY EMPLOYEES.SALARY%TYPE;
    --- Variable tipo cursor para almacenar lo retornado por la funci�n FN_HIGHER_SALARY
    DATA_EMPLOYEE SYS_REFCURSOR;
    --- Variable que mapea la tabla EMPLOYEE para imprimir individualmente
    REG_EMPLOYEE EMPLOYEES%ROWTYPE;
  BEGIN
  
    SALARY:=FN_HIGHER_SALARY(DATA_EMPLOYEE);
    
    --- Impresi�n de datos
    LOOP 
      FETCH DATA_EMPLOYEE INTO REG_EMPLOYEE;
      EXIT WHEN DATA_EMPLOYEE%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('El nombre completo del empleado con el mayor salario es: '||REG_EMPLOYEE.FIRST_NAME||' '||REG_EMPLOYEE.LAST_NAME);
      DBMS_OUTPUT.PUT_LINE('El ID del empleado con el mayor salario es: '||REG_EMPLOYEE.EMPLOYEE_ID);
      --- Valor del salario obtenido de lo retornado por la funci�n FN_HIGHER_SALARY
      DBMS_OUTPUT.PUT_LINE('El salario del empleado con el mayor salario es: '||SALARY);
      DBMS_OUTPUT.PUT_LINE('El ID del departamento del empleado con el mayor salario es: '||REG_EMPLOYEE.DEPARTMENT_ID);
      DBMS_OUTPUT.PUT_LINE(CHR(13)); 
    END LOOP;  
  END;
  
   /* Ejercicio 7.1
    Soluci�n: Procedimientos aparte para realizar las insersiones en las tablas
      Control de errores para ambas insersiones por separado
      MSJ = 0 significa SIN ERROR
      MSJ = 1 significa ERROR
  */
  PROCEDURE SP_REG_COUNTRY_LOCATION(COUNTRY_ID COUNTRIES.COUNTRY_ID%TYPE,COUNTRY_NAME COUNTRIES.COUNTRY_NAME%TYPE, REGION_ID COUNTRIES.REGION_ID%TYPE,
    LOCATION_ID LOCATIONS.LOCATION_ID%TYPE, STREET_ADDRESS LOCATIONS.STREET_ADDRESS%TYPE, POSTAL_CODE LOCATIONS.POSTAL_CODE%TYPE, CITY LOCATIONS.CITY%TYPE,
    STATE_PROVINCE LOCATIONS.STATE_PROVINCE%TYPE, MSJ_EXITO OUT VARCHAR2, MSJ_ERR_COUNTRIES OUT VARCHAR2, MSJ_ERR_LOCATIONS OUT VARCHAR2)
  IS
   --- Variable para detectar errores
    MSJ_C NUMBER;
    MSJ_L NUMBER;
  BEGIN
    --- Llamado a procedimientos para insertar en las tablas COUNTRIES y LOCATIONS
    SP_INSERT_COUNTRY(COUNTRY_ID, COUNTRY_NAME, REGION_ID, MSJ_C, MSJ_ERR_COUNTRIES);
    SP_INSERT_LOCATION(LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID, MSJ_L, MSJ_ERR_LOCATIONS);
    
    IF(MSJ_C=0 AND MSJ_L=0) THEN
      --- Mensaje a mostrar de la operaci�n exitosa
      MSJ_EXITO:='La insersi�n en las tablas COUNTRIES y LOCATIONS fue exitosa';
      --- Subir cambios
      COMMIT;
    ELSIF(MSJ_C=1 OR MSJ_L=1) THEN
      --- Revertir los cambios 
      ROLLBACK;
    END IF;
  END;
  
  PROCEDURE SP_INSERT_COUNTRY(COUNTRY_ID COUNTRIES.COUNTRY_ID%TYPE, COUNTRY_NAME COUNTRIES.COUNTRY_NAME%TYPE, REGION_ID COUNTRIES.REGION_ID%TYPE, 
  MSJ_C OUT NUMBER, MSJ_ERR_COUNTRIES OUT VARCHAR2)
  IS
  
  BEGIN
     --- Insersi�n de los campos en la tabla COUNTRIES
    INSERT INTO COUNTRIES VALUES(COUNTRY_ID, COUNTRY_NAME, REGION_ID);
    
    MSJ_C:=0;
    EXCEPTION
      WHEN OTHERS THEN
        MSJ_C:=1;
        MSJ_ERR_COUNTRIES:=('Se produjo un error al insertar en la tabla COUNTRIES el error es: '||SQLERRM);

  END;
  
  PROCEDURE SP_INSERT_LOCATION(LOCATION_ID LOCATIONS.LOCATION_ID%TYPE, STREET_ADDRESS LOCATIONS.STREET_ADDRESS%TYPE, POSTAL_CODE LOCATIONS.POSTAL_CODE%TYPE, 
  CITY LOCATIONS.CITY%TYPE, STATE_PROVINCE LOCATIONS.STATE_PROVINCE%TYPE, COUNTRY_ID COUNTRIES.COUNTRY_ID%TYPE, MSJ_L OUT NUMBER, MSJ_ERR_LOCATIONS OUT VARCHAR2)
  IS
  
  BEGIN
     --- Insersi�n de los campos en la tabla LOCATIONS
    INSERT INTO LOCATIONS VALUES(LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID);
    
    MSJ_L:=0;
    EXCEPTION
      WHEN OTHERS THEN
        MSJ_L:=1;
        MSJ_ERR_LOCATIONS:=('Se produjo un error al insertar en la tabla LOCATIONS el error es: '||SQLERRM);
  END;
  
  /* Ejercicio 7.2
    Soluci�n: Retornar un VARCHAR2
      Uso de BETWEEN dentro de la condici�n en el SELECT para obtener la cantidad
      los empleados que ganan entre 9000 y 20000
  */
  FUNCTION FN_QUANTITY_EMP RETURN VARCHAR2
  IS 
    --- Variable para almacenar la cantidad de empleados con salario entre 9k y 20k
    QUANTITY NUMBER;
    
    --- Variable con el texto a retornar
    MSJ VARCHAR2(500);
  BEGIN
    SELECT COUNT(*) INTO QUANTITY FROM EMPLOYEES WHERE SALARY BETWEEN 9000 AND 20000;
    
    MSJ:=CONCAT('La cantidad de empleados con un salario entre 9000 y 20000 es: ', QUANTITY);
    RETURN MSJ;
  END;
--- Fin del paquete
END;


/* Ejecuci�n del paquete con bloque an�nimo
    1. Llamado al procedimiento almacenado SP_REG_EMPLOYEES que a su vez realiza la ejecuci�n 
      del procedimiento SP_INSERT_EMPLOYEES para insertar en la tabla EMPLOYEES
    2. Llamado al procedimiento almacenado SP_SHOW_EMPLOYEE_HIGHER_SALARY que a su vez realiza 
      la ejecuci�n de la funci�n FN_HIGHER_SALARY para imprimir los datos del empleado con 
      el mayor salario
    3. Llamado al procedimiento almacenado SP_REG_COUNTRY_LOCATION que su vez realiza la ejecuci�n
      de los procedimientos almacenados encargados de realizar las insersiones en las tablas 
      COUNTRIES y LOCATIONS
    4. Llamado a la funci�n FN_QUANTITY_EMP para obtener la cantidad de empleados que tienen un 
      salario entre 9000 y 20000
*/

DECLARE
   MSJ_EXITO VARCHAR2(500);
   MSJ_ERROR VARCHAR2(500);
BEGIN
  --- Insersi�n Con error
  INF_EMPRESA_TAREA_N3.SP_REG_EMPLOYEES(205,'Edgar', 'Benedetto', 'edgar.benedetto@unah.hn', '504.9999.9999', '23-JUN-2021', 
  'SA_REP', 24000, 0.5, 124, 80, MSJ_EXITO, MSJ_ERROR);
  DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERROR);
  
  --- Salto de l�nea 
  DBMS_OUTPUT.PUT_LINE(CHR(13)); 
  
  --- Insersi�n Sin error
  INF_EMPRESA_TAREA_N3.SP_REG_EMPLOYEES(255,'Edgar', 'Benedetto', 'edgar.benedetto@unah.hn', '504.9999.9999', '23-JUN-2021', 
  'SA_REP', 24000, 0.5, 124, 80, MSJ_EXITO, MSJ_ERROR);
  DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERROR);
END;

BEGIN
  INF_EMPRESA_TAREA_N3.SP_SHOW_EMPLOYEE_HIGHER_SALARY;
END;

DECLARE
  MSJ_EXITO VARCHAR2(500);
  MSJ_ERR_COUNTRIES VARCHAR2(500);
  MSJ_ERR_LOCATIONS VARCHAR2(500);
BEGIN
  --- Insersi�n sin error
  INF_EMPRESA_TAREA_N3.SP_REG_COUNTRY_LOCATION('HN', 'Honduras', 2, 1900, 'Colonia Tiloarque, Segunda etapa' , 10111, 'Tegucigalpa', 'Francisco Moraz�n', 
  MSJ_EXITO , MSJ_ERR_COUNTRIES , MSJ_ERR_LOCATIONS);
  DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERR_COUNTRIES||' '||MSJ_ERR_LOCATIONS);
  
  --- Insersi�n con error 
  INF_EMPRESA_TAREA_N3.SP_REG_COUNTRY_LOCATION('HN', 'Honduras', 2, 2400, 'Colonia Tiloarque, Segunda etapa' , 10111, 'Tegucigalpa', 'Francisco Moraz�n', 
  MSJ_EXITO , MSJ_ERR_COUNTRIES , MSJ_ERR_LOCATIONS);
  DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERR_COUNTRIES||' '||MSJ_ERR_LOCATIONS);
END;

DECLARE
  EMPLOYEES_QUANTITY VARCHAR(500);
BEGIN
  EMPLOYEES_QUANTITY:=INF_EMPRESA_TAREA_N3.FN_QUANTITY_EMP;
  DBMS_OUTPUT.PUT_LINE(EMPLOYEES_QUANTITY);
END;
