--****************************************************
-- Bases de datos - Scritp base de datos venta de libros
-- Autor: Erick Varela
-- Git: https//:www.github.com/vareladev/
-- Version: 1.0 Español
-- Fecha: marzo 2019
--****************************************************

CREATE TABLE AUTOR(
	idAutor INT PRIMARY KEY IDENTITY,
	nombre VARCHAR(50),
	AnnioNacimiento DATE NOT NULL,
	AnnioMuerte DATE NULL
);
INSERT INTO AUTOR([nombre],[AnnioNacimiento],[AnnioMuerte]) VALUES('Jaquelyn Garner','15/02/1996',NULL),('Cora Dodson','19/09/2009',NULL),('Nicole Vaughan','25/11/1975','04/11/1995'),('Norman Sharp','02/11/1967','01/01/2016'),('Zeus Carpenter','18/08/1987','01/09/2012'),('Whoopi Fuller','29/07/1996',NULL),('Glenna Villarreal','09/03/1941',NULL),('Ella Vaughn','22/11/1926','10/11/1993'),('Quon Rowe','11/09/1997',NULL),('Quinlan Mcfarland','16/02/1993',NULL);
INSERT INTO AUTOR([nombre],[AnnioNacimiento],[AnnioMuerte]) VALUES('Montana Best','09/07/1947',NULL),('Ava Sparks','05/04/1964',NULL),('Todd Rivers','19/09/2011',NULL),('Kay Goodwin','24/03/1963',NULL),('Cheryl Velez','20/04/1936','04/03/1998'),('Ferris Vasquez','30/11/1955','21/07/2002'),('Baker Horne','04/12/1958','07/05/2012'),('Ahmed Hurst','03/04/1933','24/10/2006'),('Orli Arnold','23/10/2005',NULL),('September Charles','27/01/1965',NULL);


CREATE TABLE CONDICION(
	idCondicion INT PRIMARY KEY IDENTITY,
	condicion VARCHAR(50),
	descripcion VARCHAR(100)
);
INSERT INTO CONDICION (condicion,descripcion) VALUES('nuevo', 'libros importados'),('usado', 'en buen estado, detalles minimos');

CREATE TABLE LIBRO(
	codLibro INT PRIMARY KEY IDENTITY,
	titulo VARCHAR(50),
	editorial VARCHAR(25),
	fechaEdicion DATE,
	precio FLOAT,
	IdCondicion INT
)
ALTER TABLE LIBRO ADD FOREIGN KEY(IdCondicion) REFERENCES CONDICION(idCondicion);
INSERT INTO LIBRO([titulo],[editorial],[fechaEdicion],[precio],[IdCondicion]) VALUES('lorem. Donec','adipiscing','02/09/2014',45.39,2),('malesuada. Integer','augue,','14/03/2000',76.57,2),('consectetuer','Quisque','10/07/2015',59.75,1),('consequat','felis.','28/08/2000',76.87,1),('enim, condimentum eget,','metus','15/07/1984',34.62,2),('neque non','mi','30/04/1987',71.46,2),('risus. Duis a','nunc,','03/04/2008',49.18,1),('metus urna convallis','lorem','14/05/2001',17.47,2),('placerat eget, venenatis a,','Sed','13/10/1992',40.42,2),('mauris,','neque','15/11/2008',71.74,2);
INSERT INTO LIBRO([titulo],[editorial],[fechaEdicion],[precio],[IdCondicion]) VALUES('sed','elementum,','09/03/1984',23.11,2),('justo','tempor','05/10/1999',75.58,2),('at fringilla purus mauris','tellus.','07/06/1987',20.46,2),('rhoncus id, mollis nec,','Proin','21/02/1992',18.99,2),('Donec','malesuada','02/02/2008',2.19,1),('primis in','dolor,','27/01/2001',48.89,2),('sem molestie','per','18/06/2001',61.84,2),('mauris ipsum porta elit,','vulputate,','24/01/2009',18.72,2),('placerat velit. Quisque','nec','03/11/2001',81.22,1),('Proin sed turpis','sed','21/01/2012',17.53,2);
INSERT INTO LIBRO([titulo],[editorial],[fechaEdicion],[precio],[IdCondicion]) VALUES('in, cursus','arcu','09/01/2016',62.38,1),('aliquet lobortis,','orci','02/10/1996',47.88,2),('amet, consectetuer','ac','12/07/2003',33.61,1),('arcu.','venenatis','03/01/2000',52.48,2),('sodales at, velit. Pellentesque','ut,','20/08/1984',46.02,1),('libero dui nec','dolor.','10/04/2004',63.66,2),('ligula eu enim.','rhoncus.','27/06/1987',94.73,2),('Proin vel','consequat','08/03/2013',90.54,2),('ornare, libero at','mollis.','18/08/1993',43.16,1),('Nullam velit dui, semper','penatibus','16/10/1989',16.88,2);

