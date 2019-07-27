/*VerificarPruebaElectrica calcula si los valores medidos en un determinada inspeccion electrica 
para ver si cumplen o no cumplen el valor estandar. Si se desea saber de varias inspecciones a la vez, simplemente
no se especifica el id de la inspeccion.
Para utilizar la funcion es necesario hacer una consulta (como la que se muestra debajo de la funcion VerificarPruebaElectrica)
que enlace todas las tablas necesarias para formar el anexo 3. */
CREATE FUNCTION VerificarPruebaElectrica(@Nid_nombre int, @IEid_inspeccion int, @Pid_medicion int, @PEid_parametro int)
RETURNS VARCHAR(30)
AS BEGIN 
DECLARE @Prueba FLOAT;
	--Inspeccion Visual
	IF @Nid_nombre = 1
	BEGIN --IF1
		SELECT @Prueba = p.valor_medido
		FROM inspeccion_electrica ie INNER JOIN prueba_electrica p
		ON ie.id_inspeccion = p.id_inspeccion INNER JOIN nombre_prueba_electrica n
		ON p.id_nombre_prueba = n.id_nombre 
		WHERE ie.id_inspeccion = @IEid_inspeccion AND n.id_nombre = @Nid_nombre AND p.id_medicion = @Pid_medicion

		IF @Prueba = 1
		BEGIN
			RETURN 'Cumple'
		END;
	END; --IF1

	--Resistencia de puesta a tierra de proteccion
	IF @Nid_nombre = 2
	BEGIN 
		SELECT @Prueba = p.valor_medido
		FROM inspeccion_electrica ie INNER JOIN prueba_electrica p
		ON ie.id_inspeccion = p.id_inspeccion INNER JOIN nombre_prueba_electrica n
		ON p.id_nombre_prueba = n.id_nombre 
		WHERE ie.id_inspeccion = @IEid_inspeccion AND n.id_nombre = @Nid_nombre AND p.id_medicion = @Pid_medicion

		IF @Prueba < 300 AND (@PEid_parametro = 9 OR @PEid_parametro = 11)
		BEGIN
			RETURN 'Cumple'
		END;

		IF @Prueba < 200 AND @PEid_parametro = 10
		BEGIN
			RETURN 'Cumple'
		END;

		IF @Prueba < 500 AND @PEid_parametro = 12
		BEGIN
			RETURN 'Cumple'
		END;
	END; 

	--Corriente de fuga del equipo -- metodo alternativo
	IF @Nid_nombre = 3 OR @Nid_nombre = 4
	BEGIN 
		SELECT @Prueba = p.valor_medido
		FROM inspeccion_electrica ie INNER JOIN prueba_electrica p
		ON ie.id_inspeccion = p.id_inspeccion INNER JOIN nombre_prueba_electrica n
		ON p.id_nombre_prueba = n.id_nombre 
		WHERE ie.id_inspeccion = @IEid_inspeccion AND n.id_nombre = @Nid_nombre AND p.id_medicion = @Pid_medicion

		IF @Prueba <= 1000 AND (@PEid_parametro = 13)
		BEGIN
			RETURN 'Cumple'
		END;

		IF @Prueba <= 500 AND @PEid_parametro = 14
		BEGIN
			RETURN 'Cumple'
		END;
	END;

	--Corriente de fuga del equipo -- metodo directo
	IF @Nid_nombre = 5 OR @Nid_nombre = 6
	BEGIN 
		SELECT @Prueba = p.valor_medido
		FROM inspeccion_electrica ie INNER JOIN prueba_electrica p
		ON ie.id_inspeccion = p.id_inspeccion INNER JOIN nombre_prueba_electrica n
		ON p.id_nombre_prueba = n.id_nombre 
		WHERE ie.id_inspeccion = @IEid_inspeccion AND n.id_nombre = @Nid_nombre AND p.id_medicion = @Pid_medicion

		IF @Prueba <= 5000 AND (@PEid_parametro = 15)
		BEGIN
			RETURN 'Cumple'
		END;

		IF @Prueba <= 5000 AND @PEid_parametro = 16
		BEGIN
			RETURN 'Cumple'
		END;
	END;

	--Resistencia del aislamiento
	IF @Nid_nombre = 7
	BEGIN 
		SELECT @Prueba = p.valor_medido
		FROM inspeccion_electrica ie INNER JOIN prueba_electrica p
		ON ie.id_inspeccion = p.id_inspeccion INNER JOIN nombre_prueba_electrica n
		ON p.id_nombre_prueba = n.id_nombre 
		WHERE ie.id_inspeccion = @IEid_inspeccion AND n.id_nombre = @Nid_nombre AND p.id_medicion = @Pid_medicion

		IF @Prueba >= 2 AND @PEid_parametro = 17
		BEGIN
			RETURN 'Cumple'
		END;

		IF @Prueba >= 7 AND @PEid_parametro = 18
		BEGIN
			RETURN 'Cumple'
		END;

		IF @Prueba >= 70 AND (@PEid_parametro = 19 OR @PEid_parametro = 20 OR @PEid_parametro = 21)
		BEGIN
			RETURN 'Cumple'
		END;

	END;

	RETURN 'No Cumple';
END;

SELECT ie.id_inspeccion, n.nombre_prueba, p.valor_medido, p.valor_estandar, 
dbo.VerificarPruebaElectrica(n.id_nombre, ie.id_inspeccion, p.id_medicion, pe.id_parametro) as 'Cumple/No cumple'
FROM inspeccion_electrica ie INNER JOIN prueba_electrica p
ON ie.id_inspeccion = p.id_inspeccion INNER JOIN nombre_prueba_electrica n
ON p.id_nombre_prueba = n.id_nombre INNER JOIN parametro_electrico pe
ON p.id_parametro_electrico = pe.id_parametro
WHERE ie.id_inspeccion = 1;

