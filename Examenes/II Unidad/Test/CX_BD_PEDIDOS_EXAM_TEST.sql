/*
  @author edgar.benedetto@unah.hn N.Cuenta 20171033802
  @date 26/03/2021
  @decription TEST EXAMENS BDII SecciOn 1400 I PAC 2021 
  @name_file TEST_EXAM.sql
  @version 1.0
  
  1) Crear un procedimiento almacenado que se encargue de insertar nuevas órdenes, el
  SP debe recibir como parámetro los valores a insertar (excepto los valores de las llaves
  primarias). Dentro del cuerpo del SP se debe validar que el cliente y el empleado existan
  para así insertar la nueva orden, para validar esto, se debe crear una función para 
  verificar el cliente y otra función para verificar el empleado. Ambas funciones deben
  retornar un valor de 1 si el cliente o empleado existen y un 0 si no existen. El SP también
  debe validar que la fecha de la nueva orden sea mayor o igual al 1 de enero de 2021. El
  SP debe insertar cuáles son los productos que pertenecen a la orden y se debe verificar
  que los productos existan, esta verificación se debe realizar mediante una función que
  haga la validación y también retornará un 1 o 0, respectivamente a si existe o no existe el
  producto. Con un producto que se agregue a la orden es suficiente. La nueva orden se
  debe insertar solamente si se cumple la condición de la fecha, que el cliente, el empleado
  y los productos existan. De lo contrario el SP debe retornar un mensaje que indique cuál
  condición no se cumple. El SP debe aprobar los cambios realizados y en caso de
  cualquier error entonces el SP debe retornar un mensaje que diga que sucedió un error y
  además deshacer los cambios realizados. Para el valor de la llave primaria en las tablas a
  insertar, se debe de verificar cuál es el último valor guardado y sumarle una unidad, esto
  se debe realizar mediante una consulta que obtenga el último valor y luego sumarle la
  cantidad indicada. Para probar el SP se debe realizar mediante un bloque anónimo.
  
  * Campos como parametro EMPLEADOID, CLIENTEID, FECHAORDEN, DESCUENTO, PROVEEDORID, CATEGORIAID, DESCRIPCION, PRECIOUNIT, EXISTENCIA
  * Validar ID_CLIENTE, ID_EMPLEADO y ID_PRODUCTO existan con funciones que retornen un NUMBER (1)
  * Validar que la fecha de la nueva orden sea mayor o igual al 1 de enero de 2021
  * Verificar cuál es el último valor guardado y sumarle una unidad, esto se debe realizar mediante una consulta que obtenga el último valor y luego sumarle la cantidad indicada
  * Control de errores mandando mensajes de exito y error en cada función de comprobación 
*/

CREATE OR REPLACE PROCEDURE REG_ORDER_PRODUCT (EMPLEADOID ORDENES.EMPLEADOID%TYPE, CLIENTE_ID ORDENES.CLIENTEID%TYPE, FECHAORDEN ORDENES.FECHAORDEN%TYPE, 
DESCUENTO ORDENES.DESCUENTO%TYPE, PROVEEDORID PRODUCTOS.PROVEEDORID%TYPE, CATEGORIAID PRODUCTOS.CATEGORIAID%TYPE, DESCRIPCION PRODUCTOS.DESCRIPCION%TYPE, 
PRECIOUNIT PRODUCTOS.PRECIOUNIT%TYPE, EXISTENCIA  PRODUCTOS.EXISTENCIA%TYPE, MSJ_EXITO OUT VARCHAR2, MSJ_ERROR_ID_CLIENTE OUT VARCHAR2, MSJ_ERROR_ID_EMPLEADO OUT VARCHAR2,
MSJ_ERROR_ID_PRODUCT OUT VARCHAR2, MSJ_ERROR_DATE OUT VARCHAR2, MSJ_ERROR_ORDER_INSERT OUT VARCHAR2, MSJ_ERROR_PRODUCTS_INSERT OUT VARCHAR2)
IS 
  --- Variables para el control de errores en las funciones
  MSJ_FN_C NUMBER;
  MSJ_FN_E NUMBER;
  MSJ_FN_P NUMBER;
  
  --- Variables para el control de errores en los procedimientos
  MSJ_P NUMBER;
  MSJ_O NUMBER;
  
  --- Variable para controlar identificador primario
  ID_ORDER ORDENES.ORDENID%TYPE;
  ID_PRODUCT PRODUCTOS.PRODUCTOID%TYPE;
