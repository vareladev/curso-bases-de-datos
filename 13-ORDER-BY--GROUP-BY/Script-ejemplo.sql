--****************************************************
-- Bases de datos: Uso de ORDER BY y GROUP BY
-- Autor: Erick Varela
-- Git: https//:www.github.com/vareladev/
-- Version: 1.0
-- Fecha: Mayo 2019
--****************************************************

--*****************************************************
--ORDER BY
--*****************************************************
--Mostrar los datos de la tabla reserva ordenados a partir del id de cliente
SELECT r.id, r.checkin, r.checkout, r.id_cliente, r.id_habitacion
FROM reserva r
ORDER BY r.id_cliente DESC;


--Mostrar los datos de la tabla reserva ordenados a partir del nombre del cliente
--mostrar ademas la habitaciòn donde se hospeda y el hotel
SELECT r.id, r.checkin, r.checkout, c.nombre, ho.nombre, h.numero
FROM reserva r, cliente c, hotel ho, habitacion h
WHERE c.id = r.id_cliente 
	AND r.id_habitacion = h.id
	AND h.id_hotel = ho.id
ORDER BY r.id_cliente DESC;


--Cada cliente ha realizado 0, 1 o varias reservas, ordenar la lista segùn
--el nombre del cliente descendentemente y por cada cliente ordenar sus reservas
--de manera cronologica.
SELECT r.id, r.checkin, r.checkout, c.nombre, ho.nombre, h.numero
FROM reserva r, cliente c, hotel ho, habitacion h
WHERE c.id = r.id_cliente 
	AND r.id_habitacion = h.id
	AND h.id_hotel = ho.id
ORDER BY r.id_cliente DESC, r.checkin ASC;


--*****************************************************
--GROUP BY
--*****************************************************
--¿cuantos clientes hay por cada pais?
SELECT p.pais, COUNT(c.nombre) as 'cantidad de clientes'
FROM pais p, cliente c
WHERE p.id = c.id_pais
GROUP BY p.id, p.pais;

--La siguiente instrucciòn falla: 
SELECT p.id, p.pais, COUNT(c.nombre) as 'cantidad de clientes'
FROM pais p, cliente c
WHERE p.id = c.id_pais
GROUP BY  p.pais;
--soluciòn:
SELECT p.id, p.pais, COUNT(c.nombre) as 'cantidad de clientes'
FROM pais p, cliente c
WHERE p.id = c.id_pais
GROUP BY p.id, p.pais;

--¿cuantos clientes hay por cada pais?
--mostrar los paises con ningùn cliente
SELECT p.pais, COUNT(c.nombre) as 'cantidad de clientes'
FROM pais p LEFT JOIN cliente c
ON p.id = c.id_pais
GROUP BY  p.pais;

--¿Cuantas reservas se han realizado en cada hotel?
SELECT ho.nombre, COUNT(r.id) as 'cantidad reservas'
FROM hotel ho, habitacion h, reserva r
WHERE ho.id = h.id_hotel 
	AND h.id = r.id_habitacion
GROUP BY ho.nombre;


--¿Cual es la habitaciòn màs barata y màs cara de cada hotel?
SELECT ho.nombre, MIN(h.precio) as 'habitaciòn màs barata', MAX(h.precio) as 'habitaciòn màs cara'
FROM hotel ho, habitacion h
WHERE ho.id = h.id_hotel
GROUP BY  ho.nombre
ORDER BY ho.nombre ASC;

--¿Cual es la habitaciòn màs barata y màs cara de cada hotel?
--Incluir el nùmero de habitaciòn.
/*
NOTA: Esta consulta no es posible realizarla con las herramientas
vistas hasta ahora
*/


--Mostrar el detalle de cada reserva con respecto a los precios.
--incluir el precio de la habitaciòn y el total de los servicios 
--Paso a paso:
/*Consulta 1: mostrar la reserva y la relaciòn con la tabla extra,
para saber si la reserva incluye extras o no*/
SELECT r.id id_reserva, x.id_reserva id_reserva_extras
FROM reserva r LEFT JOIN extras x
		ON r.id = x.id_reserva;

/*Consulta 2: A la consulta anterior, agregar la tabla servicio,
Para saber el nombre del servicio y el precio*/
SELECT r.id id_reserva, x.id_reserva id_reserva_extras, s.id id_servicio, s.nombre nombre_servicio, s.precio 
FROM reserva r LEFT JOIN extras x
		ON r.id = x.id_reserva
	LEFT JOIN servicio s
	ON x.id_servicio = s.id;

/*Consulta 3: A la consulta anterior, agregar la tabla cliente y habitacion,
Para saber el nombre del cliente que realizò la reserva y
que habitaciòn reservò y su precio*/
SELECT c.nombre, r.id id_reserva, h.numero, h.precio, x.id_reserva id_reserva_extras, s.id id_servicio, s.nombre nombre_servicio, s.precio 
FROM reserva r LEFT JOIN extras x
		ON r.id = x.id_reserva
	LEFT JOIN servicio s
	ON x.id_servicio = s.id
	LEFT JOIN habitacion h
	ON r.id_habitacion = h.id
	LEFT JOIN cliente c
	ON c.id = r.id_cliente;

/*Consulta 4: A partir de la consulta anterior, quitar las columnas que no interesan,
dejar el nombre del cliente, el id de la reserva, el precio de la habitacion y el precio de los servicios.
Ordernar por id de reserva de manera ascendente
¿Porque hay ids de reserva que se muestran varias veces, como se interpreta?*/
SELECT c.nombre nombre_cliente, r.id id_reserva, h.precio  precio_habitacion, s.precio precio_servicio
FROM reserva r LEFT JOIN extras x
		ON r.id = x.id_reserva
	LEFT JOIN servicio s
	ON x.id_servicio = s.id
	LEFT JOIN habitacion h
	ON r.id_habitacion = h.id
	LEFT JOIN cliente c
	ON c.id = r.id_cliente
ORDER BY id_reserva;


/*Consulta 5: A partir de la consulta anterior,
Sumar los precios de los servicios con una funciòn de agregaciòn,
y agrupar en base al resto de columnas*/
SELECT c.nombre nombre_cliente, r.id id_reserva, h.precio precio_habitacion, SUM(s.precio) total_servicio
FROM reserva r LEFT JOIN extras x
		ON r.id = x.id_reserva
	LEFT JOIN servicio s
	ON x.id_servicio = s.id
	LEFT JOIN habitacion h
	ON r.id_habitacion = h.id
	LEFT JOIN cliente c
	ON c.id = r.id_cliente
GROUP BY c.nombre, r.id, h.precio
ORDER BY id_reserva;


