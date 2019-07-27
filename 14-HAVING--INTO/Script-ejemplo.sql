--****************************************************
-- Bases de datos: Uso de HAVING e INTO
-- Autor: Erick Varela
-- Git: https//:www.github.com/vareladev/
-- Version: 1.0
-- Fecha: Mayo 2019
--****************************************************

--*****************************************************
--HAVING 
--*****************************************************

--Mostrar las habitaciones que hayan sido reservadas mas de 20 dias 
--Mostrando el detalle de cada reserva: id de reserva, numero de habitacion, fecha de checkin y checkout
SELECT r.id id_reserva, h.numero, r.checkin, r.checkout
FROM reserva r, habitacion h
WHERE r.id_habitacion = h.id;

--Obteniendo cantidad de dias de cada reserva
SELECT r.id id_reserva, h.numero, r.checkin, r.checkout, DATEDIFF(DAY, r.checkin,r.checkout) dias_de_uso
FROM reserva r, habitacion h
WHERE r.id_habitacion = h.id;

--Mostrando solo columnas de interes y ordenando en base al nùmero de habitaciòn
SELECT h.numero, DATEDIFF(DAY, r.checkin,r.checkout) dias_de_uso
FROM reserva r, habitacion h
WHERE r.id_habitacion = h.id
ORDER BY h.numero ASC;

--Sumando dias de uso
SELECT h.numero, SUM(DATEDIFF(DAY, r.checkin,r.checkout)) dias_de_uso
FROM reserva r, habitacion h
WHERE r.id_habitacion = h.id
GROUP BY h.numero
ORDER BY h.numero ASC;

--Filtrando (FALLA!)
SELECT h.numero, SUM(DATEDIFF(DAY, r.checkin,r.checkout)) dias_de_uso
FROM reserva r, habitacion h
WHERE r.id_habitacion = h.id
	AND SUM(DATEDIFF(DAY, r.checkin,r.checkout)) > 20
GROUP BY h.numero
ORDER BY h.numero ASC;

--Filtrando
SELECT h.numero, SUM(DATEDIFF(DAY, r.checkin,r.checkout)) dias_de_uso
FROM reserva r, habitacion h
WHERE r.id_habitacion = h.id
GROUP BY h.numero
HAVING SUM(DATEDIFF(DAY, r.checkin,r.checkout)) > 20
ORDER BY h.numero ASC;

/*Mostrar la lista de clientes 'VIP'
Un cliente VIP se define si el promedio de precio de las habitaciones
reservadas es superior a $300*/

--Mostrando el detalle de cada reserva: el nombre del cliente, el id de reserva, la habitacion y costo de esta:
SELECT c.nombre nombre_cliente, r.id, h.numero, h.precio precio_habitacion
FROM cliente c, reserva r, habitacion h
WHERE c.id = r.id_cliente 
	AND r.id_habitacion =  h.id
ORDER BY c.nombre ASC;

--Mostrando solo datos de interes
SELECT c.nombre nombre_cliente, h.precio precio_habitacion
FROM cliente c, reserva r, habitacion h
WHERE c.id = r.id_cliente 
	AND r.id_habitacion =  h.id
ORDER BY c.nombre ASC;

--calculando promedio de precio
SELECT c.nombre nombre_cliente, AVG(h.precio) precio_habitacion_promedio
FROM cliente c, reserva r, habitacion h
WHERE c.id = r.id_cliente 
	AND r.id_habitacion =  h.id
GROUP BY c.nombre
ORDER BY c.nombre ASC;

--Mostrando lista de clientes con el promedio de precio > $300
--este falla!
SELECT c.nombre nombre_cliente, AVG(h.precio) precio_habitacion_promedio
FROM cliente c, reserva r, habitacion h
WHERE c.id = r.id_cliente 
	AND r.id_habitacion =  h.id
	AND AVG(h.precio) > 300
GROUP BY c.nombre
ORDER BY c.nombre ASC;

--Mostrando lista de clientes con el promedio de precio > $300
SELECT c.nombre nombre_cliente, AVG(h.precio) precio_habitacion_promedio
FROM cliente c, reserva r, habitacion h
WHERE c.id = r.id_cliente 
	AND r.id_habitacion =  h.id