BEGIN
  
  MSJ_FN_C:=FN_VALIDATE_CLIENT(CLIENTE_ID, MSJ_ERROR_ID_CLIENTE);
  MSJ_FN_E:=FN_VALIDATE_EMPLOYEE(EMPLEADOID, MSJ_ERROR_ID_EMPLEADO);  
  
  IF (FECHAORDEN > '01-JAN-2021' AND MSJ_FN_C=1 AND MSJ_FN_E=1) THEN
    SELECT (MAX(PRODUCTOID)+1) INTO ID_PRODUCT FROM PRODUCTOS;
    SP_INSERT_PRODUCT(ID_PRODUCT, PROVEEDORID, CATEGORIAID, DESCRIPCION, PRECIOUNIT, EXISTENCIA, MSJ_P, MSJ_ERROR_PRODUCTS_INSERT);
    MSJ_FN_P:=FN_VALIDATE_PRODUCT(ID_PRODUCT, MSJ_ERROR_ID_PRODUCT);
    
    IF(MSJ_FN_P = 1) THEN
      SELECT (MAX(ORDENID)+1) INTO ID_ORDER FROM ORDENES;
      SP_INSERT_ORDER(ID_ORDER, EMPLEADOID, CLIENTE_ID , FECHAORDEN, DESCUENTO, MSJ_O, MSJ_ERROR_ORDER_INSERT);
      MSJ_EXITO:=('La insersión en la tabla ORDENES y PRODUCTOS fue exitosa');
    END IF;
  ELSE
    MSJ_ERROR_DATE:=('Fecha incorrecta, debe ser mayor a 01-JAN-2021');
  END IF;
  
  EXCEPTION 
    WHEN OTHERS THEN
      ROLLBACK;
END;

/*
  * Validar con funciones ID_CLIENTE, ID_EMPLEADO
  * Utilizando SELECT COUNT(*) INTO var_return FROM BRANDS WHERE ID_CLIENTE = ID_CLIENTE;
*/

CREATE OR REPLACE FUNCTION FN_VALIDATE_CLIENT(CLIENTE_ID ORDENES.CLIENTEID%TYPE, MSJ_ERROR_ID_CLIENTE OUT VARCHAR2)
RETURN NUMBER
IS
  REG_CLIENT NUMBER;
BEGIN
  SELECT COUNT(*) INTO REG_CLIENT FROM CLIENTES WHERE CLIENTEID = CLIENTE_ID;
  IF(REG_CLIENT = 0) THEN
    MSJ_ERROR_ID_CLIENTE:=('No se encontro el registro del cliente en la tabla CLIENTES con el id: '||CLIENTE_ID);
  END IF;
  RETURN REG_CLIENT;
END;

CREATE OR REPLACE FUNCTION FN_VALIDATE_EMPLOYEE(EMPLEADOID ORDENES.EMPLEADOID%TYPE, MSJ_ERROR_ID_EMPLEADO OUT VARCHAR2)
RETURN NUMBER
IS
  REG_EMPLOYEE NUMBER;
BEGIN
  SELECT COUNT(*) INTO REG_EMPLOYEE FROM EMPLEADOS WHERE EMPLEADOID = EMPLEADOID;
  IF(REG_EMPLOYEE = 0) THEN
    MSJ_ERROR_ID_EMPLEADO:=('No se encontro el registro del empleado en la tabla EMPLEADOS con el id: '||EMPLEADOID);
  END IF;
  RETURN REG_EMPLOYEE;
END;

CREATE OR REPLACE FUNCTION FN_VALIDATE_PRODUCT(ID_PRODUCT PRODUCTOS.PRODUCTOID%TYPE, MSJ_ERROR_ID_PRODUCT OUT VARCHAR2)
RETURN NUMBER
IS
  REG_PRODUCT NUMBER;
BEGIN
  SELECT COUNT(*) INTO REG_PRODUCT FROM PRODUCTOS WHERE PRODUCTOID = ID_PRODUCT;
  IF(REG_PRODUCT = 0) THEN
    MSJ_ERROR_ID_PRODUCT:=('No se encontro el registro del producto en la tabla PRODUCTO con el id: '||ID_PRODUCT);
  END IF;
  RETURN REG_PRODUCT;
END;

