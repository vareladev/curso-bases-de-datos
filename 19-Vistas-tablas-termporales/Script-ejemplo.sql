--****************************************************
-- Bases de datos: Vistas
-- Autor: Erick Varela
-- Git: https//:www.github.com/vareladev/
-- Versiòn: 1.0
-- Fecha: Junio 2019
--****************************************************

--Vistas.
--**************************************************************************
--Crear una vista que muestre el detalle de cada reserva:
--	- id de reserva
--  - quien hizo la reserva
--  - fecha de checkin y checkout
--  - total incluyendo precio de habitaciòn y servicios.
CREATE VIEW view_booking_detail AS
SELECT id_reserva AS id, nombre AS nombre_cliente, checkin AS fecha_ini, checkout AS fecha_fin,  SUM(total_reserva) AS total_reserva
FROM (
	SELECT r.id id_reserva, c.nombre, r.checkin, r.checkout,  
				h.precio + ISNULL(SUM(s.precio), 0) AS total_reserva
	FROM reserva r LEFT JOIN extras x
			ON r.id = x.id_reserva
		LEFT JOIN servicio s
		ON x.id_servicio = s.id
		LEFT JOIN habitacion h
		ON r.id_habitacion = h.id
		LEFT JOIN cliente c
		ON c.id = r.id_cliente
	GROUP BY r.id, c.nombre,r.checkin, r.checkout, h.precio
) reserva_detalle
GROUP BY id_reserva, nombre, checkin, checkout;

--Mostrando contenido de vista:
SELECT * FROM view_booking_detail;

--Insertando, actualizando y eliminando datos en vista:
INSERT INTO view_booking_detail VALUES(101,'Susan',CAST('11-1-2010 15:00:00.000' AS DATETIME),CAST('13-1-2010 13:00:00.000' AS DATETIME),500);
UPDATE view_booking_detail SET nombre_cliente = 'Amena Aopr' WHERE id_reserva=1;
DELETE FROM view_booking_detail WHERE id_reserva= 1;

--Insertando nueva reserva
INSERT INTO reserva VALUES(101,CAST('14-3-2010 15:00:00.000' AS DATETIME),CAST('18-3-2010 13:00:00.000' AS DATETIME),15,10);

--Mostrando contenido de vista:
SELECT * FROM view_booking_detail;
SELECT * FROM habitacion WHERE id = 10;



--Tablas temporales.
--**************************************************************************
--Crear una tabla temporal que muestre el detalle de cada reserva:
--	- id de reserva
--  - quien hizo la reserva
--  - fecha de checkin y checkout
--  - total incluyendo precio de habitaciòn y servicios.
SELECT id_reserva AS id, nombre AS nombre_cliente, checkin AS fecha_ini, checkout AS fecha_fin,  SUM(total_reserva) AS total_reserva
INTO #t_booking_detail
FROM (
	SELECT r.id id_reserva, c.nombre, r.checkin, r.checkout,  
				h.precio + ISNULL(SUM(s.precio), 0) AS total_reserva
	FROM reserva r LEFT JOIN extras x
			ON r.id = x.id_reserva
		LEFT JOIN servicio s
		ON x.id_servicio = s.id
		LEFT JOIN habitacion h
		ON r.id_habitacion = h.id
		LEFT JOIN cliente c
		ON c.id = r.id_cliente
	GROUP BY r.id, c.nombre,r.checkin, r.checkout, h.precio
) reserva_detalle
GROUP BY id_reserva, nombre, checkin, checkout;

--Mostrando contenido de tabla temporal:
SELECT * FROM #t_booking_detail;

--Insertando, actualizando y eliminando datos en tabla temporal:
INSERT INTO #t_booking_detail VALUES(102,'Susan',CAST('11-1-2010 15:00:00.000' AS DATETIME),CAST('13-1-2010 13:00:00.000' AS DATETIME),1000);
UPDATE #t_booking_detail SET nombre_cliente = 'Susan Aopr' WHERE id=102;
SELECT * FROM #t_booking_detail;
DELETE FROM #t_booking_detail WHERE id=102;

--Insertando nueva reserva
INSERT INTO reserva VALUES(102,CAST('14-3-2010 15:00:00.000' AS DATETIME),CAST('18-3-2010 13:00:00.000' AS DATETIME),10,11);

--Mostrando contenido de vista:
SELECT * FROM #t_booking_detail;

