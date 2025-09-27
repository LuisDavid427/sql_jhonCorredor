-- create database agenciaviajesdb;
use agenciaviajesdb;
create table cliente (
    id_cliente   int identity(1,1) primary key,
    nombre       varchar(100) not null,
    email        varchar(100),
    telefono     varchar(20)
);
create table destino (
    id_destino   int identity(1,1) primary key,
    ciudad       varchar(100) not null,
    pais         varchar(100) not null
);
create table guia (
    id_guia      int identity(1,1) primary key,
    nombre       varchar(100) not null,
    idioma       varchar(50)
);
create table paquete (
    id_paquete      int identity(1,1) primary key,
    nombre          varchar(100) not null,
    precio          decimal(10,2),
    duracion_dias   int,
    id_destino      int,
    id_guia         int,
    foreign key (id_destino)
        references destino(id_destino)
        on delete cascade
        on update cascade,
    foreign key (id_guia)
        references guia(id_guia)
        on delete set null
        on update set null
);
create table actividad (
    id_actividad int identity(1,1) primary key,
    nombre       varchar(100) not null,
    tipo         varchar(50),
    id_paquete   int,
    foreign key (id_paquete)
        references paquete(id_paquete)
        on delete cascade
        on update cascade
);
create table reserva (
    id_reserva   int identity(1,1) primary key,
    fecha        date,
    personas     int,
    id_cliente   int,
    id_paquete   int,
    foreign key (id_cliente)
        references cliente(id_cliente)
        on delete cascade
        on update cascade,
    foreign key (id_paquete)
        references paquete(id_paquete)
        on delete cascade
        on update cascade
);
insert into cliente (nombre, email, telefono) values
('Juan Pérez', 'juan.perez@email.com', '3101234567'),
('María López', 'maria.lopez@email.com', '3129876543'),
('Pedro Gómez', 'pedro.gomez@email.com', '3155555555'),
('Ana Torres', 'ana.torres@email.com', '3201112233');
insert into destino (ciudad, pais) values
('París', 'Francia'),
('Tokio', 'Japón'),
('Cartagena', 'Colombia'),
('Roma', 'Italia'),
('Cancún', 'México');
insert into guia (nombre, idioma) values
('Carlos Rodriguez', 'Español'),
('Sofía Fernandez', 'Inglés'),
('Luis Morales', 'Francés'),
('Erika Zapata', 'Portugués');
insert into paquete (nombre, precio, duracion_dias, id_destino, id_guia) values
('Tour París', 1500.00, 7, 1, 1),
('Explora Tokio', 2500.00, 10, 2, 2),
('Cartagena Histórica', 800.00, 4, 3, 1),
('Aventura Maya', 1200.00, 5, 5, 2),
('Tour de la Torre Eiffel', 350.00, 1, 1, 3);
insert into actividad (nombre, tipo, id_paquete) values
('Museo del Louvre', 'Cultural', 1),
('Torre Eiffel', 'Turístico', 1),
('Templo Senso-ji', 'Cultural', 2),
('Muralla de Cartagena', 'Histórico', 3),
('Tour en Barco', 'Aventura', 3),
('Chichén Itzá', 'Arqueológico', 4),
('Coliseo Romano', 'Histórico', null);
insert into reserva (fecha, personas, id_cliente, id_paquete) values
('2024-05-15', 2, 1, 1),
('2024-06-20', 4, 2, 3),
('2024-07-10', 1, 3, 2),
('2024-08-01', 3, 4, 4),
('2024-05-16', 2, 1, 1),
('2024-06-21', 4, 2, 3),
('2024-07-11', 1, 3, 2);


-- inerciones nuevas
insert into cliente (nombre, email, telefono) values
('Lucía Ramírez', 'lucia.ramirez@email.com', '3112223344'),
('Andrés Castaño', 'andres.castano@email.com', '3144445566'),
('Valentina Silva', 'valentina.silva@email.com', '3197778899'),
('Diego Herrera', 'diego.herrera@email.com', '3001239876'),
('Camila Duarte', 'camila.duarte@email.com', '3136547890'),
('Mateo Vargas', 'mateo.vargas@email.com', '3128529637');

insert into destino (ciudad, pais) values
('Nueva York', 'Estados Unidos'),
('Londres', 'Reino Unido'),
('Buenos Aires', 'Argentina'),
('Sídney', 'Australia'),
('El Cairo', 'Egipto');

insert into guia (nombre, idioma) values
('Miguel Álvarez', 'Alemán'),
('Laura Castro', 'Japonés'),
('Fernando Ruiz', 'Italiano'),
('Patricia Gómez', 'Inglés'),
('Hugo Martínez', 'Español');

insert into paquete (nombre, precio, duracion_dias, id_destino, id_guia) values
('Ruta Nueva York', 2000.00, 6, 6, 4),
('Londres Histórico', 1800.00, 5, 7, 5),
('Descubre Buenos Aires', 950.00, 4, 8, 1),
('Aventura en Sídney', 2200.00, 8, 9, 2),
('Misterios de Egipto', 2700.00, 9, 10, 3);

insert into actividad (nombre, tipo, id_paquete) values
('Estatua de la Libertad', 'Turístico', 6),
('Museo Británico', 'Cultural', 7),
('Caminata por Caminito', 'Cultural', 8),
('Opera House', 'Arquitectónico', 9),
('Pirámides de Giza', 'Arqueológico', 10),
('Safari en desierto', 'Aventura', 10),
('Puente de la Torre', 'Turístico', 7),
('Museo de Arte Moderno', 'Cultural', 6),
('Nado con delfines', 'Aventura', 9),
('Cementerio de la Recoleta', 'Histórico', 8);

insert into reserva (fecha, personas, id_cliente, id_paquete) values
('2024-09-05', 2, 5, 6),
('2024-09-15', 3, 6, 7),
('2024-10-01', 1, 7, 8),
('2024-10-12', 4, 8, 9),
('2024-11-03', 5, 9, 10),
('2024-09-06', 2, 10, 6),
('2024-09-16', 3, 5, 7),
('2024-10-02', 1, 6, 8),
('2024-10-13', 4, 7, 9),
('2024-11-04', 5, 8, 10);


----