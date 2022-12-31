--SESION 06

USE NEPTUNO22
GO

--a.Seleccionar ciertos campos de una tabla
-----------

--Lista todas las columnas de la tabla empleado.
	SELECT * FROM Empleados
	GO
--Lista el nombre y los apellidos de todos los empleados.
	SELECT E.Nombre, E.Apellidos
	FROM Empleados AS E -- Alias acorta el identificador de una tabla
	GO

--b. ORDENAMIENTO: ascendente,descendente
-----------------
	SELECT E.Nombre, E.Apellidos
	FROM Empleados AS E 
	ORDER BY E.Apellidos DESC
	GO

	SELECT E.Nombre, E.Apellidos
	FROM Empleados AS E 
	ORDER BY 2 ASC -- el segundo campo (apellidos)
	GO
-- mostrar los campos codigo, apellidos y tratamiento.
-- ordenarlo ded manera ascendente por tratamiento
	SELECT E.IdEmpleado, E.Apellidos, E.Tratamiento
	FROM Empleados AS E -- El "E" es el alias
	ORDER BY 3 ASC
	GO
-- Caso 2
	SELECT A.IdEmpleado, A.Apellidos, A.Tratamiento
	FROM Empleados AS A -- "A" es el alias
	GO
--c. PREDICADOS: ALL, TOP, DISTINCT
-----------------
	SELECT * FROM [Detalles de pedidos] -- el "ALL" está por defecto 
	GO

	SELECT ALL * FROM "Detalles de pedidos"
	GO
	-- ALL: Todos los registros
		SELECT ALL * FROM [Detalles de pedidos]
		GO
	-- TOP: Indica la cantidad de registro como muestra que obtengo 
		
		-- Muestra los 3 primeros registros
		SELECT TOP 3 * FROM [Detalles de pedidos] -- El "3" indica la muestra de los 5 primeros registros
		GO
		-- Muestra los 10 primeros registros
		SELECT TOP 10 * FROM [Detalles de pedidos] -- El "10" indica la muestra de los 5 primeros registros
		GO
		-- Muestra los 10 últimos registros
		SELECT TOP 10 * FROM [Detalles de pedidos] 
		ORDER BY IdPedido DESC
		GO

		SELECT TOP 10 * FROM [Detalles de pedidos] 
		ORDER BY 1 DESC
		GO

-- DISTINCT 
--SELECCIONAR LOS CAMPOS PRODUCTO Y PRECIO DE LA TABLA DETALLES DE PEDIDOS
	SELECT D.IdProducto, D.PrecioUnidad 
	FROM [Detalles de pedidos] AS D
	ORDER BY 1 -- El "ASC" está por defecto
	GO

	SELECT DISTINCT D.IdProducto, D.PrecioUnidad 
	FROM [Detalles de pedidos] AS D
	ORDER BY 1 -- El "ASC" está por defecto
	GO

	SELECT DISTINCT D.IdProducto
	FROM [Detalles de pedidos] AS D
	ORDER BY 1 -- El "ASC" está por defecto
	GO

--d. alias
----------



--Propuestos:
-------------

/*1.Lista el nombre de la compañia y pais de todos los clientes ordenado de manera descendente por pais.*/
	SELECT * FROM Clientes
	GO
	
	SELECT C.NombreCompañía, C.País 
	FROM Clientes AS C
	ORDER BY 2 DESC
	GO

/*2. Lista el nombre de la compañia y pais de todos los clientes ordenado de manera descendente por pais.
     Mostrar unicamente los clientes cuyo pais inicie con la letra A o E. Asimismo, su telefono
     debe <contener> lo números '555'*/
	SELECT * FROM Clientes 
	GO

	SELECT Cli.NombreCompañía, Cli.País
	FROM Clientes AS Cli
	WHERE Cli.País  LIKE 'A%' OR Cli.País LIKE 'E%'
	ORDER BY 2 DESC
	GO

	SELECT Cli.NombreCompañía, Cli.País, Cli.Teléfono
	FROM Clientes AS Cli
	WHERE Cli.País LIKE '[A,E]%' AND Cli.Teléfono LIKE '%555%'
	ORDER BY Cli.País DESC
	GO
	
