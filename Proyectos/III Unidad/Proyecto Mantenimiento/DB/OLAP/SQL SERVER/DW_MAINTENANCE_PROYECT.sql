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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Time](
	[TimeID] [date] NOT NULL,
	[Year] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[Week] [int] NOT NULL,
	[Trimester] [int] NOT NULL,
	[DayOfWeek] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TimeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

--------------------------------------------------------
--  Dimensión MATERIAL
--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Materials](
	[MaterialID] [int] NOT NULL,
	[MaterialCod] [int] NOT NULL,
 CONSTRAINT [PK_Material] PRIMARY KEY CLUSTERED 
(
	[MaterialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Dimensión EQUIPO
--------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Equipments](
	[EquipmentID] [int] NOT NULL,
	[EquipmentCod] [char] (7) NOT NULL,
	[Name] [varchar] (100) NOT NULL,
 CONSTRAINT [PK_Equipment] PRIMARY KEY CLUSTERED 
(
	[EquipmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Dimensión EMPLEADO
--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] NOT NULL,
	[WholeName] [nvarchar] (100) NOT NULL,
	[Salary] [float] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Dimensión MANTENIMIENTO
--------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Maintenances](
	[MaintenanceID] [int] NOT NULL,
	[MaintenanceType] [varchar] (20) NOT NULL,
	[WorkedHours] [float] NOT NULL,
 CONSTRAINT [PK_Maintenance] PRIMARY KEY CLUSTERED 
(
	[MaintenanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Dimensión ORDEN
--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Orders](
	[OrderID] [int] NOT NULL,
	[OrderCod] [char] (9) NOT NULL,
	[TransactionType] [varchar] (20) NOT NULL,
	[AccountDate] [date] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Dimensión ORDEN ITEM
--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OrderItems](
	[OrderItemID] [int] NOT NULL,
	[AmountLemp] [float] NOT NULL,
	[AmountDoll] [float] NOT NULL,
	[AmountAdd] [int] NOT NULL,
 CONSTRAINT [PK_OrderItem] PRIMARY KEY CLUSTERED 
(
	[OrderItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Tabla HECHOS MANTENIMIENTOS
--------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FactMaintenances](
	[FactMaintenanceID] [int] IDENTITY(1,1) NOT NULL,
	[TimeID] [int] NOT NULL,
	[MaterialID] [int] NOT NULL,
	[EquipmentID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[MaintenanceID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[OrderItemID] [int] NOT NULL,
	[TotalAmountLemp] [float] NOT NULL,
	[TotalAmountDoll] [float] NOT NULL,
	[TotalHoursPrev] [float] NOT NULL,
	[TotalHoursCorr] [float] NOT NULL,
	[TotalPrev] [int] NOT NULL,
	[TotalCorr] [int] NOT NULL,
	[TotalMaterials] [int] NOT NULL,
	[TotalEquipmentPrev] [int] NOT NULL,
	[TotalEquipmentCorr] [int] NOT NULL,
	[TotalSalary] [float] NOT NULL,
 CONSTRAINT [PK_FactMaintenance] PRIMARY KEY CLUSTERED 
(
	[FactMaintenanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactMaintenances]  WITH CHECK ADD FOREIGN KEY([TimeID])
REFERENCES [dbo].[Time] ([TimeID])
GO
ALTER TABLE [dbo].[FactMaintenances]  WITH CHECK ADD FOREIGN KEY([MaterialID])
REFERENCES [dbo].[Materials] ([MaterialID])
GO
ALTER TABLE [dbo].[FactMaintenances]  WITH CHECK ADD FOREIGN KEY([EquipmentID])
REFERENCES [dbo].[Equipments] ([EquipmentID])
GO
ALTER TABLE [dbo].[FactMaintenances]  WITH CHECK ADD FOREIGN KEY([MaintenanceID])
REFERENCES [dbo].[Maintenances] ([MaintenanceID])
GO
ALTER TABLE [dbo].[FactMaintenances]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[FactMaintenances]  WITH CHECK ADD FOREIGN KEY([OrderItemID])
REFERENCES [dbo].[OrderItems] ([OrderItemID])
GO
  
