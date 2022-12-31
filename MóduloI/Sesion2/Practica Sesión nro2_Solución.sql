
--===========================================================================
--                Programa de Especialización en SQL server
-- Módulo: I
-- Sesión: N° 2
-- Práctica: N° 2
-- Docente: Lic. Lidia Sanchez
-- Alumno: Jhon Roly Ordoñez Leon
-- Fecha de entrega: 5 de diciembre de 2022
--===========================================================================

--==============
-- PREGUNTA N° 1 ------------------------------------------------------------
--==============
	-- Creamos la base de datos PROMOCIONES2022
		CREATE DATABASE PROMOCIONES2022 
		ON PRIMARY 
		(-- Archivo de datos o archivo primario
			NAME = 'PROMOCIONES2022',
			FILENAME = 'D:\CLIENTES\PROMOCIONES2022.mdf',
			SIZE = 5mb,
			MAXSIZE = unlimited,
			FILEGROWTH = 3mb
		),
		(-- Archivo secundario
			NAME = 'PROMOCIONES2022_SEC',
			FILENAME = 'D:\CLIENTES\PROMOCIONES2022_SEC.ndf',
			SIZE = 10mb,
			MAXSIZE = 25mb,
			FILEGROWTH = 5%
		)
		LOG ON 
		(-- Archivo de transacciones
			NAME = 'PROMOCIONES2022_LOG',
			FILENAME = 'D:\CLIENTES\PROMOCIONES2022_LOG.ldf',
			SIZE = 8mb,
			MAXSIZE = 50mb,
			FILEGROWTH = 4mb
		)
		GO
		USE PROMOCIONES2022
		GO
--==============
-- PREGUNTA N° 2 ------------------------------------------------------------
--==============
	IF DB_ID('PROMOCIONES2022') IS NOT NULL
		BEGIN 
			USE MASTER
			DROP DATABASE PROMOCIONES2022
		END
	GO
	-- Creamos nuevamente la base de datos PROMOCIONES2022 especificando los tres archivos
		CREATE DATABASE PROMOCIONES2022
		ON PRIMARY
		(-- Archivo primario o de datos 
			NAME = 'PROMOCIONES2022',
			FILENAME = 'D:\CLIENTES\PROMOCIONES2022.mdf',
			SIZE = 5mb,
			MAXSIZE = unlimited,
			FILEGROWTH = 3mb
		),
		(-- Archivo secundario
			NAME = 'PROMOCIONES2022_SEC',
			FILENAME = 'D:\CLIENTES\PROMOCIONES2022_SEC.ndf',
			SIZE = 10mb,
			MAXSIZE = 25mb,
			FILEGROWTH = 5%
		)
		LOG ON 
		(-- Archivo de transacciones
			NAME = 'PROMOCIONES2022_LOG',
			FILENAME = 'D:\CLIENTES\PROMOCIONES2022_LOG.ldf',
			SIZE = 8mb,
			MAXSIZE = 50mb,
			FILEGROWTH = 4mb
		)
		GO
	-- Usamos la base de datos PROMOCIONES2022 (para no trabajar en el master)
		USE PROMOCIONES2022
		GO
	-- Creamos la tabla Banco
		CREATE TABLE Banco (
			IdBanco INT NOT NULL PRIMARY KEY, -- Llave primaria
			NombreBanco VARCHAR(50) NOT NULL
		)
		GO
	-- Creamos la tabla Cliente
		CREATE TABLE Cliente (
			DniCli CHAR(8) NOT NULL PRIMARY KEY, -- Llave primaria
			NombreCli VARCHAR(50) NOT NULL,
			FecNacCli DATE NOT NULL,
			SexoCli VARCHAR(20) NOT NULL
		)
		GO
	-- Creamos la tabla Cuenta
		CREATE TABLE Cuenta (
			NroCuenta CHAR(16) NOT NULL PRIMARY KEY, -- Llave primaria
			NroTargCuenta CHAR(16) NOT NULL,
			FecAperCuenta DATE NOT NULL,
			TipoCuenta VARCHAR(20) NOT NULL,
			IdBanco INT NOT NULL REFERENCES Banco, -- Llave foranea
			DniCli CHAR(8) NOT NULL REFERENCES Cliente -- Llave foranea
		)
	/*
	-- DML: Lenguaje de Manipulacion de datos
		--INSERCION
			insert into BANCO (IdBanco, NombreBanco) values (1,'Banco de Crédito')
			insert into BANCO (IdBanco, NombreBanco) values (2,'BBVA')
			insert into BANCO (IdBanco, NombreBanco) values (3,'INTERBANK')
			insert into BANCO values (4, 'SCOTIABANK')
			go
		-- SELECCION (SELECT)
			SELECT * FROM Banco 
			GO
		-- ELIMINACION (DELETE)
			-- Eliminar el banco con código 3
				DELETE Banco 
				WHERE IdBanco = 3
				GO
				SELECT * FROM Banco 
				GO
		-- MODIFICACION 
			-- Modificar el banco con código 4 por BCO DE COMERCIO
				SELECT * FROM Banco 
				GO
				UPDATE BANCO
					SET NombreBanco = 'BCO DE COMERCIO'
					WHERE IdBanco = 4
					GO
				SELECT * FROM Banco 
				GO
	*/
