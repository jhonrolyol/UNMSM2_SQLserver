--SESION 07

use neptuno22
go

--FUNCIONES PARA MANEJO DE FECHAS:

SELECT GETDATE() AS 'Dia'
SELECT DAY(GETDATE()) AS 'Día'
SELECT MONTH(GETDATE()) AS 'Mes'
SELECT YEAR(GETDATE()) AS 'Año'
go

SELECT DATEPART(YEAR, GETDATE())        AS 'Year';        
SELECT DATEPART(QUARTER, GETDATE())     AS 'Quarter';     
SELECT DATEPART(MONTH, GETDATE())       AS 'Month';       
SELECT DATEPART(DAYOFYEAR, GETDATE())   AS 'DayOfYear';   
SELECT DATEPART(DAY, GETDATE())         AS 'Day';         
SELECT DATEPART(WEEK, GETDATE())        AS 'Week';        
SELECT DATEPART(WEEKDAY, GETDATE())     AS 'WeekDay';     
SELECT DATEPART(HOUR, GETDATE())        AS 'Hour';        
SELECT DATEPART(MINUTE, GETDATE())      AS 'Minute';      
SELECT DATEPART(SECOND, GETDATE())      AS 'Second';      
SELECT DATEPART(MILLISECOND, GETDATE()) AS 'MilliSecond'; 
SELECT DATEPART(MICROSECOND, GETDATE()) AS 'MicroSecond'; 
SELECT DATEPART(NANOSECOND, GETDATE())  AS 'NanoSecond';  
go
SELECT DATENAME(YEAR, GETDATE())        AS 'Year';        
SELECT DATENAME(QUARTER, GETDATE())     AS 'Quarter';     
SELECT DATENAME(MONTH, GETDATE())       AS 'Month';       
SELECT DATENAME(DAYOFYEAR, GETDATE())   AS 'DayOfYear';   
SELECT DATENAME(DAY, GETDATE())         AS 'Day';         
SELECT DATENAME(WEEK, GETDATE())        AS 'Week';        
SELECT DATENAME(WEEKDAY, GETDATE())     AS 'WeekDay';     
SELECT DATENAME(HOUR, GETDATE())        AS 'Hour';        
SELECT DATENAME(MINUTE, GETDATE())      AS 'Minute';      
SELECT DATENAME(SECOND, GETDATE())      AS 'Second';      
SELECT DATENAME(MILLISECOND, GETDATE()) AS 'MilliSecond'; 
SELECT DATENAME(MICROSECOND, GETDATE()) AS 'MicroSecond'; 
SELECT DATENAME(NANOSECOND, GETDATE())  AS 'NanoSecond';  
SELECT DATENAME(ISO_WEEK, GETDATE())    AS 'Week';
go

--DATEADD: devuelve datepart con intervalo agregado como fecha y hora
https://docs.microsoft.com/en-us/sql/t-sql/functions/dateadd-transact-sql?view=sql-server-ver16

SELECT DATEADD(DAY,1,GETDATE()) AS 'DatePlus1';	
go

--DATEDIFF: devuelve el número de fecha u hora datepart límites cruzados entre fechas especificadas como un int
https://docs.microsoft.com/en-us/sql/t-sql/functions/datediff-transact-sql?view=sql-server-ver16

set dateformat ymd

SELECT DATEDIFF(DAY, '2019-01-01', '2019-01-31')      AS 'DateDif'    -- returns int
go
SELECT DATEDIFF(DAY, '2019-31-01', '2019-01-31')      AS 'DateDif'    -- returns int
go


--Propuestos :
	use Neptuno22

/*1. Mostrar los campos codigo de producto, nombre, precio de los productos
	 ordenado por precio y en valores coincidentes , ordenarlos por nombre.*/
	 SELECT * FROM Productos
	 GO
	 SELECT Prod.IdProducto, Prod.NombreProducto, Prod.PrecioUnidad
	 FROM Productos AS Prod
	 ORDER BY Prod.PrecioUnidad ASC, Prod.NombreProducto ASC 
	 GO
