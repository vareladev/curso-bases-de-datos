--****************************************************
-- Bases de datos - Scritp base de datos veterinaria
-- Autor: Erick Varela
-- Git: https//:www.github.com/vareladev/
-- Version: 1.0 Español
-- Fecha: marzo 2019
--****************************************************


CREATE TABLE cliente(
	idCliente INT PRIMARY KEY IDENTITY,
	nombreCliente VARCHAR(100),
	direccion VARCHAR(100),
	telefono CHAR(10),
	correo VARCHAR(50)
);

CREATE TABLE medico(
	idMedico INT PRIMARY KEY IDENTITY,
	nombreMedico VARCHAR(100),
	salario MONEY,
	FechaContrato DATE
);

CREATE TABLE raza(
	idRaza INT PRIMARY KEY IDENTITY,
	raza VARCHAR(50)
);

CREATE TABLE paciente(
	idPaciente INT PRIMARY KEY IDENTITY,
	nombrePaciente VARCHAR(50),
	idCliente INT,
	idRaza INT,
	fechaNacimiento DATE
);

CREATE TABLE consulta(
	idConsulta INT PRIMARY KEY IDENTITY,
	idPaciente INT,
	idMedico INT,
	fecha DATE,
	precioConsulta MONEY
);

CREATE TABLE medicamento(
	idMedicamento INT PRIMARY KEY IDENTITY,
	nombre VARCHAR(50),
	precio MONEY
);

CREATE TABLE receta(
	idMedicamento INT NOT NULL,
	idConsulta INT NOT NULL
);

ALTER TABLE receta ADD PRIMARY KEY(idMedicamento, idConsulta);
ALTER TABLE paciente ADD FOREIGN KEY(idCliente) REFERENCES cliente(idCliente) ON DELETE CASCADE;
ALTER TABLE paciente ADD FOREIGN KEY(idRaza) REFERENCES raza(idRaza) ON DELETE CASCADE;
ALTER TABLE consulta ADD FOREIGN KEY(idPaciente) REFERENCES paciente(idPaciente) ON DELETE CASCADE;
ALTER TABLE consulta ADD FOREIGN KEY(idMedico) REFERENCES medico(idMedico) ON DELETE CASCADE;
ALTER TABLE receta ADD FOREIGN KEY(idMedicamento) REFERENCES medicamento(idMedicamento) ON DELETE CASCADE;
ALTER TABLE receta ADD FOREIGN KEY(idConsulta) REFERENCES consulta(idConsulta) ON DELETE CASCADE;

--RAZA
INSERT INTO raza VALUES('Jack Russell');
INSERT INTO raza VALUES('pit bull terrier');
INSERT INTO raza VALUES('beagle');
INSERT INTO raza VALUES('Terrier');
INSERT INTO raza VALUES('Bulldog');
INSERT INTO raza VALUES('Chihuahua');
INSERT INTO raza VALUES('Husky');
INSERT INTO raza VALUES('Pastor Alemán');
INSERT INTO raza VALUES('Mestizo');

--MEDICO
INSERT INTO medico VALUES('Kasimir Bush','1559',convert(date,'04/09/2014',103));
INSERT INTO medico VALUES('Talon Page','1229',convert(date,'21/08/2016',103));
INSERT INTO medico VALUES('Brock Howard','1455',convert(date,'08/04/2014',103));
INSERT INTO medico VALUES('Ericka Kovosky','1300',convert(date,'23/07/2015',103));

