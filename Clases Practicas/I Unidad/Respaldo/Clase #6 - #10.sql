/*
  @author edgar.benedetto@unah.hn
  @date 14/02/2021
  @version 1.0
  
  CLASE #7.1 Y #7.2
*/
DECLARE 
  VAR_CAPITAL VARCHAR(255);
  NUM_CAPITAL_ID CAPITALES.ID%TYPE;
  VAR_PAIS PAISES.NOMBRE%TYPE;
  NUM_PAIS_ID PAISES.ID%TYPE;
  NUM_POBLACION POBLACIONES.POBLACION%TYPE;
  
  --- Clase #8.1
  NUM_ITERACION NUMBER(10);
BEGIN 

  SELECT NOMBRE, ID INTO VAR_CAPITAL, NUM_CAPITAL_ID FROM CAPITALES WHERE ID=2;
  SELECT NOMBRE,ID INTO VAR_PAIS, NUM_PAIS_ID FROM PAISES WHERE CAPITAL = NUM_CAPITAL_ID;
  SELECT POBLACION INTO NUM_POBLACION FROM POBLACIONES WHERE PAIS = NUM_PAIS_ID AND ANYO = 2006;

  
  DBMS_OUTPUT.PUT_LINE('EL NOMBRE DE LA CAPITAL CON ID=2 ES: '||VAR_CAPITAL);
  DBMS_OUTPUT.PUT_LINE('EL NOMBRE DEL PAIS ES: '||VAR_PAIS);
  DBMS_OUTPUT.PUT_LINE('LA POBLACION EN EL 2006 ERA DE: '||NUM_POBLACION);
  
  --- Clase #8.1
  DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE REGISTROS ES: '||SQL%ROWCOUNT);
  
   
END;

--- SET SERVEROUTPUT ON;

--- Clase #8.1 

DECLARE 
   NUM_POBLACION POBLACIONES.POBLACION%TYPE;
   CURSOR CUR_POBLACION IS SELECT POBLACION FROM POBLACIONES; 
BEGIN
  OPEN CUR_POBLACION;
  
  LOOP 
    FETCH CUR_POBLACION INTO NUM_POBLACION;
    
    EXIT WHEN CUR_POBLACION%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE('LA POBLACION ES: '||NUM_POBLACION);
    DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE REGISTROS ES: '||CUR_POBLACION%ROWCOUNT);
  END LOOP;
  
  CLOSE CUR_POBLACION;
END;

--- Clase #8.2
--- Obtener datos a un cursor de distintas tablas

DECLARE 
   --- NOMBRE_PRODUCTO PRODUCTS.PRODUCT_NAME%TYPE;
   --- MODELO_PRODUCTO PRODUCTS.MODEL_YEAR%TYPE;
   --- NOMBRE_CATEGORIA CATEGORIES.CATEGORY_NAME%TYPE;
   CURSOR CDATOS_PRODUCTO IS SELECT PRODUCTS.PRODUCT_NAME, CATEGORIES.CATEGORY_NAME, PRODUCTS.MODEL_YEAR,
   CATEGORIES.CATEGORY_ID CAT_ID, PRODUCTS.CATEGORY_ID PROD_CAT_ID FROM PRODUCTS INNER JOIN CATEGORIES ON PRODUCTS.CATEGORY_ID = CATEGORIES.CATEGORY_ID;
   
   --- Uniendo las 3 variables en una sola
   REGISTRO CDATOS_PRODUCTO%ROWTYPE;
   
BEGIN
  OPEN CDATOS_PRODUCTO;
  
  LOOP 
    FETCH  CDATOS_PRODUCTO INTO REGISTRO; ---NOMBRE_PRODUCTO, NOMBRE_CATEGORIA, MODELO_PRODUCTO;
    
    EXIT WHEN CDATOS_PRODUCTO%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE('EL NOMBRE DEL PRODUCTO ES: '||REGISTRO.PRODUCT_NAME);
    DBMS_OUTPUT.PUT_LINE('EL MODELO DEL PRODUCTO ES DEL: '||REGISTRO.MODEL_YEAR);
    DBMS_OUTPUT.PUT_LINE('EL NOMBRE DE LA CATEGORIA DEL PRODUCTO ES: '||REGISTRO.CATEGORY_NAME);
    DBMS_OUTPUT.PUT_LINE('EL ID DE LA CATEGORIA DEL PRODUCTO ES: '||REGISTRO.CAT_ID);
    DBMS_OUTPUT.PUT_LINE('EL ID DE LA CATEGORIA DEL PRODUCTO ES: '||REGISTRO.PROD_CAT_ID);
    DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE REGISTROS ES: '||CDATOS_PRODUCTO%ROWCOUNT);
    
    --- Salto de linea 
    DBMS_OUTPUT.PUT_LINE(CHR(13));
  END LOOP;
  
  CLOSE CDATOS_PRODUCTO;  