/* 2. Listar el codigo de pedido, fecha de pedido y codigo de cliente de los pedidos
      realizados en el año 1997. */
	  SELECT * FROM Clientes
	  GO
	  SELECT * FROM Pedidos
	  GO
	  SELECT P.IdPedido, P.FechaPedido, Cli.IdCliente
	  FROM Pedidos AS P
	  INNER JOIN Clientes AS Cli
	  ON Cli.IdCliente = P.IdCliente
	  WHERE P.FechaPedido >= '01/01/1997' AND P.FechaPedido <= '12/31/1997'
	  GO

	  select p.IdPedido, p.FechaPedido, p.IdCliente
	  from Pedidos as p
	  where year(p.FechaPedido) = 1997
	  go

	  set dateformat dmy
	  select p.IdPedido, p.FechaPedido, p.IdCliente
	  from Pedidos as p
	  where p.FechaPedido between 
	  go


/* 3. Listar el codigo de pedido, fecha de pedido, codigo de cliente y razón social
      de los pedidos realizados en el año 1997.*/
	  SELECT * FROM Pedidos
	  GO
	  SELECT * FROM Clientes
	  GO
	  SELECT P.IdPedido, P.FechaPedido, Cli.IdCliente, Cli.NombreCompañía
	  FROM Pedidos AS P
	  INNER JOIN Clientes AS Cli
	  ON Cli.IdCliente = P.IdCliente
	  WHERE P.FechaPedido >= '01/01/1997' AND P.FechaPedido <= '12/31/1997'
	  GO

	  SELECT P.IdPedido, P.FechaPedido, Cli.IdCliente, Cli.NombreCompañía
	  FROM Pedidos AS P
	  INNER JOIN Clientes AS Cli
	  ON Cli.IdCliente = P.IdCliente
	  where year(p.FechaPedido) = 1997
	  GO



/* 4. Listar el codigo de pedido, fecha de pedido y dias transcurridos entre la
      fecha del pedido y la fecha de entrega de pedido. Procesar unicamente los
	  pedidos realizados en el año 1998. */
	  SELECT * FROM Pedidos
	  GO
	  SELECT P.IdPedido, P.FechaPedido,  DATEDIFF(DAY, P.FechaPedido,P.FechaEntrega)  AS DiasTranscurridos
	  FROM Pedidos AS P
	  WHERE P.FechaPedido >= '01/01/1998' AND P.FechaPedido <= '12/31/1999' 
	  GO

	  SELECT P.IdPedido, P.FechaPedido,  DATEDIFF(DAY, P.FechaPedido,P.FechaEntrega)  AS DiasTranscurridos
	  FROM Pedidos AS P
	  where year(p.FechaPedido) = 1998 
	  GO



/*5. Listar el número de pedido, fecha de pedido, nombre del producto y precio de los productos.
     Mostrar los productos solicitados entre los meses julio y agosto de 1996.*/
	 SELECT * FROM Pedidos
	 GO
	 SELECT * FROM Productos
	 GO
	 SELECT * FROM [Detalles de pedidos]
	 GO

	select P.IdPedido, P.FechaPedido, Pr.NombreProducto, Pr.PrecioUnidad	from Pedidos as P	inner join [Detalles de pedidos] as DP	on P.IdPedido = DP.IdPedido	inner join Productos as Pr	on DP.IdProducto=Pr.IdProducto	where MONTH(p.FechaPedido) between 7 and 8 and year(p.FechaPedido)=1996	go


/*6. Listar el número de pedido, fecha de pedido, nombre del producto y precio de los productos.
     Mostrar los productos solicitados entre los meses julio y agosto de 1996.*/

	select P.IdPedido, P.FechaPedido, Pr.NombreProducto, Pr.PrecioUnidad	from Pedidos as P	inner join [Detalles de pedidos] as DP	on P.IdPedido = DP.IdPedido	inner join Productos as Pr	on DP.IdProducto=Pr.IdProducto	where MONTH(p.FechaPedido) between 7 and 8 and year(p.FechaPedido)=1996	go



