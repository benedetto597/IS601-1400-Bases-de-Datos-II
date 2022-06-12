USE [PAGOS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------
--  DDL for Table CIUDAD
--------------------------------------------------------

  CREATE TABLE "CIUDAD" 
   (	"ID_CIUDAD" INTEGER NOT NULL UNIQUE, 
	"CIUDAD" VARCHAR(50), 
	"ID_DEPARTAMENTO" INTEGER
   ) 
  ;
--------------------------------------------------------
--  DDL for Table CLIENTE
--------------------------------------------------------

  CREATE TABLE "CLIENTE" 
   (	"ID_CLIENTE" INTEGER NOT NULL UNIQUE, 
	"ID_TIENDA" INTEGER, 
	"NOMBRE" VARCHAR(45), 
	"APELLIDO" VARCHAR(45), 
	"EMAIL" VARCHAR(50), 
	"ID_DIRECCION" INTEGER, 
	"ACTIVO" VARCHAR(10), 
	"FECHA_CREACION" DATE, 
	"FECHA_ACTUALIZACION" DATE
   ) 
  ;
--------------------------------------------------------
--  DDL for Table DEPARTAMENTO
--------------------------------------------------------

  CREATE TABLE "DEPARTAMENTO" 
   (	"ID_DEPARTAMENTO" INTEGER NOT NULL UNIQUE, 
	"DEPARTAMENTO" VARCHAR(50)
   ) 
  ;
--------------------------------------------------------
--  DDL for Table DIRECCION
--------------------------------------------------------

  CREATE TABLE "DIRECCION" 
   (	"ID_DIRECCION" INTEGER NOT NULL UNIQUE, 
	"COLONIA" VARCHAR(50), 
	"ID_CIUDAD" INTEGER, 
	"TELEFONO" VARCHAR(20), 
	"FECHA_ACTUALIZACION" DATE
   ) 
  ;
--------------------------------------------------------
--  DDL for Table EMPLEADO
--------------------------------------------------------

  CREATE TABLE "EMPLEADO" 
   (	"ID_EMPLEADO" INTEGER NOT NULL UNIQUE, 
	"NOMBRE" VARCHAR(45), 
	"APELLIDO" VARCHAR(45), 
	"ID_DIRECCION" INTEGER, 
	"EMAIL" VARCHAR(50), 
	"ID_TIENDA" INTEGER, 
	"ACTIVO" INTEGER, 
	"USUARIO" VARCHAR(16), 
	"PASSWORD" VARCHAR(40), 
	"FECHA_ACTUALIZACIO" DATE
   ) 
  ;
--------------------------------------------------------
--  DDL for Table PAGO
--------------------------------------------------------

  CREATE TABLE "PAGO" 
   (	"ID_PAGO" INTEGER NOT NULL UNIQUE, 
	"ID_CLIENTE" INTEGER, 
	"ID_EMPLEADO" INTEGER, 
	"CONCEPTO" VARCHAR(50), 
	"MONTO" DECIMAL(18,2), 
	"FECHA_PAGO" DATE, 
	"FECHA_ACTUALIZACION" DATE
   ) 
  ;
--------------------------------------------------------
--  DDL for Table TIENDA
--------------------------------------------------------

  CREATE TABLE "TIENDA" 
   (	"ID_TIENDA" INTEGER NOT NULL UNIQUE, 
	"ID_DIRECCION" INTEGER, 
	"FECHA_ACTUALIZACION" DATE
   ) 
  ;
-- INSERTING into CIUDAD
/* SET DEFINE OFF; */
Insert into CIUDAD (ID_CIUDAD,CIUDAD,ID_DEPARTAMENTO) values (1,'TEGUCIGALPA',1);
Insert into CIUDAD (ID_CIUDAD,CIUDAD,ID_DEPARTAMENTO) values (2,'SAN PEDRO SULA',2);
Insert into CIUDAD (ID_CIUDAD,CIUDAD,ID_DEPARTAMENTO) values (3,'LA CEIBA',3);
-- INSERTING into CLIENTE
/* SET DEFINE OFF; */
Insert into CLIENTE (ID_CLIENTE,ID_TIENDA,NOMBRE,APELLIDO,EMAIL,ID_DIRECCION,ACTIVO,FECHA_CREACION,FECHA_ACTUALIZACION) values (1,1,'MARY','SMITH','MARY.SMITH@sakilacustomer.org',1,'ACTIVO',convert(DATE, '22-MAR-19'),convert(DATE, '22-MAR-19'));
Insert into CLIENTE (ID_CLIENTE,ID_TIENDA,NOMBRE,APELLIDO,EMAIL,ID_DIRECCION,ACTIVO,FECHA_CREACION,FECHA_ACTUALIZACION) values (2,1,'PATRICIA','JOHNSON','PATRICIA.JOHNSON@sakilacustomer.org',1,'ACTIVO',convert(DATE, '22-MAR-19'),convert(DATE, '22-MAR-19'));
Insert into CLIENTE (ID_CLIENTE,ID_TIENDA,NOMBRE,APELLIDO,EMAIL,ID_DIRECCION,ACTIVO,FECHA_CREACION,FECHA_ACTUALIZACION) values (3,1,'LINDA','WILLIAMS','LINDA.WILLIAMS@sakilacustomer.org',1,'ACTIVO',convert(DATE, '22-MAR-19'),convert(DATE, '22-MAR-19'));
Insert into CLIENTE (ID_CLIENTE,ID_TIENDA,NOMBRE,APELLIDO,EMAIL,ID_DIRECCION,ACTIVO,FECHA_CREACION,FECHA_ACTUALIZACION) values (4,2,'BARBARA','JONES','BARBARA.JONES@sakilacustomer.org',2,'ACTIVO',convert(DATE, '22-MAR-19'),convert(DATE, '22-MAR-19'));
Insert into CLIENTE (ID_CLIENTE,ID_TIENDA,NOMBRE,APELLIDO,EMAIL,ID_DIRECCION,ACTIVO,FECHA_CREACION,FECHA_ACTUALIZACION) values (5,1,'ELIZABETH','BROWN','ELIZABETH.BROWN@sakilacustomer.org',1,'ACTIVO',convert(DATE, '22-MAR-19'),convert(DATE, '22-MAR-19'));
Insert into CLIENTE (ID_CLIENTE,ID_TIENDA,NOMBRE,APELLIDO,EMAIL,ID_DIRECCION,ACTIVO,FECHA_CREACION,FECHA_ACTUALIZACION) values (6,2,'JENNIFER','DAVIS','JENNIFER.DAVIS@sakilacustomer.org',2,'ACTIVO',convert(DATE, '22-MAR-19'),convert(DATE, '22-MAR-19'));
Insert into CLIENTE (ID_CLIENTE,ID_TIENDA,NOMBRE,APELLIDO,EMAIL,ID_DIRECCION,ACTIVO,FECHA_CREACION,FECHA_ACTUALIZACION) values (7,1,'MARIA','MILLER','MARIA.MILLER@sakilacustomer.org',1,'ACTIVO',convert(DATE, '22-MAR-19'),convert(DATE, '22-MAR-19'));
Insert into CLIENTE (ID_CLIENTE,ID_TIENDA,NOMBRE,APELLIDO,EMAIL,ID_DIRECCION,ACTIVO,FECHA_CREACION,FECHA_ACTUALIZACION) values (8,2,'SUSAN','WILSON','SUSAN.WILSON@sakilacustomer.org',2,'ACTIVO',convert(DATE, '22-MAR-19'),convert(DATE, '22-MAR-19'));
Insert into CLIENTE (ID_CLIENTE,ID_TIENDA,NOMBRE,APELLIDO,EMAIL,ID_DIRECCION,ACTIVO,FECHA_CREACION,FECHA_ACTUALIZACION) values (9,2,'MARGARET','MOORE','MARGARET.MOORE@sakilacustomer.org',2,'ACTIVO',convert(DATE, '22-MAR-19'),convert(DATE, '22-MAR-19'));
-- INSERTING into DEPARTAMENTO
/* SET DEFINE OFF; */
Insert into DEPARTAMENTO (ID_DEPARTAMENTO,DEPARTAMENTO) values (1,'FRANCISCO MORAZÃ?N');
Insert into DEPARTAMENTO (ID_DEPARTAMENTO,DEPARTAMENTO) values (2,'CORTES');
Insert into DEPARTAMENTO (ID_DEPARTAMENTO,DEPARTAMENTO) values (3,'ATLÃ?NTIDA');
-- INSERTING into DIRECCION
/* SET DEFINE OFF; */
Insert into DIRECCION (ID_DIRECCION,COLONIA,ID_CIUDAD,TELEFONO,FECHA_ACTUALIZACION) values (1,'UNAH',1,'2200-0000',convert(DATE, '22-MAR-19'));
Insert into DIRECCION (ID_DIRECCION,COLONIA,ID_CIUDAD,TELEFONO,FECHA_ACTUALIZACION) values (2,'HONDURAS',2,'2500-0000',convert(DATE, '22-MAR-19'));
Insert into DIRECCION (ID_DIRECCION,COLONIA,ID_CIUDAD,TELEFONO,FECHA_ACTUALIZACION) values (3,'VILLAS',3,'27000-0000',convert(DATE, '22-MAR-19'));
-- INSERTING into EMPLEADO
/* SET DEFINE OFF; */
Insert into EMPLEADO (ID_EMPLEADO,NOMBRE,APELLIDO,ID_DIRECCION,EMAIL,ID_TIENDA,ACTIVO,USUARIO,PASSWORD,FECHA_ACTUALIZACIO) values (1,'Mike','Hillyer',1,'Mike.Hillyer@sakilastaff.com',1,1,'Mike','8cb2237d0679ca88db6464eac60da96345513964',convert(DATE, '22-MAR-19'));
Insert into EMPLEADO (ID_EMPLEADO,NOMBRE,APELLIDO,ID_DIRECCION,EMAIL,ID_TIENDA,ACTIVO,USUARIO,PASSWORD,FECHA_ACTUALIZACIO) values (2,'Jon','Stephens',2,'Jon.Stephens@sakilastaff.com',2,1,'Jon','8cb2237d0679ca88db6464eac60da96345513964',convert(DATE, '22-MAR-19'));
-- INSERTING into PAGO
/* SET DEFINE OFF; */
Insert into PAGO (ID_PAGO,ID_CLIENTE,ID_EMPLEADO,CONCEPTO,MONTO,FECHA_PAGO,FECHA_ACTUALIZACION) values (1,1,1,'76',2.99,convert(DATE, '23-MAR-18'),convert(DATE, '23-MAR-18'));
Insert into PAGO (ID_PAGO,ID_CLIENTE,ID_EMPLEADO,CONCEPTO,MONTO,FECHA_PAGO,FECHA_ACTUALIZACION) values (2,1,1,'573',0.99,convert(DATE, '13-MAR-19'),convert(DATE, '13-MAR-19'));
Insert into PAGO (ID_PAGO,ID_CLIENTE,ID_EMPLEADO,CONCEPTO,MONTO,FECHA_PAGO,FECHA_ACTUALIZACION) values (3,2,1,'1185',5.99,convert(DATE, '13-MAR-19'),convert(DATE, '13-MAR-19'));
Insert into PAGO (ID_PAGO,ID_CLIENTE,ID_EMPLEADO,CONCEPTO,MONTO,FECHA_PAGO,FECHA_ACTUALIZACION) values (4,2,2,'1422',0.99,convert(DATE, '13-FEB-19'),convert(DATE, '13-FEB-19'));
Insert into PAGO (ID_PAGO,ID_CLIENTE,ID_EMPLEADO,CONCEPTO,MONTO,FECHA_PAGO,FECHA_ACTUALIZACION) values (5,3,2,'1476',9.99,convert(DATE, '13-FEB-19'),convert(DATE, '13-FEB-19'));
Insert into PAGO (ID_PAGO,ID_CLIENTE,ID_EMPLEADO,CONCEPTO,MONTO,FECHA_PAGO,FECHA_ACTUALIZACION) values (6,4,1,'1725',4.99,convert(DATE, '13-FEB-19'),convert(DATE, '13-FEB-19'));
Insert into PAGO (ID_PAGO,ID_CLIENTE,ID_EMPLEADO,CONCEPTO,MONTO,FECHA_PAGO,FECHA_ACTUALIZACION) values (7,5,1,'2308',4.99,convert(DATE, '23-MAR-18'),convert(DATE, '23-MAR-18'));
Insert into PAGO (ID_PAGO,ID_CLIENTE,ID_EMPLEADO,CONCEPTO,MONTO,FECHA_PAGO,FECHA_ACTUALIZACION) values (8,6,2,'2363',0.99,convert(DATE, '23-MAR-18'),convert(DATE, '23-MAR-18'));
Insert into PAGO (ID_PAGO,ID_CLIENTE,ID_EMPLEADO,CONCEPTO,MONTO,FECHA_PAGO,FECHA_ACTUALIZACION) values (9,5,1,'3284',3.99,convert(DATE, '13-MAR-19'),convert(DATE, '13-MAR-19'));
Insert into PAGO (ID_PAGO,ID_CLIENTE,ID_EMPLEADO,CONCEPTO,MONTO,FECHA_PAGO,FECHA_ACTUALIZACION) values (10,9,2,'4526',5.99,convert(DATE, '23-MAR-18'),convert(DATE, '23-MAR-18'));
-- INSERTING into TIENDA
/* SET DEFINE OFF; */
Insert into TIENDA (ID_TIENDA,ID_DIRECCION,FECHA_ACTUALIZACION) values (1,1,convert(DATE, '22-MAR-19'));
Insert into TIENDA (ID_TIENDA,ID_DIRECCION,FECHA_ACTUALIZACION) values (2,2,convert(DATE, '22-MAR-19'));
Insert into TIENDA (ID_TIENDA,ID_DIRECCION,FECHA_ACTUALIZACION) values (3,3,convert(DATE, '22-MAR-19'));

--------------------------------------------------------
--  Constraints for Table CIUDAD
--------------------------------------------------------

  ALTER TABLE "CIUDAD" ADD CONSTRAINT "CIUDAD_PK" PRIMARY KEY ("ID_CIUDAD");
--------------------------------------------------------
--  Constraints for Table CLIENTE
--------------------------------------------------------

  ALTER TABLE "CLIENTE" ADD CONSTRAINT "CLIENTE_PK" PRIMARY KEY ("ID_CLIENTE");
--------------------------------------------------------
--  Constraints for Table DEPARTAMENTO
--------------------------------------------------------

  ALTER TABLE "DEPARTAMENTO" ADD CONSTRAINT "DEPARTAMENTO_PK" PRIMARY KEY ("ID_DEPARTAMENTO");
--------------------------------------------------------
--  Constraints for Table DIRECCION
--------------------------------------------------------

  ALTER TABLE "DIRECCION" ADD CONSTRAINT "DIRECCION_PK" PRIMARY KEY ("ID_DIRECCION");
--------------------------------------------------------
--  Constraints for Table EMPLEADO
--------------------------------------------------------

  ALTER TABLE "EMPLEADO" ADD CONSTRAINT "EMPLEADO_PK" PRIMARY KEY ("ID_EMPLEADO");
--------------------------------------------------------
--  Constraints for Table PAGO
--------------------------------------------------------

  ALTER TABLE "PAGO" ADD CONSTRAINT "PAGO_PK" PRIMARY KEY ("ID_PAGO");
--------------------------------------------------------
--  Constraints for Table TIENDA
--------------------------------------------------------

  ALTER TABLE "TIENDA" ADD CONSTRAINT "TIENDA_PK" PRIMARY KEY ("ID_TIENDA");
--------------------------------------------------------
--  Ref Constraints for Table CIUDAD
--------------------------------------------------------

  ALTER TABLE "CIUDAD" ADD CONSTRAINT "CIUDAD_FK1" FOREIGN KEY ("ID_DEPARTAMENTO")
	  REFERENCES "DEPARTAMENTO" ("ID_DEPARTAMENTO");
--------------------------------------------------------
--  Ref Constraints for Table CLIENTE
--------------------------------------------------------

  ALTER TABLE "CLIENTE" ADD CONSTRAINT "CLIENTE_FK1" FOREIGN KEY ("ID_DIRECCION")
	  REFERENCES "DIRECCION" ("ID_DIRECCION");
  ALTER TABLE "CLIENTE" ADD CONSTRAINT "CLIENTE_FK2" FOREIGN KEY ("ID_TIENDA")
	  REFERENCES "TIENDA" ("ID_TIENDA");
--------------------------------------------------------
--  Ref Constraints for Table DIRECCION
--------------------------------------------------------

  ALTER TABLE "DIRECCION" ADD CONSTRAINT "DIRECCION_FK1" FOREIGN KEY ("ID_CIUDAD")
	  REFERENCES "CIUDAD" ("ID_CIUDAD");
--------------------------------------------------------
--  Ref Constraints for Table EMPLEADO
--------------------------------------------------------

  ALTER TABLE "EMPLEADO" ADD CONSTRAINT "EMPLEADO_FK1" FOREIGN KEY ("ID_DIRECCION")
	  REFERENCES "DIRECCION" ("ID_DIRECCION");
  ALTER TABLE "EMPLEADO" ADD CONSTRAINT "EMPLEADO_FK2" FOREIGN KEY ("ID_TIENDA")
	  REFERENCES "TIENDA" ("ID_TIENDA");
--------------------------------------------------------
--  Ref Constraints for Table PAGO
--------------------------------------------------------

  ALTER TABLE "PAGO" ADD CONSTRAINT "PAGO_FK1" FOREIGN KEY ("ID_CLIENTE")
	  REFERENCES "CLIENTE" ("ID_CLIENTE");
  ALTER TABLE "PAGO" ADD CONSTRAINT "PAGO_FK2" FOREIGN KEY ("ID_EMPLEADO")
	  REFERENCES "EMPLEADO" ("ID_EMPLEADO");
--------------------------------------------------------
--  Ref Constraints for Table TIENDA
--------------------------------------------------------

  ALTER TABLE "TIENDA" ADD CONSTRAINT "TIENDA_FK1" FOREIGN KEY ("ID_DIRECCION")
	  REFERENCES "DIRECCION" ("ID_DIRECCION");
