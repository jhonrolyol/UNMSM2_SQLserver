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