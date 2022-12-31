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