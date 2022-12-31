--SESION 08


--PARTE 1 : UNIONES INTERNAS, UNIONES EXTERNAS

use NEPTUNO22
GO

/*1. Mostrar los nombres de los clientes que han realizado pedidos, asi como,
     el numero de pedido, la fecha de pedido y el cargo. */

select c.NombreCompa��a, p.IdPedido, p.FechaPedido, p.Cargo
from Clientes as c --tabla 1
inner join Pedidos as p--tabla 2 
on c.IdCliente=p.IdCliente --enlace entre las 2 tablas
order by 1 asc
go

/*1.2 Mostrar los nombres de los clientes que han realizado pedidos, asi como,
     el numero de pedido, la fecha de pedido, codigo del empleado y el cargo del empleado. */
	 	 
SELECT CLI.NombreCompa��a, PED.IdPedido, PED.FechaPedido, PED.IdEmpleado, EMP.Cargo FROM Clientes AS CLI INNER JOIN Pedidos as PEDON CLI.IdCliente = PED.IdClienteINNER JOIN Empleados AS EMPON EMP.IdEmpleado = PED.IdEmpleadoORDER BY 1 ASCGO



--insertar un nuevo cliente

INSERT [dbo].[Clientes] ([IdCliente], [NombreCompa��a], [NombreContacto], [CargoContacto], [Direcci�n], [Ciudad], [Regi�n], [C�dPostal], [Pa�s], [Tel�fono], [Fax]) 
VALUES (N'LIDIS', N'DATOS INTELIGENTES LIDIS', N'Howard Snyder', N'Gerente de marketing', N'2732 Baker Blvd.', N'Eugenia', N'OR', N'97403', N'Estados Unidos', N'(503) 555-7555', NULL)
go
select * from Clientes as c
where c.IdCliente='lidis'
go


--2. Mostrar la lista de clientes que no nos han realizado pedidos.

--left join

select c.*, p.IdPedido,p.IdCliente
from Clientes as c
left join Pedidos as p
on c.IdCliente=p.IdCliente
where p.IdCliente IS NULL
order by 1 asc
go

--right join

select c.*, p.IdPedido,p.IdCliente
from Pedidos as p
right join  Clientes as c
on c.IdCliente=p.IdCliente
where p.IdCliente IS NULL
order by 1 asc
go


--propuesto:

select * from Categor�as
go

insert into Categor�as values (9, 'Otros',null,null)
go

--1. Mostrar las categorias que no tienen asignado productos

-- left join	select Cat. *, prod.IdCategor�a 	from Categor�as as cat	left join Productos as prod	on cat.IdCategor�a= prod.IdCategor�a	where prod.IdCategor�a IS NULL	Order by 1 ASCgo-- right join	select Cat. *, prod.IdCategor�a 	from Productos as prod	right join Categor�as as cat	on cat.IdCategor�a= prod.IdCategor�a	where prod.IdCategor�a IS NULL	Order by 1 ASCgo


--3.

-- FULL JOIN

select Cat. *, prod.IdCategor�a 	from Categor�as as cat	full join Productos as prod	on cat.IdCategor�a= prod.IdCategor�a
go



--CROS JOIN
select c.IdCliente, p.IdProducto
from Clientes as c
cross join Productos p
go


--FIN