CREATE TABLE LIBROXAUTOR(
	idAutor INT NOT NULL,
	codLibro INT NOT NULL
);
ALTER TABLE LIBROXAUTOR ADD PRIMARY KEY(idAutor,codLibro);
ALTER TABLE LIBROXAUTOR ADD FOREIGN KEY(idAutor) REFERENCES AUTOR(idAutor);
ALTER TABLE LIBROXAUTOR ADD FOREIGN KEY(codLibro) REFERENCES LIBRO(codLibro);
INSERT INTO LIBROXAUTOR([idAutor],[codLibro]) VALUES(17,1),(3,2),(13,3),(14,4),(17,5),(18,6),(5,7),(1,8),(17,9),(20,10);
INSERT INTO LIBROXAUTOR([idAutor],[codLibro]) VALUES(19,11),(20,12),(5,13),(2,14),(10,15),(16,16),(14,17),(15,18),(18,19),(6,20);
INSERT INTO LIBROXAUTOR([idAutor],[codLibro]) VALUES(18,21),(9,22),(13,23),(18,24),(8,25),(15,26),(2,27),(3,28),(16,29),(6,30);


CREATE TABLE CLIENTE(
	idCliente INT PRIMARY KEY IDENTITY,
	nombre VARCHAR(50),
	telefono CHAR(9),
	direccion VARCHAR(50)
);
INSERT INTO CLIENTE([nombre],[telefono],[direccion]) VALUES('Joelle Carter','2382-8424','4990 Nulla St.'),('Leah Fischer','7792-7375','P.O. Box 583, 1196 Amet, St.'),('Declan Wilder','2365-2932','Ap #480-7761 Magna. Rd.'),('Kyra Dickson','7424-9395','437-6087 At St.'),('Ezekiel Stark','7188-5188','815-8998 Non, Road'),('Neville Spence','2122-4606','6447 Nulla Rd.'),('Otto Workman','7913-2626','P.O. Box 586, 4798 In, Street'),('Darrel Summers','7766-7253','P.O. Box 341, 6408 Dolor St.'),('Ahmed Hodge','2584-9729','P.O. Box 533, 9255 Imperdiet Avenue'),('Ignatius Suarez','2380-0402','P.O. Box 293, 4856 Sed Avenue');
INSERT INTO CLIENTE([nombre],[telefono],[direccion]) VALUES('Benjamin Mays','2155-4077','8806 Tortor, Ave'),('Brielle Booker','7352-2696','Ap #488-2311 Nibh Road'),('Hedwig Dorsey','2969-1821','P.O. Box 291, 3657 Integer St.'),('Alika Velazquez','2521-8112','441-5684 Augue Rd.'),('Allistair Sosa','7044-7474','Ap #897-258 Urna St.'),('Yuri Shaffer','2245-2132','P.O. Box 893, 4728 Id St.'),('Ina Rice','2043-5922','Ap #987-6914 Justo. Ave'),('Beck Hill','2829-9984','P.O. Box 694, 7876 Sociis St.'),('Wade Fernandez','2484-0505','Ap #435-102 Aliquet Road'),('Minerva Baxter','7885-7152','720-3601 Quis Street');
INSERT INTO CLIENTE([nombre],[telefono],[direccion]) VALUES('Bevis Wallace','2313-5349','P.O. Box 955, 9577 Augue Rd.'),('Cooper Mckee','2249-1859','P.O. Box 167, 1948 Lobortis, Rd.'),('Teagan Faulkner','2383-5433','1839 Accumsan Avenue'),('David Vance','7360-6038','Ap #417-4911 Eget Av.'),('Valentine Branch','7112-1343','668-9231 Tellus Ave'),('Imani Vincent','2987-3292','1172 Nunc Avenue'),('Yetta Gilbert','7582-3753','877-3174 Dui. Street'),('Sarah Petersen','2194-8718','P.O. Box 736, 5944 Semper Road'),('Brenna Franklin','2476-8248','Ap #521-6406 Etiam Ave'),('Blake Cole','7616-9803','553-9169 Nullam Road');

