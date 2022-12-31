use master
go
if db_id('ALBERGUE') is not null  
	drop database ALBERGUE
go

create database ALBERGUE
go

use ALBERGUE
go 

create table MASCOTA (
	cod_masc int not null primary key,
	nombre_masc varchar(40) not null,
	sexo_masc char(1) not null check(sexo_masc like '[M,H]'), -- "like2 se usa para comparar cadenas ([] especifica un caracter)
	tamaño_masc varchar(20) not null check(tamaño_masc in ('pequeño', 'mediano', 'grande')), -- "in" se usa para este caso (() separa un varios caracteres)
	tipo_masc varchar(10) not null check(tipo_masc in ('gato', 'perro')) -- "in" 
)

/*
create table MASCOTA (
	cod_masc int not null primary key,
	nombre_masc varchar(40) not null,
	sexo_masc char(1) not null check(sexo_masc = 'M' or sexo_masc='H'), 
	tamaño_masc varchar(20) not null unique check(tamaño_masc = 'pequeño' or tamaño_masc = 'mediano' or tamaño_masc = 'grande'), 
	tipo_masc varchar(10) not null check(tipo_masc = 'GATO' or tipo_masc = 'PERRO') 
)
*/


CREATE TABLE BOLETA (
	Nro_Boleta int not null primary key,
	Fecha_Bole date not null,
	Descrip_Bole varchar(100) null,
	Total_Bole money not null check(Total_Bole > 0 )
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


INSERT INTO MASCOTA VALUES (10, 'Firulais', 'M', 'Mediano', 'gato')
INSERT INTO MASCOTA VALUES (20,'Brock','M','Mediano','perro')
INSERT INTO MASCOTA VALUES (30,'Blue','M','pequeño','gato')
INSERT INTO MASCOTA VALUES (40,'Rose','H','Mediano','perro')

INSERT INTO BOLETA VALUES ( 1,'2022-05-12',null,10)
INSERT INTO BOLETA VALUES ( 2,'2022-04-12',null,15)
INSERT INTO BOLETA VALUES ( 3,'2022-12-12','Pago con yape',5)

select * from BOLETA
select * from MASCOTA
go

INSERT INTO DETALLE_BOLETA VALUES(10,1,'Castracion',120,'Doctora Karla')INSERT INTO DETALLE_BOLETA VALUES(20,2,'Vacunas',50,'Doctor David')INSERT INTO DETALLE_BOLETA VALUES(30,3,'Esterilizacion',100,'Doctor David')
GO

select * from DETALLE_BOLETA
GO

/*ELIMINAR LOS DETALLES DE LA BOLETA CON BOLETA NUMERO 2*/select * from DETALLE_BOLETAgoDELETE DETALLE_BOLETAWHERE NRO_BOLETA=2GOselect * from DETALLE_BOLETAgo

/*modificar el tamaño de la perrita rose con código 30 por el tamaño grande*/	select * from MASCOTA	go	UPDATE MASCOTA 		SET tamaño_masc='grande'		where cod_masc=30		go	select * from MASCOTA	go

	