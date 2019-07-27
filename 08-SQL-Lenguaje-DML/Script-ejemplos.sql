--****************************************************
-- Bases de datos: Introducción a SQL Server - Lenguaje DML
-- Autor: Erick Varela
-- Git: https//:www.github.com/vareladev/
-- Version: 1.0
-- Fecha: marzo 2019
--****************************************************
drop table habitacion;
drop table cliente;
drop table reserva;

--Definiendo tablas
--tabla habitacion
CREATE TABLE habitacion(
	id INT NOT NULL IDENTITY,
	numero INT NOT NULL,
	precio MONEY NOT NULL,
	CONSTRAINT PK_habitacion PRIMARY KEY (id)
);

--tabla cliente
CREATE TABLE cliente(
	id INT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	correo VARCHAR(25) NULL
);

--tabla reserva
CREATE TABLE reserva(
	id_cliente INT NOT NULL,
	id_habitacion INT NOT NULL,
);

--Definiendo PK compuesta
ALTER TABLE reserva ADD PRIMARY KEY(id_cliente, id_habitacion);
--Definiendo FKs
ALTER TABLE reserva ADD FOREIGN KEY (id_cliente) REFERENCES cliente(id);
ALTER TABLE reserva ADD FOREIGN KEY (id_habitacion) REFERENCES  habitacion(id);

--Sentencia INSERT.
--Insertando datos en tabla habitacion
INSERT INTO habitacion VALUES(100,77.79);
INSERT INTO habitacion VALUES(101,90.50);
INSERT INTO habitacion VALUES(103,100.00);
INSERT INTO habitacion VALUES(104,91.99);

--Insertando datos en tabla cliente
INSERT INTO cliente VALUES(1,'Kaseem Sears','PFQHXJ@maiq.rom');
INSERT INTO cliente VALUES(2,'Susan','ILDGCQ@maio.pom');
INSERT INTO cliente VALUES(3,'Amena','PBHPRB@maia.fom');
INSERT INTO cliente VALUES(4,'Natalie','XUQZUC@maii.rom');
INSERT INTO cliente VALUES(5,'Evelyn','RBGXGX@maih.xom');

--Mostrando datos insertados
SELECT * FROM habitacion;
SELECT * FROM cliente;
SELECT * FROM reserva;


--Sentencia DELETE.
--Eliminando un registro de la tabla cliente.
DELETE FROM cliente; --¿Que pasa al aplicar esta instrucción? mostrar los datos de la tabla cliente
SELECT * FROM cliente;

DELETE FROM cliente WHERE id = 3;
SELECT * FROM cliente;
INSERT INTO cliente VALUES(3,'Amena','PBHPRB@maia.fom');

--Sentencia UPDATE.
--Actualizar un registro de la tabla cliente.
UPDATE cliente SET nombre = 'Amelia Earhart' WHERE id = 3;
SELECT * FROM cliente;
/*
NOTA:
	¿Que pasaría si se aplica la sentencia anterior de la siguiente manera:
	UPDATE cliente SET nombre = 'Amelia Earhart';
*/


--Sentencia SELECT (básico).
--mostrando todas las habitaciones registradas en la base de datos
SELECT * FROM habitacion;

--mostrando todos los clientes registrados en la base de datos.
SELECT * FROM cliente;
--tambien es posible:
SELECT id, nombre, correo FROM cliente;

--utilizando condiciones lógicas para mostrar datos.
SELECT * FROM cliente WHERE id > 4;
SELECT * FROM cliente WHERE nombre = 'Natalie';
SELECT * FROM cliente WHERE id >= 2;
SELECT * FROM cliente WHERE id >= 2 AND id <= 4;
--Uso de BETWEEN 
SELECT * FROM cliente WHERE id BETWEEN 2 AND 4;
SELECT * FROM cliente WHERE id NOT BETWEEN 2 AND 4;
--Uso de AND|OR
SELECT * FROM cliente WHERE id = 2 OR id = 5;
SELECT * FROM cliente WHERE id = 2 AND correo = 'ILDGCQ@maio.pom';
--Uso del LIKE
SELECT * FROM cliente WHERE nombre LIKE 'Am%';
SELECT * FROM cliente WHERE nombre LIKE '%li%';	


--Sentencia TRUNCATE
--Borrando todas las habitaciones
DELETE FROM habitacion;
--Insertando habitaciones ¿Que pasa con el campo autoincrementable?
INSERT INTO habitacion VALUES(100,77.79);
INSERT INTO habitacion VALUES(101,90.50);
INSERT INTO habitacion VALUES(103,100.00);
INSERT INTO habitacion VALUES(104,91.99);
--Mostrando datos:
SELECT * FROM habitacion;

--Borrando todas las habitaciones utilizando TRUNCATE
--Borrando todas las habitaciones
DROP TABLE reserva;
TRUNCATE TABLE habitacion;
--Insertando habitaciones ¿Que pasa con el campo autoincrementable?
INSERT INTO habitacion VALUES(100,77.79);
INSERT INTO habitacion VALUES(101,90.50);
INSERT INTO habitacion VALUES(103,100.00);
INSERT INTO habitacion VALUES(104,91.99);
--Mostrando datos:
SELECT * FROM habitacion;