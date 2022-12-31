--SESION 04

--DDL : LENGUAJE DE DEFINICION DE DATOS (CREATE, ALTER, DROP)
use master
go
if db_id('ALBERGUE') is not null  
	drop database ALBERGUE
go
create database ALBERGUE
GO
use ALBERGUE
go

create table MASCOTA (
cod_masc int not null primary key,
nombre_masc varchar(40) not null,
sexo_masc char(1) not null check(sexo_masc like '[M,H]'),
tama�o_masc varchar(20) not null check (tama�o_masc in ('Peque�o', 'Mediano', 'Grande')),
tipo_masc varchar(10) not null check(tipo_masc in ('gato','perro'))
)
go
/*
create table MASCOTA (
cod_masc int not null primary key,
nombre_masc varchar(40) not null,
sexo_masc char(1) not null check(sexo_masc='M' or sexo_masc='H'),
tama�o_masc varchar(20) not null check (tama�o_masc='Peque�o'or tama�o_masc='Mediano'
										or tama�o_masc='Grande'),
tipo_masc varchar(10) not null check(tipo_masc = 'GATO' OR tipo_masc = 'PERRO')
)
go*/

CREATE TABLE BOLETA(
	Nro_Boleta int not null primary key,
	Fecha_Bole date NOT NULL default getdate(),
	Descrip_Bole VARCHAR(50) NULL,
	Total_Bole money NOT NULL check(total_Bole > 0)
)
GO

CREATE TABLE DETALLE_BOLETA(
	cod_masc int not null references MASCOTA,
	Nro_Boleta int not null references BOLETA ,
	servicio varchar(50) not null,
	costo money not null,
	medico varchar(40) not null
	PRIMARY KEY (cod_masc,Nro_Boleta) --PK llave primaria compuesta
)
GO

--DML : LENGUAJE DE MANIPULACION DE DATOS (INSERT, DELETE, UPDATE, SELECT)
--INSERCION

INSERT INTO MASCOTA VALUES (10,'Brock','M','Mediano','perro')
INSERT INTO MASCOTA VALUES (20,'Blue','M','peque�o','gato')
INSERT INTO MASCOTA VALUES (30,'Rose','H','Mediano','perro')

INSERT INTO BOLETA VALUES ( 1,'2022-05-12',null,10)
INSERT INTO BOLETA VALUES ( 2,'2022-04-12',null,15)
INSERT INTO BOLETA VALUES ( 3,'2022-12-12','Pago con yape',5)

select * from BOLETA
select * from MASCOTA
go

INSERT INTO DETALLE_BOLETA VALUES(10,1,'Castracion',120,'Doctora Karla')
INSERT INTO DETALLE_BOLETA VALUES(20,2,'Vacunas',50,'Doctor David')
INSERT INTO DETALLE_BOLETA VALUES(30,3,'Esterilizacion',100,'Doctor David')
go
select * from DETALLE_BOLETA
go


/*ELIMINAR LOS DETALLES DE LA BOLETA CON BOLETA NUMERO 2*/

select * from DETALLE_BOLETA
go
DELETE DETALLE_BOLETA
WHERE NRO_BOLETA=2
GO
select * from DETALLE_BOLETA
go

/*modificar el tama�o de la perrita rose con c�digo 30 por el tama�o grande*/

select * from MASCOTA
go
UPDATE MASCOTA 
SET tama�o_masc='grande'
where cod_masc=30
go
select * from MASCOTA
go


