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
