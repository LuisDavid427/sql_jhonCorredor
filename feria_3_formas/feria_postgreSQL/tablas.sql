create table log (
    id_log serial primary key,
    tabla varchar(60),
    sentencia varchar(20),
    usuario varchar(100),
    fecha timestamp without time zone default current_timestamp,
    datos_old text,
    datos_new text
);

create table feria(
    id_feria serial primary key,
    nombre varchar(60),
    descripcion text
);

create table tematica(
    id_tematica serial primary key,
    tematica varchar(20)
);

create table pabellon(
    id_pabellon serial primary key,
    nombre varchar (60),
    id_tematica int,
    id_feria int,
    foreign key (id_tematica) references tematica(id_tematica),
    foreign key (id_feria) references feria(id_feria)
);

create table empresa(
    id_empresa serial primary key,
    nombre_empresa varchar (80),
    descripcion text
);

create table stand (
    id_stand serial primary key,
    nombre_stand varchar (80),
    id_pabellon int,
    id_empresa int,
    foreign key (id_pabellon) references pabellon(id_pabellon),
    foreign key (id_empresa) references empresa (id_empresa)
);

create table producto (
    id_producto serial primary key,
    nombre_producto varchar(60),
    id_stand int,
    foreign key (id_stand) references stand (id_stand)
);

create table persona(
    id_persona serial primary key,
    nombre varchar (70),
    dni varchar (12),
    telefono varchar (13)
);

create table responsable (
    id_responsable serial primary key,
    id_producto int,
    id_persona int,
    foreign key (id_producto) references producto (id_producto),
    foreign key (id_persona) references persona (id_persona)
);

create table ponente(
    id_ponente serial primary key,
    id_persona int,
    foreign key (id_persona) references persona (id_persona)
);

create table tipo_visitante(
    id_tipo serial primary key,
    tipo varchar (20)
);

create table visitante(
    id_visitante serial primary key,
    id_persona int,
    id_tipo int,
    foreign key (id_persona) references persona (id_persona),
    foreign key (id_tipo) references tipo_visitante (id_tipo)
);

create table charla (
    id_charla serial primary key,
    nombre_charla varchar (80),
    descripcion text
);

create table demostracion (
    id_demostracion serial primary key,
    nombre_demostracion varchar (80),
    descripcion text
);

create table registro(
    id_registro serial primary key,
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