/*7. Listar el número de pedido, fecha de pedido, nombre del producto, precio de los productos
     y nombre del proveedor del producto.
     Mostrar los productos solicitados en el año 1997 y cuyo precio se encuentre entre 10 y 30.*/
	 SELECT * FROM Pedidos 
	 GO
	 SELECT * FROM Productos
	 GO
	 SELECT * FROM Proveedores
	 GO

	 select p.IdPedido, p.FechaPedido,pro.NombreProducto,pro.PrecioUnidad,pv.NombreCompañía	 from Pedidos p	 inner join [Detalles de pedidos] dp	 on p.IdPedido = dp.IdPedido	 inner join Productos pro	 on dp.IdProducto=pro.IdProducto	 inner join Proveedores pv	 on pro.IdProveedor=pv.IdProveedor	 where year(p.FechaPedido)=1997 and pro.PrecioUnidad between 10 and 30	 go



	 select p.IdPedido,p.FechaPedido,prod.IdProducto,dp.PrecioUnidad,prov.NombreCompañía	 from [Detalles de pedidos]as dp	 inner join pedidos as p	 on dp.IdPedido=p.IdPedido	 inner join Productos as prod	 on dp.IdProducto=prod.IdProducto	 inner join Proveedores as prov	 on prod.IdProveedor=prov.IdProveedor	 where YEAR(p.fechapedido)= 1997 and dp.PrecioUnidad >=10 and dp.PrecioUnidad<=30 	 go






--FUNCIONES PARA MANEJO DE CADENAS :
https://docs.microsoft.com/en-us/sql/t-sql/functions/string-functions-transact-sql?view=sql-server-ver16

--LEN
https://docs.microsoft.com/en-us/sql/t-sql/functions/len-transact-sql?view=sql-server-ver1617

SELECT nombreproducto, LEN(nombreProducto) AS Length, PrecioUnidad   
FROM Productos  
GO  


--LTRIM
https://docs.microsoft.com/en-us/sql/t-sql/functions/ltrim-transact-sql?view=sql-server-ver16

Begin
	DECLARE @string_to_trim VARCHAR(60);  
	SET @string_to_trim = '     5 spaces are at the beginning of this string.';  
	SELECT 
		@string_to_trim AS 'Original string',
		LTRIM(@string_to_trim) AS 'Without spaces';  
End
GO  

--RTRIM
https://docs.microsoft.com/en-us/sql/t-sql/functions/rtrim-transact-sql?view=sql-server-ver16


Begin
	DECLARE @string_to_trim VARCHAR(60);  
	SET @string_to_trim = '     3 espacios se encuentran al final de esta cadena.   ';  
	SELECT 
		@string_to_trim AS 'Original string',
		LEN(@string_to_trim) AS 'Longitud original',
		RTRIM(@string_to_trim) AS 'Without spaces', 
		LEN(RTRIM(@string_to_trim)) AS 'Longitud';
End
GO  

--SUBSTRING/LOWER/UPPER
https://docs.microsoft.com/en-us/sql/t-sql/functions/substring-transact-sql?view=sql-server-ver16
https://docs.microsoft.com/en-us/sql/t-sql/functions/lower-transact-sql?view=sql-server-ver16
https://docs.microsoft.com/en-us/sql/t-sql/functions/upper-transact-sql?view=sql-server-ver16

SELECT pv.NombreCompañía,
	   LOWER(SUBSTRING(pv.NombreCompañía, 1, 10)) AS Lower,   
       UPPER(SUBSTRING(pv.NombreCompañía, 1, 10)) AS Upper,   
       LOWER(UPPER(SUBSTRING(pv.NombreCompañía, 1, 10))) As LowerUpper
FROM Proveedores AS PV
GO



--PROPUESTO :
--investigar las funciones : str, cast, convert, concat

/*Mostrar el codigo del cliente, su nombre y genere un password de acceso al
  sistema. El paswword estará formado por el año de la fecha actual concatenado
  con los 2 primeros caracteres del nombre y los 2 caracteres del pais.*/

  select c.IdCliente, c.NombreCompañía, trim(str(YEAR(GETDATE())))+ left(c.NombreCompañía,2)+		 substring(c.País,1,2) as 'password'   from Clientes as c  go


--FIN