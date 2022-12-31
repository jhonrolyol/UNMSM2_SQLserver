--==========================================================================
--                  Programa de Especializacion en SQL server - UNMSM
--                                  MODULO I
-- Proyecto: Restaurante
-- Docente: Lic. Lidia Sanchez
-- Alumno: Jhon Roly Ordonez Leon
-- Fecha de entrega: 29 de diciembre de 2022
--==========================================================================
--=============================
-- VALIDAR EXISTENCIA DE LA BD ---------------------------------------------
--=============================
	USE MASTER
	GO
	IF DB_ID('Restaurante') IS NOT NULL -- si es verdadero, la base de datos existe
		BEGIN -- Inicio del bloque de codigo
			USE MASTER -- Se activa el master
			DROP DATABASE Restaurante -- Elimina la base de datos Restaurante
		END -- Fin del bloque de codigo
	GO
--=====================
-- CREAR BASE DE DATOS ---------------------------------------------------
--=====================
	-- Creamos la base de datos 
		CREATE DATABASE Restaurante 
		ON PRIMARY -- filegroup (unidad logica de almacenamiento) por defecto
		(-- Archivo primario
			NAME = 'Restaurante', -- Nombre logico
			FILENAME = 'D:\BBDD\Restaurante.mdf', -- Nombre fisico
			SIZE = 5mb, -- Tamano inicial
			MAXSIZE = unlimited, -- Tamano maximo
			FILEGROWTH = 3mb -- Crecimiento con tamano fijo o porcentaje
		),
		(-- Archivo secundario
			NAME = 'Restaurante_SEC', -- Nombre logico
			FILENAME = 'D:\BBDD\Restaurante_SEC.ndf', -- Nombre fisico
			SIZE = 10mb, -- Tamano inicial
			MAXSIZE = 25mb, -- Tamano maximo
			FILEGROWTH = 5% -- Crecimiento con tamano fijo o porcentaje 
		)
		LOG ON 
		(-- Archivo de registro de transacciones
			NAME = 'Restaurante_LOG', -- Nombre logico
			FILENAME = 'D:\BBDD\Restaurante_LOG.ldf', -- Nombre fisico
			SIZE = 8mb, -- Tamano inicial
			MAXSIZE = 50mb, -- Tamano maximo
			FILEGROWTH = 4mb -- Crecimiento con tamano fijo o porcentaje 
		)
		GO
	-- Veamos las propiedades de la base de datos
		SP_HELPDB Restaurante -- (SP : Stored Procedure)
		GO
	-- Usamos la base de datos Restaurante
		USE Restaurante 
		GO	
