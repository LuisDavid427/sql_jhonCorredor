--create database conjunto_residencial;
use conjunto_residencial;

create table apartamento (
    id_apartamento int identity(1,1) primary key,
    numero varchar(10),
    torre varchar(5),
    piso int
);
create table residente (
    id_residente int identity(1,1) primary key,
    nombre varchar(100),
    telefono varchar(20),
    correo varchar(100)
);
create table parqueadero (
    id_parqueadero int identity(1,1) primary key,
    numero varchar(10),
    tipo varchar(20),
    id_apartamento int unique,
    foreign key (id_apartamento) references apartamento(id_apartamento)
);
create table pago (
    id_pago int identity(1,1) primary key,
    id_residente int,
    fecha date,
    concepto varchar(100),
    valor decimal(10,2),
    foreign key (id_residente) references residente(id_residente)
);
create table visita (
    id_visita int identity(1,1) primary key,
    nombre varchar(100),
    cedula varchar(15)
);
create table apartamento_residente (
    id_apart_res int identity(1,1) primary key,
    id_apartamento int,
    id_residente int,
    fecha_inicio date,
    foreign key (id_apartamento) references apartamento(id_apartamento),
    foreign key (id_residente) references residente(id_residente)
);
create table registro_visita (
    id_registro int identity(1,1) primary key,
    id_visita int,
    id_apartamento int,
    fecha date,
    foreign key (id_visita) references visita(id_visita),
    foreign key (id_apartamento) references apartamento(id_apartamento)
);
insert into apartamento (numero, torre, piso) values
('101', 'A', 1),
('202', 'B', 2),
('303', 'C', 3);
insert into residente (nombre, telefono, correo) values
('Carlos Ruiz', '3101234567', 'carlos.ruiz@email.com'),
('Ana López', '3209876543', 'ana.lopez@email.com'),
('Juan Pérez', '3155554444', 'juan.perez@email.com');
insert into parqueadero (numero, tipo, id_apartamento) values
('P01', 'Cubierto', 1),
('P02', 'Descubierto', 2);
insert into pago (id_residente, fecha, concepto, valor) values
(1, '2024-05-01', 'Administración', 150000.00),
(2, '2024-05-02', 'Parqueadero', 50000.00),
(3, '2024-05-03', 'Administración', 150000.00),
(1, '2024-06-01', 'Administración', 150000.00),
(2, '2024-06-02', 'Parqueadero', 50000.00),
(3, '2024-06-03', 'Administración', 150000.00);
insert into visita (nombre, cedula) values
('Luisa', '10101010'),
('Mario', '20202020'),
('Fernanda', '30303030');
insert into apartamento_residente (id_apartamento, id_residente, fecha_inicio) values
(1, 1, '2023-01-15'),
(2, 2, '2022-11-20'),
(3, 3, '2023-05-10');
insert into registro_visita (id_visita, id_apartamento, fecha) values
(1, 1, '2024-05-10'),
(2, 1, '2024-05-11'),
(3, 2, '2024-05-12');


--nuevas inserciones

insert into apartamento (numero, torre, piso) values
('404', 'D', 4),
('505', 'E', 5),
('606', 'F', 6),
('707', 'G', 7),
('808', 'H', 8),
('909', 'I', 9),
('1001', 'J', 10);

insert into residente (nombre, telefono, correo) values
('Laura Martínez', '3112223333', 'laura.martinez@email.com'),
('Pedro Gómez', '3124445555', 'pedro.gomez@email.com'),
('María Torres', '3136667777', 'maria.torres@email.com'),
('Andrés Vargas', '3148889999', 'andres.vargas@email.com'),
('Sofía Herrera', '3150001111', 'sofia.herrera@email.com'),
('Felipe Castro', '3162223333', 'felipe.castro@email.com'),
('Gabriela Ríos', '3174445555', 'gabriela.rios@email.com');