CREATE TABLE FORMAPAGO(
	idFormaPago INT PRIMARY KEY IDENTITY,
	formaPago VARCHAR(25)
);
INSERT INTO FORMAPAGO (formaPago) VALUES('contado'),('credito');

CREATE TABLE DEPARTAMENTO(
	idDepartamento INT PRIMARY KEY IDENTITY,
	departamento VARCHAR(25)
);
INSERT INTO departamento (departamento) VALUES('ventas'),('recursos humanos'),('administracion');

CREATE TABLE EMPLEADO(
	idEmpleado INT PRIMARY KEY IDENTITY,
	nombre VARCHAR(50),
	telefono CHAR(9),
	direccion VARCHAR(50),
	fechaIngreso DATE,
	idDepartamento INT
);
ALTER TABLE EMPLEADO ADD FOREIGN KEY(idDepartamento) REFERENCES DEPARTAMENTO(idDepartamento);
INSERT INTO EMPLEADO([nombre],[telefono],[direccion],[fechaIngreso],[idDepartamento]) VALUES('Scarlet Porter','7088-9016','P.O. Box 919, 2286 At Street','22/09/2016',1),('Lance Gilmore','7362-4852','7116 Arcu. Road','03/07/2015',1),('Azalia Rutledge','7192-3920','P.O. Box 747, 5956 Gravida. Street','22/10/2016',1),('Tatyana Lyons','7523-3479','6916 Nam Street','02/11/2016',1),('Drew Pace','7110-5519','Ap #533-4494 Dictum. Rd.','01/07/2016',1),('Andrew Maddox','7514-6027','5435 Aliquam St.','29/11/2015',1),('Lamar Kelley','7825-2756','1508 Ligula. Street','15/11/2015',1),('Naida Guthrie','7179-9813','832-9665 Magnis St.','25/05/2017',1),('Piper Byrd','7764-0189','P.O. Box 514, 7006 Velit Rd.','01/04/2016',1),('Flynn Sullivan','7666-3117','P.O. Box 981, 9455 Mus. Ave','24/02/2017',1);

CREATE TABLE ORDEN(
	idOrden INT PRIMARY KEY IDENTITY,
	idEmpleado INT,
	idFormaPago INT,
	idCliente INT,
	fecha DATE
);
ALTER TABLE ORDEN ADD FOREIGN KEY(idEmpleado) REFERENCES EMPLEADO(idEmpleado);
ALTER TABLE ORDEN ADD FOREIGN KEY(idFormaPago) REFERENCES FORMAPAGO(idFormaPago);
ALTER TABLE ORDEN ADD FOREIGN KEY(idCliente) REFERENCES CLIENTE(idCliente);
INSERT INTO ORDEN([idEmpleado],[idFormaPago],[idCliente],[fecha]) VALUES(2,1,5,'04/02/2015'),(8,2,5,'09/06/2015'),(1,1,5,'24/03/2015'),(1,2,13,'25/01/2015'),(8,1,29,'24/03/2016'),(8,1,10,'27/02/2016'),(7,1,12,'16/06/2015'),(9,1,26,'25/02/2016'),(3,1,28,'08/02/2016'),(9,2,26,'14/06/2015');
INSERT INTO ORDEN([idEmpleado],[idFormaPago],[idCliente],[fecha]) VALUES(3,1,23,'07/11/2015'),(6,2,15,'01/12/2015'),(8,1,20,'29/05/2015'),(2,1,29,'16/03/2015'),(10,1,7,'03/07/2015'),(4,1,18,'12/12/2015'),(4,1,28,'21/01/2015'),(1,1,23,'28/03/2016'),(3,2,18,'16/05/2015'),(1,2,3,'07/05/2015');
INSERT INTO ORDEN([idEmpleado],[idFormaPago],[idCliente],[fecha]) VALUES(7,1,10,'10/11/2015'),(7,1,28,'14/09/2015'),(2,2,21,'18/09/2015'),(9,1,29,'03/07/2015'),(9,1,22,'09/12/2015'),(5,1,15,'11/07/2015'),(8,2,16,'07/12/2015'),(10,1,20,'30/07/2015'),(2,2,17,'21/02/2016'),(1,1,1,'23/08/2015');
INSERT INTO ORDEN([idEmpleado],[idFormaPago],[idCliente],[fecha]) VALUES(1,2,9,'05/08/2015'),(8,1,29,'05/04/2016'),(10,2,11,'11/01/2015'),(5,1,6,'29/05/2016'),(10,1,8,'13/03/2015'),(3,2,4,'12/05/2015'),(6,1,11,'21/05/2016'),(4,2,6,'31/08/2015'),(9,2,19,'03/05/2016'),(1,2,4,'26/09/2015');
INSERT INTO ORDEN([idEmpleado],[idFormaPago],[idCliente],[fecha]) VALUES(6,1,16,'14/10/2015'),(9,1,14,'28/05/2015'),(3,1,17,'16/02/2016'),(7,1,20,'17/02/2015'),(5,2,19,'04/08/2015'),(8,1,28,'15/05/2015'),(3,1,16,'21/03/2016'),(4,1,25,'10/05/2015'),(3,1,12,'02/04/2016'),(3,2,21,'05/03/2015');

