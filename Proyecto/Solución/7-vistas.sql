/* La siguiente vista muestra un resumen del anexo 1: "Verificacion de parametros ambientales", 
comenzando por el nombre del equipo utilizado, el nombre del par�metro ambiental, 
as� como tambi�n el valor medido,  valor est�ndar de las mediciones y el responsable de estas. */
create view vista1
as 
select em.nombre 'Nombre equipo', pa.nombre 'Par�metro ambiental', ma.valor_medido 'Valor medido', ma.valor_estandar 'Valor est�ndar', ic.responsable 'Responsable'
from medicion_ambiental ma, parametro_ambiental pa, inspeccion_comun ic, Inspeccion_comun_X_Equipo ice, equipo_medicion em
where pa.id_parametro = ma.id_parametro_ambiental
and ic.id_inspeccion = ma.id_inspeccion 
and ice.id_inspeccion_comun = ic.id_inspeccion
and ice.num_inventario = em.num_inventario

select *from vista1

/*Esta vista resume el Anexo 2: "Verificaci�n de recept�culos el�tricos",  
muestra el equipo, el par�metro del recept�culo, el valor medido 
y al lado el valor est�ndar con el que se puede hacer una comparaci�n, 
tambi�m se puede ver qui�n es el reponsable de cada una de las medidas medidas*/

create view vista2
as 
select em.nombre 'Equipo', pr.nombre 'Par�metro Recept�culo', vm.valor_medido 'Valor medido', mr.valor_estandar 'Valor est�ndar', ic.responsable 'Responsable'
from equipo_medicion em, Inspeccion_comun_X_Equipo ice, inspeccion_comun ic, medicion_receptaculo mr, parametro_receptaculo pr, valor_medido vm
where em.num_inventario = ice.num_inventario
and ice.id_inspeccion_comun = ic.id_inspeccion
and mr.id_inspeccion = ic.id_inspeccion
and pr.id_parametro = mr.id_parametro_receptaculo

select *from vista2

/*Esta vista muestra el nombre del dispositivo, el encargado o encargada, 
as� como el nombre de la prueba el�trica 'Resistencia de puesta a tierra de protecci�n',
tambi�n muestra se observa el valor medido, para que luego se compare con el valor est�ndar, 
y tambi�n se especifica la fecha de inspecci�n*/
create view vista3
as 
select dm.nombre 'Dispositivo M�dico', et.nombre Encargado, npe.nombre_prueba 'Nombre prueba', pae.nombre 'Par�metro el�ctrico', pe.valor_medido 'Valor Medido', pe.valor_estandar 'Valor est�ndar', ie.fecha_inspeccion 'Fecha inspecci�n'
from nombre_prueba_electrica npe, prueba_electrica pe, inspeccion_electrica ie, equipo_trabajo et, Inspeccion_electrica_X_Equipo iee, parametro_electrico pae, dispositivo_medico dm , Dispositivo_X_Inspeccion_electrica die
where et.id_equipo = iee.id_equipo
and iee.id_inspeccion_electrica = ie.id_inspeccion
and ie.id_inspeccion = pe.id_inspeccion
and pae.id_parametro = pe.id_parametro_electrico
and npe.id_nombre = pe.id_nombre_prueba
and die.id_inspeccion_electrica = ie.id_inspeccion
and dm.num_inventario = die.num_inventario
and npe.nombre_prueba like 'Resistencia de %'

select *from vista3


/*La siguiente vista muestra de la inspecci�n de seguridad el�trica 
el nombre del dispositivo m�dico utilizado, el encargado, as� como el
nombre de la prueba el�trica, que en este caso ser�a "Corriente de fuga del equipo", 
as� como tambi�n se observa el valor medido, el valor est�ndar, la fecha de inspecci�n*/
create view vista4
as 
select dm.nombre 'Dispositivo M�dico', et.nombre Encargado, npe.nombre_prueba 'Nombre prueba', pae.nombre 'Par�metro el�ctrico', pe.valor_medido 'Valor Medido', pe.valor_estandar 'Valor est�ndar', ie.fecha_inspeccion 'Fecha inspecci�n'
from nombre_prueba_electrica npe, prueba_electrica pe, inspeccion_electrica ie, equipo_trabajo et, Inspeccion_electrica_X_Equipo iee, parametro_electrico pae, dispositivo_medico dm , Dispositivo_X_Inspeccion_electrica die
where et.id_equipo = iee.id_equipo
and iee.id_inspeccion_electrica = ie.id_inspeccion
and ie.id_inspeccion = pe.id_inspeccion
and pae.id_parametro = pe.id_parametro_electrico
and npe.id_nombre = pe.id_nombre_prueba
and die.id_inspeccion_electrica = ie.id_inspeccion
and dm.num_inventario = die.num_inventario
and npe.nombre_prueba like 'Corriente %'

select *from vista4


/**En esta vista se observa el dispositivo m�dico, el encargado, 
tambi�n la prueba el�trica "Resistencia del aislamiento", 
as� como tambi�n se observa el valor medido, para compararlo el valor est�ndar, 
y tambien se muestra la fecha de inspecci�n**/
create view vista5
as 
select dm.nombre 'Dispositivo M�dico', et.nombre Encargado, npe.nombre_prueba 'Nombre prueba', pae.nombre 'Par�metro el�ctrico', pe.valor_medido 'Valor Medido', pe.valor_estandar 'Valor est�ndar', ie.fecha_inspeccion 'Fecha inspecci�n'
from nombre_prueba_electrica npe, prueba_electrica pe, inspeccion_electrica ie, equipo_trabajo et, Inspeccion_electrica_X_Equipo iee, parametro_electrico pae, dispositivo_medico dm , Dispositivo_X_Inspeccion_electrica die
where et.id_equipo = iee.id_equipo
and iee.id_inspeccion_electrica = ie.id_inspeccion
and ie.id_inspeccion = pe.id_inspeccion
and pae.id_parametro = pe.id_parametro_electrico
and npe.id_nombre = pe.id_nombre_prueba
and die.id_inspeccion_electrica = ie.id_inspeccion
and dm.num_inventario = die.num_inventario
and npe.nombre_prueba = 'Resistencia del aislamiento'

select *from vista5