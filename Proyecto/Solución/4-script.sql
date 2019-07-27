CREATE DATABASE Unidad_Cuidados;

USE Unidad_Cuidados;

SET LANGUAGE SPANISH;

CREATE TABLE unidad (
id_unidad int primary key not null identity,
nombre varchar(50),
responsable varchar(50),
responsable_extension varchar(15),
id_hospital int not null,
id_servicio_hospitalario int not null
);

CREATE TABLE hospital(
id_hospital int primary key not null identity,
nombre varchar(50),
direccion varchar(100),
id_municipio int not null
);

CREATE TABLE municipio(
id_municipio int primary key not null identity,
nombre varchar(50) not null
);

CREATE TABLE servicio_hospitalario(
id_servicio int primary key not null identity,
nombre_servicio varchar(50) not null
);

alter table unidad
add constraint FK_unidad_hospital
foreign key (id_hospital) references hospital (id_hospital);

alter table hospital
add constraint FK_hospital_municipio
foreign key (id_municipio) references municipio (id_municipio);

alter table unidad
add constraint FK_unidad_servicio_hospitalario
foreign key (id_servicio_hospitalario) references servicio_hospitalario (id_servicio);

CREATE TABLE dispositivo_medico(
num_inventario int primary key not null,
num_serie int not null,
nombre varchar(50),
certificado_calibracion varchar(50),
id_tipo int,
id_clase int,
id_modelo int not null
);

CREATE TABLE tipo(
id_tipo int primary key not null identity,
tipo varchar(50) not null
);

CREATE TABLE clase(
id_clase int primary key not null identity,
clase varchar(50) not null
);

CREATE TABLE modelo(
id_modelo int primary key not null identity,
modelo varchar(50) not null
);

alter table dispositivo_medico
add constraint FK_dispositivo_medico_tipo
foreign key (id_tipo) references tipo (id_tipo);

alter table dispositivo_medico
add constraint FK_dispositivo_medico_clase
foreign key (id_clase) references clase (id_clase);

alter table dispositivo_medico
add constraint FK_dispositivo_medico_modelo
foreign key (id_modelo) references modelo (id_modelo);

CREATE TABLE accesorio_medico(
id_accesorio int primary key not null identity,
accesorio varchar(50),
num_inventario int not null
);

alter table accesorio_medico
add constraint FK_accesorio_medico_dispositivo_medico
foreign key (num_inventario) references dispositivo_medico (num_inventario);

CREATE TABLE  inspeccion_electrica(
id_inspeccion int primary key not null identity,
fecha_inspeccion date
);

CREATE TABLE Unidad_X_Inspeccion_electrica(
id_unidad int  not null,
id_inspeccion_electrica int not null
);

alter table Unidad_X_Inspeccion_electrica
add  primary key(id_unidad, id_inspeccion_electrica);
alter table Unidad_X_Inspeccion_electrica ADD FOREIGN KEY (id_unidad) REFERENCES unidad(id_unidad);
alter table Unidad_X_Inspeccion_electrica ADD FOREIGN KEY (id_inspeccion_electrica) REFERENCES  inspeccion_electrica(id_inspeccion);

CREATE TABLE Dispositivo_X_Inspeccion_electrica(
num_inventario int  not null,
id_inspeccion_electrica int  not null
);

alter table Dispositivo_X_Inspeccion_electrica
add  PRIMARY KEY(num_inventario, id_inspeccion_electrica);
ALTER TABLE Dispositivo_X_Inspeccion_electrica ADD FOREIGN KEY (num_inventario) REFERENCES dispositivo_medico(num_inventario);
ALTER TABLE Dispositivo_X_Inspeccion_electrica ADD FOREIGN KEY (id_inspeccion_electrica) REFERENCES  inspeccion_electrica(id_inspeccion);

CREATE TABLE prueba_electrica(
id_medicion int primary key not null identity,
valor_medido float not null,
valor_estandar float not null,
observacion varchar(50),
id_nombre_prueba int not null,
id_parametro_electrico int not null,
id_inspeccion int not null
);

CREATE TABLE nombre_prueba_electrica(
	id_nombre int primary key not null identity,
	nombre_prueba varchar(100)
);

CREATE TABLE parametro_electrico(
id_parametro int primary key not null identity,
nombre varchar(300) not null
);

alter table prueba_electrica
add foreign key (id_parametro_electrico) references parametro_electrico(id_parametro);

alter table prueba_electrica
add foreign key (id_inspeccion) references inspeccion_electrica(id_inspeccion);

alter table prueba_electrica
add foreign key (id_nombre_prueba) references nombre_prueba_electrica(id_nombre);

CREATE TABLE equipo_trabajo(
id_equipo int primary key not null identity,
nombre varchar(50)
);

CREATE TABLE Inspeccion_electrica_X_Equipo(
id_inspeccion_electrica int not null,
id_equipo int not null
);