END;

--- Clase #8.3
--- Crear estructura tipo record para almacenar registros que devuelve un cursor

DECLARE 
   --- Variable tipo RECORD
   TYPE FILA IS RECORD(
     NOMBRE_PRODUCTO PRODUCTS.PRODUCT_NAME%TYPE,
     NOMBRE_CATEGORIA CATEGORIES.CATEGORY_NAME%TYPE,
     ANIO_MODELO NUMBER,
     COD_CATEGORIA NUMBER
   );
   
   CURSOR CDATOS_PRODUCTO IS SELECT PRODUCTS.PRODUCT_NAME, CATEGORIES.CATEGORY_NAME, PRODUCTS.MODEL_YEAR,
   CATEGORIES.CATEGORY_ID CAT_ID FROM PRODUCTS INNER JOIN CATEGORIES ON PRODUCTS.CATEGORY_ID = CATEGORIES.CATEGORY_ID;
   
   --- Variable tipo Fila la cual es tipo record ---> DATOS_CURSOR es tipo RECORD
   DATOS_CURSOR FILA;
   
BEGIN
  OPEN CDATOS_PRODUCTO;
  
  LOOP 
    FETCH  CDATOS_PRODUCTO INTO DATOS_CURSOR;
    
    DBMS_OUTPUT.PUT_LINE('EL NOMBRE DEL PRODUCTO ES: '||DATOS_CURSOR.NOMBRE_PRODUCTO);
    DBMS_OUTPUT.PUT_LINE('EL MODELO DEL PRODUCTO ES DEL: '||DATOS_CURSOR.ANIO_MODELO);
    DBMS_OUTPUT.PUT_LINE('EL NOMBRE DE LA CATEGORIA DEL PRODUCTO ES: '||DATOS_CURSOR.NOMBRE_CATEGORIA);
    DBMS_OUTPUT.PUT_LINE('EL ID DE LA CATEGORIA DEL PRODUCTO ES: '||DATOS_CURSOR.COD_CATEGORIA);
    DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE REGISTROS ES: '||CDATOS_PRODUCTO%ROWCOUNT);
    
    EXIT WHEN CDATOS_PRODUCTO%NOTFOUND;
  
    --- Salto de linea 
    DBMS_OUTPUT.PUT_LINE(CHR(13));
  END LOOP;
  
  CLOSE CDATOS_PRODUCTO;  
END;

/* 
   Obtener los nombres de todas las categorias y los codigos de las mismas.
   Bulk Collect --> se utiliza cuando se quieren obtener todos los registros de una sola vez 
*/
DECLARE 
   TYPE FILA IS RECORD(
     CODIGO_CATEGORIA CATEGORIES.CATEGORY_ID%TYPE,
     NOMBRE_CATEGORIA CATEGORIES.CATEGORY_NAME%TYPE
   );
    
   --- PLS INTEGER --> Tipo de datos en Oracle para poder definir de forma unico los registros de una estructura especifica.
   --- Estructura tipo tabla, y la tabla sera de tipo fila o RECORD.
   TYPE TABLA_CATEGORIAS IS TABLE OF FILA INDEX BY PLS_INTEGER;
   
   --- Variable para almacenar todos los registros del Bulk Collect
   DATOS_CATEGORIA TABLA_CATEGORIAS;
   
   --- Variable para recorrer los registros obtenidos
   ITERACION NUMBER(10):= 0;
BEGIN
   SELECT CATEGORIES.CATEGORY_ID, CATEGORIES.CATEGORY_NAME BULK COLLECT INTO DATOS_CATEGORIA FROM CATEGORIES;
   
   DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE REGISTROS ES: '||SQL%ROWCOUNT);
   
   --- Ciclo WHILE 
   WHILE (ITERACION<SQL%ROWCOUNT) LOOP
     DBMS_OUTPUT.PUT_LINE('EL CODIGO DE LA CATEGORIA ES: '||DATOS_CATEGORIA(ITERACION+1).CODIGO_CATEGORIA);
     DBMS_OUTPUT.PUT_LINE('EL NOMBRE DE LA CATEGORIA ES: '||DATOS_CATEGORIA(ITERACION+1).NOMBRE_CATEGORIA);

     ITERACION:=ITERACION+1;
   END LOOP;
END;

--- Clase #8.4
--- Cursores y arreglos asociativos
--- Tabla creada a base de un mapeo de una tabla de los registros 

DECLARE 
   TYPE TABLA_CATEGORIAS IS TABLE OF CATEGORIES%ROWTYPE INDEX BY PLS_INTEGER;
   
   --- Variable para almacenar todos los registros del Bulk Collect
   DATOS_CATEGORIA TABLA_CATEGORIAS;
   
   --- Variable para recorrer los registros obtenidos
   ITERACION NUMBER(10):= 0;
