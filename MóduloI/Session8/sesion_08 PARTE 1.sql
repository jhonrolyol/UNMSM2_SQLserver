--SESION 08


--PARTE 1 : UNIONES INTERNAS, UNIONES EXTERNAS

use Neptunos
GO

/*1. Mostrar los nombres de los clientes que han realizado pedidos, asi como,
     el numero de pedido, la fecha de pedido y el cargo. */




--insertar un nuevo cliente

INSERT [dbo].[Clientes] ([IdCliente], [NombreCompañía], [NombreContacto], [CargoContacto], [Dirección], [Ciudad], [Región], [CódPostal], [País], [Teléfono], [Fax]) 
VALUES (N'LIDIS', N'DATOS INTELIGENTES LIDIS', N'Howard Snyder', N'Gerente de marketing', N'2732 Baker Blvd.', N'Eugenia', N'OR', N'97403', N'Estados Unidos', N'(503) 555-7555', NULL)
go




--2. Mostrar la lista de clientes que no nos han realizado pedidos.

--left join



--propuesto:

select * from Categorías
go

insert into Categorías values (9, 'Otros',null,null)
go

--1. Mostrar las categorias que no tienen asignado productos





--rigth join



--3.

-- FULL JOIN






--CROS JOIN
select c.IdCliente, p.IdProducto
from Clientes as c
cross join Productos p
go


--FIN