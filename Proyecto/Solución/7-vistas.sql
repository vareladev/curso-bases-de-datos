/* La siguiente vista muestra un resumen del anexo 1: "Verificacion de parametros ambientales", 
comenzando por el nombre del equipo utilizado, el nombre del parámetro ambiental, 
así como también el valor medido,  valor estándar de las mediciones y el responsable de estas. */
create view vista1
as 
select em.nombre 'Nombre equipo', pa.nombre 'Parámetro ambiental', ma.valor_medido 'Valor medido', ma.valor_estandar 'Valor estándar', ic.responsable 'Responsable'
from medicion_ambiental ma, parametro_ambiental pa, inspeccion_comun ic, Inspeccion_comun_X_Equipo ice, equipo_medicion em
where pa.id_parametro = ma.id_parametro_ambiental
and ic.id_inspeccion = ma.id_inspeccion 
and ice.id_inspeccion_comun = ic.id_inspeccion
and ice.num_inventario = em.num_inventario

select *from vista1

/*Esta vista resume el Anexo 2: "Verificación de receptáculos elétricos",  
muestra el equipo, el parámetro del receptáculo, el valor medido 
y al lado el valor estándar con el que se puede hacer una comparación, 
tambiém se puede ver quién es el reponsable de cada una de las medidas medidas*/

create view vista2
as 
select em.nombre 'Equipo', pr.nombre 'Parámetro Receptáculo', vm.valor_medido 'Valor medido', mr.valor_estandar 'Valor estándar', ic.responsable 'Responsable'
from equipo_medicion em, Inspeccion_comun_X_Equipo ice, inspeccion_comun ic, medicion_receptaculo mr, parametro_receptaculo pr, valor_medido vm
where em.num_inventario = ice.num_inventario
and ice.id_inspeccion_comun = ic.id_inspeccion
and mr.id_inspeccion = ic.id_inspeccion
and pr.id_parametro = mr.id_parametro_receptaculo

select *from vista2

/*Esta vista muestra el nombre del dispositivo, el encargado o encargada, 
así como el nombre de la prueba elétrica 'Resistencia de puesta a tierra de protección',
también muestra se observa el valor medido, para que luego se compare con el valor estándar, 
y también se especifica la fecha de inspección*/
create view vista3
as 
select dm.nombre 'Dispositivo Médico', et.nombre Encargado, npe.nombre_prueba 'Nombre prueba', pae.nombre 'Parámetro eléctrico', pe.valor_medido 'Valor Medido', pe.valor_estandar 'Valor estándar', ie.fecha_inspeccion 'Fecha inspección'
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


/*La siguiente vista muestra de la inspección de seguridad elétrica 
el nombre del dispositivo médico utilizado, el encargado, así como el
nombre de la prueba elétrica, que en este caso sería "Corriente de fuga del equipo", 
así como también se observa el valor medido, el valor estándar, la fecha de inspección*/
create view vista4
as 
select dm.nombre 'Dispositivo Médico', et.nombre Encargado, npe.nombre_prueba 'Nombre prueba', pae.nombre 'Parámetro eléctrico', pe.valor_medido 'Valor Medido', pe.valor_estandar 'Valor estándar', ie.fecha_inspeccion 'Fecha inspección'
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


/**En esta vista se observa el dispositivo médico, el encargado, 
también la prueba elétrica "Resistencia del aislamiento", 
así como también se observa el valor medido, para compararlo el valor estándar, 
y tambien se muestra la fecha de inspección**/
create view vista5
as 
select dm.nombre 'Dispositivo Médico', et.nombre Encargado, npe.nombre_prueba 'Nombre prueba', pae.nombre 'Parámetro eléctrico', pe.valor_medido 'Valor Medido', pe.valor_estandar 'Valor estándar', ie.fecha_inspeccion 'Fecha inspección'
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