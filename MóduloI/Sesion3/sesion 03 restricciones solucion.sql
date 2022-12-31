--SESION 03 RESTRICCIONES

if db_id('DESPACHO2022_2') IS NOT NULL
Begin --inicio del bloque de código
	use master --activo la bd master
	DROP DATABASE DESPACHO2022_2
End --fin
GO

CREATE DATABASE DESPACHO2022_2 -- creo la bd
GO -- fin del bloque de código

SP_HELPDB DESPACHO2022_2 --muestra las propiedades de la BD
GO

USE DESPACHO2022_2
GO

CREATE table PROVEEDOR(
idProv int not null primary key,
razSocProv varchar(40) not null,
rucProv char(11) not null unique check(rucProv like '[1,2]0[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') ,
celularProv char(9) not null check(celularProv like '9[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
direcProv varchar(60) not null,
email varchar(20) not null
)
GO

SP_HELP PROVEEDOR
GO

CREATE TABLE PRODUCTO (
idProd int not null primary key,
nombreProd varchar(40) not null unique,
precioProd money not null check (precioProd>0),
fechaVenProd date not null default getdate(),
descripProd varchar(45) null,
idProv int not null references PROVEEDOR --llave foránea
)
GO

INSERT INTO PROVEEDOR VALUES ('1', 'RS1', '1234567891','12345678915', 'Av. Predro Paulet1', 'proveedor1@gmail.com')
INSERT INTO PROVEEDOR VALUES ('2', 'RS2', '1234567892','12345678914', 'Av. Predro Paulet2', 'proveedor2@gmail.com')
INSERT INTO PROVEEDOR VALUES ('3', 'RS3', '1234567893','12345678913', 'Av. Predro Paulet3', 'proveedor3@gmail.com')
INSERT INTO PROVEEDOR VALUES ('4', 'RS4', '1234567894','12345678912', 'Av. Predro Paulet4', 'proveedor4@gmail.com')
INSERT INTO PROVEEDOR VALUES ('5', 'RS5', '1234567895','12345678911', 'Av. Predro Paulet5', 'proveedor5@gmail.com')
GO

INSERT INTO PRODUCTO VALUES ('1', 'Producto1', '100', '01/03/2021','Descripcción1', '11')
INSERT INTO PRODUCTO VALUES ('2', 'Producto2', '200', '02/03/2021','Descripcción2', '21')
INSERT INTO PRODUCTO VALUES ('3', 'Producto3', '300', '03/03/2021','Descripcción3', '31')
INSERT INTO PRODUCTO VALUES ('4', 'Producto4', '400', '04/03/2021','Descripcción4', '41')
INSERT INTO PRODUCTO VALUES ('5', 'Producto5', '500', '05/03/2021','Descripcción5', '51')
GO






