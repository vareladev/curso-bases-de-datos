--****************************************************
-- Bases de datos: Introducción a SQL Server
-- Autor: Erick Varela
-- Git: https//:www.github.com/vareladev/
-- Version: 1.0
-- Fecha: marzo 2019
--****************************************************

--Definiendo tablas
--tabla habitacion
CREATE TABLE habitacion(
	id INT NOT NULL,
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
ALTER TABLE reserva ADD CONSTRAINT PK_reserva PRIMARY KEY(id_cliente, id_habitacion);
--Definiendo FKs
ALTER TABLE reserva ADD CONSTRAINT FK_cli_to_res FOREIGN KEY (id_cliente) REFERENCES cliente(id);


	ALTER TABLE reserva ADD CONSTRAINT FK_hab_to_res 
	FOREIGN KEY (id_habitacion) REFERENCES  habitacion(id);

/*
NOTA:
Otra forma de definir las llaves foraneas:
CREATE TABLE reserva(
	id_cliente INT NOT NULL,
	id_habitacion INT NOT NULL,
	CONSTRAINT FK_cli_to_res FOREIGN KEY (id_cliente)     
    REFERENCES cliente(id), 
	CONSTRAINT FK_hab_to_res FOREIGN KEY (id_habitacion)     
    REFERENCES habitacion(id)
);
*/
	
--Sentencia INSERT.
--Insertando datos en tabla habitacion
INSERT INTO habitacion VALUES(1,100,77.79);
INSERT INTO habitacion VALUES(2,101,90.50);
INSERT INTO habitacion VALUES(3,103,100.00);
INSERT INTO habitacion VALUES(4,104,91.99);

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

--No es posible eliminar una tabla que sirva como base a otra (PK->FK)
--Eliminando tabla habitacion
DROP TABLE habitacion --falla!
--Eliminando restriccion FK FK_hab_to_res
ALTER TABLE reserva DROP CONSTRAINT FK_hab_to_res;
--Eliminando tabla habitacion
DROP TABLE habitacion


--Creando tabla habitacion
CREATE TABLE habitacion(
	id INT NOT NULL,
	numero INT NOT NULL,
	precio MONEY NOT NULL,
	CONSTRAINT PK_habitacion PRIMARY KEY (id)
);
INSERT INTO habitacion VALUES(1,100,77.79);
INSERT INTO habitacion VALUES(2,101,90.50);
INSERT INTO habitacion VALUES(3,103,100.00);
INSERT INTO habitacion VALUES(4,104,91.99);

--Definiendo FK FK_hab_to_res
ALTER TABLE reserva ADD CONSTRAINT FK_hab_to_res FOREIGN KEY (id_habitacion) REFERENCES  habitacion(id);

--Insertando datos en reserva:
INSERT INTO reserva VALUES(1,3);
INSERT INTO reserva VALUES(3,4);
INSERT INTO reserva VALUES(4,1);
INSERT INTO reserva VALUES(3,2);
INSERT INTO reserva VALUES(5,2);
INSERT INTO reserva VALUES(2,4);

--Mostrando datos insertados
SELECT * FROM habitacion;
SELECT * FROM cliente;
SELECT * FROM reserva;

--Intentado eliminar la habitacion con id:2
DELETE FROM habitacion WHERE id = 2; --falla!!

--Eliminando FKs:
ALTER TABLE reserva DROP CONSTRAINT FK_cli_to_res;
ALTER TABLE reserva DROP CONSTRAINT FK_hab_to_res;

--Creando FKs de la tabla reserva:
ALTER TABLE reserva ADD CONSTRAINT FK_cli_to_res 
	FOREIGN KEY (id_cliente) REFERENCES cliente(id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE;
ALTER TABLE reserva ADD CONSTRAINT FK_hab_to_res 
	FOREIGN KEY (id_habitacion) REFERENCES  habitacion(id)
	ON DELETE CASCADE
	ON UPDATE NO ACTION;


--Alterando datos en la tabla cliente.
UPDATE cliente SET id = 100 WHERE id = 5;
DELETE FROM cliente WHERE id = 100; --falla!
--Mostrando datos
SELECT * FROM cliente;
SELECT * FROM reserva;

--Alterando datos en la tabla habitacion.
UPDATE habitacion SET id = 400 WHERE id = 4; --falla!
DELETE FROM habitacion WHERE id = 2; 
--Mostrando datos
SELECT * FROM habitacion;
SELECT * FROM reserva;