--- Procedimientos almacenados
CREATE OR REPLACE PROCEDURE SP_INSERT_PRODUCT(ID_PRODUCT PRODUCTOS.PRODUCTOID%TYPE, PROVEEDORID PRODUCTOS.PROVEEDORID%TYPE, CATEGORIAID PRODUCTOS.CATEGORIAID%TYPE, 
DESCRIPCION PRODUCTOS.DESCRIPCION%TYPE, PRECIOUNIT PRODUCTOS.PRECIOUNIT%TYPE, EXISTENCIA PRODUCTOS.EXISTENCIA%TYPE, MSJ_P OUT NUMBER, MSJ_ERROR_PRODUCTS_INSERT OUT VARCHAR2)
IS
BEGIN
  INSERT INTO PRODUCTOS VALUES (ID_PRODUCT, PROVEEDORID, CATEGORIAID, DESCRIPCION, PRECIOUNIT, EXISTENCIA);
  
  MSJ_P:=1;
  EXCEPTION
    --- Control de cualquier error usando OTHERS informando sobre el error al bloque anonimo
    WHEN OTHERS THEN
      MSJ_ERROR_PRODUCTS_INSERT:=('Se produjo un error al insertar en la tabla PRODUCTOS, el error es:'||SQLERRM);
END; 


CREATE OR REPLACE PROCEDURE SP_INSERT_ORDER(ID_ORDER ORDENES.ORDENID%TYPE,EMPLEADOID ORDENES.EMPLEADOID%TYPE, CLIENTE_ID ORDENES.CLIENTEID%TYPE, FECHAORDEN ORDENES.FECHAORDEN%TYPE, 
DESCUENTO ORDENES.DESCUENTO%TYPE, MSJ_O OUT NUMBER, MSJ_ERROR_ORDER_INSERT OUT VARCHAR2)
IS
BEGIN
  INSERT INTO ORDENES VALUES (ID_ORDER, EMPLEADOID, CLIENTE_ID , FECHAORDEN, DESCUENTO);
  
  MSJ_O:=1;
  EXCEPTION
    --- Control de cualquier error usando OTHERS informando sobre el error al bloque anonimo
    WHEN OTHERS THEN
      MSJ_ERROR_ORDER_INSERT:=('Se produjo un error al insertar en la tabla ORDENES, el error es:'||SQLERRM);
END;   

--- Ejeción del procedimiento almacenado REG_ORDER_PRODUCT
DECLARE

  MSJ_EXITO VARCHAR2(500);
  MSJ_ERROR_ID_CLIENTE VARCHAR2(500);
  MSJ_ERROR_ID_EMPLEADO VARCHAR2(500);
  MSJ_ERROR_ID_PRODUCT VARCHAR2(500);
  MSJ_ERROR_DATE VARCHAR2(500);
  MSJ_ERROR_ORDER_INSERT VARCHAR2(500);
  MSJ_ERROR_PRODUCTS_INSERT VARCHAR2(500);
  
BEGIN
  /*REG_ORDER_PRODUCT(4, 4, '04-JUN-2021', 5, 40, 400, 'Limpieza de ventanas', 
  18.7, 50, MSJ_EXITO, MSJ_ERROR_ID_CLIENTE, MSJ_ERROR_ID_EMPLEADO, MSJ_ERROR_ID_PRODUCT, MSJ_ERROR_DATE,
  MSJ_ERROR_ORDER_INSERT, MSJ_ERROR_PRODUCTS_INSERT);*/
  
  REG_ORDER_PRODUCT(9, 4, '04-JUN-2021', 5, 40, 400, 'Limpieza de ventanas', 
  18.7, 50, MSJ_EXITO, MSJ_ERROR_ID_CLIENTE, MSJ_ERROR_ID_EMPLEADO, MSJ_ERROR_ID_PRODUCT, MSJ_ERROR_DATE,
  MSJ_ERROR_ORDER_INSERT, MSJ_ERROR_PRODUCTS_INSERT);
  
  DBMS_OUTPUT.PUT_LINE(MSJ_EXITO||' '||MSJ_ERROR_ID_CLIENTE||' '||MSJ_ERROR_ID_EMPLEADO||' '||MSJ_ERROR_ID_PRODUCT||' '||MSJ_ERROR_DATE||' '||MSJ_ERROR_ORDER_INSERT||' '||MSJ_ERROR_PRODUCTS_INSERT);

END;





























