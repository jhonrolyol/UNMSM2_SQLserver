--SESION 06

USE NEPTUNO22
GO

--a.Seleccionar ciertos campos de una tabla
-----------

--Lista todas las columnas de la tabla empleado.

Select * from Empleados
go


--Lista el nombre y los apellidos de todos los empleados.

select e.Nombre , e.Apellidos
from Empleados as e --alias acorta el identificador de una tabla
go

--b. ORDENAMIENTO: ascendente,descendente
-----------------

select e.Nombre , e.Apellidos
from Empleados as e 
order by e.Apellidos -- El "order by" Ordena de manera ascendente por defecto 
go

select e.Nombre , e.Apellidos
from Empleados as e 
order by e.Apellidos asc -- "asc" indica un ordenamiento ascendente
go

select e.Nombre , e.Apellidos
from Empleados as e 
order by e.Apellidos desc -- "desc" indica un ordenamiento descendente
go


select e.Nombre , e.Apellidos
from Empleados as e 
order by 2 asc -- El "2" indica que se va ordenar por el campo que tiene la posici�n 2 (e.Apellidos)
go


-- mostrar los campos c�digo, ap�llidos y tratamiento.
--ordenarlo de manera ascendente por tratamiento

select e.IdEmpleado, e.Apellidos, e.Tratamiento
from Empleados as e -- Donde "e" es el alias
order by 3 asc
go

--caso 2
select a.IdEmpleado, a.Apellidos, a.Tratamiento
from empleados as a --Donde "a" es el alias
go

--c. PREDICADOS: ALL, TOP, DISTINCT
-----------------

select * from [Detalles de pedidos] -- Los corchetes salen por defecto (por los espacios que hay)
go

select * from "Detalles de pedidos" -- Las comillas " " se pueden usar en lugar de los corchetes [ ] 
go


--ALL: Todos los registros
select ALL * from [Detalles de pedidos] -- El "All" sale por defecto al usar el select (en este caso se est� colocando)
go

--TOP : Indica la cantidad de registro como muestra que obtengo

--muestra los 3 primeros registros
select top 3 * from [Detalles de pedidos]
go

select ALL top 3 * from [Detalles de pedidos] -- En este caso incluimos el "All" (el resultado anterior no cambia)
go

--muestra los 10 primeros registros
select top 10 * from [Detalles de pedidos]
go

select top 10 IdPedido,IdProducto from [Detalles de pedidos] -- En este caso consideramos solamente dos campos (IdPedido,IdProducto)
go

--muestra los 10 �ltimos registros
select top 10 * from [Detalles de pedidos]
order by IdPedido desc
go

select top 10 * from [Detalles de pedidos]
order by 1 desc -- En este caso el "1" es el campo IdPedido
go

--DISTINCT

--SELECCIONAR LOS CAMPOS PRODUCTO Y PRECIO DE LA TABLA DETALLES DE PEDIDOS
	SELECT D.IdProducto, D.PrecioUnidad 
	FROM [Detalles de pedidos] AS D
	ORDER BY 1 -- El "ASC" est� por defecto (El "ORDER BY" por defecto ordena de manera ascendente)
	GO

	SELECT DISTINCT D.IdProducto, D.PrecioUnidad 
	FROM [Detalles de pedidos] AS D
	ORDER BY 1 -- El "ASC" est� por defecto
	GO

	SELECT DISTINCT D.IdProducto
	FROM [Detalles de pedidos] AS D
	ORDER BY 1 -- El "ASC" est� por defecto
	GO


--d. alias
----------

	-- Ya se us� en los ejercicios previos

--Propuestos:
-------------

