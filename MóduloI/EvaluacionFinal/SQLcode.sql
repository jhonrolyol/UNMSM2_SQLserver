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
--====================
-- CREAMOS LAS TABLAS -------------------------------
--====================
	-- Autor 
		CREATE TABLE Autor (
			IdAutor INT NOT NULL PRIMARY KEY,
			DNIAutor CHAR(8) NOT NULL UNIQUE,
			NombreAutor VARCHAR(50) NOT NULL,
			SexoAutor CHAR(1) NOT NULL,
			FecNacAutor DATE NOT NULL,
		)
		GO
	-- Libro
		CREATE TABLE Libro (
			IdLibro INT NOT NULL PRIMARY KEY,
			TituloLibro VARCHAR(100) NOT NULL,
			EditorialLibro VARCHAR(70) NOT NULL,
			TiposLibro VARCHAR(50) NOT NULL,
			EdicionLibro INT NOT NULL,
			IdAutor INT NOT NULL REFERENCES Autor
		)
		GO
	-- Estudiante
		CREATE TABLE Estudiante (
			IdEstudiante CHAR(8) NOT NULL PRIMARY KEY,
			DNIEstudiante CHAR(8) NOT NULL UNIQUE,
			NombreEstudiante VARCHAR(50) NOT NULL,
			ApellidosEstudiante VARCHAR(50) NOT NULL,
			ProfesionEstudiante VARCHAR(50) NOT NULL,
			EdadEstudiante INT NOT NULL,
			IdLibro INT NOT NULL REFERENCES Libro
		)
		GO
	-- DetalleEstudianteLibro
		CREATE TABLE DetalleEstudianteLibro (
			IdLibro INT NOT NULL REFERENCES Libro,
			IdEstudiante CHAR(8) NOT NULL REFERENCES Estudiante,
			Cantidad INT NOT NULL,
			PRIMARY KEY (IdLibro, IdEstudiante)
		)
		GO
--====================
-- INGRESAR REGISTROS --------------------------------
--====================
	-- Autor
		INSERT INTO Autor (
			IdAutor,
			DNIAutor,
			NombreAutor,
			SexoAutor,
			FecNacAutor
		) VALUES (
			1,
			'43856761',
			'Jostein Gaarder',
			'M',
			'08/08/1952'
		)
		GO
		INSERT INTO Autor (
			IdAutor,
			DNIAutor,
			NombreAutor,
			SexoAutor,
			FecNacAutor
		) VALUES (
			2,
			'33856965',
			'Moises Lazaro',
			'M',
			'04/17/1970'
		)
		GO
		INSERT INTO Autor (
			IdAutor,
			DNIAutor,
			NombreAutor,
			SexoAutor,
			FecNacAutor
		) VALUES (
			3,
			'13857768',
			'Julian Marias',
			'M',
			'02/05/1941'
		)
		GO
			-- Visulizar los registros
				SELECT ALL * FROM Autor
				GO
	-- Libro
		INSERT INTO Libro (
			IdLibro,
			TituloLibro,
			EditorialLibro,
			TiposLibro,
			EdicionLibro,
			IdAutor
		) VALUES (
			1,
			'El Mundo de Sofia',
			'Siruela',
			'Novela',
			6,
			1
		)
		GO
		INSERT INTO Libro (
			IdLibro,
			TituloLibro,
			EditorialLibro,
			TiposLibro,
			EdicionLibro,
			IdAutor
		) VALUES (
			2,
			'Algebra Lineal',
			'Moshera',
			'Matematica',
			4,
			2
		)
		GO
		INSERT INTO Libro (
			IdLibro,
			TituloLibro,
			EditorialLibro,
			TiposLibro,
			EdicionLibro,
			IdAutor
		) VALUES (
			3,
			'Historia de la Filosofia',
			'Alianza Editorial',
			'Historia',
			5,
			3
		)
		GO
			-- Visualizar los registros
				SELECT * FROM Libro 
				GO
	-- Estudiante 
		INSERT INTO Estudiante (
			IdEstudiante,
			DNIEstudiante,
			NombreEstudiante,
			ApellidosEstudiante,
			ProfesionEstudiante,
			EdadEstudiante,
			IdLibro
		) VALUES (
			'09110512', 
			'77955896', 
			'Juan', 
			'Vargas Perez',
			'Derecho', 
			24,
			1
		)
		GO
		INSERT INTO Estudiante (
			IdEstudiante,
			DNIEstudiante,
			NombreEstudiante,
			ApellidosEstudiante,
			ProfesionEstudiante,
			EdadEstudiante,
			IdLibro
		) VALUES (
			'09110516', 
			'71855896', 
			'Luis', 
			'Lopez Ayala',
			'Agronomia', 
			26,
			2
		)
		GO
		INSERT INTO Estudiante (
			IdEstudiante,
			DNIEstudiante,
			NombreEstudiante,
			ApellidosEstudiante,
			ProfesionEstudiante,
			EdadEstudiante,
			IdLibro
		) VALUES (
			'09110517', 
			'79356276', 
			'Carolina', 
			'Quispe Torres',
			'Enfermeria', 
			25,
			3
		)
		GO
			-- Visualizar los registros
				SELECT ALL * FROM Estudiante
				GO
	-- DetalleEstudianteLibro
		INSERT INTO DetalleEstudianteLibro (
			IdLibro,
			IdEstudiante,
			Cantidad
		) VALUES (
			1,
			'09110512',
			3
		)
		GO
		INSERT INTO DetalleEstudianteLibro (
			IdLibro,
			IdEstudiante,
			Cantidad
		) VALUES (
			2,
			'09110516',
			5
		)
		GO
		INSERT INTO DetalleEstudianteLibro (
			IdLibro,
			IdEstudiante,
			Cantidad
		) VALUES (
			3,
			'09110517',
			2
		)
		GO
			-- Visulaizar los registros 
				SELECT ALL * FROM DetalleEstudianteLibro
				GO