--CLIENTE
INSERT INTO cliente VALUES('Julie Fleming','Ap #516-3204 Nulla Road','7996-8165','hendrerit@Vivamus.edu');
INSERT INTO cliente VALUES('Avye Wiley','P.O. Box 319, 3154 Ornare Rd.','7683-9474','nisi.magna@enimsitamet.net');
INSERT INTO cliente VALUES('Regan Greene','9943 Tincidunt Ave','7593-2558','Donec@malesuadamalesuada.com');
INSERT INTO cliente VALUES('Karly Charles','P.O. Box 447, 2355 Euismod Rd.','7975-8486','Nam@nulla.com');
INSERT INTO cliente VALUES('Melodie George','P.O. Box 257, 5814 Eu, St.','7298-3505','lobortis.risus.In@diamProin.com');
INSERT INTO cliente VALUES('Dai Oneill','Ap #194-9317 Vel, Rd.','7283-5384','in.dolor.Fusce@vitae.ca');
INSERT INTO cliente VALUES('Mari Cross','480-7023 Aliquet Rd.','7471-3990','pellentesque@Proin.co.uk');
INSERT INTO cliente VALUES('TaShya Simpson','8170 Cursus Av.','7119-9480','risus.varius@velfaucibus.net');
INSERT INTO cliente VALUES('Sonia Woodward','490-6531 Sem. St.','7342-0371','malesuada.fringilla@scelerisque.org');
INSERT INTO cliente VALUES('Sonia Woodward','490-6531 Sem. St.','7342-0371','malesuada.fringilla@scelerisque.org');
INSERT INTO cliente VALUES('Lee Chambers','733-1804 Parturient Avenue','7852-6526','vulputate@Cras.net');

--paciente
INSERT INTO paciente VALUES('Callum',2,1,convert(date,'10/09/2017',103));
INSERT INTO paciente VALUES('Ray',4,7,convert(date,'02/05/2018',103));
INSERT INTO paciente VALUES('Dieter',1,3,convert(date,'11/10/2016',103));
INSERT INTO paciente VALUES('Malachi',2,9,convert(date,'07/11/2016',103));
INSERT INTO paciente VALUES('Rahim',5,6,convert(date,'28/04/2018',103));
INSERT INTO paciente VALUES('Ezra',3,9,convert(date,'30/06/2017',103));
INSERT INTO paciente VALUES('Gannon',6,7,convert(date,'11/11/2018',103));
INSERT INTO paciente VALUES('Griffin',1,6,convert(date,'07/02/2017',103));
INSERT INTO paciente VALUES('Francis',3,7,convert(date,'10/06/2016',103));
INSERT INTO paciente VALUES('Kareem',7,8,convert(date,'12/06/2017',103));
INSERT INTO paciente VALUES('Perry',1,6,convert(date,'23/05/2018',103));
INSERT INTO paciente VALUES('Troy',9,4,convert(date,'03/07/2016',103));
INSERT INTO paciente VALUES('Mason',2,5,convert(date,'20/04/2018',103));

--medicamento
INSERT INTO medicamento VALUES('Aspirina', 8.26);
INSERT INTO medicamento VALUES('Bromuros de potasio', 8.34);
INSERT INTO medicamento VALUES('Carprofeno', 1.83);
INSERT INTO medicamento VALUES('Cloruro de potasio', 2.50);
INSERT INTO medicamento VALUES('Diazepam', 1.99);
INSERT INTO medicamento VALUES('Digoxina', 22.85);
INSERT INTO medicamento VALUES('Enalapril', 17.04);
INSERT INTO medicamento VALUES('Fenbendazol', 9.50);
INSERT INTO medicamento VALUES('Metronidazol', 8.99);
INSERT INTO medicamento VALUES('Piroxicam',7.10);