/*1.Lista el nombre de la compa��a y pais de todos los clientes ordenado de manera descendente por pais.*/

	SELECT C.[NombreCompa��a], C.[Pa�s]
	FROM Clientes AS C
	order by 2 desc -- El "2" indica la posici�n del campo que se est� usando para ordenar (C.[Pa�s])
	go

	-- Usamos el "DISTINCT" para ver el n�mero de pa�ses diferentes (solamente por curiosidad)
	SELECT DISTINCT C.[Pa�s]
	FROM Clientes AS C
	order by 1 desc -- El "2" indica la posici�n del campo que se est� usando para ordenar (C.[Pa�s])
	go


/*2. Lista el nombre de la compa��a y pais de todos los clientes ordenado de manera descendente por pais.
     Mostrar unicamente los clientes cuyo pais inicie con la letra A o E. Asimismo, su telefono
     debe <contener> lo n�meros '555'*/

	SELECT * FROM Clientes 
	GO

	SELECT Cli.NombreCompa��a, Cli.Pa�s, Cli.Tel�fono
	FROM Clientes AS Cli -- Donde "Cli" es un alias
	WHERE (Cli.Pa�s LIKE 'A%' OR Cli.Pa�s LIKE 'E%') AND Cli.Tel�fono LIKE '%555%'
	ORDER BY 2 DESC
	GO

	SELECT Cli.NombreCompa��a, Cli.Pa�s, Cli.Tel�fono
	FROM Clientes AS Cli
	WHERE Cli.Pa�s LIKE '[A,E]%' AND Cli.Tel�fono LIKE '%555%'
	ORDER BY Cli.Pa�s DESC
	GO


/*3. Lista los nombres, apellidos concatenados y separados por una coma de los empleados 
     cuyo cargo sea Gerente de ventas o representante de ventas. De dos respuestas.*/

	 SELECT E.Nombre  + ',' + E.Apellidos, E.Cargo
	 FROM Empleados AS E
	 WHERE E.Cargo= 'Gerente de ventas' OR E.Cargo = 'Representante de ventas'
	 GO

	 SELECT E.Nombre  + ',' + E.Apellidos AS NombresApellidos, E.Cargo 
	 FROM Empleados E
	 WHERE E.Cargo= 'Gerente de ventas' OR E.Cargo = 'Representante de ventas'
	 GO

	 SELECT CONCAT (Empl.Nombre, ',', Empl.Apellidos), Empl.Cargo AS NombresApellidos FROM Empleados Empl
	 WHERE Cargo IN ('Gerente de ventas','Representante de ventas')
	 GO


/*4. Mostrar el codigo. nombre, precio y unidades en existencia de todos los productos
     cuyo precio se encuentre entre 10 y 40. Asimismo, sus unidades en existencias 
	 sean mayores a 10.*/

	SELECT * FROM Productos
	GO

	SELECT Prod.NombreProducto, Prod.PrecioUnidad, Prod.UnidadesEnExistencia
	FROM Productos AS Prod
	WHERE (Prod.PrecioUnidad BETWEEN 10 AND 40) AND Prod.UnidadesEnExistencia > 10
	GO



--PROCEDIMIENTOS ALMACENADOS

/*1.Cree un Stored Procedure (SP) que muestre todos los pedidos. Listar unicamente los pedidos del codigo de
	cliente enviado como par�metro.*/

--PASO 1 : SELECCIONO TODOS LOS PEDIDOS

	SELECT * FROM Pedidos
	GO

--PASO 2 : AGREGO UNA CONDICION
	SELECT * FROM Pedidos AS P
	WHERE P.IdCliente='WILMK'
	GO

--PASO 3 : DESARROLLO DEL PROCEDIMIENTO ALMACENADO

	CREATE OR ALTER PROCEDURE USP_ListarPedidosxCliente -- USP: User Stored Procedure
	@idcliente char(5) -- Par�metro
	as
	Begin
		SELECT * FROM Pedidos AS P
		WHERE P.IdCliente = @idcliente
	End
	go