--=========================
-- CONSULTA USANDO 1 TABLA -----------------------------------
--=========================
	-- Listar el IdEstudiante, ApellidosNombre y Profesion.
	SELECT ALL * FROM Estudiante
	GO
	-- Insertamos un registro mas en la tabla Estudiante
	INSERT INTO Estudiante (
		IdEstudiante,
		DNIEstudiante,
		NombreEstudiante,
		ApellidosEstudiante,
		ProfesionEstudiante,
		EdadEstudiante,
		IdLibro
	) VALUES (
		'09120516', 
		'79356279', 
		'Valentina', 
		'Robles Huaman',
		'Enfermeria', 
		23,
		3
	)
	GO
	BEGIN
		SELECT E.IdEstudiante, E.ApellidosEstudiante +','+ E.NombreEstudiante AS ApellidosNombre, 
		SUBSTRING(E.ProfesionEstudiante,1,7) Profesion
		FROM Estudiante AS E
		WHERE E.ProfesionEstudiante IN ('Derecho','Agronomia', 'Enfermeria') AND E.IdEstudiante LIKE '%16'
		ORDER BY NombreEstudiante ASC
	END
	GO
--==========================
-- CONSULTA USANDO 3 TABLAS ----------------------------------
--==========================
	-- Listar el nombre del autor y edad; titulo del libro;
	-- nombre del estudiante y profesion; 
	-- Mostrar el autor, edad y titulo del libro que inicie con
	-- un caracter especificado y cuyo estudiante sea de derecho.
	SELECT ALL * FROM Autor
	SELECT ALL * FROM Libro
	SELECT ALL * FROM Estudiante
	GO
	BEGIN
		SELECT A.NombreAutor, DATEDIFF(YEAR, FecNacAutor, '12/31/2022') AS EdadAutor, 
		L.TituloLibro, E.NombreEstudiante, E.ProfesionEstudiante
		FROM Autor AS A
		INNER JOIN Libro AS L
		ON A.IdAutor = L.IdLibro  
		INNER JOIN Estudiante AS E
		ON L.IdLibro = E.IdLibro
		WHERE  L.TituloLibro LIKE 'El%'  AND  E.ProfesionEstudiante = 'Derecho' 
		ORDER BY E.NombreEstudiante ASC
	END
	GO
--=======================
-- STORED PROCEDURE (SP) -------------------------------------
--=======================
	-- Cree un stored procedure (sp) que muestre autor, titulo y edicion.
	-- Listar unicamente los autores, titulo del libro y edicion cuyo codigo 
	-- DNIAutor sea enviado como parametro.
	SELECT ALL * FROM Autor
	SELECT ALL * FROM Libro 
	GO
	CREATE OR ALTER PROCEDURE USP_ListarAutorLibroxDNI
		@DNIAutor CHAR(8) 
		AS
		BEGIN
			SELECT A.NombreAutor, L.TituloLibro, L.EdicionLibro
			FROM Autor AS A
			INNER JOIN Libro AS L
			ON A.IdAutor = L.IdAutor
			WHERE (DNIAutor = @DNIAutor) AND (L.EdicionLibro BETWEEN 4 AND 6)
			ORDER BY L.EdicionLibro ASC
		END
	GO
	EXECUTE USP_ListarAutorLibroxDNI @DNIAutor = '43856761';
	GO