GROUP BY c.nombre
HAVING AVG(h.precio) > 300
ORDER BY c.nombre ASC;


--Mostrar la categoria de habitacion generò màs de $100 en el primer trimestre de 2010
--para el hotel Semper:
--Mostrando el detalle de cada reserva: fecha, categoria de habitacion, id de reserva, id de habitacion y precio de habitacion
SELECT r.checkin fecha, th.nombre tipo_habitacion, r.id reserva_id, ho.nombre hotel_nombre, h.id, h.precio precio_habitacion
FROM reserva r, habitacion h, tipo_habitacion th, hotel ho
WHERE r.id_habitacion = h.id
	AND h.id_tipo = th.id
	AND h.id_hotel = ho.id
	AND r.checkin BETWEEN CAST('01-01-2010' AS DATETIME) 
		AND CAST('31-03-2010' AS DATETIME) 
	AND ho.nombre = 'Semper'
ORDER BY th.nombre ASC;

--Mostrando solo las columnas de interes
SELECT th.nombre tipo_habitacion, h.precio precio_habitacion
FROM reserva r, habitacion h, tipo_habitacion th, hotel ho
WHERE r.id_habitacion = h.id
	AND h.id_tipo = th.id
	AND h.id_hotel = ho.id
	AND r.checkin BETWEEN CAST('01-01-2010' AS DATETIME) 
		AND CAST('31-03-2010' AS DATETIME) 
	AND ho.nombre = 'Semper'
ORDER BY th.nombre ASC;

--Sumando ganancia con la operaciòn de agregaciòn SUM
SELECT th.nombre tipo_habitacion, SUM(h.precio) ganancia
FROM reserva r, habitacion h, tipo_habitacion th, hotel ho
WHERE r.id_habitacion = h.id
	AND h.id_tipo = th.id
	AND h.id_hotel = ho.id
	AND r.checkin BETWEEN CAST('01-01-2010' AS DATETIME) 
		AND CAST('31-03-2010' AS DATETIME) 
	AND ho.nombre = 'Semper'
GROUP BY th.nombre
ORDER BY th.nombre ASC;

--Filtrando
SELECT th.nombre tipo_habitacion, SUM(h.precio) ganancia
FROM reserva r, habitacion h, tipo_habitacion th, hotel ho
WHERE r.id_habitacion = h.id
	AND h.id_tipo = th.id
	AND h.id_hotel = ho.id
	AND r.checkin BETWEEN CAST('01-01-2010' AS DATETIME) 
		AND CAST('31-03-2010' AS DATETIME) 
	AND ho.nombre = 'Semper'
GROUP BY th.nombre
HAVING SUM(h.precio) > 100
ORDER BY th.nombre ASC;



--*****************************************************
--INTO
--*****************************************************
SELECT r.id id_reserva, h.precio precio_habitacion, s.precio precio_servicio
FROM reserva r
	LEFT JOIN extras x
		ON r.id = x.id_reserva
	LEFT JOIN servicio s
		ON s.id = x.id_servicio
	LEFT JOIN habitacion h
		ON h.id = r.id_habitacion
ORDER BY r.id;

SELECT r.id id_reserva, h.precio precio_habitacion, SUM(s.precio) total_servicio
INTO ganancia_abril_2010
FROM reserva r
	LEFT JOIN extras x
		ON r.id = x.id_reserva
	LEFT JOIN servicio s
		ON s.id = x.id_servicio
	LEFT JOIN habitacion h
		ON h.id = r.id_habitacion
WHERE r.checkin BETWEEN CAST('1-4-2010' AS DATETIME)
					AND CAST('30-4-2010' AS DATETIME)
GROUP BY r.id, h.precio
ORDER BY r.id ASC;


SELECT * FROM ganancia_abril_2010;

UPDATE ganancia_abril_2010 SET total_servicio = 0
WHERE total_servicio IS NULL;

SELECT * FROM ganancia_abril_2010;

ALTER TABLE ganancia_abril_2010 ADD total_reserva MONEY;

SELECT * FROM ganancia_abril_2010;

UPDATE ganancia_abril_2010 SET total_reserva = precio_habitacion + total_servicio;

SELECT * FROM ganancia_abril_2010;