<div align="center">

![image](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL-asWnyC6AWsiAreZmNaTxOpld0BCmlGmZuLJvVt8pGP1xbkuaqV7tYlxcOfn0N83Izk&usqp=CAU)
    
<!-- Encabezado -->
## Proyecto - Venta de Retail
### IS601 -  Bases de datos II
### Integrantes 

| Nombre | Numero De Cuenta | Correo |
|:-------------:| :-----:|:-----:|
| Jesé Daniel Aguilar Martínez | `20141012902` | [jese.aguilar@unah.hn](mailto:jese.aguilar@unah.hn) |
| Demsey Giovany Euceda Sanchez | `20161000978` | [demsey.euceda@unah.hn](mailto:demsey.euceda@unah.hn) |
| Anibal Alejandro Reyes | `20171003445` | [anibalreyes@unah.hn](mailto:anibalreyes@unah.hn) |
| Francisca Alejandra Ramirez  | `20151003826` | [framirezd@unah.hn](mailto:framirezd@unah.hn) |


</div>

______
______

### Flujo de creación del proyecto
1. Crear la base de datos **OLTP_Retail** y ejecutar el query para la creación de las siguientes tablas:
   1. Categoria
   2. Marcas
   3. Productos
   4. Inventario (stock)
   5.  Proveedores
   6. Clientes
   7. Sucursales
   8.  Direccion
   9.  Pais
   10. Departamento
   11. Municipio
   12. Empleados
   13. Orden de venta
   14. Detalle de la orden de venta

2. Poblar la base de datos OLTP con una herramienta de población de datos.
3. Seleccionar las preguntas de negocio y metricas para la base OLAP
   1. Preguntas de negocio
      1. Productos que representan un mayor margen de ganancia al mes.
      2. Productos más vendidos al mes.
      3. Sucursal que más productos vende en un año.
      4. Marcas de productos más vendidas en una semana.
      5. Categorias de productos que más se compran a los proveedores en un mes.
      6. Horas en las que más se realizan ordenes de ventas al día.
      7. Municipios donde hay una mayor cantidad de ventas.
      8. Tiendas que producen la mayor ganancia al mes.
      9. Empleados que producen más ventas en una semana.
      10. Sucursal que tenga a los empleados con más productos vendidos al mes.
   
   2.  Metricas seleccionadas
       1. Empleados que producen más ventas al trimestre.
       2. Sucursal que producen la mayor cantidad de ventas al mes.
       3. Productos más variacion al mes.
       4. Marcas de productos más vendidas en una semana.
       5. Municipios donde hay una mayor cantidad de ventas al año.
4. Crear la base de datos **OLAP_Retail** (Modelo Copo de nieve) y ejecutar el query para la creación de las siguientes tablas:
   1. Dimensiones
      1. Empleado
      2. Sucursal
      3. Orden de venta
      4. Detalles de la orden de venta
      5. Marca
      6. Producto
      7. Dirección
      8. Tiempo
   2. Hechos
      1. Ventas
   
5. Crear los ETL para poblar la base de datos OLAP_Retail:
   1. Crear un nuevo proyecto en Visual Studio (SSDT) que se de **Integración de servicio**
   2. Cambiar el nombre del paquete en el **Explorador de soluciones** a **DataMart_RetailSales** para poder hacer la publicación de los servicios correctamente
   3. Pasos para crear la tabla dimensión
      1. Tarea de flujo de datos **Insertar y Actualizar** de la OLTP a la OLAP
         1. En el flujo de control agregar una tarea de flujo de datos
         2. En Explorador de soluciones se deben agregar conexiones con el administrador de conexiones (dando click derecho)
         3. Crear dos nuevas conexiones usando ADO.NET
         4. Colocar el nombre del servidor donde con solo poner un punto ya aparecen las bases que se tienen en local en el SQL Server o se puede escribir el nombre del servidor en concreto al que se quiere conectar
         5. Se selecciona la base de la que se extraerá la data (OLTP_Retail) y la en la otra conexion seleccionar la base de analisis (OLAP_Retail), se prueba la conexion y se guarda
         6. En el flujo de datos agregar el origen **Origen de ADO NET** y seleccionar la conexión OLTP_Retail y seleccionar la tabla o escribir la consulta para extraer la data requerida
         7. En el flujo de datos agregar el destino **Destino de ADO NET** y seleccionar la base de destino OLAP_Retail y asegurarse de que esten asignados correctamente los campos entre las tablas
         8. Hacer la validación para que solo se agreguen a la base OLAP los nuevos registros encontrados en la base de origen OLTP haciendo uso de otro Origen de ADO NET junto al Ordenar para ordenar los registros por identificador y agregar el combinador de mezcla para diferenciar entre los datos de la OLAP y la OLTP luego usar la herramienta de división condicional para definir que registros ya existen en la base OLAP
         9.  Agregar a la división condicional una nueva regla para identificar cuando se modifica un registro y usar un comando OLE DB (Crear y seleccionar la conexión de la base de datos OLAP) para poder realizar la actualización en la base de datos, en propiedades del componente se debe colocar la consulta SQL que permita actualizar la data de la tabla y por último se deben realizar las asignaciones de las variables de la consulta de actualización (usando las de la tabla de origen OLTP) 
      2. Tarea de flujo de datos **Eliminar** de la OLTP a la OLAP
         1. Crear los origines de datos para la OLAP y la OLTP para validar que lo que este en la OLAP y no esté en la OLTP se debe eliminar
         2. Ordenar los datos por su identificador
         3. Unirlos en una sola tabla usando el left join
         4. Condicionar para que solo devuelva los registros que no estén en la OLTP
         5. Hacer un comando OLEDB para eliminar los registros de la base OLAP
   4. Pasos para crear el JOB para automatizar la carga de las dimensiones
      1. En SSDT darle click derecho al proyecto en Exploracion de soluciones y sleccionar implementar
      2. Escoger el servidor, se puede usar un punto para designar que se trabaja en local
      3. Crear un nuevo catalogo de integracion en el SQL Server (Si da error se debe ejecutar el instalador SQL Server Installation Center y se debe marcar la opción de **Integration Services**) en el que se debe asignar una contraseña: 
         1. Contraseña: **retail123**
      4. Continuando en SSDT se debe examinar la ruta de acceso creando una nueva carpeta en el catalogo de integración recientemente creado
      5. En el SQL Server ya se creo la implementacion del proyecto se debe de validar el proyecto, dando click derecho a los archivos del proyecto y seleccionar "Validar"
      6. En el SQL Server en el SQL Server Agent agregar el job poniendo como dueño al SQL Server Agent
      7. Agregar un step o paso dejando el tipo SQL Server Integration Services Package y en la pestaña de configuración en avanzado se debe marcar el checkbox de que el tiempo de ejecución sea de 32 bits
      8. Agregar un schedule o programación para que corra a diario y cada cierta cantidad de minutos

