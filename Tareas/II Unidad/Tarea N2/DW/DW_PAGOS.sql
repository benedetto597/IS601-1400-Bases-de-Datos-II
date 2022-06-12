/*
  @author edgar.benedetto@unah.hn
  @date 14/03/2021
  @version 1.0
  
  Tarea #2 Base de datos OLAP
*/

--------------------------------------------------------
--  Dimensi�n DEPARTAMENTO
--------------------------------------------------------

  CREATE TABLE "DW_DEPARTAMENTO" 
   (	"ID_DEPARTAMENTO" INTEGER NOT NULL UNIQUE, 
	"DEPARTAMENTO" VARCHAR(50)
   ) 
  ;
  

--------------------------------------------------------
--  Dimensi�n Ciudad
--------------------------------------------------------

 CREATE TABLE "DW_CIUDAD" 
   (	"ID_CIUDAD" INTEGER NOT NULL UNIQUE, 
	"CIUDAD" VARCHAR(50), 
	"ID_DEPARTAMENTO" INTEGER,
   FOREIGN KEY ("ID_DEPARTAMENTO")
            REFERENCES DW_DEPARTAMENTO (ID_DEPARTAMENTO)
   ) 
  ;
  
--------------------------------------------------------
--  Dimensi�n DIRECCION
--------------------------------------------------------

  CREATE TABLE "DW_DIRECCION" 
   (	"ID_DIRECCION" INTEGER NOT NULL UNIQUE, 
	"COLONIA" VARCHAR(50), 
	"ID_CIUDAD" INTEGER,
   FOREIGN KEY ("ID_CIUDAD")
            REFERENCES DW_CIUDAD (ID_CIUDAD)
   ) 
  ;


--------------------------------------------------------
--  Dimensi�n PAGO
--------------------------------------------------------

  CREATE TABLE "DW_PAGO" 
   (	"ID_PAGO" INTEGER NOT NULL UNIQUE, 
	"MONTO" DECIMAL(18,2), 
	"FECHA_PAGO" DATE
   ) 
  ;
--------------------------------------------------------
--  Dimensi�n TIENDA
--------------------------------------------------------

  CREATE TABLE "DW_TIENDA" 
   (	"ID_TIENDA" INTEGER NOT NULL UNIQUE, 
	"ID_DIRECCION" INTEGER,
  FOREIGN KEY ("ID_DIRECCION")
            REFERENCES DW_DIRECCION (ID_DIRECCION)
  ) 
;

--------------------------------------------------------
--  Dimensi�n CLIENTE
--------------------------------------------------------

  CREATE TABLE "DW_CLIENTE" 
   (	"ID_CLIENTE" INTEGER NOT NULL UNIQUE, 
	"ID_TIENDA" INTEGER, 
	"NOMBRE" VARCHAR(60),
  FOREIGN KEY ("ID_TIENDA")
            REFERENCES DW_TIENDA (ID_TIENDA)
   ) 
  ;

--------------------------------------------------------
--  Dimensi�n EMPLEADO
--------------------------------------------------------

  CREATE TABLE "DW_EMPLEADO" 
   (	"ID_EMPLEADO" INTEGER NOT NULL UNIQUE, 
	"NOMBRE" VARCHAR(45), 
	"ID_TIENDA" INTEGER,
  FOREIGN KEY ("ID_TIENDA")
            REFERENCES DW_TIENDA (ID_TIENDA)
   ) 
  ;
  
--------------------------------------------------------
--  Dimensión TIEMPO
--------------------------------------------------------
 CREATE TABLE "DW_TIEMPO" 
   (	"ID_TIEMPO" DATE NOT NULL UNIQUE,
	"AÑO" INTEGER,
	"MES" INTEGER,
	"SEMANA" INTEGER,
	"TRIMESTRE" INTEGER,
	"DIA_DE_SEMANA" VARCHAR(45) NULL 
  ) 
;

--------------------------------------------------------
--  Hechos Pagos
--------------------------------------------------------
  
  CREATE TABLE "Hechos_Pagos" 
   (	"ID_HECHOS" INTEGER NOT NULL UNIQUE, 
  "ID_EMPLEADO" INTEGER,
  "ID_CLIENTE" INTEGER,
  "ID_PAGO" INTEGER,
  "ID_TIEMPO" DATE,
  "COUNT_PAGOS" INTEGER,
  "MOUNT_PAGOS" INTEGER, 
   FOREIGN KEY ("ID_EMPLEADO")
            REFERENCES DW_EMPLEADO (ID_EMPLEADO),
   FOREIGN KEY ("ID_CLIENTE")
            REFERENCES DW_CLIENTE (ID_CLIENTE),
  FOREIGN KEY ("ID_PAGO")
            REFERENCES DW_PAGO (ID_PAGO),
   FOREIGN KEY ("ID_TIEMPO")
            REFERENCES DW_TIEMPO (ID_TIEMPO)
  ) 
  ;
  
