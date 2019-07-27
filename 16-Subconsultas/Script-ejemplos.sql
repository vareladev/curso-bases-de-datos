--****************************************************
-- Bases de datos: Subconsultas
-- Autor: Erick Varela
-- Git: https//:www.github.com/vareladev/
-- Version: 1.0
-- Fecha: Mayo 2019
--****************************************************

--Ejercicio 1
--*****************************************************
--¿Cual es el porcentaje de clientes que vienen de cada pais?
--Paso 1: Contando cantidad de clientes que vienen de cada pais
SELECT p.id, p.pais, COUNT(c.nombre) as 'cantidad de clientes'
FROM pais p LEFT JOIN cliente c
ON p.id = c.id_pais
GROUP BY  p.id, p.pais;

--Paso 2: Contanto cuantos clientes se quieren tomar en cuenta:
SELECT COUNT(*) FROM cliente;

--Paso 3: Mostrando la lista de paises y el promedio a partir de la divisiòn
--de la cantidad de clientes de cada pais entre la cantidad total de clientes
--NOTA: Este resultado no muestra lo esperado
SELECT p.id, p.pais, COUNT(c.nombre)  / (SELECT COUNT(*) FROM cliente)
FROM pais p LEFT JOIN cliente c
ON p.id = c.id_pais
GROUP BY  p.id, p.pais;

--Paso 3.1: Mostrando la lista de paises y el promedio a partir de la divisiòn
--de la cantidad de clientes de cada pais entre la cantidad total de clientes
--NOTA: Al dividir entero entre entero el resultado es entero, por lo que debe
--realizar un CAST a cualquiera de los dos operandos:
SELECT p.id, p.pais, CAST(COUNT(c.nombre) AS FLOAT) / (SELECT COUNT(*) FROM cliente)
FROM pais p LEFT JOIN cliente c
ON p.id = c.id_pais
GROUP BY  p.id, p.pais;

--Paso 4: Aproximando resultado para tener una mejor vista de los datos:
SELECT p.id, p.pais, ROUND (CAST(COUNT(c.nombre) AS FLOAT) / (SELECT COUNT(*) FROM cliente),2)
FROM pais p LEFT JOIN cliente c
ON p.id = c.id_pais
GROUP BY  p.id, p.pais;

--Paso 5: Dar formato al resultado:
SELECT p.id, p.pais, CONCAT( ROUND (CAST(COUNT(c.nombre) AS FLOAT) / (SELECT COUNT(*) FROM cliente),2) , '%') porcentaje_clientes
FROM pais p LEFT JOIN cliente c
ON p.id = c.id_pais
GROUP BY  p.id, p.pais;


--Ejercicio 2A
--*****************************************************
--Mostrar la lista de clientes, junto con los subtotales de habitaciòn (A)
--y servicios (B). Ademàs incluir el total de la reserva (A+B).
--El objetivo es mostrar la reserva màs cara de cada cliente.

--Este falla.
--Razòn: No es posible utilizar una funciòn de agregaciòn (MAX) sobre otra funciòn de agregaciòn (SUM).
SELECT r.id id_reserva, c.nombre nombre_cliente, h.precio subtotal_habitacion, ISNULL(SUM(s.precio), 0)  subtotal_servicio,
			MAX(h.precio + ISNULL(SUM(s.precio), 0)) AS total_reserva
FROM reserva r LEFT JOIN extras x
		ON r.id = x.id_reserva
	LEFT JOIN servicio s
	ON x.id_servicio = s.id
	LEFT JOIN habitacion h
	ON r.id_habitacion = h.id
	LEFT JOIN cliente c
	ON c.id = r.id_cliente
GROUP BY c.nombre, r.id, h.precio
ORDER BY nombre_cliente ASC;

--Este falla.
--Razòn: La cláusula ORDER BY no es válida en vistas, funciones insertadas, tablas derivadas, subconsultas
SELECT *
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
	ORDER BY nombre_cliente ASC
) reserva_detalle;