--==============
-- CREAR TABLAS --------------------------------------------------------
--==============
	-- Establecimiento
		CREATE TABLE Establecimiento (
			IdEstabl INT NOT NULL PRIMARY KEY, -- Llave primaria
			TelefEstabl CHAR(9) NOT NULL CHECK (TelefEstabl LIKE '9[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'), 
			UbicEstabl VARCHAR(100) NOT NULL, 
			NombreEstabl CHAR(6) NOT NULL CHECK(NombreEstabl like 'Tullpa'),
		)
		GO
		-- Stored Procedure (SP) Help 
			SP_HELP Establecimiento
			GO
		-- Visualizamos los campos creados
			SELECT * FROM Establecimiento
			GO
	-- Empleado
		CREATE TABLE Empleado (
			IdEmpleado INT NOT NULL PRIMARY KEY, -- Llave primaria
			NombEmpleado VARCHAR(50) NOT NULL,
			DireccEmpleado VARCHAR(100) NOT NULL,
			CargoEmpleado VARCHAR(50) NOT NULL,
			IdEstabl INT NOT NULL REFERENCES Establecimiento
		)
		GO
		-- Stored Procedure (SP) Help 
			SP_HELP Empleado
			GO
		-- Visualizamos los campos creados
			SELECT * FROM Empleado
			GO
	-- Cliente
		CREATE TABLE Cliente (
			IdCli INT NOT NULL PRIMARY KEY, -- Llave primara
			NombreCli VARCHAR(50) NOT NULL,
			TelefonoCli CHAR(9) NOT NULL CHECK (TelefonoCli LIKE '9[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
			SexoCli CHAR(5) NOT NULL CHECK (SexoCli IN ('Varon', 'Mujer')),
			FecNacCli DATE NOT NULL 
		)
		GO
		-- Stored Procedure (SP) Help 
			SP_HELP Cliente
			GO
		-- Visualizamos los campos creados
			SELECT * FROM Cliente
			GO
	-- Reservacion
		CREATE TABLE Reservacion (
			IdReserv INT NOT NULL PRIMARY KEY, -- Llave primaria
			NroMesaReserv INT NOT NULL,
			FechaReserv DATE NOT NULL DEFAULT GETDATE(),
			CantPersonReserv INT NOT NULL,
			IdCli INT NOT NULL REFERENCES Cliente
		)
		GO
		-- Stored Procedure (SP) Help 
			SP_HELP Reservacion
			GO
		-- Visualizamos los campos creados
			SELECT * FROM Reservacion
			GO
	-- Menu
		CREATE TABLE Menu (
			IdMenu INT NOT NULL PRIMARY KEY, -- Llave primaria
			NombreMenu VARCHAR(50) NOT NULL,
			DescripcionMenu VARCHAR(100) NULL
		)
		GO
		-- Stored Procedure (SP) Help 
			SP_HELP Menu
			GO
		-- Visualizamos los campos creados
			SELECT * FROM Menu
			GO
	-- Boleta
		CREATE TABLE Boleta (
			IdBoleta CHAR(7) NOT NULL PRIMARY KEY, -- Llave primaria
			RucBoleta CHAR(11) NOT NULL CHECK(RucBoleta like '20123456784'),
			NombreCliBoleta VARCHAR(50) NOT NULL,
			DireccCliBoleta VARCHAR(100) NOT NULL, 
			FechaBoleta DATE NOT NULL,
			ImpTotBoleta MONEY NOT NULL,
			IdEmpleado INT NOT NULL REFERENCES Empleado,
			IdMenu INT NOT NULL REFERENCES Menu,
			IdCli INT NOT NULL REFERENCES Cliente,
		)
		GO
		-- Stored Procedure (SP) Help 
			SP_HELP Boleta
			GO
		-- Visualizamos los campos creados
			SELECT * FROM Boleta
			GO
	-- Detalle Menu - Boleta
		CREATE TABLE DetalleMenuBoleta (
			IdMenu INT NOT NULL REFERENCES Menu,
			IdBoleta CHAR(7) NOT NULL REFERENCES Boleta,
			PrecioVenta MONEY NOT NULL,
			Cantidad INT NOT NULL,
			PRIMARY KEY (IdMenu, IdBoleta) -- Llave primaria compuesta
		)
		GO
		-- Stored Procedure (SP) Help 
			SP_HELP DetalleMenuBoleta
			GO
		-- Visualizamos los campos creados
			SELECT * FROM DetalleMenuBoleta
			GO
--=====================
-- INGRESAR REGISTROS  ------------------------------------------------------
--=====================
	-- Estableciento
		SELECT * FROM Establecimiento
			GO
		INSERT INTO Establecimiento (IdEstabl, TelefEstabl, UbicEstabl, NombreEstabl) 
		VALUES (1, '934128562', 'Jr Manco Capac,  Huamanga, Ayacucho, Peru', 'Tullpa')
		INSERT INTO Establecimiento (IdEstabl, TelefEstabl, UbicEstabl, NombreEstabl) 
		VALUES (2, '944128562', 'Jr Bolivar,  Huamanga, Ayacucho, Peru', 'Tullpa')
		INSERT INTO Establecimiento (IdEstabl, TelefEstabl, UbicEstabl, NombreEstabl) 
		VALUES (3, '954128562', 'Jr Los Ingenieros,  Huamanga, Ayacucho, Peru', 'Tullpa')
		INSERT INTO Establecimiento (IdEstabl, TelefEstabl, UbicEstabl, NombreEstabl) 
		VALUES (4, '964128562', 'Jr Amauta,  Huamanga, Ayacucho, Peru', 'Tullpa')
		INSERT INTO Establecimiento (IdEstabl, TelefEstabl, UbicEstabl, NombreEstabl) 
		VALUES (5, '974128562', 'Jr La Florida,  Huamanga, Ayacucho, Peru', 'Tullpa')
		GO
		-- Visualizamos los registros 
			SELECT * FROM Establecimiento
			GO
		-- Eliminar el registro con el numero 934128562 de la tabla Establecimiento
			SELECT ALL * FROM Establecimiento
			GO
			BEGIN
				DELETE Establecimiento
				WHERE TelefEstabl = '934128562'
			END
			GO
			SELECT ALL * FROM Establecimiento
			GO
		-- Insertar nuevamente el registro con el numero 934128562 de la tabla Establecimiento
			SELECT ALL * FROM Establecimiento
			GO
			BEGIN
				INSERT INTO Establecimiento (IdEstabl, TelefEstabl, UbicEstabl, NombreEstabl) 
				VALUES (1, '934128562', 'Jr Manco Capac,  Huamanga, Ayacucho, Peru', 'Tullpa')
			END
			GO
			SELECT ALL * FROM Establecimiento
			GO
		-- Modificar del primer registro el campo de la ubiacion del Establecimiento
			SELECT ALL * FROM Establecimiento
			GO
			BEGIN
				UPDATE Establecimiento
				SET UbicEstabl = 'Jr Los libertadores modificado'
				WHERE IdEstabl = 1
			END
			SELECT ALL * FROM Establecimiento
			GO
	-- Empleado
		SELECT ALL * FROM Empleado
			GO
		INSERT INTO Empleado (IdEmpleado, NombEmpleado, DireccEmpleado, CargoEmpleado, IdEstabl) 
		VALUES (1, 'Lucia', 'Jr Hipolito Unanue', 'Chef', 5)
		INSERT INTO Empleado (IdEmpleado, NombEmpleado, DireccEmpleado, CargoEmpleado, IdEstabl) 
		VALUES (2, 'Pedro', 'Jr Amazonas, 234', 'Cocinero', 4)
		INSERT INTO Empleado (IdEmpleado, NombEmpleado, DireccEmpleado, CargoEmpleado, IdEstabl) 
		VALUES (3, 'Alfredo', 'Jr Maria Parado de Bellido', 'Cocinero', 3)
		INSERT INTO Empleado (IdEmpleado, NombEmpleado, DireccEmpleado, CargoEmpleado, IdEstabl) 
		VALUES (4, 'Bertha', 'Jr Los Libertadores', 'Cocinera', 5)
		INSERT INTO Empleado (IdEmpleado, NombEmpleado, DireccEmpleado, CargoEmpleado, IdEstabl) 
		VALUES (5, 'Carla', 'Jr Vista Alegre', 'Recepcionista', 1)
		INSERT INTO Empleado (IdEmpleado, NombEmpleado, DireccEmpleado, CargoEmpleado, IdEstabl) 
		VALUES (6, 'Adriana', 'Jr Los Libertadores 145', 'Mesera', 2)
		INSERT INTO Empleado (IdEmpleado, NombEmpleado, DireccEmpleado, CargoEmpleado, IdEstabl) 
		VALUES (7, 'Carolina', 'Jr Manco Capac', 'Mesera', 3)
		INSERT INTO Empleado (IdEmpleado, NombEmpleado, DireccEmpleado, CargoEmpleado, IdEstabl) 
		VALUES (8, 'Mariela', 'Jr Andres Avelino Caceres, 123', 'Mesera', 4)
		INSERT INTO Empleado (IdEmpleado, NombEmpleado, DireccEmpleado, CargoEmpleado, IdEstabl) 
		VALUES (9, 'Benjamin', 'Jr Los Alamos', 'Mesero', 1)
		INSERT INTO Empleado (IdEmpleado, NombEmpleado, DireccEmpleado, CargoEmpleado, IdEstabl) 
		VALUES (10, 'Rodrigo', 'Jr Tupac Amaru', 'Mesero', 4)
		GO
		-- Visualizamos los registros 
			SELECT ALL * FROM Empleado
			GO
	-- Cliente
		SELECT ALL * FROM Cliente
			GO
		INSERT INTO Cliente (IdCli, NombreCli, TelefonoCli, SexoCli, FecNacCli) 
		VALUES (1, 'Juan', '913129561', 'Varon', '01/04/1980')
		INSERT INTO Cliente (IdCli, NombreCli, TelefonoCli, SexoCli, FecNacCli) 
		VALUES (2, 'Maria', '933239462', 'Mujer', '04/09/1979')
		INSERT INTO Cliente (IdCli, NombreCli, TelefonoCli, SexoCli, FecNacCli) 
		VALUES (3, 'Pablo', '943349363', 'Varon','02/07/1992')
		INSERT INTO Cliente (IdCli, NombreCli, TelefonoCli, SexoCli, FecNacCli) 
		VALUES (4, 'Juana', '953459264', 'Mujer','08/03/2000')
		INSERT INTO Cliente (IdCli, NombreCli, TelefonoCli, SexoCli, FecNacCli) 
		VALUES (5, 'Martha', '963569165', 'Mujer', '11/06/1984')
		INSERT INTO Cliente (IdCli, NombreCli, TelefonoCli, SexoCli, FecNacCli) 
		VALUES (6, 'Julio', '973569161', 'Varon', '09/03/1985')
		INSERT INTO Cliente (IdCli, NombreCli, TelefonoCli, SexoCli, FecNacCli) 
		VALUES (7, 'Luis', '983569161', 'Varon', '07/09/1975')
		INSERT INTO Cliente (IdCli, NombreCli, TelefonoCli, SexoCli, FecNacCli) 
		VALUES (8, 'Carlos', '993569163', 'Varon', '01/05/1997')
		INSERT INTO Cliente (IdCli, NombreCli, TelefonoCli, SexoCli, FecNacCli) 
		VALUES (9, 'Tatiana', '923569164', 'Mujer', '07/07/2004')
		INSERT INTO Cliente (IdCli, NombreCli, TelefonoCli, SexoCli, FecNacCli) 
		VALUES (10, 'Alejandra', '933569165', 'Mujer', '07/05/1989')
		GO
		-- Visualizamos los registros 
			SELECT ALL * FROM Cliente
			GO
	-- Reservacion
		SELECT ALL * FROM Reservacion
			GO
		INSERT INTO Reservacion (IdReserv, NroMesaReserv, FechaReserv, CantPersonReserv, IdCli) 
		VALUES (1, 4, '01/02/2021', 10, 1)
		INSERT INTO Reservacion (IdReserv, NroMesaReserv, FechaReserv, CantPersonReserv, IdCli) 
		VALUES (2, 6, '01/02/2022', 23, 2)
		INSERT INTO Reservacion (IdReserv, NroMesaReserv, FechaReserv, CantPersonReserv, IdCli) 
		VALUES (3, 2, '02/02/2022', 12, 3)
		INSERT INTO Reservacion (IdReserv, NroMesaReserv, FechaReserv, CantPersonReserv, IdCli)
		VALUES (4, 4, '02/02/2022', 7, 4)
		INSERT INTO Reservacion (IdReserv, NroMesaReserv, FechaReserv, CantPersonReserv, IdCli) 
		VALUES (5, 3, '03/02/2022', 15, 5)
		INSERT INTO Reservacion (IdReserv, NroMesaReserv, FechaReserv, CantPersonReserv, IdCli) 
		VALUES (6, 5, '03/03/2022', 5, 6)
		INSERT INTO Reservacion (IdReserv, NroMesaReserv, FechaReserv, CantPersonReserv, IdCli) 
		VALUES (7, 4, '04/03/2022', 17, 7)
		INSERT INTO Reservacion (IdReserv, NroMesaReserv, FechaReserv, CantPersonReserv, IdCli) 
		VALUES (8, 2, '03/05/2022', 16, 8)
		INSERT INTO Reservacion (IdReserv, NroMesaReserv, FechaReserv, CantPersonReserv, IdCli) 
		VALUES (9, 1, '09/05/2022', 11, 9)
		INSERT INTO Reservacion (IdReserv, NroMesaReserv, FechaReserv, CantPersonReserv, IdCli) 
		VALUES (10,5, '07/06/2022', 6, 10)
		GO
		-- Visualizamos los registros 
			SELECT ALL * FROM Reservacion
			GO
	-- Menu
		SELECT ALL * FROM Menu
			GO
		INSERT INTO Menu (IdMenu, NombreMenu, DescripcionMenu) 
		VALUES (1, 'Tamal', 'Tamal de arroz Chakupe molido hecho tamal, dorado con pato asado')
		INSERT INTO Menu (IdMenu, NombreMenu, DescripcionMenu) 
		VALUES (2, 'Ceviche a la Brasa', 'Conocido en termino medio en brasas de carbon natural')
		INSERT INTO Menu (IdMenu, NombreMenu, DescripcionMenu) 
		VALUES (3, 'Causa Nortena', NULL)
		INSERT INTO Menu (IdMenu, NombreMenu, DescripcionMenu) 
		VALUES (4, 'Croquetas', 'Croquetas de cachetes y morras de Mero Murique' )
		INSERT INTO Menu (IdMenu, NombreMenu, DescripcionMenu) 
		VALUES (5, 'Arroz con pato', 'Arroz con pato clasica del Fiesta')
		INSERT INTO Menu (IdMenu, NombreMenu, DescripcionMenu) 
		VALUES (6, 'Pescado', NULL)
		INSERT INTO Menu (IdMenu, NombreMenu, DescripcionMenu) 
		VALUES (7, 'Pollo', 'A la brasa con papas fritas mas ensaladas' )
		INSERT INTO Menu (IdMenu, NombreMenu, DescripcionMenu) 
		VALUES (8, 'Cerdo', NULL)
		INSERT INTO Menu (IdMenu, NombreMenu, DescripcionMenu) 
		VALUES (9, 'Trucha', 'Trucha rosada con papas fritas')
		INSERT INTO Menu (IdMenu, NombreMenu, DescripcionMenu) 
		VALUES (10, 'Cuy Chactado', NULL)
		GO 
		-- Visualizamos los registros 
			SELECT ALL * FROM Menu
			GO
	-- Boleta
		SELECT ALL * FROM Boleta
			GO
		INSERT INTO Boleta (IdBoleta, RucBoleta, NombreCliBoleta, DireccCliBoleta, FechaBoleta, ImpTotBoleta, IdEmpleado, IdMenu, IdCli) 
		VALUES ('0000101', '20123456784', 'Lucia', 'Jr Manco Capac', '03/04/2022', 60, 6, 1,1)
		INSERT INTO Boleta (IdBoleta, RucBoleta, NombreCliBoleta, DireccCliBoleta, FechaBoleta, ImpTotBoleta, IdEmpleado, IdMenu, IdCli) 
		VALUES ('0000102', '20123456784', 'Carlos', 'Jr Cusco', '03/04/2022', 145, 7, 2,2)
		INSERT INTO Boleta (IdBoleta, RucBoleta, NombreCliBoleta, DireccCliBoleta, FechaBoleta, ImpTotBoleta, IdEmpleado, IdMenu, IdCli) 
		VALUES ('0000103', '20123456784', 'Korina', 'Jr Los igenieros', '04/05/2022', 35, 7, 3,3)
		INSERT INTO Boleta (IdBoleta, RucBoleta, NombreCliBoleta, DireccCliBoleta, FechaBoleta, ImpTotBoleta, IdEmpleado, IdMenu, IdCli) 
		VALUES ('0000104', '20123456784', 'David', 'Jr Los Alamos', '04/05/2022',70, 7, 4,4)
		INSERT INTO Boleta (IdBoleta, RucBoleta, NombreCliBoleta, DireccCliBoleta, FechaBoleta, ImpTotBoleta, IdEmpleado, IdMenu, IdCli) 
		VALUES ('0000105', '20123456784','Alfredo', 'Jr Junin', '05/05/2022', 90, 8, 5,5)
		INSERT INTO Boleta (IdBoleta, RucBoleta, NombreCliBoleta, DireccCliBoleta, FechaBoleta, ImpTotBoleta, IdEmpleado, IdMenu, IdCli) 
		VALUES ('0000106', '20123456784', 'Aldair', 'Jr Lima', '05/05/2022', 65, 9, 6,6)
		INSERT INTO Boleta (IdBoleta, RucBoleta, NombreCliBoleta, DireccCliBoleta, FechaBoleta, ImpTotBoleta, IdEmpleado, IdMenu, IdCli) 
		VALUES ('0000107', '20123456784', 'Fernando', 'Jr Los Libertadores', '06/06/2022', 120, 10, 7,7)
		INSERT INTO Boleta (IdBoleta, RucBoleta, NombreCliBoleta, DireccCliBoleta, FechaBoleta, ImpTotBoleta, IdEmpleado, IdMenu, IdCli) 
		VALUES ('0000108', '20123456784', 'Mario', 'Jr Atahualpa', '06/06/2022', 45, 6, 8,8)
		INSERT INTO Boleta (IdBoleta, RucBoleta, NombreCliBoleta, DireccCliBoleta, FechaBoleta, ImpTotBoleta, IdEmpleado, IdMenu, IdCli) 
		VALUES ('0000109', '20123456784', 'Julia', 'Jr Ayacucho', '08/07/2022', 25, 7, 9,9)
		INSERT INTO Boleta (IdBoleta, RucBoleta, NombreCliBoleta, DireccCliBoleta, FechaBoleta, ImpTotBoleta, IdEmpleado, IdMenu, IdCli) 
		VALUES ('0000110', '20123456784', 'Julian', 'Jr Junin', '08/07/2022', 50, 8, 10,10)
		GO
		-- Visualizamos los registros 
			SELECT ALL * FROM Boleta
			GO
	-- Detalle Menu - Boleta
		SELECT * FROM DetalleMenuBoleta
			GO
		INSERT INTO DetalleMenuBoleta (IdMenu, IdBoleta, PrecioVenta, Cantidad) 
		VALUES (1,'0000101', 25, 4)
		INSERT INTO DetalleMenuBoleta (IdMenu, IdBoleta, PrecioVenta, Cantidad) 
		VALUES (2,'0000102', 99, 1)
		INSERT INTO DetalleMenuBoleta (IdMenu, IdBoleta, PrecioVenta, Cantidad) 
		VALUES (3,'0000103', 90, 3)
		INSERT INTO DetalleMenuBoleta (IdMenu, IdBoleta, PrecioVenta, Cantidad) 
		VALUES (4,'0000104', 45, 4)
		INSERT INTO DetalleMenuBoleta (IdMenu, IdBoleta, PrecioVenta, Cantidad) 
		VALUES (5,'0000105', 90, 2)
		INSERT INTO DetalleMenuBoleta (IdMenu, IdBoleta, PrecioVenta, Cantidad) 
		VALUES (6,'0000106', 25, 6)
		INSERT INTO DetalleMenuBoleta (IdMenu, IdBoleta, PrecioVenta, Cantidad) 
		VALUES (7,'0000107', 25, 2)
		INSERT INTO DetalleMenuBoleta (IdMenu, IdBoleta, PrecioVenta, Cantidad) 
		VALUES (8,'0000108', 45, 2)
		INSERT INTO DetalleMenuBoleta (IdMenu, IdBoleta, PrecioVenta, Cantidad) 
		VALUES (9,'0000109', 30, 5)
		INSERT INTO DetalleMenuBoleta (IdMenu, IdBoleta, PrecioVenta, Cantidad) 
		VALUES (10,'0000110', 50, 3)
		GO
		-- Visualizamos los registros 
			SELECT ALL * FROM DetalleMenuBoleta
			GO
---======================
-- STORED PROCEDURE (SP) -----------------------------------------------------
--=======================
	-- Procedimiento almacenado que liste todos los campos de la tabla Cliente.  
	-- Listar unicamente los clientes del codigo sexo cliente enviado como parametro. 
		-- PASO 1: Listar todos los campos de la tabla Cliente
			SELECT ALL * FROM Cliente 
			GO
		-- PASO 2: Agregar la condicion
			SELECT ALL * FROM Cliente AS Cli -- Donde "Cli" es el alias
			WHERE Cli.SexoCli = 'Varon' -- Campo igual a dato
			GO
		-- PASO 3: Desarrollo del procedimiento almacenado (sp)
			CREATE OR ALTER PROCEDURE USP_ListarClientexSexo -- Nombre del sp
				@SexoCli CHAR(5) -- Parametro o variable
				AS
				BEGIN -- Inicio del bloque de codigo
					SELECT ALL * FROM Cliente AS Cli 
					WHERE Cli.SexoCli = @SexoCli -- Campo igual a dato
				END -- Fin del bloque de codigo
				GO
		-- PASO 4: Llamar al procedimiento almacenado
			EXECUTE USP_ListarClientexSexo 
			@SexoCli = 'Varon';
			GO
			EXEC USP_ListarClientexSexo 
			@SexoCli = 'Mujer';
			GO
			USP_ListarClientexSexo 
			@SexoCli = 'Varon';
			GO
	-- Procedimiento almacenado que muestre nombre y descripcion de todos los menus
	-- ordenado de manera ascendente por nombre del menu.
	-- Mostrar unicamente los menus cuyo nombre inicie con la letra enviada como parametro.
	-- Asimismo, mostrar unicamente los menus cuya descripcion contenga la letra 
	-- enviada como parametro.
		-- PASO 1: Listar los campos nombre y descripcion de la tabla Menu
			SELECT NombreMenu, DescripcionMenu FROM Menu 
			GO
		-- PASO 2: Agregar la condicion
			SELECT M.NombreMenu, M.DescripcionMenu 
			FROM Menu AS M -- M es el alias de Menu
			WHERE M.NombreMenu LIKE 'T%'AND 
			M.DescripcionMenu LIKE '%CON%'
			ORDER BY M.NombreMenu ASC
			GO
		-- PASO 3: Desarrollo del procedimiento almacenado (sp)
			CREATE OR ALTER PROCEDURE USP_ListarMenuxNombreDescripcion
				@NombreMenu VARCHAR(50), 
				@DescripcionMenu VARCHAR(100) -- Parametros
				AS
				BEGIN
					SELECT M.NombreMenu, M.DescripcionMenu FROM Menu AS M
					WHERE M.NombreMenu LIKE @NombreMenu + '%' AND 
					M.DescripcionMenu LIKE '%'+ @DescripcionMenu + '%'
					ORDER BY M.NombreMenu ASC
				END 
				GO
		-- PASO 4: Llamar al procedimiento almacenado
			EXECUTE USP_ListarMenuxNombreDescripcion 
			@NombreMenu = 'T', @DescripcionMenu = 'CON';
			GO
			EXEC USP_ListarMenuxNombreDescripcion 
			@NombreMenu = 'C', @DescripcionMenu = 'DE';
			GO
			USP_ListarMenuxNombreDescripcion 
			@NombreMenu = 'A', @DescripcionMenu = 'Arroz';
			GO
---====================
-- BD, Tablas y campos ------------------------------------------------
--=====================
	-- Visualizamos las bases de datos 
		BEGIN
			--SELECT ALL * FROM SYS.DATABASES
			SELECT NAME, DATABASE_ID, CREATE_DATE 
			FROM SYS.DATABASES
			WHERE DATABASE_ID > 4
		END
		GO
	-- Visualizamos las tablas
		BEGIN
			USE Restaurante
			--SELECT ALL * FROM INFORMATION_SCHEMA.TABLES
			SELECT TABLE_NAME, TABLE_TYPE 
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE = 'BASE TABLE'
		END
		GO
	-- Visualizamos los campos de las tablas 
		BEGIN
			USE Restaurante
			-- Tabla Empleado
				--SELECT ALL * FROM INFORMATION_SCHEMA.COLUMNS
				SELECT ALL TABLE_NAME,COLUMN_NAME, DATA_TYPE 
				FROM INFORMATION_SCHEMA.COLUMNS
				WHERE TABLE_NAME = 'Empleado'
			-- Tabla Establecimiento
				SELECT ALL TABLE_NAME,COLUMN_NAME, DATA_TYPE 
				FROM INFORMATION_SCHEMA.COLUMNS
				WHERE TABLE_NAME = 'Establecimiento'
			-- Tabla Cliente
				SELECT ALL TABLE_NAME,COLUMN_NAME, DATA_TYPE 
				FROM INFORMATION_SCHEMA.COLUMNS
				WHERE TABLE_NAME = 'Cliente'
			-- Tabla Reservacion
				SELECT ALL TABLE_NAME,COLUMN_NAME, DATA_TYPE 
				FROM INFORMATION_SCHEMA.COLUMNS
				WHERE TABLE_NAME = 'Reservacion'
			-- Tabla Menu
				SELECT ALL TABLE_NAME,COLUMN_NAME, DATA_TYPE 
				FROM INFORMATION_SCHEMA.COLUMNS
				WHERE TABLE_NAME = 'Menu'
			-- Tabla Boleta
				SELECT ALL TABLE_NAME,COLUMN_NAME, DATA_TYPE 
				FROM INFORMATION_SCHEMA.COLUMNS
				WHERE TABLE_NAME = 'Boleta'
			-- Tabla DetableMenuBoleta
				SELECT ALL TABLE_NAME,COLUMN_NAME, DATA_TYPE 
				FROM INFORMATION_SCHEMA.COLUMNS
				WHERE TABLE_NAME = 'DetalleMenuBoleta'
		END
		GO
---=========
-- CONSULTAS ------------------------------------------------------------------
--==========
	-- Crear una consulta que muestre todos los nombres
	-- y cargos del empleado mas el importe total de la boleta
	-- que se encuentre en un rango determinado.
	-- Donde, el cargo del empleado sea enviado como parametro.
		SELECT ALL * FROM Empleado
		SELECT ALL * FROM Boleta
		SELECT ALL * FROM DetalleMenuBoleta
		GO
		CREATE OR ALTER PROCEDURE USP_ListarEmpleadoBoletaxCargo
		@CargoEmpleado VARCHAR(50)
		AS
		BEGIN
			SELECT ALL E.NombEmpleado, E.CargoEmpleado, B.ImpTotBoleta
			FROM Empleado AS E
			INNER JOIN Boleta AS B
			ON E.IdEmpleado = B.IdEmpleado
			WHERE (E.CargoEmpleado = @CargoEmpleado) AND (B.ImpTotBoleta BETWEEN 70 AND 145)
			ORDER BY B.ImpTotBoleta ASC
		END
		GO
		EXECUTE USP_ListarEmpleadoBoletaxCargo @CargoEmpleado = 'Mesero';
		GO
		EXEC USP_ListarEmpleadoBoletaxCargo @CargoEmpleado = 'Mesera';
		GO
		USP_ListarEmpleadoBoletaxCargo @CargoEmpleado = 'Mesero';
		GO
	-- Crear una consulta que muestre todos nombres que inicien con el caracter
	-- establecido y los cargos del empleado limitado hasta cierto caracter
	-- Ordenado por el nombre de los empleados de manera ascendente.
		SELECT ALL * FROM Empleado
		SELECT ALL * FROM Boleta
		GO
		CREATE OR ALTER PROCEDURE USP_ListarEmpleadoBoletaxCargo
		AS
		BEGIN
			SELECT ALL E.NombEmpleado, SUBSTRING(E.CargoEmpleado,1,6), B.ImpTotBoleta
			FROM Empleado AS E
			LEFT JOIN Boleta AS B
			ON E.IdEmpleado = B.IdEmpleado
			WHERE B.IdEmpleado IS NULL AND E.NombEmpleado LIKE 'A%'
			ORDER BY E.NombEmpleado ASC
		END
		GO
		EXECUTE USP_ListarEmpleadoBoletaxCargo;
		GO	
	-- Creamos una consulta que muestre todos los campos de las tablas
	-- establecimiento y empleado. Donde, el cargo del empleado sea enviado
	-- como parametro, el nombre del establecimiento inicie con T
	-- o L y ordenado de manera ascendente por cargo del empleado.
		SELECT * FROM Establecimiento
		SELECT * FROM Empleado
		GO
		CREATE OR ALTER PROCEDURE USP_ListarEmpleadoEstablecimientoxCargo
		@CargoEmpleado VARCHAR(50)
		AS
		BEGIN
			SELECT Establ.*, Empl.*
			FROM Establecimiento AS Establ
			INNER JOIN Empleado AS Empl
			ON Establ.IdEstabl = Empl.IdEstabl
			WHERE (Empl.CargoEmpleado = @CargoEmpleado) AND (Establ.NombreEstabl LIKE 'T%'
			OR Establ.NombreEstabl LIKE 'L%')
			ORDER BY Empl.CargoEmpleado ASC
		END
		GO
		EXECUTE USP_ListarEmpleadoEstablecimientoxCargo @CargoEmpleado = 'Chef';
		GO
		EXEC USP_ListarEmpleadoEstablecimientoxCargo @CargoEmpleado = 'Cocinero';
		GO
		USP_ListarEmpleadoEstablecimientoxCargo @CargoEmpleado = 'Mesera';
		GO
---=================
-- MANEJO DE FECHAS ---------------------------------------------------
--==================
	SELECT GETDATE() AS 'Dia'
	SELECT DAY(GETDATE()) AS 'Dia'
	SELECT MONTH(GETDATE()) AS 'Mes'
	SELECT YEAR(GETDATE()) AS 'Anio'
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






















