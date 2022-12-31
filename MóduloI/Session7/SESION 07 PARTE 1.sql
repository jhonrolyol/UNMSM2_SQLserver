
--SESION 07

use Neptuno22
go

--PARTE 1 : subconsultas

-- empleados que emitieron pedidosselect distinct e.*from Empleados as einner join pedidos as pon e.IdEmpleado=p.IdEmpleadogoselect e.*from Empleados as ewhere e.IdEmpleado in (select p.IdEmpleado                       from Pedidos as p)go-- empleados que NO emitieron pedidosselect e.*from Empleados as ewhere e.IdEmpleado not in (select p.IdEmpleado                       from Pedidos as p)go



--ingresar un nuevo empleado
INSERT [dbo].[Empleados] ([IdEmpleado], [Apellidos], [Nombre], [Cargo], [Tratamiento], [FechaNacimiento],
[FechaContratación], [Dirección], [Ciudad], [Región], [CódPostal], [País], [TelDomicilio], [Extensión], 
[Foto], [Notas], [Jefe]) 
VALUES (10, 'Lidia', N'Nancy', N'Representante de ventas', N'Srta.', CAST(N'1968-12-08T00:00:00.000' AS DateTime), CAST(N'1992-05-01T00:00:00.000' AS DateTime), N'507 - 20th Ave. E.
Apt. 2A', N'Seattle', N'WA', N'98122', N'EE.UU.', N'(206) 555-9857', N'5467', N'EMPID1.BMP', N'Su formación incluye una licenciatura en Psicología por la Universidad del Estado de Colorado. También escribió "El arte de la llamada en frío". Nancy es miembro de Toastmasters International.', 2)
go


/*Seleccione las categorias que tengan productos registrados*/







--agregar una nueva categoria

INSERT [dbo].[Categorías] ([IdCategoría], [NombreCategoría], [Descripción], [Imagen]) 
VALUES (9, N'Otros', null,null )
go

/*Seleccione las categorias que no tengan productos registrados*/





--PROPUESTOS

/*1. Mostrar todos los campos de los productos que pertenezcan a un proveedor específico*/





/*2. Mostrar los productos cuyo precios sea mayor al precio promedio.*/





--PARTE II : VISTAS


/*Crear una vista que liste NombreProducto,NombreCategoría,PrecioUnidad,Suspendido*/

select * from Productos
go
select * from Categorías
go

create view v_ProductosxCatasselect p.NombreProducto, c.NombreCategoría, p.PrecioUnidad,p.Suspendidofrom Productos as pinner join Categorías as con p.IdCategoría=c.IdCategoríago--consultar la vistaselect *from v_ProductosxCatwhere PrecioUnidad between 0 and 5go


--PROPUESTO
/*Crear la vista v_Pedidos y muestre su codigo, fecha de pedido, nombre del cliente,
  codigo y apellido del empleado*/


--Consulte la vista v_Pedido y liste a los pedidos emitidos por empleados cuyo apellido
--inicie con la letra D.



--fin
