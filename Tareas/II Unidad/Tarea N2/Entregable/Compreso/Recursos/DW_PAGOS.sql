/*
  @author edgar.benedetto@unah.hn
  @date 14/03/2021
  @version 1.0
  
  Tarea #2 Base de datos OLAP
*/

    USE [DW_PAGOS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------
--  Dimension DEPARTAMENTO
--------------------------------------------------------
CREATE TABLE [dbo].[DEPARTAMENTO](
	[ID_DEPARTAMENTO] [int] NOT NULL,
	[DEPARTAMENTO] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DEPARTAMENTO] PRIMARY KEY CLUSTERED 
(
	[ID_DEPARTAMENTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
---------------------------------------------------------
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------
--  Dimension Ciudad
--------------------------------------------------------
CREATE TABLE [dbo].[CIUDAD](
	[ID_CIUDAD] [int] NOT NULL,
	[ID_DEPARTAMENTO] [int] NOT NULL,
	[CIUDAD] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_CIUDAD] PRIMARY KEY CLUSTERED 
(
	[ID_CIUDAD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
---------------------------------------------------------
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------
--  Dimension Direccion
--------------------------------------------------------
CREATE TABLE [dbo].[DIRECCION](
	[ID_DIRECCION] [int] NOT NULL,
	[ID_CIUDAD] [int] NOT NULL,
	[COLONIA] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DIRECCION] PRIMARY KEY CLUSTERED 
(
	[ID_DIRECCION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
---------------------------------------------------------
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------
--  Dimension Pago
--------------------------------------------------------
CREATE TABLE [dbo].[PAGO](
	[ID_PAGO] [int] NOT NULL,
	[MONTO] DECIMAL(18,2) NOT NULL,
	[FECHA] [date] NOT NULL,
 CONSTRAINT [PK_PAGO] PRIMARY KEY CLUSTERED 
(
	[ID_PAGO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
---------------------------------------------------------
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------
--  Dimension Tienda
--------------------------------------------------------
CREATE TABLE [dbo].[TIENDA](
	[ID_TIENDA] [int] NOT NULL,
	[ID_DIRECCION] [int] NOT NULL,
 CONSTRAINT [PK_TIENDA] PRIMARY KEY CLUSTERED 
(
	[ID_TIENDA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
---------------------------------------------------------
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------
--  Dimension Cliente
--------------------------------------------------------
CREATE TABLE [dbo].[CLIENTE](
	[ID_CLIENTE] [int] NOT NULL,
	[ID_TIENDA] [int] NOT NULL,
    [NOMBRE] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_CLIENTE] PRIMARY KEY CLUSTERED 
(
	[ID_CLIENTE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
---------------------------------------------------------
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------
--  Dimension Empleado
--------------------------------------------------------
CREATE TABLE [dbo].[EMPLEADO](
	[ID_EMPLEADO] [int] NOT NULL,
	[ID_TIENDA] [int] NOT NULL,
    [NOMBRE] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_EMPLEADO] PRIMARY KEY CLUSTERED 
(
	[ID_EMPLEADO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
---------------------------------------------------------
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------
--  Dimension Tiempo
--------------------------------------------------------
CREATE TABLE [dbo].[TIEMPO](
	[ID_TIEMPO] [date] NOT NULL,
	[AÑO] [int] NULL,
	[MES] [int] NULL,
	[SEMANA] [int] NULL,
	[TRIMESTRE] [int] NULL,
	[DIA_DE_SEMANA] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_TIEMPO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
---------------------------------------------------------
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------
--  Tabla de Hechos
--------------------------------------------------------
CREATE TABLE [dbo].[HECHOS_PAGOS](
	[ID_HECHOS] [int] IDENTITY(1,1) NOT NULL,
	[ID_EMPLEADO] [int] NOT NULL,
	[ID_CLIENTE] [int] NOT NULL,
	[ID_PAGO] [int] NOT NULL,
	[ID_TIEMPO] [date] NOT NULL,
	[COUNT_PAGOS] [int] NULL,
	[MOUNT_PAGOS] DECIMAL(18,2) NULL,
 CONSTRAINT [PK_HECHOS_PAGOS] PRIMARY KEY CLUSTERED 
(
	[ID_HECHOS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[HECHOS_PAGOS]  WITH CHECK ADD FOREIGN KEY([ID_EMPLEADO])
REFERENCES [dbo].[EMPLEADO] ([ID_EMPLEADO])
GO
ALTER TABLE [dbo].[HECHOS_PAGOS]  WITH CHECK ADD FOREIGN KEY([ID_CLIENTE])
REFERENCES [dbo].[CLIENTE] ([ID_CLIENTE])
GO
ALTER TABLE [dbo].[HECHOS_PAGOS]  WITH CHECK ADD FOREIGN KEY([ID_PAGO])
REFERENCES [dbo].[PAGO] ([ID_PAGO])
GO
ALTER TABLE [dbo].[HECHOS_PAGOS]  WITH CHECK ADD FOREIGN KEY([ID_TIEMPO])
REFERENCES [dbo].[TIEMPO] ([ID_TIEMPO])
GO
