--****************************************************
-- Bases de datos: Introducción a SQL Server
-- Autor: Erick Varela
-- Git: https//:www.github.com/vareladev/
-- Version: 1.0
-- Fecha: Abril 2019
--****************************************************

-- PAIS:              CLIENTE:
-- +--------+         +----------------+
-- |PK id   |-1-----N-|PK id           |
-- |   pais |         |   nombre       |
-- +--------+         |FK id_pais      |
--                    |   correo       |
--                    |   tipo_cliente |
--                    +----------------+

--Descubriendo la utilidad de cada JOIN
--Antes se deben agregar un par de clientes sin tener definido un paìs de procedencia: 
INSERT INTO cliente VALUES(26,'Finley Armstrong',NULL,'farm@maiw.yom',3);
INSERT INTO cliente VALUES(27,'Naomi Lee',NULL,'kkkk@mail.net',4);

--INNER JOIN
SELECT p.id, p.pais, c.id, c.nombre, c.id_pais, c.correo
FROM pais p
	INNER JOIN cliente c
ON p.id = c.id_pais;

--LEFT JOIN
SELECT p.id, p.pais, c.id, c.nombre, c.id_pais, c.correo
FROM pais p
	LEFT JOIN cliente c
ON p.id = c.id_pais;

--RIGHT JOIN
SELECT p.id, p.pais, c.id, c.nombre, c.id_pais, c.correo
FROM pais p
	RIGHT JOIN cliente c
ON p.id = c.id_pais;

--FULL JOIN
SELECT p.id, p.pais, c.id, c.nombre, c.id_pais, c.correo
FROM pais p
	FULL JOIN cliente c
ON p.id = c.id_pais;

--FULL JOIN
SELECT p.id, p.pais, c.id, c.nombre, c.id_pais, c.correo
FROM pais p
	FULL JOIN cliente c
ON p.id = c.id_pais
WHERE p.id IS NULL OR c.id IS NULL;


--Utilizando JOINS para realizar consultas
--Mostrar el id y nombre de cada hotel y el nombre de la categoría a la que pertenece:
SELECT h.id, h.nombre, h.id_categoria, c.categoria
FROM hotel h
	INNER JOIN categoria c
ON h.id_categoria = c.id;

--Mostrar toda la información de cada cliente excepto el correo electrónico, mostrando el nombre del pais al cual pertenece y el tipo de cliente que es:
SELECT c.id, c.nombre, p.pais, tp.tipo
FROM cliente c
	INNER JOIN pais p
ON c.id_pais = p.id
	INNER JOIN tipo_cliente tp
ON c.tipo_cliente = tp.id;

--Consulta convencional
/*
SELECT c.id, c.nombre, p.pais, tp.tipo
FROM cliente c, pais p, tipo_cliente tp
WHERE c.id_pais = p.id
	AND c.tipo_cliente = tp.id;
*/
	
--Mostrar toda la información de cada cliente excepto el correo electrónico, que sean tipo "Viajero", se debe mostrar el nombre del pais al cual pertenece y el tipo de cliente que es:
SELECT c.id, c.nombre, p.pais, tp.tipo
FROM cliente c
	INNER JOIN pais p
ON c.id_pais = p.id
	INNER JOIN tipo_cliente tp
ON c.tipo_cliente = tp.id
WHERE tp.tipo = 'Viajero';

--Consulta convencional
/*
SELECT c.id, c.nombre, p.pais, tp.tipo
FROM cliente c, pais p, tipo_cliente tp
WHERE c.id_pais = p.id
	AND c.tipo_cliente = tp.id
	AND tp.tipo = 'Viajero';
*/

--Mostrar toda la información de cada cliente, que provengan de centroamérica. Se debe mostrar el nombre del pais al cual pertenece y el tipo de cliente que es:
SELECT c.id, c.nombre, p.pais, tp.tipo
FROM cliente c
	INNER JOIN pais p
ON c.id_pais = p.id
	INNER JOIN tipo_cliente tp
ON c.tipo_cliente = tp.id
WHERE p.pais = 'El Salvador'
		OR p.pais = 'Honduras'
		OR p.pais = 'Guatemala'
		OR p.pais = 'Costa Rica'
		OR p.pais = 'Panama';

--Consulta convencional
/*
SELECT c.id, c.nombre, p.pais, tp.tipo
FROM cliente c, pais p, tipo_cliente tp
WHERE c.id_pais = p.id
	AND c.tipo_cliente = tp.id
	AND (p.pais = 'El Salvador'
			OR p.pais = 'Honduras'
			OR p.pais = 'Guatemala'
			OR p.pais = 'Costa Rica'
			OR p.pais = 'Panama');
*/		

--Mostrar toda la información de cada cliente, que provengan de centroamérica. Se debe mostrar el nombre del pais al cual pertenece y el tipo de cliente que es:
--Incluir en la lista incluso los paises de los que no se tienen registros aùn
SELECT c.id, c.nombre, p.pais, tp.tipo
FROM cliente c
	RIGHT JOIN pais p
ON c.id_pais = p.id
	LEFT JOIN tipo_cliente tp
ON c.tipo_cliente = tp.id
WHERE p.pais = 'El Salvador'
		OR p.pais = 'Honduras'
		OR p.pais = 'Guatemala'
		OR p.pais = 'Costa Rica'
		OR p.pais = 'Panama';

--Mostrar todas las reservas que inician en el mes abril de 2010 junto al nombre del cliente 
SELECT r.id, r.checkin, r.checkout, c.nombre, r.id_habitacion
FROM reserva r
	INNER JOIN cliente c
ON r.id_cliente = c.id
WHERE CAST(r.checkin AS DATE) >= '01-04-2010'
	AND CAST(r.checkin AS DATE) <= '30-04-2010';	

--Mostrar todas las reservas que inician en el mes abril de 2010 junto al nombre del cliente y que habitaciòn reservò
SELECT r.id, r.checkin, r.checkout, c.nombre, r.id_habitacion as 'id en reserva', hab.id as 'id en habitacion', hab.numero
FROM reserva r
	INNER JOIN cliente c
ON r.id_cliente = c.id
	INNER JOIN habitacion hab
ON r.id_habitacion = hab.id
WHERE CAST(r.checkin AS DATE) >= '01-04-2010'
	AND CAST(r.checkin AS DATE) <= '30-04-2010';	

--Mostrar todas las reservas que inician en el mes abril de 2010 junto al nombre del cliente y que habitaciòn reservò, mostrar ademàs el nombre del hotel donde reservò
SELECT r.id, r.checkin, r.checkout, c.nombre, r.id_habitacion as 'id en reserva', hab.id as 'id en habitacion', hab.numero, h.nombre
FROM reserva r
	INNER JOIN cliente c
ON r.id_cliente = c.id	
	INNER JOIN habitacion hab
ON r.id_habitacion = hab.id
	INNER JOIN hotel h
ON hab.id_hotel = h.id
WHERE CAST(r.checkin AS DATE) >= '01-04-2010'
	AND CAST(r.checkin AS DATE) <= '30-04-2010';	