--SOLUCIÒN.
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


--Ejercicio 2B
--*****************************************************
--Mostrar la lista de clientes, junto con los subtotales de habitaciòn (A)
--y servicios (B). Ademàs incluir el total de la reserva (A+B).
--El objetivo es mostrar el promedio del valor de las reservas hechas por cada usuario.

--SOLUCIÒN.
SELECT id, nombre_cliente, AVG(total_reserva) AS promedio
FROM (
	SELECT r.id id_reserva, c.id, c.nombre nombre_cliente, h.precio subtotal_habitacion, ISNULL(SUM(s.precio), 0)  subtotal_servicio,
				h.precio + ISNULL(SUM(s.precio), 0) AS total_reserva
	FROM reserva r LEFT JOIN extras x
			ON r.id = x.id_reserva
		LEFT JOIN servicio s
		ON x.id_servicio = s.id
		LEFT JOIN habitacion h
		ON r.id_habitacion = h.id
		LEFT JOIN cliente c
		ON c.id = r.id_cliente
	GROUP BY  c.id, c.nombre, r.id, h.precio
) reserva_detalle
GROUP BY id, nombre_cliente
ORDER BY promedio DESC;


--Ejercicio 3
--*****************************************************
--Agregar una columna llamada VIP a la tabla cliente
--Configurar el valor de 1 a todos los usuarios cuyo promedio de 
--reservas sea mayor a $300
ALTER TABLE cliente ADD vip INT;
UPDATE cliente SET vip=0;
SELECT * FROM cliente;

UPDATE cliente SET vip=1
WHERE id IN (
	SELECT TOP 3 id
	FROM (
		SELECT r.id id_reserva, c.id, c.nombre nombre_cliente, h.precio subtotal_habitacion, ISNULL(SUM(s.precio), 0)  subtotal_servicio,
					h.precio + ISNULL(SUM(s.precio), 0) AS total_reserva
		FROM reserva r LEFT JOIN extras x
				ON r.id = x.id_reserva
			LEFT JOIN servicio s
			ON x.id_servicio = s.id
			LEFT JOIN habitacion h
			ON r.id_habitacion = h.id
			LEFT JOIN cliente c
			ON c.id = r.id_cliente
		GROUP BY  c.id, c.nombre, r.id, h.precio
	) reserva_detalle
	GROUP BY id, nombre_cliente
	ORDER BY AVG(total_reserva) DESC
);

--Ejercicio 3
--*****************************************************
--¿Cual es el servicio que màs ganancias genera?
SELECT TOP 1 s.id, s.nombre, SUM(s.precio) as subtotal
FROM servicio s, extras x
WHERE s.id = x.id_servicio
GROUP BY s.id, s.nombre
ORDER BY SUM(s.precio) DESC;
--¿Cual es el servicio que menos ganancias genera?
SELECT TOP 1 s.id, s.nombre, SUM(s.precio) as subtotal
FROM servicio s, extras x
WHERE s.id = x.id_servicio
GROUP BY s.id, s.nombre
ORDER BY SUM(s.precio) ASC;
--Mostrar el servicio que mas ganancia genera y el que menos ganancia genera
--en una sola consulta:
SELECT s.id, s.nombre, SUM(s.precio) as subtotal
FROM servicio s, extras x
WHERE s.id = x.id_servicio
	AND ( s.id IN (
					SELECT TOP 1 s.id
					FROM servicio s, extras x
					WHERE s.id = x.id_servicio
					GROUP BY s.id, s.nombre
					ORDER BY SUM(s.precio) ASC
				)
		OR 
		s.id IN (
					SELECT TOP 1 s.id
					FROM servicio s, extras x
					WHERE s.id = x.id_servicio
					GROUP BY s.id, s.nombre
					ORDER BY SUM(s.precio) DESC
				))
GROUP BY s.id, s.nombre;
