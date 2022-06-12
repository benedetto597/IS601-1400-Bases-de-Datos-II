/*
  @author edgar.benedetto@unah.hn N.Cuenta 20171033802
  @date 23/03/2021
  @decription Tarea N3 BDII Sección 1400 I PAC 2021 
  @name_file Ejercicios 1-3.sql
  @version 1.0
  
  * Funciones, y procedimientos almacenados encapsulados en un paquete 
    para la realización de los ejercicios 1, 2, y 3 de la Tarea N3 
  
  * La ejecución de las funciones y procedimientos almacenados encapsulados en el 
    paquete se encuentra al final en bloques anónimos
    
  * Ejercicios 
    1. Función que obtenga los productos incluidos en una orden, retornar de un
      cursor, campos a obtener ORDER_ID, PRODUCT_ID, PRODUCT_NAME, ORDER_TOTAL y 
      ORDER_TIMESTAMP
      
    2. Procedimiento almacenado para imprimir lo que devuelve la función
    
    3. Procedimiento almacenado que asigna valor de 300 a usuarios sin QUOTA, 
      dar anuncio de exito y fracaso control de errores, QUOTA es parametro
      
    Habiltar impresión en pantalla
      ---> SET SERVEROUTPUT ON;

*/
CREATE OR REPLACE PACKAGE PK_INF_VENTA_TAREA_N3
 IS
 
--- Prototipo de funcion
  FUNCTION FN_PRODUCT_ORDER RETURN SYS_REFCURSOR;
  
--- Prototipo de procedimientos almacenados
--- Procedimiento para mostrar los productos obtenidos en la función FN_PRODUCT_ORDER
  PROCEDURE SP_SHOW_PRODUCT_ORDER;

--- Procedimiento para admitir (COMMIT) o denegar (ROLLBACK) la actualización del campo QUOTA en la tabla USERS
  PROCEDURE SP_UPDATE_USER_QUOTA(QUOTA_QUANTITY NUMBER, MSJ_EXITO OUT VARCHAR2, MSJ_ERROR OUT VARCHAR2);
  
--- Procedimiento para actualizar el campo QUOTA de los usuarios que no poseans
  PROCEDURE SP_UPDATE_QUOTA(QUOTA_QUANTITY NUMBER, MSJ OUT NUMBER, MSJ_ERROR OUT VARCHAR2);

 END;


