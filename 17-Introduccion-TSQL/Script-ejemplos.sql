--****************************************************
-- Bases de datos: Introducción a TSQL
-- Autor: Erick Varela
-- Git: https//:www.github.com/vareladev/
-- Version: 1.0
-- Fecha: Junio 2019
--****************************************************

--declarando variables T-SQL
DECLARE @variable varchar(15)
SET @variable = 'bases de datos'
-- Imprimiendo variables.
PRINT @variable
-- Concatenando cadenas de texto:
PRINT @variable + ' relacionales.'
--Concantenando numeros
DECLARE @numero2 INT
SET @numero2 = 25
PRINT 'el numero es '+CONVERT(VARCHAR(2),@numero2)

--Integrando T-SQL a consultas SQL.
--Mostrar la categoria de habitacion generò màs de $100 en el primer trimestre de 2010 para el hotel Semper:
-- Consulta original:
SELECT th.nombre tipo_habitacion, SUM(h.precio) ganancia
FROM reserva r, habitacion h, tipo_habitacion th, hotel ho
WHERE r.id_habitacion = h.id
	AND h.id_tipo = th.id
	AND h.id_hotel = ho.id
	AND r.checkin BETWEEN CAST('01-01-2010' AS DATE) AND CAST('31-03-2010' AS DATE) 
	AND ho.nombre = 'Semper'
GROUP BY th.nombre
HAVING SUM(h.precio) > 100
ORDER BY th.nombre ASC;


DECLARE @hotel VARCHAR(20), 
		@ganancia_objetivo INT, 
		@fecha_inicial DATE,  
		@fecha_final DATE
SET @hotel = 'Semper'
SET @ganancia_objetivo = 100
SET @fecha_inicial = CAST('01-01-2010' AS DATE)
SET @fecha_final = CAST('31-03-2010' AS DATE) 
SELECT th.nombre tipo_habitacion, SUM(h.precio) ganancia
FROM reserva r, habitacion h, tipo_habitacion th, hotel ho
WHERE r.id_habitacion = h.id
	AND h.id_tipo = th.id
	AND h.id_hotel = ho.id
	AND r.checkin BETWEEN @fecha_inicial AND @fecha_final
	AND ho.nombre = @hotel
GROUP BY th.nombre
HAVING SUM(h.precio) > @ganancia_objetivo
ORDER BY th.nombre ASC;


--¿cuantos clientes hay por cada pais?
-- Consulta original:
SELECT p.pais, COUNT(c.nombre) as 'cantidad de clientes'
FROM pais p LEFT JOIN cliente c
ON p.id = c.id_pais
GROUP BY  p.pais;


--Utilizando CASE para dar formato a la salida de una consulta.
SELECT p.id, p.pais,
		CASE COUNT(c.nombre)
			WHEN 0 THEN
				'Sin clientes registrados'
			WHEN 1 THEN
				'1 cliente'
			ELSE
				CONCAT(COUNT(c.nombre), ' clientes')
		END as 'Cantidad lientes'
FROM pais p LEFT JOIN cliente c
ON p.id = c.id_pais
GROUP BY p.id, p.pais;


--Mostrar la lista de clientes 'VIP' Un cliente VIP se define si el promedio de precio de las habitaciones reservadas es superior a $300
-- Consulta original:
SELECT c.nombre nombre_cliente, AVG(h.precio) precio_habitacion_promedio
FROM cliente c, reserva r, habitacion h
WHERE c.id = r.id_cliente 
	AND r.id_habitacion =  h.id
GROUP BY c.nombre
ORDER BY c.nombre ASC;

SELECT c.nombre nombre_cliente, AVG(h.precio) precio_habitacion_promedio,
		IIF(AVG(h.precio) > 300, 'VIP', 'Estandar') AS 'Tipo cliente'
FROM cliente c, reserva r, habitacion h
WHERE c.id = r.id_cliente 
	AND r.id_habitacion =  h.id
GROUP BY c.nombre
ORDER BY c.nombre ASC;

--Eliminando sub-consultas al utilizar T-SQL
--Mostrando la lista de paises y el promedio de clientes de cada pais
--NOTA: Este resultado no muestra lo esperado
SELECT p.id, p.pais, CONCAT( ROUND (CAST(COUNT(c.nombre) AS FLOAT) / (SELECT COUNT(*) FROM cliente),2) , '%') porcentaje_clientes
FROM pais p LEFT JOIN cliente c
ON p.id = c.id_pais
GROUP BY  p.id, p.pais;

DECLARE @cantidad_clientes FLOAT;
SELECT @cantidad_clientes = COUNT(*)  FROM cliente
SELECT p.id, p.pais, ROUND( COUNT(c.nombre) / @cantidad_clientes, 2) porcentaje_clientes
FROM pais p LEFT JOIN cliente c
ON p.id = c.id_pais
GROUP BY  p.id, p.pais;


--Mostrar la lista de clientes, junto con los subtotales de habitaciòn (A)
--y servicios (B). Ademàs incluir el total de la reserva (A+B).
--El objetivo es mostrar la reserva màs cara de cada cliente
--Consulta utilzando subqueries.
SELECT nombre_cliente, MAX(total_reserva) AS reserva_mas_cara
FROM (
	SELECT r.id id_reserva, c.nombre nombre_cliente, h.precio subtotal_habitacion, ISNULL(SUM(s.precio), 0)  subtotal_servicio,
				h.precio + ISNULL(SUM(s.precio), 0) AS total_reserva
	FROM reserva r LEFT JOIN extras x
			ON r.id = x.id_reserva
		LEFT JOIN servicio s
		ON x.id_servicio = s.id
		LEFT JOIN habitacion h
		ON r.id_habitacion = h.id
		LEFT JOIN cliente c
		ON c.id = r.id_cliente
	GROUP BY c.nombre, r.id, h.precio
) reserva_detalle
GROUP BY nombre_cliente;


--Consulta utilizando T-SQL.
DECLARE @cliente_reserva TABLE(
	nombre VARCHAR(20) NULL,
	total_reserva FLOAT NULL
);
INSERT INTO @cliente_reserva (nombre, total_reserva)
SELECT c.nombre nombre_cliente, h.precio + ISNULL(SUM(s.precio), 0) AS total_reserva
FROM reserva r LEFT JOIN extras x
		ON r.id = x.id_reserva
	LEFT JOIN servicio s
	ON x.id_servicio = s.id
	LEFT JOIN habitacion h
	ON r.id_habitacion = h.id
	LEFT JOIN cliente c
	ON c.id = r.id_cliente
GROUP BY c.nombre,  h.precio;
SELECT nombre, MAX(total_reserva) AS reserva_mas_cara FROM @cliente_reserva GROUP BY nombre ORDER BY nombre ASC;