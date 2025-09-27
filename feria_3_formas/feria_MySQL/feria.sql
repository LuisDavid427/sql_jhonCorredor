create database feria;
use feria;
create table feria(
    id_feria int primary key auto_increment,
    nombre varchar(60),
    descripcion text
);

create table tematica(
    id_tematica int primary key auto_increment,
    tematica varchar(20)
);

create table pabellon(
    id_pabellon int primary key auto_increment,
    nombre varchar (60),
    id_tematica int,
    id_feria int,
    foreign key (id_tematica) references tematica(id_tematica),
    foreign key (id_feria) references feria(id_feria)
);

create table empresa(
    id_empresa int primary key auto_increment,
    nombre_empresa varchar (80),
    descripcion text
);

create table stand (
    id_stand int primary key auto_increment,
    nombre_stand varchar (80),
    id_pabellon int,
    id_empresa int,
    foreign key (id_pabellon) references pabellon(id_pabellon),
    foreign key (id_empresa) references empresa (id_empresa)
);

create table producto (
    id_producto int primary key auto_increment,
    nombre_producto varchar(60),
    id_stand int,
    foreign key (id_stand) references stand (id_stand)
);

create table persona(
    id_persona int primary key auto_increment,
    nombre varchar (70),
    dni varchar (12),
    telefono varchar (13)
);

create table responsable (
    id_responsable int primary key auto_increment,
    id_producto int,
    id_persona int,
    foreign key (id_producto) references producto (id_producto),
    foreign key (id_persona) references persona (id_persona)
);

create table ponente(
    id_ponente int primary key auto_increment,
    id_persona int,
    foreign key (id_persona) references persona (id_persona)
);

create table tipo_visitante(
    id_tipo int primary key auto_increment,
    tipo varchar (20)
);

create table visitante(
    id_visitante int primary key auto_increment,
    id_persona int,
    id_tipo int,
    foreign key (id_persona) references persona (id_persona),
    foreign key (id_tipo) references tipo_visitante (id_tipo)
);

create table charla (
    id_charla int primary key auto_increment,
    nombre_charla varchar (80),
    descripcion text
);

create table demostracion (
    id_demostracion int primary key auto_increment,
    nombre_demostracion varchar (80),
    descripcion text
);

create table registro(
    id_registro int primary key auto_increment,
    id_feria int,
    id_stand int,
    id_empresa int,
    id_charla int default null,
    id_demostracion int default null,
    id_ponente int,
    id_visitante int,
    foreign key (id_feria) references feria(id_feria),
    foreign key (id_empresa) references empresa (id_empresa),
    foreign key (id_stand) references stand (id_stand),
    foreign key (id_charla) references charla (id_charla),
    foreign key (id_demostracion) references demostracion (id_demostracion),
    foreign key (id_ponente) references ponente (id_ponente),
    foreign key (id_visitante) references visitante (id_visitante)
);

create table log (
    id_log int primary key auto_increment,
    tabla varchar(60),
    sentencia varchar(20),
    usuario varchar(100),
    fecha datetime,
    datos_old text,
    datos_new text
);