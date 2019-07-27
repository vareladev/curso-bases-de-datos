

--Ejercicio 1. 
--Utilizando subconsultas. Mostrar el porcentaje de uso en las recetas de cada medicamento.
SELECT m.idMedicamento, m.nombre, CONCAT(ROUND(CAST(COUNT(r.idConsulta) AS FLOAT) / (SELECT COUNT(*) FROM receta),2)*100,'%') as 'Porcentaje de uso'
FROM medicamento m LEFT JOIN receta r
ON m.idMedicamento = r.idMedicamento
GROUP BY m.idMedicamento, m.nombre;

--Ejercicio 2. 
--Utilizando procedimientos almacenados. Mostrar el porcentaje de uso en las recetas de cada medicamento.
ALTER PROCEDURE sp_med_porcentaje
AS
BEGIN
	DECLARE @cantidad_recetas FLOAT;
	DECLARE @cantidad_medicamentos INT;
	DECLARE cursor_cuenta_medicamentos CURSOR FOR
		SELECT m.idMedicamento, m.nombre, COUNT(r.idConsulta) as cantidad
		FROM medicamento m LEFT JOIN receta r
			ON m.idMedicamento = r.idMedicamento
		GROUP BY m.idMedicamento, m.nombre;

	DECLARE @id INT, @nombre VARCHAR(15), @cantidad FLOAT, @porcentaje FLOAT;
	
	SELECT @cantidad_medicamentos = COUNT(*) FROM medicamento;
	SELECT @cantidad_recetas = COUNT(*) FROM receta;

	OPEN cursor_cuenta_medicamentos;
	WHILE @cantidad_medicamentos > 0 
	BEGIN
		FETCH cursor_cuenta_medicamentos INTO @id, @nombre, @cantidad;
		SET @porcentaje = ROUND(@cantidad / @cantidad_recetas,2)*100;
		PRINT (@nombre + ': '+CAST(@porcentaje AS VARCHAR(10))+'%');
		SET @cantidad_medicamentos = @cantidad_medicamentos - 1;
	END;

	CLOSE cursor_cuenta_medicamentos;
	DEALLOCATE cursor_cuenta_medicamentos;

END;

EXEC sp_med_porcentaje;

--Ejercicio 3. 
--Crear una funciòn que reciba como paràmetro el id de una consulta, esta debe calcular, el total a cobrar por la consulta.
--NOTA: el total de cada consulta se calcular basandose en la siguiente formula: ((precio de la consulta + IVA) + (suma de precios de los medicamentos recetados en la consulta))

ALTER FUNCTION get_total (@id_consulta INT)
RETURNS FLOAT
AS BEGIN
	DECLARE @total FLOAT;

	SELECT @total =  SUM(ISNULL(m.precio,0.00)) + (c.precioConsulta * CAST(1.13 AS FLOAT))
	FROM consulta c LEFT JOIN receta r
		ON c.idConsulta = r.idConsulta
		LEFT JOIN medicamento m
		ON m.idMedicamento = r.idMedicamento
	WHERE c.idConsulta = @id_consulta
	GROUP BY c.idConsulta, c.precioConsulta;

	RETURN ROUND(@total,2);
END;


SELECT c.idConsulta, c.fecha, CONCAT('$',dbo.get_total(c.idConsulta)) AS total
FROM consulta c


--Ejercicio 4. 
--Crear una subconsulta que muestre la ganancia de cada mes entre marzo y mayo de 2018
--NOTA: el total de cada consulta se calcular basandose en la siguiente formula: ((precio de la consulta + IVA) + (suma de precios de los medicamentos recetados en la consulta))
SELECT DATENAME(month, c.fecha) as Mes, CONCAT('$',SUM(dbo.get_total(c.idConsulta))) AS ganancia
FROM consulta c
GROUP BY MONTH(c.fecha), DATENAME(month, c.fecha)
ORDER BY MONTH(c.fecha) ASC;

--Ejercicio 5. 
--Crear una tabla temporal que contenga el id, nombre y precio de cada medicamento. Ademàs, deberà mostrar un descuento de 15% para todos aquellos medicamentos, que tengan un porcentaje de receta menor o igual al 10%
SELECT m.idMedicamento,m.nombre,m.precio, 
	IIF(
		m.idMedicamento IN (
			SELECT m.idMedicamento
			FROM medicamento m LEFT JOIN receta r
			ON m.idMedicamento = r.idMedicamento
			GROUP BY m.idMedicamento, m.nombre
			HAVING ROUND(CAST(COUNT(r.idConsulta) AS FLOAT) / (SELECT COUNT(*) FROM receta),2)*100 <= 10
		)
		, ROUND(CAST(m.precio * 0.85 AS FLOAT),2)
		, m.precio) AS precio_descuento
INTO #temp_medicamentos_descuento
FROM medicamento m

SELECT * FROM #temp_medicamentos_descuento;


--Ejercicio 6. 
--Mostrar el porcentaje de consultas atendidas por cada veterinario entre los meses marzo y abril de 2018.
SELECT m.idMedico, m.nombreMedico, COUNT(c.idConsulta) consultasMedico,
	CONCAT(ROUND(CAST(COUNT(c.idConsulta) AS FLOAT) 
	/ 
	(SELECT COUNT(*) 
	FROM consulta c
	WHERE MONTH(c.fecha) = 3 OR MONTH(c.fecha) = 4),2)*100,'%') AS porcentaje_consulta
FROM consulta c, medico m
WHERE c.idMedico = m.idMedico
	AND 
		(MONTH(c.fecha) = 3
		OR MONTH(c.fecha) = 4)
GROUP BY m.idMedico, m.nombreMedico



--Ejercicio 7. 
--Crear una vista que muestre el bono calculado de cada veterinario. La forma de calculo es la siguiente:
--Si el doctor tiene 3 o menos años de trabajar en la clinica el bono es 50% de su salario actual
--Si el doctor tiene entre 3 y 5 años de trabajar en la clinica el bono es de 75% de su salario actual
--Si tiene mas de 5 el bono es del 100% de su salario actual.
--Todos los calculos se realizan en base a la fecha 'actual' del sistema.

CREATE VIEW view_bono AS
SELECT *, 
	CASE 
        WHEN detalleMedico.tiempo_trabajo <= 3 THEN detalleMedico.salario * CAST(0.5 AS FLOAT)
        WHEN detalleMedico.tiempo_trabajo > 3 AND detalleMedico.tiempo_trabajo <= 5 THEN detalleMedico.salario * CAST(0.75 AS FLOAT)
		WHEN detalleMedico.tiempo_trabajo > 5 THEN detalleMedico.salario
    END as bono
FROM(
	SELECT * , DATEDIFF ( yy , m.FechaContrato , getdate() )  as tiempo_trabajo
	FROM medico m
) as detalleMedico;

SELECT * FROM view_bono;