/*3. Lista los nombres, apellidos concatenados y separados por una coma de los empleados 
     cuyo cargo sea Gerente de ventas o representante de ventas. De dos respuestas.*/
	 SELECT * FROM Empleados
	 GO

	 SELECT E.Nombre  + ',' + E.Apellidos, E.Cargo
	 FROM Empleados AS E
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

/*1.Cree un sp que muestre todos los pedidos. Listar unicamente los pedidos del codigo de
	cliente enviado como parámetro.*/

-- PASO 1: SELECCIONO TODOS LOS PEDIDOS
	SELECT ALL * FROM Pedidos
	GO
-- PASO 2: AGREGO UNA CONDICICÓN
	SELECT ALL * FROM Pedidos AS P
	WHERE P.IdCliente = 'WILMK' -- El primero es el campo y el siguiente es el dato
	GO
-- PASO 3: DESARROLLO EL PROCEDIMIENTO ALMACENADO (EL PROCEDIMIENTO ALMACENADO es la programación de SQL)
	CREATE OR ALTER PROCEDURE USP_ListarPedidosxCliente  -- "USP" es User Store Procedure creando o modificando el procedimiento
	@Idcliente CHAR(5) -- "@Idcliente" es el dato o parámetro
	AS
	BEGIN
		SELECT * FROM Pedidos AS P
		WHERE P.IdCliente = @Idcliente -- Campo y dato
	END
	GO
-- Llamando al SP
	EXECUTE USP_ListarPedidosxCliente 'WILMK'
	GO
	EXEC USP_ListarPedidosxCliente 'WILMK'
	GO 
	USP_ListarPedidosxCliente 'WILMK'
	GO
	
	execute USP_ListarPedidosxCliente 'WILMK'
	go
	exec USP_ListarPedidosxCliente 'anton'
	go
	USP_ListarPedidosxCliente 'kala'
	go
	USP_ListarPedidosxCliente 'hanar'
	go
	USP_ListarPedidosxCliente 'ricsu'
	go


/*2.Cree un sp que muestre todos los pedidos. Listar unicamente los pedidos del codigo de
	empleado enviado como parámetro. Muestre los pedidos ordenado de manera descendente 
	por fecha.*/

/*3.Cree un sp que muestre el numero de pedido, fecha de pedido, codigo de cliente y 
	codigo de empleado. Listar unicamente los pedidos del codigo de cliente enviado 
	como parámetro. Muestre los pedidos ordenado de manera ascendente por codigo de
	cliente*/



/*4.Cree un sp que muestre el nombre de la cia, region y pais de todos los clientes ordenado de manera 
    descendente por pais. Listar unicamente los clientes cuyo pais sea el enviado como parámetro.*/



/*5. Cree un sp que muestre el nombre de la cia y pais de todos los clientes ordenado de manera
     descendente por pais.
     Mostrar unicamente los clientes cuyo pais inicie con la letra enviada como parámetro. 
	 Asimismo, su telefono debe contener una cadena de números enviados como parámetro.*/



/*6. Cree un sp que muestre los nombres, apellidos concatenados y separados por una coma 
     de los empleados cuyo cargo sea el enviado como parámetro.*/



/*7. Cree un sp que muestre el codigo. nombre, precio y unidades en existencia de todos los productos
     cuyo precio se encuentre entre un rango enviado como parametro. Asimismo, sus unidades 
	 en existencias sean mayores a un valor enviado como parámetro.*/



--PARTE II

--CONSULTA MULTITABLA : UNION INTERNA, INNER JOIN, JOIN


--1.Listar el codigo de pedido, fecha de pedido y codigo de cliente.


--2.Listar el codigo de pedido, fecha de pedido,codigo de cliente y razón social del cliente.


/*3. Lista el nombre del producto, nombre del proveedor y precio de los productos.
     Mostrar los productos cuyo precio se encuentre entre 10 y 40.*/


--PROPUESTO:

/*Crear un sp que muestre el nombre del producto, nombre del proveedor y precio de 
  los productos cuyo precio se encuentre en un rango enviado como parámetro.*/





--FIN