CREATE OR REPLACE PACKAGE BODY PK_INF_VENTA_TAREA_N3
IS
  /* Ejercicio 1
    Solución: Relacionar las siguientes tablas utilizando INNER JOIN
      ---> PRODUCT con la tabla de ORDER_ITEMS
      ---> ORDER_ITEMS con ORDERS
  */
  FUNCTION FN_PRODUCT_ORDER
  --- SYS_REFCURSOR retorna el cursor
  RETURN SYS_REFCURSOR
  IS 
    CPRODUCTS SYS_REFCURSOR;
  BEGIN
  --- Apertura del cursor y asignación de consulta
    OPEN CPRODUCTS FOR SELECT DEMO_PRODUCT_INFO.PRODUCT_ID, DEMO_PRODUCT_INFO.PRODUCT_NAME,
      DEMO_ORDERS.ORDER_ID, DEMO_ORDERS.ORDER_TOTAL, DEMO_ORDERS.ORDER_TIMESTAMP 
    FROM DEMO_PRODUCT_INFO 
    INNER JOIN
      DEMO_ORDER_ITEMS ON DEMO_PRODUCT_INFO.PRODUCT_ID = DEMO_ORDER_ITEMS.PRODUCT_ID
    INNER JOIN 
      DEMO_ORDERS ON DEMO_ORDER_ITEMS.ORDER_ID = DEMO_ORDERS.ORDER_ID;
    
    --- Retornar cursor
    RETURN CPRODUCTS;
  END;
  
  /* Ejercicio 2
    Solución: Uso de estructura tipo record para almacenar lo que el cursor retorna
      Uso de ciclo while para el recorrido de los registros del cursor
  */
  
  PROCEDURE SP_SHOW_PRODUCT_ORDER
  IS
    --- Variable tipo CURSOR
    CSHOW_PRODUCTS SYS_REFCURSOR;
  
    --- Variable tipo RECORD
    TYPE FILA IS RECORD(
      PRODUCT_ID DEMO_PRODUCT_INFO.PRODUCT_ID%TYPE,
      PRODUCT_NAME DEMO_PRODUCT_INFO.PRODUCT_NAME%TYPE,
      ORDER_ID DEMO_ORDERS.ORDER_ID%TYPE,
      ORDER_TOTAL DEMO_ORDERS.ORDER_TOTAL%TYPE,
      ORDER_TIMESTAMP DEMO_ORDERS.ORDER_TIMESTAMP%TYPE
    );
  
    --- Variable tipo FILA
    PRODUCT_ORDER FILA;
    
  BEGIN
    --- Apertura de cursor
    CSHOW_PRODUCTS:=FN_PRODUCT_ORDER;
    FETCH CSHOW_PRODUCTS INTO PRODUCT_ORDER; 
    
    WHILE (CSHOW_PRODUCTS%FOUND)LOOP 
    
      DBMS_OUTPUT.PUT_LINE('El identificador del producto es: '||PRODUCT_ORDER.PRODUCT_ID);
      DBMS_OUTPUT.PUT_LINE('El nombre del producto es: '||PRODUCT_ORDER.PRODUCT_NAME);
      DBMS_OUTPUT.PUT_LINE('El identificador de la orden es: '||PRODUCT_ORDER.ORDER_ID);
      DBMS_OUTPUT.PUT_LINE('El total de la orden es: '||PRODUCT_ORDER.ORDER_TOTAL);
      DBMS_OUTPUT.PUT_LINE('La fecha de la orden es: '||PRODUCT_ORDER.ORDER_TIMESTAMP);
      
      --- Salto de linea 
      DBMS_OUTPUT.PUT_LINE(CHR(13));
    FETCH CSHOW_PRODUCTS INTO PRODUCT_ORDER; 
  
    END LOOP;
    --- Cierre de cursor
    CLOSE CSHOW_PRODUCTS;
    END;
    
    /* Ejercicio 3
    Solución: Realizar un UPDATE a los usuarios que no tienen QUOTA
      Control de errores COMMIT y ROLLBACK 
      Usar procedimiento aparte para el UPDATE al usuario
      MSJ = 0 significa SIN ERROR
      MSJ = 1 significa ERROR
    */
    
    PROCEDURE SP_UPDATE_USER_QUOTA(QUOTA_QUANTITY NUMBER, MSJ_EXITO OUT VARCHAR2, MSJ_ERROR OUT VARCHAR2)
    IS
      MSJ NUMBER;
    BEGIN
      SP_UPDATE_QUOTA(QUOTA_QUANTITY,  MSJ, MSJ_ERROR);
      --- Verificación de la realización exitosa o erronea
      IF(MSJ=0) THEN
        MSJ_EXITO:='La actualización del campo QUOTA fue exitosa';
      --- Subir cambios si se realizo con éxito
        COMMIT;
      ELSIF(MSJ=1) THEN
      --- Ejecutar el ROLLBACK si ha ocurrido algún error
        ROLLBACK; 
      END IF;
    END;
    
    --- Procedimiento para realizar el UPDATE en el campo QUOTA
    PROCEDURE SP_UPDATE_QUOTA(QUOTA_QUANTITY NUMBER, MSJ OUT NUMBER, MSJ_ERROR OUT VARCHAR2)
    IS
      CUSER_IDS SYS_REFCURSOR;
      ID_USER NUMBER;
    BEGIN
      --- Consulta para obtener el USER_ID de los usuarios sin QUOTA
      OPEN CUSER_IDS FOR SELECT USER_ID FROM DEMO_USERS WHERE QUOTA IS NULL ;

      --- Recorrer todos los usuarios sin QUOTA
      LOOP 
          FETCH CUSER_IDS INTO ID_USER;
          EXIT WHEN CUSER_IDS%NOTFOUND;
          UPDATE DEMO_USERS SET QUOTA = QUOTA_QUANTITY WHERE USER_ID =  ID_USER;
      END LOOP;
      
      --- Control de errores
      MSJ:=0;
      EXCEPTION 
        WHEN OTHERS THEN
          MSJ:=1;
          MSJ_ERROR:=('Se produjo un error al actualizar el campo QUOTA: '||SQLERRM);
     END;
--- Fin de paquete
END;

/* Ejecución del paquete con bloque anónimo
    1. Llamado al procedimiento almacenado SP_SHOW_PRODUCT_ORDER que a su vez realiza la ejecución de la función
    2. Llamado al procedimiento almacenado SP_UPDATE_USER_QUOTA que posee control de errores
*/

 BEGIN
  PK_INF_VENTA_TAREA_N3.SP_SHOW_PRODUCT_ORDER;
 END;
 
 
 DECLARE
   MSJ_EXITO VARCHAR2(500);
   MSJ_ERROR VARCHAR2(500);
 BEGIN
  PK_INF_VENTA_TAREA_N3.SP_UPDATE_USER_QUOTA(300, MSJ_EXITO, MSJ_ERROR);
  DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERROR);
 END;
 
--- UPDATE DEMO_USERS SET QUOTA = NULL WHERE USER_ID =  3;
