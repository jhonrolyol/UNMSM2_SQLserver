--CERSEU FISI UNMSM
--Docente : Lic. Lidia Sanchez
--SQL SERVER MODULO 1

--SESION 04
--RESTRICCIONES/DML

if db_id('DESPACHO2023') IS NOT NULL
Begin --inicio del bloque de código
	use master --activo la bd master
	DROP DATABASE DESPACHO2023
End --fin
GO

CREATE DATABASE DESPACHO2023 -- creo la bd
GO -- fin del bloque de código
SP_HELPDB DESPACHO2023 --muestra las propiedades de la BD
GO
USE DESPACHO2023
GO
CREATE table PROVEEDOR(
idProv int not null primary key,
razSocProv varchar(40) not null UNIQUE,
rucProv char(11) not null,
celularProv char(9) not null CHECK (celularProv like '9[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
direcProv varchar(60) not null,
emailProv varchar(30) not null
)
GO
SP_HELP PROVEEDOR
GO
insert into PROVEEDOR VALUES (100,'KORAT S.A.C.','20365261235', '978546232','LA COLMENA 356, SURCO', 'pmartinez@hotmail.com')
insert into PROVEEDOR VALUES (101,'KORAT SRL','20365261235', '978546231','LA COLMENA 380, SURCO', 'amartinez@hotmail.com')
INSERT INTO PROVEEDOR VALUES (102,'SUPERMERCADOS PERUANOS','12345678911','959993322','CALLE LIMA 841','CLIENTES@SUPERMERCADOS.COM')
go

SELECT * FROM PROVEEDOR
GO
--pk 
insert into PROVEEDOR VALUES (100,'KORAT S.A.C.','20365261235', '978546232','LA COLMENA 356, SURCO', 'pmartinez@hotmail.com')
GO --ERROR, VALOR DUPLICADO

--UNIQUE
insert into PROVEEDOR VALUES (103,'KORAT S.A.C.','20365261235', '978546232','LA COLMENA 356, SURCO', 'pmartinez@hotmail.com')
GO--ERROR, RAZON SOCIAL DUPLCADA

--CHECK
insert into PROVEEDOR VALUES (104,'KORAT2 SRL','20365261235', '97854623','LA COLMENA 356, SURCO', 'pmartinez@hotmail.com')
GO--ERROR DEBE TENER 9 DIGITOS

insert into PROVEEDOR VALUES (104,'KORAT3 SRL','20365261235', '878546232','LA COLMENA 356, SURCO', 'pmartinez@hotmail.com')
GO --ERROR, DEBE EMPEZAR EN EL DIGITO 9



CREATE TABLE PRODUCTO (
idProd int not null primary key,
nombreProd varchar(40) not null UNIQUE,
precioProd money not null CHECK (precioProd>=0),
fechaVenProd date not null DEFAULT GETDATE(),
descripProd varchar(45) null,
idProv int not null references PROVEEDOR --llave foránea
)
GO

insert into PRODUCTO VALUES (1, 'TOALLA FELPA 40X30', 50.00, DEFAULT, NULL, 100)
insert into PRODUCTO VALUES (2,' smart TV 42" ',1300.00,DEFAULT,NULL,101)
insert into PRODUCTO VALUES (3,' smart TV 60" ',2500.00,'9/8/22',NULL,102)
insert into PRODUCTO VALUES (4, 'SABANA 2PLZ', 100.00, DEFAULT, NULL, 100)
insert into PRODUCTO VALUES (5, 'SABANA 1.5PLZ', 100.00, DEFAULT, NULL, 102)
insert into PRODUCTO VALUES(6,'Laptop Lenovo',2600.00,'7/08/2022',null,102)
insert into PRODUCTO values(7,'Yogur',5,'2023/08/01','1Lt',100)
insert into PRODUCTO VALUES(8,'Samsung TV 45"',1795.69,'10/06/2022',null,101)
insert into PRODUCTO VALUES(9,'TV Samsung 50"',1795.69,'10/06/2022',null,101)

GO
SELECT * FROM PRODUCTO
GO

--UNIQUE

insert into PRODUCTO VALUES (10, 'TOALLA FELPA 40X30', 50.00, DEFAULT, NULL, 100)
GO --ERROR, NOMBRE DE PRODUCTO DUPLICADO

--FK
insert into PRODUCTO VALUES (10, 'TOALLA FELPA', 50.00, DEFAULT, NULL, 1000)
GO

--PREDICADOS : BETWEEN , LIKE,IN

SELECT * FROM PRODUCTO
GO
--1. Mostrar los productos cuyo precio se encuentre entre 1000 y 3000

-- usando operadores de comparacion (>,<,<>,!=, =) y operadores lógicos (and, or, not)
select * from PRODUCTO as pwhere p.precioProd>=1000 and p.precioProd<=3000 go

--usando el predicado BETWEENselect *from PRODUCTO as pwhere p.precioProd between 1000 and 3000go

--2. Mostrar los productos que empiezan con la letra T.
SELECT * FROM PRODUCTO AS P
WHERE P.nombreProd LIKE 'T%' -- Se usa con patrones
GO

--3. Mostrar los productos que contengan la palabra TV.
SELECT * FROM PRODUCTO AS P
WHERE P.nombreProd LIKE '%TV%' -- Puede estar en cualquier lugar (es un patrón)
GO

--4. Mostrar los productos cuyo 3er caracter sea la letra B.
SELECT * FROM PRODUCTO AS P
WHERE P.nombreProd LIKE '__B%' 
GO


/*LIKE :
[ ] 1 POSICION
_ 1 POSICION -- Se usa para colocar cualquier valor
% VARIOS CARACTERES
^ NEGACION
*/

--PREDICADO : IN

--5. Mostrar los productos proveidos por los proveedores con código 100 o 101

SELECT * FROM PRODUCTO AS P
WHERE P.idProv = 100 or P.idProv = 101
GO

SELECT * FROM PRODUCTO AS P
WHERE P.idProv in (100, 101) 
GO
