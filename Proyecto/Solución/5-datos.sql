CREATE DATABASE Unidad_Cuidados;

USE Unidad_Cuidados;

DROP DATABASE Unidad_Cuidados;

SET LANGUAGE SPANISH;

INSERT INTO parametro_electrico (nombre) 
VALUES('Condiciones del chasis (presencia de quiebres, rajaduras, daños)'),
('Los fusibles accesibles desde el exterior son acorde a lo que establece el
fabricante (corriente nominal, características)'),
('Los símbolos de seguridad y las etiquetas son legibles y están completos'),
('Integridad de las aprtes mecánicas (por ejemplo: obstrucción de partes móviles)'),
('Presencia de daño o contaminación'),
('Evaluación de los accesorios relevantes al equipo biomédico (por ejemplo: cables/circuito
de paciente, cables de poder, transductores, etc)'),
('Estado de los enchufes, cables y conectores, conexiones correctas'),
('Documentación actualizada del equipo biomédico'),
('La resistencia medida entre el conector de tierra de protección del enchufe de la red
y las partes conductivas accesibles protegidas a tierra,
no debe exceder de 300 mΩ para equipos biomédicos que cuentan con un cable de poder fijo al equipo.'),
('La resistencia medida entre el conector de tierra del conector de entrada de red al equipo y las
partes conductivas accesibles protegidas a tierra, no debe de exceder de 200 mΩ para equipos con
cable de poder desmontable'),
('En equipos permanentemente instalados: La resistencia medida entre el terminal de tierra de
protección del equipo biomédico y las partes conductivas accesibles protegidas a tierra, no
deberá exceder de 300 mΩ. Durante esta prueba no se desconecta el conductor de tierra de protección'),
('En sistemas con múltiples salidas eléctricas, la resistencia entre el conector de tierra de protección
del enchufe de la red de las múltiples salidas eléctricas y todas las partes conductivas accesibles
protegidas a tierra, no deberán exceder 500 mΩ'),
('Corriente de fuga del equipo para partes conductivas accesibles de equipos biomédicos clase I
conectados o no conectados al conductor de tierra de protección'),
('Corriente de fuga del equipo para equipos biomédicos'),
('Corriente de fuga de la parte aplicada en contacto con el paciente'),
('Corrientes de fuga de la parte en contacto con el paciente (voltaje de red en la parte e
contacto con el paciente)'),
('Medición de la resistencia del aislamiento entre tensión de alimentación y protección de puesta a tierra'),
('Medición de la resistencia del aislamiento entre tensión de alimentación y partes conductivas sin puesta a tierra'),
('Medición de la resistencia del aislamiento entre partes aplicadas y protección de puesta a tierra'),
('Medición de la resistencia del aislamiento entre partes aplicadas y partes conductivas sin puesta a tierra'),
('Medición de la resistencia del aislamiento entre tensión de alimentación y partes aplicadas');

INSERT INTO nombre_prueba_electrica (nombre_prueba) 
VALUES('Inspección visual'),
('Resistencia de puesta a tierra de protección - Equipos biomédicos Clase I'),
('Corriente de fuga del equipo - Método alternativo'),
('Corriente de fuga del equipo - Método directo o diferencial'),
('Corriente de fuga de la parte aplicada en contacto con el paciente - Método alternativo'),
('Corriente de fuga de la parte en contacto con el paciente - Método directo'),
('Resistencia del aislamiento');


INSERT INTO equipo_trabajo (nombre) 
VALUES('Luis'),
('Manuel'),
('Eduardo'),
('Gabriela'),
('Valeria'),
('Tamara'),
('Ronaldo'),
('Camilo'),
('Rodrigo'),
('Diego');


INSERT INTO inspeccion_electrica (fecha_inspeccion)
VALUES('01-01-2018'),
('31-03-2018');


INSERT INTO tipo_inspeccion (tipo_inspeccion) 
VALUES('Inspeccion ambiental'),
('Inspeccion de receptaculos electricos');


INSERT INTO inspeccion_comun (responsable, observacion, conclusion, fecha_inspeccion, id_tipo)
VALUES('Manuel Garcia', 'Regular', 'Bien', '21-06-2019', 2),
('Adriana Palacios', 'Mas o menos', 'Mala vibra', '11-07-2019', 2),
('Valeria Sanchez', 'Quien sabe', 'Portatil', '03-08-2019', 1),
('Paola Padilla', 'Se necesita mas', 'Disfuncional', '30-10-2019', 1);


INSERT INTO prueba_electrica (valor_medido, valor_estandar, observacion, id_nombre_prueba, id_parametro_electrico, id_inspeccion)
VALUES(1, 1, 'creep', 1, 1, 1), --Inspeccion visual
(0, 1, 'cree', 1, 2, 1),
(1, 1, 'cre', 1, 3, 1),
(0, 1, 'cr', 1, 4, 1),
(1, 1, 'c', 1, 5, 1),
(1, 1, 'biography', 1, 6, 1),
(0, 1, 'biograph', 1, 7, 1),
(1, 1, 'biograp', 1, 8, 1),
(350, 300, 'biogra', 2, 9, 1), --Resistencia de puesta a tierra de proteccion - Equipo biomedico Clase I
(199, 200, 'biogr', 2, 10, 1),
(269, 300, 'biog', 2, 11, 1),
(501, 500, 'bio', 2, 12, 1),
(978, 1000, 'bi', 3, 13, 1), --Corriente de fuga del equipo - Metodo alternativo
(600, 500, 'b', 3, 14, 1),
(400, 500, 'worm', 4, 13, 1), --Corriente de fuga del equipo - Metodo directo
(50, 100, 'wor', 4, 14, 1),
(4800, 5000, 'wo', 5, 15, 1), --Corriente de fuga de la parte aplicada en contacto con el paciente - metodo alternativo
(40, 50, 'w', 5, 15, 1),
(5001, 5000, 'greeting', 6, 16, 1), --Corriente de fuga de la parte aplicada en contacto con el paciente - metodo directo
(49, 50, 'greetin', 6, 16, 1),
(2, 2, 'greeti', 7, 17, 1), --Resistencia del aislamiento
(9, 7, 'greet', 7, 18, 1),
(45, 70, 'gree', 7, 19, 1),
(68, 70, 'gre', 7, 20, 1),
(83, 70, 'gr', 7, 21, 1);


INSERT INTO prueba_electrica (valor_medido, valor_estandar, observacion, id_nombre_prueba, id_parametro_electrico, id_inspeccion)
VALUES(0, 1, 'pottery', 1, 1, 2), --Inspeccion visual
(0, 1, 'potter', 2, 2, 2),
(1, 1, 'potte', 1, 3, 2),
(1, 1, 'pott', 1, 4, 2),
(1, 1, 'pot', 1, 5, 2),
(0, 1, 'po', 1, 6, 2),
(0, 1, 'p', 1, 7, 2),
(0, 1, 'urgency', 1, 8, 2),
(200, 300, 'urgenc', 2, 9, 2), --Resistencia de puesta a tierra de proteccion - Equipo biomedico Clase I
(251, 200, 'urgen', 2, 10, 2),
(377.10, 300, 'urge', 2, 11, 2),
(358.30, 500, 'urg', 2, 12, 2),
(736.45, 1000, 'ur', 3, 13, 2), --Corriente de fuga del equipo - Metodo alternativo
(499.99, 500, 'u', 3, 14, 2),
(500, 500, 'established', 4, 13, 2), --Corriente de fuga del equipo - Metodo directo
(10, 100, 'establishe', 4, 14, 2),
(3500, 5000, 'establish', 5, 15, 2), --Corriente de fuga de la parte aplicada en contacto con el paciente - metodo alternativo
(35, 50, 'establis', 5, 15, 2),
(4999.3, 5000, 'establi', 6, 16, 2), --Corriente de fuga de la parte aplicada en contacto con el paciente - metodo directo
(84, 50, 'establ', 6, 16, 2),
(1, 2, 'estab', 7, 17, 2), --Resistencia del aislamiento
(6, 7, 'esta', 7, 18, 2),
(63.54, 70, 'est', 7, 19, 2),
(69, 70, 'es', 7, 20, 2),
(70.50, 70, 'e', 7, 21, 2);


INSERT INTO Inspeccion_electrica_X_Equipo
VALUES(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(2, 6);


INSERT INTO parametro_receptaculo (nombre)
VALUES ('Polaridad'),
('Vfase-Neutro'),
('Vneutro-tierra'),
('Vfase-tierra');


INSERT INTO municipio (nombre) 
VALUES 
('Ahuachapán'),
('Apaneca'),
('Atiquizaya'),
('Concepción de Ataco'),
('El Refugio'),
('Guaymango'),
('Jujutla'),
('San Francisco Menéndez'),
('San Lorenzo'),
('San Pedro Puxtla'),
('Tacuba'),
('Turín'),
('Sensuntepeque'),
('Cinquera'),
('Dolores'),
('Guacotecti'),
('Ilobasco'),
('Jutiapa'),
('San Isidro'),
('Tejutepeque'),
('Victoria'),
('Chalatenango'),
('Agua Caliente'),
('Arcatao'),
('Azacualpa'),
('Cancasque'),
('Citalá'),
('Comalapa'),
('Concepción Quezaltepeque'),
('Dulce Nombre de María'),
('El Carrizal'),
('El Paraíso'),
('La Laguna'),
('La Palma'),
('La Reina');


INSERT INTO parametro_ambiental(nombre)
VALUES ('Iluminacion ambiental'),
('Ruido ambiental'),
('Temperatura ambiental'),
('Humedad relativa ambiental');


insert into hospital (nombre, direccion, id_municipio)
values('Hospital Diagnostico','Paseo general escalon colonia medica av Dr luis Edmunod vasquez San Salvador',29),
('Hospital Nacional Rosales','25 AV Norte San Salvador',35);


insert into servicio_hospitalario(nombre_servicio)
values ('Quimioterapia'),
('cirujia'),
('Electrofisiologia');


insert into unidad(nombre,responsable,responsable_extension,id_hospital,id_servicio_hospitalario)
values ('Unidad de emergencia ','Esmeralda Martinez','4842',2,2),
('Unidad de Cuidados intensivos ','Juan Antonio Tobar','4852',2,2),
('Unidad Cardiovascular ','Caceros Hernandez','4822',1,3),
('Unidad de Quimioterapia ','Mario Argueta','4802',1,1);


INSERT INTO Unidad_X_Inspeccion_electrica (id_unidad, id_inspeccion_electrica) 
VALUES(3, 1),
(4, 2);


INSERT INTO Unidad_x_Inspeccion_comun (id_inspeccion_comun, id_unidad)
VALUES(1,3),
(2,4),
(3, 1),
(4, 2);

insert into medicion_receptaculo(id_parametro_receptaculo,valor_estandar,id_inspeccion)
values(1,1,1), --Polaridad
(2,120,1), --Vfase-neutro
(3,0.5,1), --Vneutro-tierra
(4,120,1), --Vfase-tierra
(1,1,2), --Polaridad
(2,120,2), --Vfase-neutro
(3,0.4,2), --Vneutro-tierra
(4,120,2); --Vfase-tierra

insert into valor_medido(valor_medido,id_medicion)
values (1,1), --Polaridad
(0,1),
(1,1),
(0,1),
(1,1),
(51.2,2), --Vfase-neutro
(116.4,2),
(79.6,2),
(34.6,2),
(80.3,2),
(0.23,3), --Vneutro-tierra
(0.488,3),
(0.48,3),
(0.71,3),
(0.33,3),
(21.2,4),
(100.9,4), --Vfase-tierra
(64.98,4),
(47.9,4),
(66.6,4),
(1,5), --Polaridad
(1,5),
(0,5),
(0,5),
(1,5),
(67.2,6), --Vfase-neutro
(113.4,6),
(25.7,6),
(92.3,6),
(120,6),
(0.4,7), --Vneutro-tierra
(0.478,7),
(0.78,7),
(0.95,7),
(0.76,7),
(51.2,8),
(115.4,8), --Vfase-tierra
(74.6,8),
(72.3,8),
(65.7,8);

INSERT INTO medicion_ambiental(valor_medido,valor_estandar,id_parametro_ambiental,id_inspeccion)
VALUES(550,'600 Lux Max',1,3),
		(560,'600 Lux Max',1,3),
		(570,'600 Lux Max',1,3),
		(580,'600 Lux Max',1,3),
		(590,'600 Lux Max',1,3),
		(55,'65 dB Max',2,3),
		(22,'22° a 26° C',3,3),
		(23,'22° a 26° C',3,3),
		(35,'30% a 60 %' ,4,3),
		(37,'30% a 60 %',4,3);

INSERT INTO medicion_ambiental(valor_medido,valor_estandar,id_parametro_ambiental,id_inspeccion)
VALUES(510,'600 Lux Max',1,4),
		(520,'600 Lux Max',1,4),
		(530,'600 Lux Max',1,4),
		(540,'600 Lux Max',1,4),
		(545,'600 Lux Max',1,4),
		(40,'65 dB Max',2,4),
		(25,'22° a 26° C',3,4),
		(24,'22° a 26° C',3,4),
		(50,'30% a 60 %',4,4),
		(45,'30% a 60 %',4,4);

Insert into marca_equipo(marca)
VALUES('Gigaware'),
('Lasko'),
('Peaktech'),
('Megger');

Insert into modelo_equipo(modelo)
VALUES('Gigaware'),
('Lasko'),
('Peaktech'),
('Megger');

INSERT INTO equipo_medicion(nombre,fecha_calibracion,num_serie,certificado_calibracion,id_marca,id_modelo)
VALUES('Luxometro','02-03-2018',4250569401956,'Certificado',1,1),
	('Sonometros','03-04-2018',	42508794020,'Certificado',2,2),
	('Medidor de temperatura','15-03-2018',159785275,'Certificado',1,3),
	('Ohmetro','28-03-2018',876674238,'Certificado',4,4);

Insert into accesorio_medicion(accesorio, num_inventario)
VALUES('Sensor Fotodiodo',1),
('Sensor semiconductor',2),
('Sonda de luz',3),
('Aguja Indicadora',4);

INSERT INTO Inspeccion_comun_X_Equipo (id_inspeccion_comun, num_inventario)
VALUES(1,1),
(2,2),
(3,3),
(4,4);

insert into modelo(modelo)
values('cardiovit1'),
('PD 1200'),
('PD 1400'),
('ALARIS ASENA AP'),
('PD 1400'),
('Express Panda'),
(' PCE-CFE');

insert into clase(clase)
values ('Clase I'),
('Clase II)');

insert into tipo(tipo)
values('Tipo B'),
('Tipo BF'),
('Tipo CF');

insert into dispositivo_medico(num_inventario,num_serie,nombre,certificado_calibracion,id_tipo,id_clase,id_modelo)
values(1,001,'Electrocardiógrafo', 'certificado',1,1,1),
(2,002,'Desfibrilador', 'certificado',2,1,1),
(3,003,'Bomba de infusion', 'certificado',3,1,4),
(4,004,'Incubadora', 'certificado',1,2,5),
(5,005,' Electroencefalógrafo', 'certificado',2,2,7),
(6,006,'Centrifugas', 'certificado',3,2,6);

insert into accesorio_medico(accesorio, num_inventario) 
values ('Adaptador de electrodo caimán tipo banana',1),
('Palas de desfibrilación',2),
('FUENTES DE ALIMENTACIÓN ELÉCTRICA EXTERNA',3),
('Ionizador',4),
('Electrodos',5),
('Tacómetro.',6);

insert into Dispositivo_X_Inspeccion_electrica(num_inventario, id_inspeccion_electrica)
values(1,1),
(2,1),
(3,1),
(4,2),
(5,2),
(6,2);