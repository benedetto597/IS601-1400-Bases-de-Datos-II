/*
  @author edgar.benedetto@unah.hn N.Cuenta 20171033802
  @date 01/04/2021
  @decription Proyecto BD II Sección 1400 I PAC 2021 
  @name_file DW_MAINTENANCE_PROYECT.sql
  @version 1.0
  
    1. Creacipon de la base de datos OLAP
      - Creación de las tablas de dimensiones
      - Creación de la tabla de Hechos
      - Especificación de métricas en la tabla de Hechos
*/

--------------------------------------------------------
--  Dimensión TIEMPO
--------------------------------------------------------
 CREATE TABLE "DM_TIME" (
  "ID_TIME" DATE PRIMARY KEY NOT NULL,
	"YEAR" INTEGER NOT NULL,
	"MONTH" VARCHAR(30) NOT NULL ,
	"WEEK" INTEGER NOT NULL,
	"TRIMESTER" INTEGER NOT NULL,
	"DAY_OF_WEEK" VARCHAR(30) NOT NULL 
);

--------------------------------------------------------
--  Dimensión MATERIAL
--------------------------------------------------------

CREATE TABLE "DM_MATERIAL" (
  "ID_MATERIAL" INT PRIMARY KEY NOT NULL ,
  "COD_MATERIAL" NUMBER(8,0) NOT NULL
);

--------------------------------------------------------
--  Dimensión EQUIPO
--------------------------------------------------------

CREATE TABLE "DM_EQUIPMENT"(
    "ID_EQUIPMENT" INT PRIMARY KEY NOT NULL,
    "COD_EQUIPMENT" CHAR(7) NOT NULL,
    "NAME" VARCHAR2(100) NOT NULL
);

--------------------------------------------------------
--  Dimensión EMPLEADO
--------------------------------------------------------

CREATE TABLE "DM_EMPLOYEE" (
      "ID_EMPLOYEE" INT PRIMARY KEY NOT NULL, 
      "NAME" VARCHAR2(20) NOT NULL, 
      "SALARY" NUMBER(8,2) NOT NULL 
);

--------------------------------------------------------
--  Dimensión MANTENIMIENTO
--------------------------------------------------------

CREATE TABLE "DM_MAINTENANCE" (
      "ID_MAINTENANCE" INT PRIMARY KEY NOT NULL, 
      "TYPE_MAINTENANCE" VARCHAR2(20) NOT NULL, 
      "WORKED_HOURS" NUMBER(2,2)
);
  
--------------------------------------------------------
--  Dimensión ORDEN
--------------------------------------------------------

CREATE TABLE "DM_ORDER" (
      "ID_ORDER" INT PRIMARY KEY NOT NULL, 
      "COD_ORDER" CHAR(9) NOT NULL, 
      "TYPE_TRANSACTION" VARCHAR2(20) NOT NULL, 
      "ACCOUNT_DATE" DATE NOT NULL
); 
  
--------------------------------------------------------
--  Dimensión ORDEN ITEM
--------------------------------------------------------

CREATE TABLE "DM_ORDER_ITEM" (
      "ID_ORDER_ITEM" INT PRIMARY KEY NOT NULL, 
      "AMOUNT_LEMP" NUMBER(18,2), 
      "AMOUNT_DOLL" NUMBER(18,2), 
      "ADD_AMOUNT" NUMBER NOT NULL
); 
  
--------------------------------------------------------
--  Tabla HECHOS MANTENIMIENTOS
--------------------------------------------------------
  
CREATE TABLE "FACTS_MAINTENANCES"(	
  "ID_FACT" INTEGER PRIMARY KEY NOT NULL, 
  "ID_TIME" DATE,
  "ID_MATERIAL" INTEGER,
  "ID_EQUIPMENT" INTEGER,
  "ID_EMPLOYEE" INTEGER,
  "ID_MAINTENANCE" INTEGER,
  "ID_ORDER" INTEGER,
  "ID_ORDER_ITEM" INTEGER,
  "TOTAL_AMOUNT_LEMP"  NUMBER(18,2),
  "TOTAL_AMOUNT_DOLL"  NUMBER(18,2), 
  "TOTAL_HOURS_PREV"  NUMBER(2,2), 
  "TOTAL_HOURS_CORR"  NUMBER(2,2), 
  "TOTAL_PREV"  NUMBER, 
  "TOTAL_CORR"  NUMBER, 
  "TOTAL_MATERIALS"  NUMBER, 
  "TOTAL_EQ_PREV"  NUMBER, 
  "TOTAL_EQ_CORR"  NUMBER, 
  "TOTAL_SALARY"  NUMBER(8,2), 
  CONSTRAINT PK_ORDER_ITEM_TIME FOREIGN KEY (ID_TIME) REFERENCES DM_TIME(ID_TIME),
  CONSTRAINT PK_ORDER_ITEM_MATERIAL FOREIGN KEY (ID_MATERIAL) REFERENCES DM_MATERIAL(ID_MATERIAL),
  CONSTRAINT PK_ORDER_ITEM_EQUIPMENT FOREIGN KEY (ID_EQUIPMENT) REFERENCES DM_EQUIPMENT(ID_EQUIPMENT),
  CONSTRAINT PK_ORDER_ITEM_EMPLOYEE FOREIGN KEY (ID_EMPLOYEE) REFERENCES DM_EMPLOYEE(ID_EMPLOYEE),
  CONSTRAINT PK_ORDER_ITEM_MAINTENANCE FOREIGN KEY (ID_MAINTENANCE) REFERENCES DM_MAINTENANCE(ID_MAINTENANCE),
  CONSTRAINT PK_ORDER_ITEM_ORDER FOREIGN KEY (ID_ORDER) REFERENCES DM_ORDER(ID_ORDER),
  CONSTRAINT PK_ORDER_ITEM_ORDER_ITEM FOREIGN KEY (ID_ORDER_ITEM) REFERENCES DM_ORDER_ITEM(ID_ORDER_ITEM)
);
  