-- PASO 4: Llamando al Stored Procedure (SP)

	execute USP_ListarPedidosxCliente  'WILMK'
	go
	exec USP_ListarPedidosxCliente 'anton'
	go
	USP_ListarPedidosxCliente 'kala'
	go
	USP_ListarPedidosxCliente  'hanar'
	go
	USP_ListarPedidosxCliente 'ricsu'
	go


/*2.Cree un Stored Procedure (SP) que muestre todos los pedidos. Listar unicamente los pedidos del codigo de
	empleado enviado como par�metro. Muestre los pedidos ordenado de manera descendente 
	por fecha.*/

	-- PASO 1: Seleccionar todos los pedidos
		SELECT * FROM Pedidos
		GO
	-- PASO 2: Agregar una condici�n
		SELECT * FROM Pedidos AS P
		WHERE P.IdEmpleado = 5
		GO
	-- PASO 3:  Desarrollo del Procedimiento Almacenado 
		CREATE OR ALTER PROCEDURE USP_ListarPedidosxEmpleado -- USP: User Stored Procedure
		@IdEmpleado INT -- Par�metro
		AS
		BEGIN
			SELECT * FROM Pedidos AS P
			WHERE P.IdEmpleado = @IdEmpleado
			ORDER BY P.FechaPedido DESC -- Fecha pedido es el 4 campo
		END
		GO
	-- PASO 4: LLamando al Stored Procedure (SP)
		EXECUTE USP_ListarPedidosxEmpleado @IdEmpleado = 5;
		GO
		EXEC USP_ListarPedidosxEmpleado @IdEmpleado = 6;
		GO
		USP_ListarPedidosxEmpleado @IdEmpleado = 3;
		GO		

/*3.Cree un Stored Procedure (SP) que muestre el numero de pedido, fecha de pedido, codigo de cliente y 
	codigo de empleado. Listar unicamente los pedidos del codigo de cliente enviado 
	como par�metro. Muestre los pedidos ordenado de manera ascendente por codigo de
	cliente*/
	-- PASO 1: Seleccionar todos los pedidos
		SELECT ALL * FROM Pedidos
		GO
	-- PASO 2: Agregar una condici�n
		SELECT P.IdPedido, P.FechaPedido, P.IdCliente, P.IdEmpleado FROM Pedidos AS P
		WHERE P.IdCliente = 'WILMK'
		GO
	-- PASO 3: Desarrollo del Procedimiento Almacenado
		CREATE OR ALTER PROCEDURE USP_ListarPedidosxCodCliente -- USP: User Stored Procedure
		@IdCliente CHAR(5) -- Par�metro
		AS
		BEGIN
			SELECT IdPedido, FechaPedido, IdCliente, IdEmpleado FROM Pedidos AS P
			WHERE P.IdCliente = @IdCliente
			ORDER BY P.IdCliente ASC 
		END
		GO
	-- PASO 4: LLamando al Stored Procedure (SP)
		EXECUTE USP_ListarPedidosxCodCliente @IdCliente = 'WILMK';
		GO
		EXEC USP_ListarPedidosxCodCliente @IdCliente = 'TOMSP';
		GO
		USP_ListarPedidosxCodCliente @IdCliente = 'VICTE';
		GO

/*4.Cree un Stored Procedure (SP) que muestre el nombre de la compa��a, region y pais de todos los clientes ordenado de manera 
    descendente por pais. Listar unicamente los clientes cuyo pais sea el enviado como par�metro.*/
	-- PASO 1: Seleccionar todos los Clientes
		SELECT ALL * FROM Clientes 
		GO
	-- PASO 2: Agregar una condicic�n
		SELECT Cli.NombreCompa��a, Cli.Regi�n, Cli.Pa�s FROM Clientes AS Cli
		ORDER BY Cli.Pa�s DESC 
		GO
	-- PASO 3: Desarrollo del Procedimiento Almacenado
		CREATE OR ALTER PROCEDURE USP_ListarClientesxPa�s
		@Pa�s NVARCHAR(15) -- Par�metro
		AS
		BEGIN
			SELECT Cli.NombreCompa��a, Cli.Regi�n, Cli.Pa�s FROM Clientes AS Cli
			WHERE Cli.Pa�s = @Pa�s
			ORDER BY Cli.Pa�s DESC 
		END
		GO
	-- PASO 4: Llamando al Stored Procedure
		EXECUTE USP_ListarClientesxPa�s @Pa�s = 'Suiza';
		GO
		EXEC USP_ListarClientesxPa�s @Pa�s = 'Reino Unido';
		GO
		USP_ListarClientesxPa�s @Pa�s = 'M�xico';
		GO

