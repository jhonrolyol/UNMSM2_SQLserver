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