CREATE TABLE ORDENDETALLE(
	idOrden INT NOT NULL,
	codLibro INT NOT NULL,
	cantidad FLOAT
);
ALTER TABLE ORDENDETALLE ADD PRIMARY KEY(idOrden, codLibro);
ALTER TABLE ORDENDETALLE ADD FOREIGN KEY(idOrden) REFERENCES ORDEN(idOrden);
ALTER TABLE ORDENDETALLE ADD FOREIGN KEY(codLibro) REFERENCES LIBRO(codLibro);
INSERT INTO ORDENDETALLE([idOrden],[codLibro],[cantidad]) VALUES(43,26,4),(28,18,4),(40,30,3),(3,25,5),(39,19,1),(47,17,2),(45,13,3),(41,12,1),(31,30,3),(20,15,1);
INSERT INTO ORDENDETALLE([idOrden],[codLibro],[cantidad]) VALUES(11,17,4),(40,2,2),(46,30,3),(48,4,2),(26,11,3),(3,4,4),(27,18,2),(23,11,5),(40,27,1),(23,6,2);
INSERT INTO ORDENDETALLE([idOrden],[codLibro],[cantidad]) VALUES(1,30,4),(16,12,2),(7,2,5),(42,18,3),(37,1,4),(10,20,3),(45,4,3),(7,8,5),(4,27,3),(38,30,3);
INSERT INTO ORDENDETALLE([idOrden],[codLibro],[cantidad]) VALUES(3,22,2),(31,28,4),(6,9,3),(8,14,4),(36,3,4),(16,11,3),(1,6,1),(46,24,5),(22,23,2),(28,8,1);
INSERT INTO ORDENDETALLE([idOrden],[codLibro],[cantidad]) VALUES(2,14,1),(50,24,2),(44,13,5),(10,17,5),(7,17,4),(33,27,1),(26,21,5),(33,5,5),(22,30,3),(3,21,4);
INSERT INTO ORDENDETALLE([idOrden],[codLibro],[cantidad]) VALUES(15,9,2),(3,28,3),(10,18,4),(33,6,3),(31,7,2),(9,24,3),(44,2,5),(47,13,1),(12,13,5),(34,9,2);
INSERT INTO ORDENDETALLE([idOrden],[codLibro],[cantidad]) VALUES(41,1,3),(27,15,2),(1,1,2),(11,22,5),(10,26,1),(4,1,5),(16,14,3),(9,6,4),(3,23,2),(40,21,2);
INSERT INTO ORDENDETALLE([idOrden],[codLibro],[cantidad]) VALUES(45,14,5),(23,14,4),(6,2,5),(34,24,5),(10,7,5),(16,23,4),(14,30,4),(28,26,1),(35,11,5),(3,29,2);
INSERT INTO ORDENDETALLE([idOrden],[codLibro],[cantidad]) VALUES(20,12,4),(33,8,3),(6,5,3),(32,21,4),(17,21,1),(24,21,4),(49,3,5),(45,6,3),(21,28,3),(34,19,1);