### Flujo de implementación del proyecto
1. Crear la base de datos **OLTP_Retail** y ejecutar el query **OLTP_Retail.sql** para la creación de las tablas
2. Crear la base de datos **OLAP_Retail** y ejecutar el query **OLAP_Retail.sql** para la creación de las tablas
3. Poblar la base de datos con la herramienta de generación de datos
4. Crear el catalogo para luego realizar la implementación del proyecto (ETL) desde SSDT y crear el JOB para que el ETL se ejecute periodicamente
5. Crear los cubos para el análisis de datos 
6. Realizar la integración del servicio de análisis con el servicio de reporteria para poder mostrar los datos en dashboards
______

### Consultas SQL 
#### Consulta SQL para la la tabla de dimension empleados de la base de datos OLAP_Retail
```sql
SELECT 
   EmployeeID,
   CONCAT(FirstName, ' ', LastName) CompleteName,
   ManagerID,
   StoreID,
FROM Employees
```

#### Consulta SQL para la la tabla de dimension ordenes de venta de la base de datos OLAP_Retail
```sql
SELECT 
	dbo.Orders.OrderID,
	CONVERT(DATETIME, SUBSTRING(dbo.Orders.OrderDate, 1,2) + '/' + SUBSTRING(dbo.Orders.OrderDate, 3,2) + '/' + SUBSTRING(dbo.Orders.OrderDate, 5,4)) AS OrderDate,
	dbo.Orders.StoreID,
	dbo.Orders.EmployeeID
FROM
	dbo.Orders
```

### Consulta SQL para la la tabla de hechos de la base de datos OLAP_Retail
```sql
SELECT
	SUM(dbo.OrdersItems.TotalPrice) AS TotalAmount,
	(SELECT COUNT(dbo.Orders.OrderID) FROM dbo.Orders)  AS TotalOrders,
	(SELECT SUM(dbo.OrdersItems.Quantity) FROM dbo.OrdersItems WHERE dbo.OrdersItems.OrderID = dbo.Orders.OrderID) AS TotalSoldProducts,
	(SELECT VAR(dbo.OrdersItems.Quantity) FROM dbo.OrdersItems WHERE dbo.OrdersItems.OrderID = dbo.Orders.OrderID) AS TotalVarianceProducts,
	(SUM(dbo.OrdersItems.TotalPrice) - (SUM(dbo.Products.StandardCost) * SUM(dbo.OrdersItems.Quantity)))  AS TotalRevenue,
	dbo.Stores.StoreID,
	dbo.Products.ProductID,
	dbo.Employees.EmployeeID,
	dbo.Orders.OrderID,
	dbo.OrdersItems.OrderItemID
FROM dbo.OrdersItems
INNER JOIN dbo.Orders 
ON dbo.OrdersItems.OrderID = dbo.Orders.OrderID 
INNER JOIN dbo.Products
ON dbo.OrdersItems.ProductID = dbo.Products.ProductID
INNER JOIN dbo.Stores
ON dbo.Orders.StoreID = dbo.Stores.StoreID
INNER JOIN dbo.Employees
ON dbo.Orders.EmployeeID = dbo.Employees.EmployeeID
GROUP BY dbo.Stores.StoreID, dbo.Products.ProductID, dbo.Employees.EmployeeID, dbo.Orders.OrderID, dbo.OrdersItems.OrderItemID
```

### Observaciones 
* Cuando SQL Server no permita crear el diagrama por el error code **0x534** se debe colocar la siguiente consulta como nueva query en la base de datos donde se da el error:
   ```sql
   USE yourdatabasename
   GO
   EXEC sp_changedbowner 'sa'
   ```
* Herramienta para realizar el llenado de la base de datos OLTP_Retail
  * [dbForge Data Generator](https://www.devart.com/dbforge/sql/data-generator/download.html)