/*5. Cree un Stored Procedure (SP) que muestre el nombre de la compa��a y pais de todos los clientes ordenado de manera
     descendente por pais.
     Mostrar unicamente los clientes cuyo pais inicie con la letra enviada como par�metro. 
	 Asimismo, su telefono debe contener una cadena de n�meros enviados como par�metro.*/

	-- PASO 1: Seleccionar todos los Clientes
		SELECT * FROM Clientes 
		GO
	-- PASO 2: Agregar una condicic�n
		SELECT Cli.NombreCompa��a, Cli.Pa�s, CLI.Tel�fono FROM Clientes AS Cli
		WHERE Cli.Pa�s LIKE  'A%' AND Cli.Tel�fono LIKE '%555%'
		ORDER BY Cli.Pa�s DESC
		GO
	-- PASO 3: Desarrollo del Procedimiento Almacenado
		CREATE OR ALTER PROCEDURE USP_ListarClientesxPa�sTel�fono
		@Pa�s NVARCHAR(15), @Tel�fono NVARCHAR (24) -- Par�metros
		AS
		BEGIN
			SELECT Cli.NombreCompa��a, Cli.Pa�s, Cli.Tel�fono FROM Clientes AS Cli
			WHERE Cli.Pa�s LIKE  @Pa�s + '%' AND Cli.Tel�fono LIKE '%' + @Tel�fono + '%'
			ORDER BY Cli.Pa�s DESC
		END
		GO
	-- PASO 4: Llamando al Stored Procedure
		EXECUTE USP_ListarClientesxPa�sTel�fono @Pa�s = 'A', @Tel�fono = '007';
		GO
		EXEC USP_ListarClientesxPa�sTel�fono @Pa�s = 'M', @Tel�fono = '555';
		GO
		USP_ListarClientesxPa�sTel�fono @Pa�s = 'R', @Tel�fono = '88';
		GO


/*6. Cree un Stored Procedure (SP) que muestre los nombres, apellidos concatenados y separados por una coma 
     de los empleados cuyo cargo sea el enviado como par�metro.*/
	-- PASO 1: Seleccionar todos los Empleados
		SELECT * FROM Empleados
		GO
	-- PASO 2: Agregar una condicic�n
		SELECT Empl.Nombre + ',' + Empl.Apellidos AS NombreApellidos, Empl.Cargo FROM Empleados Empl
		GO
	-- PASO 3: Desarrollo del Procedimiento Almacenado
		CREATE OR ALTER PROCEDURE USP_ListarEmpleadosxCargo
		@Cargo NVARCHAR(30) -- Par�metro
		AS
		BEGIN
			SELECT Empl.Nombre + ',' + Empl.Apellidos AS NombreApellidos, Empl.Cargo FROM Empleados Empl
			WHERE Empl.Cargo = @Cargo 
		END
		GO
	-- PASO 4: Llamando al Stored Procedure
		EXECUTE USP_ListarEmpleadosxCargo @Cargo = 'Representante de ventas';
		GO
		EXEC USP_ListarEmpleadosxCargo @Cargo = 'Gerente de ventas';
		GO
		USP_ListarEmpleadosxCargo @Cargo = 'Vicepresidente comercial';
		GO

