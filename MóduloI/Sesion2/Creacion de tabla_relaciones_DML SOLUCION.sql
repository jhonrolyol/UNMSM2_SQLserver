--CERSEU FISI UNMSM
--Docente : Lic. Lidia Sanchez
--SQL SERVER MODULO 1

--SESION 02
--CREACION DE TABLAS/RELACION ENTRE TABLAS/DML

--PARTE 1
--1. Crear la base de datos DESPACHO2022
	CREATE DATABASE DESPACHO20221
	GO
	USE DESPACHO20221
	GO
--2.1 CREACION DE TABLAS
	CREATE TABLE Proveedor (
		IdProv INT not null PRIMARY KEY, -- Llave primaria
		NombreProv VARCHAR(40) not null 
	)
	GO
-- PRODUCTO
	CREATE TABLE Producto (
		IdProd INT not null PRIMARY KEY, -- Llave primaria
		NombreProd VARCHAR(50) not null,
		PrecioProd MONEY not null,
		ObsProd VARCHAR(80) null,
		IdProv INT not null REFERENCES Proveedor -- Llave foranea
	)
	GO
--2.2 Eliminar una tabla
	DROP TABLE Proveedor
	GO
--PARTE 2: RELACION ENTRE TABLAS

--1ro creamos la tabla padre, la relación del 1 y luego la tabla hija, la relación del muchos.
	
	-- ESTA PARTE CONSULTAR A LA MISS OK!

--PROPUESTO :

--Crear la tabla CATEGORIA con sus campos id, nombre y observación. Luego, relacione con
--la tabla producto
	CREATE TABLE Categoria (
		IdCateg INT NOT NULL PRIMARY KEY, -- Llave primaria
		NombCateg VARCHAR(50) NOT NULL,
		ObsCateg TEXT NULL,
		IdProd INT NOT NULL REFERENCES Producto -- Llave foranea
	)
--PARTE 3: DML Lenguaje de manipulacion de Datos con la tabla PRODUCTO

--Insercion de registros
	-- Proveedor
	INSERT INTO Proveedor (IdProv, NombreProv) VALUES (1, 'Proveedor1')
	INSERT INTO Proveedor (IdProv, NombreProv) VALUES (2, 'Proveedor2')
	INSERT INTO Proveedor (IdProv, NombreProv) VALUES (3, 'Proveedor3')
	INSERT INTO Proveedor (IdProv, NombreProv) VALUES (4, 'Proveedor4')
	GO
		SELECT * FROM Proveedor
		GO
	-- Producto
	INSERT INTO Producto (IdProd, NombreProd, PrecioProd, ObsProd, IdProv) VALUES (11, 'Nombre del producto 1', 50, 'Observación del producto 1', 1)
	INSERT INTO Producto (IdProd, NombreProd, PrecioProd, ObsProd, IdProv) VALUES (12, 'Nombre del producto 1', 50, 'Observación del producto 1', 1)
	INSERT INTO Producto (IdProd, NombreProd, PrecioProd, ObsProd, IdProv) VALUES (13, 'Nombre del producto 1', 50, 'Observación del producto 1', 1)
	INSERT INTO Producto (IdProd, NombreProd, PrecioProd, ObsProd, IdProv) VALUES (14, 'Nombre del producto 1', 50, 'Observación del producto 1', 1)
	GO
		SELECT * FROM Producto 
		GO
	-- Categoria
	INSERT INTO Categoria (IdCateg, NombCateg, ObsCateg, IdProd) VALUES (1, 'Nombre de la categoria 1', 'Observación de la categoria 1', 11)
	INSERT INTO Categoria (IdCateg, NombCateg, ObsCateg, IdProd) VALUES (2, 'Nombre de la categoria 2', 'Observación de la categoria 2', 12)
	INSERT INTO Categoria (IdCateg, NombCateg, ObsCateg, IdProd) VALUES (3, 'Nombre de la categoria 3', 'Observación de la categoria 3', 13)
	INSERT INTO Categoria (IdCateg, NombCateg, ObsCateg, IdProd) VALUES (4, 'Nombre de la categoria 4', 'Observación de la categoria 4', 14)
	GO
		SELECT * FROM Categoria
		GO
--Selección de registros
	-- Proveedor
	SELECT * FROM Proveedor 
	GO
	-- Producto 
	SELECT * FROM Producto
	GO
	-- Categoria
	SELECT * FROM Categoria 
	GO
--Modificacion de registros
	-- Proveedor
	SELECT * FROM Proveedor 
	GO
	UPDATE Proveedor 
		SET NombreProv = 'Modificamos de proveedor'
		WHERE IdProv = 1 -- Usamos como referencia la llave primaria de la tabla Proveedor
		GO
		-- Veamos los cambios
		SELECT * FROM Proveedor 
		GO
	-- Producto
	SELECT * FROM Producto 
	GO
	UPDATE Producto
		SET ObsProd = 'Modificamos la observación 1'
		WHERE IdProd = 11 -- Usamos como referencia la llave primaria de la tabla Producto
		GO
		-- Veamos los cambios
		SELECT * FROM Producto
		GO
	-- Categoria
	SELECT * FROM Categoria
	GO
	UPDATE Categoria
		SET NombCateg = 'Modificamos el nombre de la categoria 1'
		WHERE IdCateg = 1 -- Usamos como referencia la llave primaria de la tabla Categoria
		GO
		-- Veamos los cambios
		SELECT * FROM Categoria
		GO
--Eliminacion de registros
	-- Proveedor
	SELECT * FROM Proveedor
	GO
	DELETE Proveedor WHERE IdProv = 2 -- Usamos la llave primaria para eliminar un registro
	GO
	SELECT * FROM Proveedor
	GO
	-- Producto 
	SELECT * FROM Producto
	GO
	DELETE Producto WHERE IdProd = 14 -- Usamos la llave primaria para eliminar un registro // REVISAR EL ERROR DE ESTA LÍNEA OK!
	GO
	SELECT * FROM Producto
	GO
	-- Categoria
	SELECT * FROM Categoria
	GO
	DELETE Categoria WHERE IdCateg = 4 -- Usamos la llave primaria para eliminar un registro
	GO
	SELECT * FROM Categoria
	GO
--fin