/*VerificarReceptaculo calcula si los valores medidos en un determinada inspeccion de receptaculos 
para ver si cumplen o no cumplen el valor estandar. Si se desea saber de varias inspecciones a la vez, simplemente
no se especifica el id de la inspeccion.
Para utilizar la funcion es necesario hacer una consulta (como la que se muestra debajo de la funcion VerificarPruebaElectrica)
que enlace todas las tablas necesarias para formar el anexo 2 y es fundamental que el id del tipo de inspeccion sea igual a 2. */
CREATE FUNCTION VerificarReceptaculo(@ICid_inspeccion INT, @PRid_parametro INT, @VMid_valor INT) 
RETURNS VARCHAR(30)
AS BEGIN
	DECLARE @Prueba FLOAT

	SELECT @Prueba = vm.valor_medido
	FROM inspeccion_comun ic INNER JOIN tipo_inspeccion ti
	ON ic.id_tipo = ti.id_tipo INNER JOIN medicion_receptaculo mr
	ON mr.id_inspeccion = ic.id_inspeccion INNER JOIN parametro_receptaculo pr
	ON mr.id_parametro_receptaculo = pr.id_parametro INNER JOIN valor_medido vm
	ON vm.id_medicion = mr.id_medicion
	WHERE ti.id_tipo = 2 AND pr.id_parametro = @PRid_parametro AND ic.id_inspeccion = @ICid_inspeccion AND vm.id_valor = @VMid_valor;

	--Polaridad 
	IF @PRid_parametro = 1
	BEGIN
		IF @Prueba = 1
		BEGIN
			RETURN 'Cumple'
		END;
	END;

	--Vfase-neutro y Vfase-tierra
	IF @PRid_parametro = 2  OR @PRid_parametro = 4
	BEGIN
		IF @Prueba >= 110 AND @PRid_parametro <= 130
		BEGIN
			RETURN 'Cumple'
		END;
	END;

	--Vfase-neutro
	IF @PRid_parametro = 3
	BEGIN
		IF @Prueba < 1
		BEGIN
			RETURN 'Cumple'
		END;
	END;

	RETURN 'No cumple'
END;

SELECT ic.id_inspeccion, vm.valor_medido, mr.valor_estandar, dbo.VerificarReceptaculo(ic.id_inspeccion, pr.id_parametro, vm.id_valor) as 'Cumple/No cumple', pr.nombre
FROM inspeccion_comun ic INNER JOIN tipo_inspeccion ti
ON ic.id_tipo = ti.id_tipo INNER JOIN medicion_receptaculo mr
ON mr.id_inspeccion = ic.id_inspeccion INNER JOIN parametro_receptaculo pr
ON mr.id_parametro_receptaculo = pr.id_parametro INNER JOIN valor_medido vm
ON vm.id_medicion = mr.id_medicion
WHERE ti.id_tipo = 2 AND ic.id_inspeccion = 1;

/*Este proceso almacenado nos muestra un promedio divido por parámetro de medición y 
según su correspondiente medición y además si cumple o no con los estándares que se están evaluando
Y al uso solo es ejecutar la función mandándole como parámetro el ID de la medición que se desea obtener los valores*/
create procedure Valor_prom
@id_inspeccion int
as
select avg(valor_medido) as 'Promedio', id_parametro_ambiental, case id_parametro_ambiental
when  1 then case  when avg(valor_medido) > 600  then 'No cumple' else 'Cumple' end
when  2 then case when  avg(valor_medido) > 65 then 'No cumple' else 'Cumple' end
when  3 then case  when avg(valor_medido) between 22 and 25 then 'Cumple' else 'No cumple'end
when  4 then case  when   avg(valor_medido) between 30 and 60 then 'Cumple' else 'No cumple'end
end
from medicion_ambiental
where id_inspeccion = @id_inspeccion
group by id_parametro_ambiental,valor_estandar
order  by id_parametro_ambiental ASC
RETURN  
GO

EXECUTE valor_prom 3;


/*La función PorcentajeReceptaculo muestra la cantidad de mediciones que cumplen 
con el valor estándar, y también calcula el porcentaje de cumplimiento del estándar 
de la inspección del Receptáculo eléctrico.*/

create function PorcentajeReceptaculo()
returns table 
as 
return 
SELECT COUNT(dbo.VerificarReceptaculo(ic.id_inspeccion, pr.id_parametro, vm.id_valor)) 'Total que cumplen', (COUNT(dbo.VerificarReceptaculo(ic.id_inspeccion, pr.id_parametro, vm.id_valor))*100)/40  as 'Porcentaje de cumplimiento'
FROM  inspeccion_comun ic INNER JOIN tipo_inspeccion ti
ON ic.id_tipo = ti.id_tipo INNER JOIN medicion_receptaculo mr
ON mr.id_inspeccion = ic.id_inspeccion INNER JOIN parametro_receptaculo pr
ON mr.id_parametro_receptaculo = pr.id_parametro INNER JOIN valor_medido vm
ON vm.id_medicion = mr.id_medicion
WHERE dbo.VerificarReceptaculo(ic.id_inspeccion, pr.id_parametro, vm.id_valor) = 'Cumple'

select *from dbo.PorcentajeReceptaculo();