alter table Inspeccion_electrica_X_Equipo
add  PRIMARY KEY(id_inspeccion_electrica, id_equipo);
ALTER TABLE Inspeccion_electrica_X_Equipo ADD FOREIGN KEY (id_equipo) REFERENCES equipo_trabajo(id_equipo);
ALTER TABLE Inspeccion_electrica_X_Equipo ADD FOREIGN KEY (id_inspeccion_electrica) REFERENCES  inspeccion_electrica(id_inspeccion);

CREATE TABLE inspeccion_comun(
id_inspeccion int primary key not null identity,
responsable varchar(50) not null,
observacion varchar(50),
conclusion varchar(50),
fecha_inspeccion date,
id_tipo int not null,
);

CREATE TABLE tipo_inspeccion(
id_tipo int primary key not null identity,
tipo_inspeccion varchar(50) not null
);

CREATE TABLE medicion_receptaculo(
id_medicion int primary key not null identity,
valor_estandar float,
id_parametro_receptaculo int not null,
id_inspeccion int not null
);

CREATE TABLE valor_medido(
id_valor int primary key not null identity,
valor_medido float not null,
id_medicion int not null
);

CREATE TABLE parametro_receptaculo(
id_parametro int primary key not null identity,
nombre varchar(50)
);

ALTER TABLE medicion_receptaculo ADD FOREIGN KEY (id_parametro_receptaculo) REFERENCES parametro_receptaculo(id_parametro);
ALTER TABLE medicion_receptaculo ADD FOREIGN KEY (id_inspeccion) REFERENCES inspeccion_comun(id_inspeccion);
ALTER TABLE valor_medido ADD FOREIGN KEY (id_medicion) REFERENCES medicion_receptaculo(id_medicion);
ALTER TABLE inspeccion_comun ADD FOREIGN KEY (id_tipo) REFERENCES tipo_inspeccion(id_tipo);

CREATE TABLE Unidad_x_Inspeccion_comun(
id_inspeccion_comun int not null,
id_unidad int not null
);

alter table Unidad_x_Inspeccion_comun
add  PRIMARY KEY(id_inspeccion_comun, id_unidad);
ALTER TABLE Unidad_x_Inspeccion_comun ADD FOREIGN KEY (id_inspeccion_comun) REFERENCES inspeccion_comun(id_inspeccion);
ALTER TABLE Unidad_x_Inspeccion_comun ADD FOREIGN KEY (id_unidad) REFERENCES  unidad(id_unidad);

CREATE TABLE medicion_ambiental(
id_medicion int primary key not null identity,
valor_medido float not null,
valor_estandar varchar(50),
id_parametro_ambiental int not null,
id_inspeccion int not null
);

CREATE TABLE parametro_ambiental(
id_parametro int primary key not null identity,
nombre varchar(50)
);

ALTER TABLE medicion_ambiental ADD FOREIGN KEY (id_parametro_ambiental) REFERENCES  parametro_ambiental(id_parametro);
ALTER TABLE medicion_ambiental ADD FOREIGN KEY (id_inspeccion) REFERENCES  inspeccion_comun(id_inspeccion);

CREATE TABLE equipo_medicion (
num_inventario int primary key not null identity,
nombre varchar(50),
fecha_calibracion date,
num_serie varchar(50) not null,
certificado_calibracion varchar(50),
id_marca int not null,
id_modelo int not null
);

CREATE TABLE accesorio_medicion(
id_accesorio int primary key not null identity,
accesorio varchar(50),
num_inventario int not null
);

CREATE TABLE modelo_equipo(
id_modelo int primary key not null identity,
modelo varchar(50) not null
);

CREATE TABLE marca_equipo(
id_marca int primary key not null identity,
marca varchar(50) not null
);

ALTER TABLE accesorio_medicion ADD FOREIGN KEY (num_inventario) REFERENCES  equipo_medicion(num_inventario);
ALTER TABLE equipo_medicion ADD FOREIGN KEY (id_modelo) REFERENCES  modelo_equipo(id_modelo);
ALTER TABLE equipo_medicion ADD FOREIGN KEY (id_marca) REFERENCES  marca_equipo(id_marca);

CREATE TABLE Inspeccion_comun_X_Equipo(
id_inspeccion_comun int not null,
num_inventario int not null
);

alter table Inspeccion_comun_X_Equipo
add  PRIMARY KEY(id_inspeccion_comun, num_inventario);
ALTER TABLE Inspeccion_comun_X_Equipo ADD FOREIGN KEY (id_inspeccion_comun) REFERENCES inspeccion_comun(id_inspeccion);
ALTER TABLE Inspeccion_comun_X_Equipo ADD FOREIGN KEY (num_inventario) REFERENCES  equipo_medicion(num_inventario);

