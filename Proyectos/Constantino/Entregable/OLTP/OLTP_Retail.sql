/*
  @author
  @date 15/04/2021
  @decription Proyecto BD II - OLTP Comercio general (Retail) 
  @name_file OLTP_Retail.sql
  @version 1.0
*/

--------------------------------------------------------
--  DDL para la tabla Categoria
--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] NOT NULL,
	[CategoryName] [varchar] (50) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  DDL para la tabla Marcas
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
--  DDL para la tabla Paises
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
--  DDL para la tabla Departamentos
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
--  DDL para la tabla Municipios
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
--  DDL para la tabla Direcciones
--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Addresses](
	[AddressID] [int] NOT NULL,
	[AddressLine] [varchar] (100) NOT NULL,
	[ZipCode] [int] NOT NULL,
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
--  DDL para la tabla Clientes
--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Clients](
	[ClientID] [int] NOT NULL,
	[FirstName] [varchar] (100) NOT NULL,
	[LastName] [varchar] (100) NOT NULL,
    [Gender] [varchar] (10) CHECK (Gender IN ('Female', 'Male', 'Other')) NOT NULL,
    [Age] [int] CHECK (Age>=8) NOT NULL,
	[Phone] [char] (14) DEFAULT '+504 9999-9999' NOT NULL,
    [Email] [varchar] (50) NOT NULL,
    [AddressID] [int] NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  DDL para la tabla Sucursales
--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Stores](
	[StoreID] [int] NOT NULL,
	[StoreName] [varchar] (50) NOT NULL,
    [Phone] [char] (14) DEFAULT '+504 9999-9999' NOT NULL,
    [Email] [varchar] (50) NOT NULL,
    [AddressID] [int] NOT NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  DDL para la tabla Proveedores
--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [int] NOT NULL,
	[SupplierName] [varchar] (50) NOT NULL,
    [Phone] [char] (14) DEFAULT '+504 9999-9999' NOT NULL,
    [AddressID] [int] NOT NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  DDL para la tabla Productos
--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Products](
	[ProductID] [int] NOT NULL,
	[ProductName] [varchar] (50) NOT NULL,
	[ReleaseYear] [int] NOT NULL,
	[ListPrice] [float] NOT NULL,
	[StandardCost] [float] NOT NULL,
    [BrandID] [int] NOT NULL,
    [CategoryID] [int] NOT NULL,
    [SupplierID] [int] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  DDL para la tabla Inventarios
--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Stocks](
	[StockID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
    [StoreID] [int] NOT NULL,
    [ProductID] [int] NOT NULL,
 CONSTRAINT [PK_Stock] PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  DDL para la tabla Empleados
--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] NOT NULL,
    [FirstName] [varchar] (100) NOT NULL,
	[LastName] [varchar] (100) NOT NULL,
    [Active] [bit] NOT NULL,
	[Phone] [char] (14) DEFAULT '+504 9999-9999' NOT NULL,
    [Email] [varchar] (50) NOT NULL,
    [ManagerID] [int] NOT NULL,
    [StoreID] [int] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  DDL para la tabla Ordenes de venta
--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Orders](
	[OrderID] [int] NOT NULL,
    [Status] [int] NOT NULL,
    -- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	[OrderDate] [char] (8) NOT NULL,
    [RequiredDate] [char] (8) NOT NULL,
    [ShippedDate] [char] (8),
    [ClientID] [int] NOT NULL,
    [StoreID] [int] NOT NULL,
    [EmployeeID] [int] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--------------------------------------------------------
--  DDL para la tabla Detalles de ordenes de venta
--------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[OrdersItems](
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

ALTER TABLE [dbo].[Clients]  WITH CHECK ADD FOREIGN KEY([AddressID])
REFERENCES [dbo].[Addresses] ([AddressID])
GO

ALTER TABLE [dbo].[Stores]  WITH CHECK ADD FOREIGN KEY([AddressID])
REFERENCES [dbo].[Addresses] ([AddressID])
GO

ALTER TABLE [dbo].[Suppliers]  WITH CHECK ADD FOREIGN KEY([AddressID])
REFERENCES [dbo].[Addresses] ([AddressID])
GO

ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([BrandID])
REFERENCES [dbo].[Brands] ([BrandID])
GO

ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO

ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO

ALTER TABLE [dbo].[Stocks]  WITH CHECK ADD FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO

ALTER TABLE [dbo].[Stocks]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO

ALTER TABLE [dbo].[Employees]  WITH CHECK ADD FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO

ALTER TABLE [dbo].[Employees]  WITH CHECK ADD FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO

ALTER TABLE [dbo].[OrdersItems]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO

ALTER TABLE [dbo].[OrdersItems]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
