--==========================
-- VALIDACION DE EXISTENCIA --------------------------
--==========================
	USE MASTER 
	GO
	IF DB_ID('BBDD_Biblioteca') IS NOT NULL
		BEGIN
			USE MASTER 
			DROP DATABASE BBDD_Biblioteca
		END
	GO 
--==================
-- CREAMOS UNA BBDD ----------------------------------
--==================
	CREATE DATABASE BBDD_Biblioteca
	ON PRIMARY (
		NAME = 'BBDD_Biblioteca',
		FILENAME = 'D:\BBDD\BBDD_Biblioteca.mdf',
		SIZE = 5mb,
		MAXSIZE = UNLIMITED,
		FILEGROWTH = 3mb
	),(
		NAME = 'BBDD_Biblioteca_SEC',
		FILENAME = 'D:\BBDD\BBDD_Biblioteca_SEC.ndf',
		SIZE = 10mb,
		MAXSIZE = 25mb,
		FILEGROWTH = 5%
	) LOG ON (
		NAME = 'BBDD_Biblioteca_LOG',
		FILENAME = 'D:\BBDD\BBDD_Biblioteca_LOG.ldf',
		SIZE = 8mb,
		MAXSIZE = 50mb,
		FILEGROWTH = 4mb
	)
	GO
	USE BBDD_Biblioteca
	GO