BEGIN
   SELECT CATEGORIES.CATEGORY_ID, CATEGORIES.CATEGORY_NAME BULK COLLECT INTO DATOS_CATEGORIA FROM CATEGORIES;
   
   DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE REGISTROS ES: '||SQL%ROWCOUNT);
   
   --- Ciclo WHILE 
   WHILE (ITERACION<SQL%ROWCOUNT) LOOP
     DBMS_OUTPUT.PUT_LINE('EL CODIGO DE LA CATEGORIA ES: '||DATOS_CATEGORIA(ITERACION+1).CATEGORY_ID);
     DBMS_OUTPUT.PUT_LINE('EL NOMBRE DE LA CATEGORIA ES: '||DATOS_CATEGORIA(ITERACION+1).CATEGORY_NAME);

     ITERACION:=ITERACION+1;
   END LOOP;
END;

--- Arreglo Asociativo
DECLARE 
  TYPE ARREGLO IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
  DATOS ARREGLO;
BEGIN
  DATOS(1):= 'ELEMENTO 1';
  DATOS(2):= 'ELEMENTO 2';
  DATOS(3):= 'ELEMENTO 3';
  DATOS(4):= 'ELEMENTO 4';
  DATOS(5):= 'ELEMENTO 5';
  DATOS(6):= 'ELEMENTO 6';
    
  --- Ciclo FOR
  --- Contar la cantidad de elementos que tiene el arreglo usando la funcion COUNT
  FOR ITERACION IN 1..DATOS.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(DATOS(ITERACION));
  END LOOP;
  
  --- PRIOR --> La tarea de esta funcion es Retornar el numero de indice anterior al que se mande como parametro
  DBMS_OUTPUT.PUT_LINE(DATOS.PRIOR(3));
  
  --- NEXT --> La tarea de esta funcion es Retornar el numero de indice siguiente al que se mande como parametro
  DBMS_OUTPUT.PUT_LINE(DATOS.NEXT(3));

  --- DELETE --> La tarea de esta funcion es Eliminar el numero de indice que se mande como parametro
  DATOS.DELETE(1); 
  DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE VALORES ES: '||DATOS.COUNT);
  
  --- Variante de DELETE borrar todo lo que este entre un rango de indices (de 2 a 4 por ejemplo)
  DATOS.DELETE(2,4); 
  DBMS_OUTPUT.PUT_LINE('LA CANTIDAD DE VALORES ES: '||DATOS.COUNT);
  
END;


--- Clase #9 
--- Funciones incorporadas en Oracle 
--- Manejo de fechas, imprimir mensajes con formatos especificos

DECLARE 
  FECHA DATE;
  FECHA_HORA TIMESTAMP;
BEGIN 
  FECHA:= SYSDATE;
  DBMS_OUTPUT.PUT_LINE('LA FECHA DEL SISTEMA OBTENIDA POR SYSDATE ES: '||FECHA);
  
  FECHA_HORA:= SYSTIMESTAMP;
  DBMS_OUTPUT.PUT_LINE('LA HORA DEL SISTEMA OBTENIDA POR SYSTIMESTAMP ES: '||FECHA_HORA);
  
  --- TO DATE indicar la fecha que se quiera y en el formato que guste
  FECHA:= TO_DATE('2018-02-28', 'YYYY-MM-DD');
  DBMS_OUTPUT.PUT_LINE('LA FECHA DEL SISTEMA OBTENIDA POR TO_DATE ES: '||FECHA);
  
  --- TO TIMESTAMP Convierte del formato que se le manda al formato en el que Oracle gestiona estos datos 
  --- HH Indica que el formato de la hora es de 12 horas
  
  FECHA_HORA:= TO_TIMESTAMP('25-02-2020 11:30:16', 'DD-MM-YYYY HH:MI:SS');
  DBMS_OUTPUT.PUT_LINE('LA HORA DEL SISTEMA OBTENIDA POR TO_TIMESTAMP ES: '||FECHA_HORA);
  
  DBMS_OUTPUT.PUT_LINE('USO DE LA FUNCION TO_CHAR PARA CAMBIAR EL FORMATO DE IMPRESION DE FECHA: '||TO_CHAR(FECHA, 'YYYY-MM-DD'));
  DBMS_OUTPUT.PUT_LINE('USO DE LA FUNCION TO_CHAR PARA CAMBIAR EL FORMATO DE IMPRESION DE FECHA: '||TO_CHAR(FECHA_HORA, 'YYYY-MM-DD HH-MI-SS'));
  
   FECHA_HORA:= TO_TIMESTAMP('25-02-2020 11:30:16', 'DD-MM-YYYY HH24:MI:SS');
   DBMS_OUTPUT.PUT_LINE('LA HORA DEL SISTEMA OBTENIDA POR TO_TIMESTAMP ES: '||FECHA_HORA);

END;