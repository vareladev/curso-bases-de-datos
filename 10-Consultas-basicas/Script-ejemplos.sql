--****************************************************
-- Bases de datos: Consulta de datos básica
-- Autor: Erick Varela
-- Git: https//:www.github.com/vareladev/
-- Version: 1.0
-- Fecha: marzo 2019
--****************************************************

--Mostrar todos los hoteles disponibles en la base de datos:
SELECT id, nombre, direccion, telefono, id_categoria
FROM hotel;

--es válido también:
SELECT * FROM hotel;

--Mostrar cada el id y nombre de cada hotel y a que categoría pertenece:
SELECT id, nombre, id_categoria
FROM hotel;

--Mostrar cada el id y nombre de cada hotel y el nombre de la categoría a la que pertenece:
SELECT hotel.id, hotel.nombre, hotel.id_categoria, categoria.categoria
FROM hotel, categoria
WHERE hotel.id_categoria = categoria.id;

--Uso de alias
SELECT htl.id, htl.nombre, htl.id_categoria, cat.categoria
FROM hotel htl, categoria cat
WHERE htl.id_categoria = cat.id;


--Mostrar toda la información de cada cliente excepto el correo electrónico:
SELECT id, nombre, id_pais, tipo_cliente
FROM cliente;

--Mostrar toda la información de cada cliente excepto el correo electrónico, mostrando el nombre del pais al cual pertenece y el tipo de cliente que es:
SELECT c.id, c.nombre, p.pais, tp.tipo
FROM cliente c, pais p, tipo_cliente tp
WHERE c.id_pais = p.id
	AND c.tipo_cliente = tp.id;
	
--Mostrar toda la información de cada cliente excepto el correo electrónico, que sean tipo "Viajero", se debe mostrar el nombre del pais al cual pertenece y el tipo de cliente que es:
SELECT c.id, c.nombre, p.pais, tp.tipo
FROM cliente c, pais p, tipo_cliente tp
WHERE c.id_pais = p.id
	AND c.tipo_cliente = tp.id
	AND tp.tipo = 'Viajero';
	
--Mostrar toda la información de cada cliente, que provengan de centroamérica. Se debe mostrar el nombre del pais al cual pertenece y el tipo de cliente que es:
SELECT c.id, c.nombre, p.pais, tp.tipo
FROM cliente c, pais p, tipo_cliente tp
WHERE c.id_pais = p.id
	AND c.tipo_cliente = tp.id
	AND (p.pais = 'El Salvador'
			OR p.pais = 'Honduras'
			OR p.pais = 'Guatemala'
			OR p.pais = 'Costa Rica'
			OR p.pais = 'Panama');
			
	
--Mostrar todas las reservas que inician en el mes abril de 2010.
--opcion 1:
SELECT id, checkin, checkout, id_cliente, id_habitacion
FROM reserva
WHERE CAST(checkin AS DATE) >= '01-04-2010'
	AND CAST(checkin AS DATE) <= '30-04-2010';

--opcion 2:
SELECT id, checkin, checkout, id_cliente, id_habitacion
FROM reserva
WHERE CAST(checkin AS DATE) 
		BETWEEN '01-04-2010' AND '30-04-2010';
	
--opcion 3:
SELECT id, checkin, checkout, id_cliente, id_habitacion
FROM reserva
WHERE MONTH(CAST(checkin AS DATE)) = 4;


--Mostrar todas las reservas que inician en el mes abril de 2010 junto al nombre del cliente 
SELECT r.id, r.checkin, r.checkout, c.nombre, r.id_habitacion
FROM reserva r, cliente c
WHERE CAST(r.checkin AS DATE) >= '01-04-2010'
	AND CAST(r.checkin AS DATE) <= '30-04-2010'
	AND r.id_cliente = c.id;	

--Mostrar todas las reservas que inician en el mes abril de 2010 junto al nombre del cliente y que habitaciòn reservò
SELECT r.id, r.checkin, r.checkout, c.nombre, r.id_habitacion as 'id en reserva', hab.id as 'id en habitacion', hab.numero
FROM reserva r, cliente c, habitacion hab
WHERE CAST(r.checkin AS DATE) >= '01-04-2010'
	AND CAST(r.checkin AS DATE) <= '30-04-2010'
	AND r.id_cliente = c.id
	AND r.id_habitacion = hab.id;	

--Mostrar todas las reservas que inician en el mes abril de 2010 junto al nombre del cliente y que habitaciòn reservò, mostrar ademàs el nombre del hotel donde reservò
SELECT r.id, r.checkin, r.checkout, c.nombre, r.id_habitacion as 'id en reserva', hab.id as 'id en habitacion', hab.numero, h.nombre
FROM reserva r, cliente c, habitacion hab, hotel h
WHERE CAST(r.checkin AS DATE) >= '01-04-2010'
	AND CAST(r.checkin AS DATE) <= '30-04-2010'
	AND r.id_cliente = c.id
	AND r.id_habitacion = hab.id
	AND hab.id_hotel = h.id;	