--==============
-- PREGUNTA N° 3 ------------------------------------------------------------
--==============
	-- Ingresamos 4 registros a la tabla Banco
		INSERT INTO Banco (IdBanco, NombreBanco) VALUES (1,'Banco de Crédito')
		INSERT INTO Banco (IdBanco, NombreBanco) VALUES (2,'BBVA')
		INSERT INTO Banco (IdBanco, NombreBanco) VALUES (3,'INTERBANK')	
		INSERT INTO Banco (IdBanco, NombreBanco) VALUES (4,'Banca Movil 4')
		GO
			SELECT * FROM Banco
			GO
			SELECT IdBanco  FROM Banco
			GO
			SELECT NombreBanco FROM Banco 
			GO
			SELECT IdBanco,NombreBanco FROM Banco 
			GO
	-- Ingresamos 4 registros a la tabla Cliente
		INSERT INTO Cliente (DniCli, NombreCli, FecNacCli, SexoCli) VALUES ('83656492', 'Juan', '01/04/1975','Varon')
		INSERT INTO Cliente (DniCli, NombreCli, FecNacCli, SexoCli) VALUES ('63756393', 'Pedro', '11/06/1985','Varon')
		INSERT INTO Cliente (DniCli, NombreCli, FecNacCli, SexoCli) VALUES ('53856294', 'Maria', '10/07/1995','Mujer')
		INSERT INTO Cliente (DniCli, NombreCli, FecNacCli, SexoCli) VALUES ('43956195', 'Lucia', '06/09/2000','Mujer')
		GO
			SELECT * FROM Cliente
			GO
			DELETE Cliente WHERE DniCli = '53856294' -- Elimina un registro
			GO
			SELECT * FROM Cliente
			GO
	-- Ingresamos 4 registros a la tabla Cuenta
		INSERT INTO Cuenta (NroCuenta, NroTargCuenta, FecAperCuenta, TipoCuenta, IdBanco, DniCli) VALUES ('1234567812345478', '1234567812345078', '01/04/2022', 'Ahorro1',1,'83656492')
		INSERT INTO Cuenta (NroCuenta, NroTargCuenta, FecAperCuenta, TipoCuenta, IdBanco, DniCli) VALUES ('2234567812345677', '1334567812345678', '05/05/2022', 'Ahorro2',2,'63756393')
		INSERT INTO Cuenta (NroCuenta, NroTargCuenta, FecAperCuenta, TipoCuenta, IdBanco, DniCli) VALUES ('3234567812345676', '1434567812345678', '03/07/2022', 'Ahorro3',3,'53856294')
		INSERT INTO Cuenta (NroCuenta, NroTargCuenta, FecAperCuenta, TipoCuenta, IdBanco, DniCli) VALUES ('4234567812345675', '1534567812345678', '07/09/2022', 'Ahorro4',4,'43956195')
		GO
			SELECT * FROM Cuenta
			GO
	-- Veamos las tablas creadas
		USE PROMOCIONES2022
			SELECT * FROM INFORMATION_SCHEMA.TABLES	
	-- Usamos el SELECT 
		-- Banco
			SELECT * FROM Banco
			SELECT IdBanco FROM Banco
			SELECT NombreBanco FROM Banco
			SELECT IdBanco, NombreBanco FROM Banco 
		-- Cliente
			SELECT * FROM Cliente 
			SELECT DniCli FROM Cliente
			SELECT NombreCli FROM Cliente 
			SELECT FecNacCli FROM Cliente
			SELECT SexoCli FROM Cliente
			SELECT DniCli, NombreCli, FecNacCli, SexoCli FROM Cliente
		-- Cuenta
			SELECT * FROM Cuenta
			SELECT NroCuenta FROM Cuenta 
			SELECT NroTargCuenta FROM Cuenta
			SELECT FecAperCuenta FROM Cuenta
			SELECT TipoCuenta FROM Cuenta 
			SELECT IdBanco FROM Cuenta 
			SELECT DniCli FROM Cuenta 
			SELECT NroCuenta, NroTargCuenta, FecAperCuenta, TipoCuenta, IdBanco, DniCli FROM Cuenta
--==============
-- PREGUNTA N° 4 ------------------------------------------------------------
--==============
	-- Modificamos 1 registro de la tabla Banco
		SELECT * FROM Banco
		GO
		UPDATE Banco
			SET NombreBanco = 'BANCO DE COMERCIO'
			WHERE IdBanco = 1 -- Se usa como referencia 
			GO
		-- Veamos el cambio en la tabla Banco
			SELECT * FROM Banco
			GO
	-- Modificamos 1 registro de la tabla Cliente
		SELECT * FROM Cliente
		GO
		UPDATE Cliente
			SET NombreCli = 'Alberto'
			WHERE DniCli = '83656492' -- Se usa como referencia
			GO
		-- Veamos el cambio en la tabla Cliente
			SELECT * FROM Cliente
			GO
	-- Modificamos 1 registro de la tabla Cuenta
		SELECT * FROM Cuenta
		GO
		UPDATE Cuenta
			SET TipoCuenta = 'Nueva Cuenta'
			WHERE NroCuenta = '1234567812345478' -- Se usa como referencia
			GO
		-- Veamos el cambio en la tabla Cuenta
			SELECT * FROM Cuenta
			GO
