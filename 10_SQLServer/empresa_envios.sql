--create database empresa_envios;
use empresa_envios;
create table cliente (
    id_cliente int identity(1,1) primary key,
    nombre varchar(100),
    telefono varchar(20),
    direccion varchar(150)
);
create table paquete (
    id_paquete int identity(1,1) primary key,
    descripcion varchar(150),
    peso decimal(5,2),
    dimensiones varchar(50)
);
create table repartidor (
    id_repartidor int identity(1,1) primary key,
    nombre varchar(100),
    zona varchar(50)
);
create table ruta (
    id_ruta int identity(1,1) primary key,
    origen varchar(100),
    destino varchar(100),
    distancia_km decimal(6,2)
);
create table estado_envio (
    id_estado int identity(1,1) primary key,
    descripcion varchar(50)
);
create table envio (
    id_envio int identity(1,1) primary key,
    id_cliente int,
    id_paquete int,
    id_repartidor int,
    id_ruta int,
    id_estado int,
    fecha_envio datetime,
    fecha_entrega datetime,
    foreign key (id_cliente) references cliente(id_cliente),
    foreign key (id_paquete) references paquete(id_paquete),
    foreign key (id_repartidor) references repartidor(id_repartidor),
    foreign key (id_ruta) references ruta(id_ruta),
    foreign key (id_estado) references estado_envio(id_estado)
);
create table repartidor_ruta (
    id_repartidor int,
    id_ruta int,
    primary key (id_repartidor, id_ruta),
    foreign key (id_repartidor) references repartidor(id_repartidor),
    foreign key (id_ruta) references ruta(id_ruta)
);
insert into cliente (nombre, telefono, direccion) values
('cliente a', '3101234567', 'calle 10 # 5-20'),
('cliente b', '3209876543', 'avenida 15 # 2-30');
insert into paquete (descripcion, peso, dimensiones) values
('documentos importantes', 0.50, 'a4'),
('caja de zapatos', 1.50, '30x20x10'),
('televisor 55 pulgadas', 25.00, '120x80x10');
insert into repartidor (nombre, zona) values
('juan', 'centro'),
('maria', 'norte');
insert into ruta (origen, destino, distancia_km) values
('bogota', 'medellin', 420.00),
('cali', 'bogota', 300.50);
insert into estado_envio (descripcion) values
('en transito'),
('entregado'),
('en espera');
insert into envio (id_cliente, id_paquete, id_repartidor, id_ruta, id_estado, fecha_envio, fecha_entrega) values
(1, 1, 1, 1, 1, '2024-05-01 10:00:00', null),
(2, 2, 2, 2, 2, '2024-04-28 15:30:00', '2024-04-30 11:00:00');
insert into repartidor_ruta (id_repartidor, id_ruta) values
(1, 1),
(1, 2),
(2, 2);


-- nuevas inserciones


insert into cliente (nombre, telefono, direccion) values
('cliente c', '3111111111', 'carrera 8 # 12-45'),
('cliente d', '3122222222', 'calle 22 # 7-10'),
('cliente e', '3133333333', 'transversal 5 # 3-15'),
('cliente f', '3144444444', 'diagonal 9 # 6-25'),
('cliente g', '3155555555', 'carrera 10 # 8-50'),
('cliente h', '3166666666', 'avenida 3 # 1-60'),
('cliente i', '3177777777', 'calle 18 # 4-70'),
('cliente j', '3188888888', 'carrera 15 # 9-80');

insert into paquete (descripcion, peso, dimensiones) values
('libros universitarios', 3.20, '40x30x15'),
('computadora portátil', 2.50, '35x25x5'),
('bicicleta plegable', 12.00, '100x60x30'),
('juguetes variados', 4.75, '50x40x20'),
('maleta de viaje', 8.90, '70x50x25'),
('equipo de sonido', 15.30, '80x60x40'),
('herramientas mecánicas', 6.40, '45x35x20');

insert into repartidor (nombre, zona) values
('carlos', 'sur'),
('laura', 'occidente'),
('andres', 'oriente'),
('paula', 'centro'),
('diego', 'norte'),
('sandra', 'sur'),
('felipe', 'occidente'),
('camila', 'oriente');

