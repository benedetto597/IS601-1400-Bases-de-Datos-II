/*
  @author edgar.benedetto@unah.hn N.Cuenta 20171033802
  @date 12/04/2021
  @decription Proyecto BD II Sección 1400 I PAC 2021 
  @name_file Consultas_ETL.sql
  @version 1.0
*/

--------------------------------------------------------------------------------
--- Limpieza de la tabla de Hechos
--------------------------------------------------------------------------------
DELETE FROM FactMaintenances;

--------------------------------------------------------------------------------
--- Limpieza de las tablas de dimensiones
--------------------------------------------------------------------------------
DELETE FROM Time;
DELETE FROM Materials;
DELETE FROM Equipments;
DELETE FROM Employees;
DELETE FROM Maintenances;
DELETE FROM Orders;
DELETE FROM OrderItems;

--------------------------------------------------------------------------------
--- Origen de datos Dimensión Material
--------------------------------------------------------------------------------
SELECT 
	MaterialID, 
	MaterialCod
FROM dbo.Materials;

--------------------------------------------------------------------------------
--- Origen de datos Dimensión Equipo
--------------------------------------------------------------------------------
SELECT 
	EquipmentID, 
	EquipmentCod,
	Name
FROM dbo.Equipments;

--------------------------------------------------------------------------------
--- Origen de datos Dimensión Empleado
--------------------------------------------------------------------------------
SELECT 
	EmployeeID, 
	FirstName,
	LastName,
	Salary
FROM dbo.Employees;

--------------------------------------------------------------------------------
--- Origen de datos Dimensión Mantenimiento
--------------------------------------------------------------------------------
SELECT 
	MaintenanceID, 
	MaintenanceType,
	WorkedHours
FROM dbo.Maintenances;

--------------------------------------------------------------------------------
--- Origen de datos Dimensión Ordenes
--------------------------------------------------------------------------------
SELECT 
	OrderID, 
	OrderCod,
	TransactionType,
	AccountDate
FROM dbo.Orders;

--------------------------------------------------------------------------------
--- Origen de datos Dimensión Orden Items
--------------------------------------------------------------------------------
SELECT 
	OrderItemID, 
	AmountLemp,
	AmountDoll,
	AmountAdd
FROM dbo.OrderItems;

--------------------------------------------------------------------------------
--- Origen de datos Dimensión Tiempo
--------------------------------------------------------------------------------
SELECT 
	CONVERT(DATE, AccountDate) TimeID, 
	DATEPART(YEAR, AccountDate) Year, 
	DATEPART(MONTH, AccountDate) Month, 
	DATEPART(WEEK, AccountDate) Week, 
	DATEPART(QUARTER, AccountDate) Trimester, 
	DATENAME(WEEKDAY, AccountDate) DayOfWeek
FROM dbo.Orders
ORDER BY Orders.AccountDate;

--------------------------------------------------------------------------------
--- Origen de datos Dimensión Tiempo
--------------------------------------------------------------------------------
SELECT 
	CONVERT(DATE, dbo.Orders.AccountDate) TimeID,
	dbo.Materials.MaterialID,
	dbo.Equipments.EquipmentID,
	dbo.Employees.EmployeeID,
	dbo.Maintenances.MaintenanceID,
	dbo.Orders.OrderID,
	dbo.OrderItems.OrderItemID,
	(SELECT SUM(dbo.OrderItems.AmountLemp) FROM dbo.OrderItems) TotalAmountLemp,
	(SELECT SUM(dbo.OrderItems.AmountDoll) FROM dbo.OrderItems) TotalAmountDoll,
	(SELECT SUM(CASE WHEN dbo.Maintenances.MaintenanceType = 'PREVENTIVO' THEN dbo.Maintenances.WorkedHours END) FROM dbo.Maintenances)TotalHoursPrev,
	(SELECT SUM(CASE WHEN dbo.Maintenances.MaintenanceType = 'CORRECTIVO' THEN dbo.Maintenances.WorkedHours END) FROM dbo.Maintenances) TotalHoursCorr,
	(SELECT COUNT(CASE WHEN dbo.Maintenances.MaintenanceType = 'PREVENTIVO' THEN dbo.Maintenances.MaintenanceID END) FROM dbo.Maintenances) TotalPrev,
	(SELECT COUNT(CASE WHEN dbo.Maintenances.MaintenanceType = 'CORRECTIVO' THEN dbo.Maintenances.MaintenanceID END) FROM dbo.Maintenances) TotalCorr,
	(SELECT COUNT(dbo.Materials.MaterialID) FROM dbo.Materials) TotalMaterials,
	(SELECT COUNT(CASE WHEN dbo.Maintenances.MaintenanceType = 'PREVENTIVO' THEN dbo.Maintenances.EquipmentID END) FROM dbo.Maintenances) TotalEquipmentPrev,
	(SELECT COUNT(CASE WHEN dbo.Maintenances.MaintenanceType = 'CORRECTIVO' THEN dbo.Maintenances.EquipmentID END) FROM dbo.Maintenances) TotalEquipmentCorr,
	(SELECT SUM(dbo.Employees.Salary) FROM dbo.Employees) TotalSalary
FROM dbo.OrderItems 
INNER JOIN dbo.Materials ON dbo.OrderItems.MaterialID= dbo.Materials.MaterialID 
INNER JOIN dbo.Orders ON dbo.OrderItems.OrderID = dbo.Orders.OrderID
INNER JOIN dbo.Employees ON dbo.Orders.EmployeeID = dbo.Employees.EmployeeID
INNER JOIN dbo.Maintenances ON dbo.Orders.MaintenanceID = dbo.Maintenances.MaintenanceID
INNER JOIN dbo.Equipments ON dbo.Maintenances.EquipmentID = dbo.Equipments.EquipmentID
GROUP BY dbo.Orders.AccountDate, dbo.OrderItems.OrderItemID,  dbo.Materials.MaterialID, dbo.Orders.OrderID, dbo.Employees.EmployeeID,
dbo.Maintenances.MaintenanceID, dbo.Equipments.EquipmentID;

