--CERSEU FISI UNMSM
--Docente : Lic. Lidia Sanchez
--SQL SERVER MODULO 1

--CREACION DE BASE DE DATOS
/*https://docs.microsoft.com/en-us/sql/t-sql/statements/create-database-transact-sql?view=sql-server-ver16&tabs=sqlpool

https://www.youtube.com/watch?v=fyvEhDgKl7E
*/
--1. Creacion de una bd con sus propiedades por defecto BD_PRUEBA01

	create database BD_PRUEBA01 --creación de una bd con las propiedades por defecto
	go

--2. Ver las propiedades de la base de datos BD_PRUEBA01
	sp_helpdb BD_PRUEBA01 --(sp : procedimiento almacenado)
	go

--3. Crear la base de datos BD_PRUEBA02 especificando sus propiedades :

--3.1 Con el archivo primario
	create database  BD_PRUEBA02
	ON PRIMARY --filegroup (unidad lógica de almacenamiento) por defecto
	(
		NAME='BD_PRUEBA02', --nombre lógico
		FILENAME= 'd:\data\BD_PRUEBA02.mdf', --nombre físico
		SIZE= 100mb, --tamaño inicial
		MAXSIZE=400mb, --máximo tamaño
		FILEGROWTH= 10mb  --crecimiento con tamaño fijo o porcentaje
	)
	GO
	sp_helpdb BD_PRUEBA02
	go

--3.2 Con el archivo primario y de registro
	create database BD_PRUEBA021
	ON PRIMARY --filegroup (unidad lógica de almacenamiento) por defecto
	(
		NAME='BD_PRUEBA021_data', --nombre lógico
		FILENAME= 'd:\data\BD_PRUEBA021_data.mdf', --nombre físico
		SIZE= 100mb, --tamaño inicial
		MAXSIZE=400mb, --máximo tamaño
		FILEGROWTH= 10mb  --crecimiento con tamaño fijo o porcentaje
	)
	log on --archivo de registro de transacciones
	(
		NAME='BD_PRUEBA021_log', --nombre lógico
		FILENAME= 'd:\data\BD_PRUEBA021_log.ldf', --nombre físico
		SIZE= 50mb, --tamaño inicial
		MAXSIZE=200mb, --máximo tamaño
		FILEGROWTH= 5%  --crecimiento con tamaño fijo o porcentaje
	)
	GO
	sp_helpdb BD_PRUEBA021
	go

--3.3 Con el archivo primario, secundario y de registro de transacciones

	create database BD_PRUEBA022
	ON PRIMARY --filegroup (unidad lógica de almacenamiento) por defecto
	(
		NAME='BD_PRUEBA022_data', --nombre lógico
		FILENAME= 'd:\data\BD_PRUEBA022_data.mdf', --nombre físico
		SIZE= 100mb, --tamaño inicial
		MAXSIZE=400mb, --máximo tamaño
		FILEGROWTH= 10mb  --crecimiento con tamaño fijo o porcentaje
	), --archivo secuendario
	(
		NAME='BD_PRUEBA022_sec', --nombre lógico
		FILENAME= 'd:\data\BD_PRUEBA022_sec.ndf', --nombre físico
		SIZE= 80mb, --tamaño inicial
		MAXSIZE=500mb, --máximo tamaño
		FILEGROWTH= 10%  --crecimiento con tamaño fijo o porcentaje
	)
	log on --archivo de registro de transacciones
	(
		NAME='BD_PRUEBA022_log', --nombre lógico
		FILENAME= 'd:\data\BD_PRUEBA022_log.ldf', --nombre físico
		SIZE= 50mb, --tamaño inicial
		MAXSIZE=200mb, --máximo tamaño
		FILEGROWTH= 5%  --crecimiento con tamaño fijo o porcentaje
	)
	GO
	sp_helpdb BD_PRUEBA022
	go


--4.Ver las propiedades de la base de datos
	sp_helpdb BD_PRUEBA022
	go

--5. Eliminar una base de datos

	drop database BD_PRUEBA022
	go

/*
EJERCICIO PROPUESTO : 
Cree la base de datos BD_BECAS en la carpeta D:\DATA\BD\ con la siguiente configuración:
Archivo de datos: Un tamaño inicial de 5MB, máximo permitido por el sistema y un factor de crecimiento de 3MB.
Archivo secundario: Un tamaño inicial de 10MB, máximo de 25MB y un factor de crecimiento de 5%.
Archivo de transacciones: Un tamaño inicial de 8MB, máximo de 50MB y un factor de crecimiento de 4MB.
*/

--validación forma 1 de la existencia de la base de datos
	if db_id('bd_becas') is not null --la bd existe
	begin --inicio de bloque de código
		use master
		drop database bd_becas
	end --fin de bloque
	go

--validación forma 2 
	use master
	go
	if db_id('bd_becas') is not null --la bd existe
		drop database bd_becas
	go
	create database bd_becas
	on
	(
		name='bd_becas',
		filename='D:\DATA\BD\bd_becas.mdf',
		size=5,
		maxsize=unlimited,
		filegrowth=3
	),
	(
		name='bd_becas_sec',
		filename='D:\DATA\BD\bd_becas_sec.ndf',
		size=10,
		maxsize=25,
		filegrowth=5%
	)
	log on
	(
		name='bd_becas_log',
		filename='D:\DATA\BD\bd_becas_log.ldf',
		size=8,
		maxsize=50,
		filegrowth=4
	)
	go
	sp_helpdb bd_becas
	go

--6. Crear la base de datos DESPACHO2023
	create database DESPACHO2023
	go
	sp_helpdb DESPACHO2023
	go
--7. Volver a ejecutar la creacion de la base de datos DESPACHO2023


--8. Crear una base de datos con validacion de existencia
	if db_id('DESPACHO2023') is not null --si es verdadero la bd existe
		begin --inicio bloque de código
			use master --activo master para desbloquer el uso de la bd DESPACHO2023
			drop database DESPACHO2023
		end --fin bloque de código
	go
	create database DESPACHO2023
	go
	sp_helpdb DESPACHO2023
	go
--fin