insert into parqueadero (numero, tipo, id_apartamento) values
('P03', 'Cubierto', 3),
('P04', 'Descubierto', 4),
('P05', 'Cubierto', 5),
('P06', 'Descubierto', 6),
('P07', 'Cubierto', 7),
('P08', 'Descubierto', 8),
('P09', 'Cubierto', 9),
('P10', 'Descubierto', 10);

insert into pago (id_residente, fecha, concepto, valor) values
(4, '2024-07-01', 'Administración', 150000.00),
(5, '2024-07-02', 'Parqueadero', 50000.00),
(6, '2024-07-03', 'Administración', 150000.00),
(7, '2024-07-04', 'Administración', 150000.00);

insert into visita (nombre, cedula) values
('Andrés', '40404040'),
('Camila', '50505050'),
('Jorge', '60606060'),
('Valentina', '70707070'),
('Raúl', '80808080'),
('Esteban', '90909090'),
('Claudia', '100100100');

insert into apartamento_residente (id_apartamento, id_residente, fecha_inicio) values
(4, 4, '2023-06-15'),
(5, 5, '2023-07-20'),
(6, 6, '2023-08-10'),
(7, 7, '2023-09-05'),
(8, 8, '2023-10-01'),
(9, 9, '2023-11-12'),
(10, 10, '2023-12-25');

insert into registro_visita (id_visita, id_apartamento, fecha) values
(4, 3, '2024-05-13'),
(5, 4, '2024-05-14'),
(6, 5, '2024-05-15'),
(7, 6, '2024-05-16'),
(8, 7, '2024-05-17'),
(9, 8, '2024-05-18'),
(10, 9, '2024-05-19');
----------


/*
select * from apartamento;
select * from residente;
select * from parqueadero;
select * from pago;
select * from visita;
select * from apartamento_residente;
select * from registro_visita;
select r.nombre as residente, a.numero as apartamento
from residente as r
inner join apartamento_residente as ar on r.id_residente = ar.id_residente
inner join apartamento as a on ar.id_apartamento = a.id_apartamento;
select r.nombre as residente, p.numero as parqueadero
from residente as r
right join apartamento_residente as ar on r.id_residente = ar.id_residente
right join apartamento as a on ar.id_apartamento = a.id_apartamento
right join parqueadero as p on a.id_apartamento = p.id_apartamento;
select v.nombre as visitante, a.numero as apartamento, rv.fecha
from registro_visita as rv
right join visita as v on rv.id_visita = v.id_visita
left join apartamento as a on rv.id_apartamento = a.id_apartamento;
select sum(valor) as total_recaudado from pago;
select avg(distinct valor) as promedio_distinto from pago;
select count(distinct concepto) as conceptos_distintos from pago;
select r.nombre, max(p.valor) as mayor_pago
from pago as p
inner join residente as r on p.id_residente = r.id_residente
group by r.nombre;
select r.nombre, p.valor
from pago as p
inner join residente as r on p.id_residente = r.id_residente
where p.valor = (select min(valor) from pago);
select a.numero as apartamento, count(rv.id_registro) as total_visitas
from apartamento as a
left join registro_visita as rv on a.id_apartamento = rv.id_apartamento
group by a.numero;
select nombre
from residente
where id_residente in (
    select id_residente
    from pago
    where valor > 140000
);
select nombre, valor
from pago
where valor between 100000 and 200000;
select
    p.nombre as parqueadero,
    a.numero as apartamento,
    r.nombre as residente
from parqueadero as p
inner join apartamento as a on p.id_apartamento = a.id_apartamento
inner join apartamento_residente as ar on a.id_apartamento = ar.id_apartamento
inner join residente as r on ar.id_residente = r.id_residente;
update residente set telefono = '3101234568' where id_residente = 1;
update pago set valor = 160000.00 where id_pago = 1;
delete from visita where id_visita = 1;
delete from apartamento where id_apartamento = 3;
*/