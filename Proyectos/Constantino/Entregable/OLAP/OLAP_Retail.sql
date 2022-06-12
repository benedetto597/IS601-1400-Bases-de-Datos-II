/*
  @author
  @date 15/04/2021
  @decription Proyecto BD II - OLAP Comercio general (Retail) 
  @name_file OLAP_Retail.sql
  @version 1.0

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
*/

--------------------------------------------------------
--  Dimensión MARCAS
--------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands](
	[BrandID] [int] NOT NULL,
	[BrandName] [varchar] (50) NOT NULL,
 CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED 
(
	[BrandID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Dimensión Paises
--------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Countries](
	[CountryID] [int] NOT NULL,
	[CountryName] [varchar] (50) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Dimensión Departamentos
--------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Departments](
	[DepartmentID] [int] NOT NULL,
	[DepartmentName] [varchar] (50) NOT NULL,
    [CountryID] [int] NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Dimensión Municipios
--------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Municipalities](
	[MunicipalityID] [int] NOT NULL,
	[MunicipalityName] [varchar] (50) NOT NULL,
    [DepartmentID] [int] NOT NULL,
 CONSTRAINT [PK_Municipality] PRIMARY KEY CLUSTERED 
(
	[MunicipalityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Dimensión Dirección
--------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Addresses](
	[AddressID] [int] NOT NULL,
    [CountryID] [int] NOT NULL,
    [DepartmentID] [int] NOT NULL,
    [MunicipalityID] [int] NOT NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Dimensión Sucursales
--------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Stores](
	[StoreID] [int] NOT NULL,
    [StoreName] [varchar] (50) NOT NULL,
    [AddressID] [int] NOT NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Dimensión Empleao
--------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] NOT NULL,
    [CompleteName] [varchar] (200) NOT NULL,
    [ManagerID] [int] NOT NULL,
    [StoreID] [int] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Dimensión Productos
--------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Products](
	[ProductID] [int] NOT NULL,
	[ProductName] [varchar] (50) NOT NULL,
	[ListPrice] [float] NOT NULL,
	[StandardCost] [float] NOT NULL,
    [BrandID] [int] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Dimensión Orden de venta
--------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Orders](
	[OrderID] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
    [StoreID] [int] NOT NULL,
    [EmployeeID] [int] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Dimensión Orden de venta
--------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OrderItems](
	[OrderItemID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
    [TotalPrice] [float] NOT NULL,
    [OrderID] [int] NOT NULL,
    [ProductID] [int] NOT NULL,
 CONSTRAINT [PK_OrderItem] PRIMARY KEY CLUSTERED 
(
	[OrderItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  Tabla Hechos VENTAS
--------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RetailSales](
    [OrderItemID] [int] NOT NULL,
	[TotalAmount] [float] NOT NULL,
    [TotalOrders] [int] NOT NULL,
    [TotalSoldProducts] [int] NOT NULL,
    [TotalVarianceProducts] [float] DEFAULT 0.00,
    [TotalRevenue] [float] NOT NULL,
    [StoreID] [int] NOT NULL,
    [ProductID] [int] NOT NULL,
    [EmployeeID] [int] NOT NULL,
    [OrderID] [int] NOT NULL,
 CONSTRAINT [PK_OrderItemRetail] PRIMARY KEY CLUSTERED 
(
	[OrderItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Departments]  WITH CHECK ADD FOREIGN KEY([CountryID])
REFERENCES [dbo].[Countries] ([CountryID])
GO

ALTER TABLE [dbo].[Municipalities]  WITH CHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Departments] ([DepartmentID])
GO

ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD FOREIGN KEY([CountryID])
REFERENCES [dbo].[Countries] ([CountryID])
GO

ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Departments] ([DepartmentID])
GO

ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD FOREIGN KEY([MunicipalityID])
REFERENCES [dbo].[Municipalities] ([MunicipalityID])
GO

ALTER TABLE [dbo].[Stores]  WITH CHECK ADD FOREIGN KEY([AddressID])
REFERENCES [dbo].[Addresses] ([AddressID])
GO

ALTER TABLE [dbo].[Employees]  WITH CHECK ADD FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO

ALTER TABLE [dbo].[Employees]  WITH CHECK ADD FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO

ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([BrandID])
REFERENCES [dbo].[Brands] ([BrandID])
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO

ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO

ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO

ALTER TABLE [dbo].[RetailSales]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO

ALTER TABLE [dbo].[RetailSales]  WITH CHECK ADD FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO

ALTER TABLE [dbo].[RetailSales]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO

ALTER TABLE [dbo].[RetailSales]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO

ALTER TABLE [dbo].[RetailSales]  WITH CHECK ADD FOREIGN KEY([OrderItemID])
REFERENCES [dbo].[OrderItems] ([OrderItemID])

-- ALTER TABLE [dbo].[RetailSales]  WITH CHECK ADD FOREIGN KEY([TimeID])
-- REFERENCES [dbo].[Time] ([TimeID])
-- GO
GO