insert into ruta (origen, destino, distancia_km) values
('barranquilla', 'cartagena', 120.00),
('manizales', 'pereira', 90.50),
('ibague', 'neiva', 210.75),
('villavicencio', 'bogota', 86.40),
('cucuta', 'bucaramanga', 190.00),
('pasto', 'popayan', 250.60),
('tunja', 'sogamoso', 75.30),
('armenia', 'calarca', 15.20);

insert into estado_envio (descripcion) values
('cancelado'),
('devuelto'),
('reprogramado'),
('extraviado'),
('en aduana'),
('retenido'),
('en revisión');

insert into envio (id_cliente, id_paquete, id_repartidor, id_ruta, id_estado, fecha_envio, fecha_entrega) values
(3, 3, 3, 3, 3, '2024-05-02 09:00:00', null),
(4, 4, 4, 4, 1, '2024-05-03 14:15:00', '2024-05-05 10:00:00'),
(5, 5, 5, 5, 2, '2024-05-04 11:30:00', null),
(6, 6, 6, 6, 3, '2024-05-05 08:45:00', '2024-05-06 13:20:00'),
(7, 7, 7, 7, 1, '2024-05-06 16:00:00', null),
(8, 1, 8, 8, 2, '2024-05-07 10:10:00', '2024-05-08 09:00:00'),
(9, 2, 1, 1, 3, '2024-05-08 12:00:00', null),
(10, 3, 2, 2, 1, '2024-05-09 15:30:00', '2024-05-10 11:45:00');

insert into repartidor_ruta (id_repartidor, id_ruta) values
(2, 1),
(3, 3),
(3, 4),
(4, 5),
(5, 6),
(6, 7),
(7, 8);


----


/*
select * from cliente;
select * from paquete;
select * from repartidor;
select * from ruta;
select * from estado_envio;
select * from envio;
select * from repartidor_ruta;
select
    c.nombre as cliente,
    p.descripcion as paquete,
    ru.destino as destino,
    rep.nombre as repartidor,
    es.descripcion as estado
from envio as e
inner join cliente as c on e.id_cliente = c.id_cliente
inner join paquete as p on e.id_paquete = p.id_paquete
inner join repartidor as rep on e.id_repartidor = rep.id_repartidor
inner join ruta as ru on e.id_ruta = ru.id_ruta
inner join estado_envio as es on e.id_estado = es.id_estado;
select rep.nombre as repartidor, ru.origen, ru.destino
from repartidor as rep
inner join repartidor_ruta as rr on rep.id_repartidor = rr.id_repartidor
inner join ruta as ru on rr.id_ruta = ru.id_ruta;
select ru.origen, ru.destino, es.descripcion as estado
from envio as e
inner join ruta as ru on e.id_ruta = ru.id_ruta
inner join estado_envio as es on e.id_estado = es.id_estado
union
select ru.origen, ru.destino, rep.nombre as repartidor
from repartidor as rep
left join repartidor_ruta as rr on rep.id_repartidor = rr.id_repartidor
left join ruta as ru on rr.id_ruta = ru.id_ruta;
select sum(p.peso) as peso_total
from paquete as p;
select avg(distinct ru.distancia_km) as promedio_distancia
from ruta as ru;
select count(distinct descripcion) as estados_diferentes
from estado_envio;
select descripcion, peso
from paquete
where peso = (select max(peso) from paquete);
select origen, destino, distancia_km
from ruta
where distancia_km = (select min(distancia_km) from ruta);
select es.descripcion as estado, count(e.id_envio) as cantidad
from envio as e
inner join estado_envio as es on e.id_estado = es.id_estado
group by es.descripcion;
select r.nombre as repartidor, count(rr.id_ruta) as total_rutas
from repartidor as r
inner join repartidor_ruta as rr on r.id_repartidor = rr.id_repartidor
group by r.nombre
having count(rr.id_ruta) > 1;
update cliente set telefono = '3109998877' where id_cliente = 1;
update paquete set peso = 30.50 where id_paquete = 3;
delete from envio where id_envio = 1;
delete from repartidor where id_repartidor = 2;
*/