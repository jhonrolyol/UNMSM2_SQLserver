--SESION 03 RESTRICCIONES

if db_id('DESPACHO2022') IS NOT NULL
Begin --inicio del bloque de código
	use master --activo la bd master
	DROP DATABASE DESPACHO2022
End --fin
GO
CREATE DATABASE DESPACHO2022 -- creo la bd
GO -- fin del bloque de código
SP_HELPDB DESPACHO2022 --muestra las propiedades de la BD
GO
CREATE table PROVEEDOR(
idProv int not null primary key,
razSocProv varchar(40) not null,
rucProv char(11) not null,
celularProv char(9) not null,
direcProv varchar(60) not null,
email varchar(20) not null
)
GO
CREATE TABLE PRODUCTO (
idProd int not null primary key,
nombreProd varchar(40) not null,
precioProd money not null,
fechaVenProd date not null,
descripProd varchar(45) null,
idProv int not null references PROVEEDOR --llave foránea
)
GO