-Consulta
INSERT INTO consulta VALUES(2,3,convert(date,'06/03/2018',103),75.96);
INSERT INTO consulta VALUES(1,2,convert(date,'17/04/2018',103),28.41);
INSERT INTO consulta VALUES(5,2,convert(date,'23/03/2018',103),90.25);
INSERT INTO consulta VALUES(11,2,convert(date,'27/03/2018',103),84.14);
INSERT INTO consulta VALUES(13,3,convert(date,'26/05/2018',103),93.67);
INSERT INTO consulta VALUES(12,2,convert(date,'30/05/2018',103),18.06);
INSERT INTO consulta VALUES(1,2,convert(date,'22/05/2018',103),72.14);
INSERT INTO consulta VALUES(2,3,convert(date,'13/05/2018',103),83.44);
INSERT INTO consulta VALUES(8,3,convert(date,'19/04/2018',103),86.10);
INSERT INTO consulta VALUES(9,2,convert(date,'01/03/2018',103),77.47);
INSERT INTO consulta VALUES(13,3,convert(date,'03/04/2018',103),72.80);
INSERT INTO consulta VALUES(6,3,convert(date,'30/04/2018',103),23.70);
INSERT INTO consulta VALUES(7,3,convert(date,'19/03/2018',103),38.96);
INSERT INTO consulta VALUES(4,4,convert(date,'15/03/2018',103),0.79);
INSERT INTO consulta VALUES(2,3,convert(date,'18/03/2018',103),26.72);
INSERT INTO consulta VALUES(1,2,convert(date,'16/03/2018',103),81.15);
INSERT INTO consulta VALUES(2,2,convert(date,'10/03/2018',103),14.84);
INSERT INTO consulta VALUES(10,4,convert(date,'24/03/2018',103),35.80);
INSERT INTO consulta VALUES(12,2,convert(date,'06/03/2018',103),97.64);
INSERT INTO consulta VALUES(8,3,convert(date,'04/05/2018',103),54.15);

--Receta
INSERT INTO receta VALUES(8,9);
INSERT INTO receta VALUES(3,15);
INSERT INTO receta VALUES(7,20);
INSERT INTO receta VALUES(1,10);
INSERT INTO receta VALUES(1,17);
INSERT INTO receta VALUES(6,12);
INSERT INTO receta VALUES(4,14);
INSERT INTO receta VALUES(8,19);
INSERT INTO receta VALUES(8,1);
INSERT INTO receta VALUES(4,11);
INSERT INTO receta VALUES(6,19);
INSERT INTO receta VALUES(5,5);
INSERT INTO receta VALUES(7,9);
INSERT INTO receta VALUES(6,6);
INSERT INTO receta VALUES(7,3);
INSERT INTO receta VALUES(7,7);
INSERT INTO receta VALUES(2,15);
INSERT INTO receta VALUES(9,1);
INSERT INTO receta VALUES(9,2);
INSERT INTO receta VALUES(7,14);
INSERT INTO receta VALUES(5,2);
INSERT INTO receta VALUES(9,3);
INSERT INTO receta VALUES(3,5);
INSERT INTO receta VALUES(2,12);
INSERT INTO receta VALUES(2,11);
INSERT INTO receta VALUES(1,20);
INSERT INTO receta VALUES(9,14);
INSERT INTO receta VALUES(2,8);
INSERT INTO receta VALUES(4,15);
INSERT INTO receta VALUES(2,6);

-- Ejercicio 1a
-- Mostrar la lista de medicamentos ordenados del mas caro al mas barato.

-- Ejercicio 1b
-- Basandose en el ejercicio 1a, mostrar los 3 productos mas caros
-- investigar la instruccion TOP


-- Ejercicio 1c
-- Basandose en el ejercicio 1a, mostrar los 3 productos mas baratos
-- investigar la instruccion TOP


-- Ejercicio 2a
-- Mostrar cuantas mascotas tienen registradas cada cliente:

-- Ejercicio 2b
-- Mostrar los clientes que no tienen ninguna mascota registrada:


-- Ejercicio 2c
-- Mostrar cuantas mascotas tienen registradas cada cliente, incluir en la lista los clientes que no tienen ninguna mascota registrada.
-- es necesario mostrar primero los clientes que mas mascotas tienen registradas.


--Ejercicio 3
-- Mostrar cuantas consultas realizò cada doctor en el mes de marzo de 2018.


--Ejercicio 4
-- Mostrar cuales son las 4 razas de perros mas saludables 


