  @author edgar.benedetto@unah.hn
  @date 14/03/2021
  @version 1.0
  
  Tarea #2 Consultas utilizadas

--------------------------------------------------------
--  Dimensiones
--------------------------------------------------------

--- Departamento
SELECT ID_DEPARTAMENTO "Cod. Departamento", DEPARTAMENTO "Nombre Departamento" FROM DEPARTAMENTO

--- Ciudad
SELECT ID_CIUDAD "Cod. Ciudad", CIUDAD "Nombre Ciudad", ID_DEPARTAMENTO "Cod. Departamento" FROM CIUDAD

--- Dirección
SELECT ID_DIRECCION "Cod. Dirección", ID_CIUDAD "Cod. Ciudad", COLONIA "Nombre Colonia" FROM DIRECCION 

--- Pago
SELECT ID_PAGO "Cod. Pago", MONTO "Monto", FECHA_PAGO "Fecha de pago" FROM PAGO

--- Tienda 
SELECT ID_TIENDA "Cod. Tienda", ID_DIRECCION "Cod. Dirección" FROM TIENDA

--- Cliente
SELECT ID_CLIENTE "Cod. Cliente", ID_TIENDA "Cod. Tienda", CONCAT(NOMBRE,' ', APELLIDO) Nombre FROM CLIENTE

--- Empleado   
SELECT ID_EMPLEADO "Cod. Empleado", ID_TIENDA "Cod. Tienda", CONCAT(NOMBRE,' ', APELLIDO) Nombre FROM EMPLEADO

--- Tiempo
SELECT CONVERT(DATE, FECHA_PAGO) "Id. Tiempo", DATEPART(YEAR, FECHA_PAGO) Año, 
DATEPART(MONTH, FECHA_PAGO) Mes, DATEPART(WEEK, FECHA_PAGO) Semana, 
DATEPART(QUARTER, FECHA_PAGO) Trimestre, DATENAME(WEEKDAY, FECHA_PAGO) "Día de la semana"
FROM PAGO
GROUP BY PAGO.FECHA_PAGO

--------------------------------------------------------
--  Tabla de hechos
--------------------------------------------------------

SELECT EMPLEADO.ID_EMPLEADO "Cod. Empleado", CLIENTE.ID_CLIENTE "Cod. Cliente", 
ID_PAGO "Cod. Pago", CONVERT(DATE, FECHA_PAGO) "Id. Fecha de pago", 
COUNT(ID_PAGO) OVER (PARTITION BY DATEPART(MONTH, FECHA_PAGO), DATEPART(YEAR, FECHA_PAGO)) "Conteo de pagos en el mes", SUM(MONTO) OVER (PARTITION BY DATEPART(MONTH, FECHA_PAGO), DATEPART(YEAR, FECHA_PAGO)) "Monto de pagos del mes"
FROM PAGO 
  INNER JOIN EMPLEADO ON PAGO.ID_EMPLEADO = EMPLEADO.ID_EMPLEADO 
  INNER JOIN CLIENTE ON PAGO.ID_CLIENTE = CLIENTE.ID_CLIENTE 
GROUP BY EMPLEADO.ID_EMPLEADO, CLIENTE.ID_CLIENTE, ID_PAGO, FECHA_PAGO, MONTO;