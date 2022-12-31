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
