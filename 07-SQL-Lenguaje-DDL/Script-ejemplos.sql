--****************************************************
-- Bases de datos: Introducción a SQL Server - lenguaje DDL
-- Autor: Erick Varela
-- Git: https//:www.github.com/vareladev/
-- Version: 1.0
-- Fecha: marzo 2019
--****************************************************

--Creando comentarios omentarios
--Este es un comentario de linea

/*
	Este 
	es un comentario
	de
	Bloque
*/

--Creando tablas
CREATE TABLE hotel(
	id INT,
	nombre VARCHAR(50),
	direccion VARCHAR(100),
	telefono CHAR(13)
);

--Insertando datos en tabla:
INSERT INTO hotel (id, nombre, direccion, telefono)
	VALUES(1,'Vulputate Posuere LLC','4945 Purus. St.','+5032423-4992');
INSERT INTO hotel(id, nombre,telefono)
	VALUES(2,'Mi Egestas Ltd','+5032500-8446');

--Mostrar toda la información de la tabla:
SELECT * FROM hotel;
--Mostrar algunas columnas:
SELECT nombre, telefono FROM hotel;
--El orden de seleccion de columnas no importa:
SELECT telefono, direccion, id, nombre FROM hotel;
/*
NOTA: SQL es un lenguaje no sensible a mayusculas. 
¿Que significa esto?
*/

--borrando tabla
DROP TABLE hotel;

--RESTRICCIONES: 
--Columnas NULL/NOT NULL
CREATE TABLE hotel(
	id INT,
	nombre VARCHAR(50) NOT NULL,
	direccion VARCHAR(100) NULL,
	telefono CHAR(13) NOT NULL
);

INSERT INTO hotel(id, nombre, direccion, telefono)
	VALUES(1,'Vulputate Posuere LLC','4945 Purus. St.','+5032423-4992');
INSERT INTO hotel(id, nombre)
	VALUES(2,'Mi Egestas Ltd'); --falla!
--Mostrando la información de la tabla:
SELECT * FROM hotel;

/*
NOTA:
Las columnas definidas como llaves primaria por defecto son definen como NOT NULL
*/

--Definiendo llave primaria (PK)
ALTER TABLE hotel ADD CONSTRAINT PK_hotel PRIMARY KEY (id); --¡Falla! 
--(Es necesario que el campo a definir como PK sea configurado como NOT NULL)

--borrando tabla
DROP TABLE hotel;


CREATE TABLE hotel(
	id INT NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	direccion VARCHAR(100) NULL,
	telefono CHAR(13) NULL
);


--Definiendo llave primaria (PK)
ALTER TABLE hotel ADD CONSTRAINT PK_hotel PRIMARY KEY (id); 

/*
NOTA:
Alternativas para definir la llave primaria: 
	* Agregar llave primaria cuando se crea la tabla:
		CREATE TABLE hotel(
			id INT PRIMARY KEY,
			nombre VARCHAR(50) NOT NULL,
			direccion VARCHAR(100) NULL,
			telefono CHAR(13) NULL
		);
	
	* Agregar llave primaria al final de la definición de la tabla:
		CREATE TABLE hotel(
			id INT,
			nombre VARCHAR(50) NOT NULL,
			direccion VARCHAR(100) NULL,
			telefono CHAR(13) NULL,
			CONSTRAINT PK_hotel PRIMARY KEY (id)
		);	
*/

--borrando tabla
DROP TABLE hotel;

--Columnas UNIQUE
CREATE TABLE hotel(
	id INT NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	direccion VARCHAR(100) NULL,
	telefono CHAR(13) NULL UNIQUE,
	CONSTRAINT PK_hotel PRIMARY KEY (id)
);

INSERT INTO hotel(id, nombre, direccion, telefono)
	VALUES(1,'Vulputate Posuere LLC','4945 Purus. St.','+5032423-4992');
INSERT INTO hotel(id, nombre,telefono)
	VALUES(2,'Mi Egestas Ltd','+5032500-8446');
INSERT INTO hotel(id, nombre, telefono)
	VALUES(3,'Quisque Associates','+5032500-8446'); --falla!
--Mostrando la información de la tabla:
SELECT * FROM hotel;
	
--Columnas con valores por defecto.
DROP TABLE hotel;
CREATE TABLE hotel(
	id INT NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	direccion VARCHAR(100) DEFAULT 'Dirección no definida',
	telefono CHAR(13) NULL UNIQUE,
	CONSTRAINT PK_hotel PRIMARY KEY (id)
);	

INSERT INTO hotel(id, nombre,telefono)
	VALUES(2,'Mi Egestas Ltd','+5032500-8446');
--Mostrando la información de la tabla:
SELECT * FROM hotel;

--Columnas con evaluacion de valores
DROP TABLE hotel;
CREATE TABLE hotel(
	id INT NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	direccion VARCHAR(100) DEFAULT 'Dirección no definida',
	telefono CHAR(13) CHECK (telefono LIKE '\+503[27][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' ESCAPE '\'),
	CONSTRAINT PK_hotel PRIMARY KEY (id)
);	


INSERT INTO hotel(id, nombre, direccion, telefono)
	VALUES(1,'Vulputate Posuere LLC','4945 Purus. St.','2423-4992'); --falla!
INSERT INTO hotel(id, nombre, direccion, telefono)
	VALUES(1,'Vulputate Posuere LLC','4945 Purus. St.','+5032423-4992');
--Mostrando la información de la tabla:
SELECT * FROM hotel;

--Definiendo llaves foráneas (FK)
--Definiendo tabla habitacion
CREATE TABLE habitacion(
	id INT NOT NULL,
	numero INT NOT NULL,
	precio MONEY NOT NULL,
	CONSTRAINT PK_habitacion PRIMARY KEY (id)
);

--Definiendo Foreign Keys (Relaciones)
--Agregando columnas
ALTER TABLE habitacion ADD id_hotel INT;

--Mostrando la información de la tabla:
SELECT * FROM habitacion;

--Creando relaciones:
ALTER TABLE habitacion ADD CONSTRAINT FK_from_hotel FOREIGN KEY (id_hotel) REFERENCES hotel (id); 