/*7. Cree un Stored Procedure (SP) que muestre el codigo. nombre, precio y unidades en existencia de todos los productos
     cuyo precio se encuentre entre un rango enviado como parametro. Asimismo, sus unidades 
	 en existencias sean mayores a un valor enviado como par�metro.*/
	-- PASO 1: Seleccionar todos los Productos
		SELECT * FROM Productos 
		GO
	-- PASO 2: Agregar una condicic�n
		SELECT Prod.NombreProducto, Prod.PrecioUnidad, Prod.UnidadesEnExistencia FROM Productos AS Prod
		WHERE Prod.PrecioUnidad BETWEEN 10 AND 40 AND Prod.UnidadesEnExistencia > 39
		GO
	-- PASO 3: Desarrollo del Procedimiento Almacenado
		CREATE OR ALTER PROCEDURE USP_ListarProductosxPrecio
		@PrecioIni MONEY,@PrecioFin MONEY, @UnidadesEnExistencias  SMALLINT -- Par�metros
		AS 
		BEGIN
			SELECT Prod.NombreProducto, Prod.PrecioUnidad, Prod.UnidadesEnExistencia FROM Productos AS Prod
			WHERE (Prod.PrecioUnidad BETWEEN @PrecioIni AND @PrecioFin) AND (Prod.UnidadesEnExistencia > @UnidadesEnExistencias)
		END
		GO
	-- PASO 4: Llamando al Stored Procedure (SP)
		EXECUTE USP_ListarProductosxPrecio 18, 30,39 ;
		GO
		EXEC USP_ListarProductosxPrecio @PrecioUnidad = 19, @UnidadesEnExistencias = 17;
		GO
		USP_ListarProductosxPrecio @PrecioUnidad = 10, @UnidadesEnExistencias = 13;
		GO

--PARTE II

--CONSULTA MULTITABLA : UNION INTERNA, INNER JOIN, JOIN


--1.Listar el codigo de pedido, fecha de pedido y codigo de cliente.
	select p.IdPedido, p.FechaPedido, p.IdCliente
	from Pedidos as p 
	go

--2.Listar el codigo de pedido, fecha de pedido,codigo de cliente y raz�n social del cliente.
	select p.IdPedido, p.FechaPedido, p.IdCliente, c.NombreCompa�ia
	from Pedidos as p -- tabla 1
	inner join Clientes as c -- tabla 2
	on p.IdCliente = p.IdCliente
	/* inner join tabla 3 
		on enlazar tabla 3 con la tabla 1 o 2*/ 
	/* inner join tabla 4
		on enlazar tabla 4 con la tabla 1 o 2 o 3*/ 
	go

/*3. Lista el nombre del producto, nombre del proveedor y precio de los productos.
     Mostrar los productos cuyo precio se encuentre entre 10 y 40.*/
	

--PROPUESTO:

/*Crear un stored procedure (sp) que muestre el nombre del producto, nombre del proveedor y precio de 
  los productos cuyo precio se encuentre en un rango enviado como par�metro.*/

	CREATE OR ALTER PROCEDURE USP_ProductosxRangoPrecio
	@Precio1 MONEY, @Precio2 MONEY -- Par�metros
	AS
	BEGIN
		SELECT Prod.NombreProducto, Prov.NombreCompa��a, Prod.PrecioUnidad
		FROM Productos AS Prod
		INNER JOIN Proveedores AS Prov
		ON Prod.IdProveedor = Prod.IdProveedor 
		WHERE Prod.PrecioUnidad >= @Precio1 AND Prod.PrecioUnidad <= @Precio2 -- El campo igual, mayor que, menor que, mayor o igual que y menor o igual que el Dato
	END
	GO
	
	EXECUTE USP_ProductosxRangoPrecio 15, 20;
	GO
	EXEC USP_ProductosxRangoPrecio 12, 19;
	GO
	USP_ProductosxRangoPrecio 16, 18;
	GO


--FIN