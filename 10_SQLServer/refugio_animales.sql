--create database refugio_animales;

use refugio_animales;

create table especie (
    id_especie int identity(1,1) primary key,
    nombre_especie varchar(50)
);
create table animal (
    id_animal int identity(1,1) primary key,
    nombre varchar(50),
    edad int,
    sexo varchar(1),
    id_especie int,
    fecha_ingreso date,
    foreign key (id_especie) references especie(id_especie)
);
create table cuidador (
    id_cuidador int identity(1,1) primary key,
    nombre varchar(100),
    telefono varchar(20)
);
create table adoptante (
    id_adoptante int identity(1,1) primary key,
    nombre varchar(100),
    direccion varchar(150),
    telefono varchar(20)
);
create table vacuna (
    id_vacuna int identity(1,1) primary key,
    nombre varchar(100),
    dosis varchar(20)
);
create table animal_cuidador (
    id_relacion int identity(1,1) primary key,
    id_animal int,
    id_cuidador int,
    fecha_asignacion date,
    foreign key (id_animal) references animal(id_animal),
    foreign key (id_cuidador) references cuidador(id_cuidador)
);
create table vacunacion (
    id_vacunacion int identity(1,1) primary key,
    id_animal int,
    id_vacuna int,
    fecha date,
    foreign key (id_animal) references animal(id_animal),
    foreign key (id_vacuna) references vacuna(id_vacuna)
);
create table adopcion (
    id_adopcion int identity(1,1) primary key,
    id_animal int,
    id_adoptante int,
    fecha_adopcion date,
    foreign key (id_animal) references animal(id_animal),
    foreign key (id_adoptante) references adoptante(id_adoptante)
);
insert into especie (nombre_especie) values
('perro'),
('gato'),
('conejo');
insert into animal (nombre, edad, sexo, id_especie, fecha_ingreso) values
('boby', 3, 'm', 1, '2023-01-15'),
('michi', 2, 'f', 2, '2023-02-20'),
('luna', 5, 'f', 1, '2023-03-10'),
('rex', 1, 'm', 1, '2024-07-01');
insert into cuidador (nombre, telefono) values
('carlos', '3101234567'),
('ana', '3209876543');
insert into adoptante (nombre, direccion, telefono) values
('maria', 'calle 1 # 1-1', '3151111111'),
('pedro', 'carrera 2 # 2-2', '3162222222');
insert into vacuna (nombre, dosis) values
('rabia', 'unica'),
('parvovirus', 'refuerzo');
insert into animal_cuidador (id_animal, id_cuidador, fecha_asignacion) values
(1, 1, '2023-01-20'),
(2, 2, '2023-02-25'),
(3, 1, '2023-03-15');
insert into vacunacion (id_animal, id_vacuna, fecha) values
(1, 1, '2023-01-25'),
(1, 2, '2023-02-01'),
(2, 1, '2023-02-28');
insert into adopcion (id_animal, id_adoptante, fecha_adopcion) values
(3, 1, '2023-04-01');

-- nuevas inserciones

insert into especie (nombre_especie) values
('hamster'),
('loro'),
('tortuga'),
('pez'),
('caballo'),
('cobayo'),
('iguana');

insert into animal (nombre, edad, sexo, id_especie, fecha_ingreso) values
('rocky', 4, 'm', 1, '2023-04-12'),
('nina', 1, 'f', 2, '2023-05-18'),
('pelusa', 2, 'f', 3, '2023-06-05'),
('max', 6, 'm', 1, '2023-07-20'),
('toby', 3, 'm', 2, '2023-08-14'),
('sol', 1, 'f', 4, '2023-09-01');

insert into cuidador (nombre, telefono) values
('laura', '3173333333'),
('felipe', '3184444444'),
('sofia', '3195555555'),
('david', '3206666666'),
('camila', '3217777777'),
('jose', '3228888888'),
('andres', '3239999999'),
('juliana', '3240000000');

insert into adoptante (nombre, direccion, telefono) values
('andrea', 'avenida 3 # 4-56', '3171234567'),
('jorge', 'calle 10 # 8-22', '3182345678'),
('claudia', 'carrera 5 # 12-34', '3193456789'),
('ricardo', 'avenida 20 # 15-89', '3204567890'),
('esteban', 'calle 7 # 6-21', '3215678901'),
('paula', 'carrera 30 # 45-67', '3226789012'),
('diana', 'calle 25 # 18-45', '3237890123'),
('mateo', 'avenida 50 # 22-33', '3248901234');

insert into vacuna (nombre, dosis) values
('moquillo', 'unica'),
('hepatitis', 'refuerzo'),
('leptospirosis', 'anual'),
('triple felina', 'refuerzo'),
('tos de las perreras', 'anual'),
('panleucopenia', 'refuerzo'),
('coronavirus', 'anual'),
('calicivirus', 'refuerzo');

insert into animal_cuidador (id_animal, id_cuidador, fecha_asignacion) values
(4, 2, '2024-07-05'),
(5, 3, '2023-08-20'),
(6, 4, '2023-09-10'),
(2, 5, '2023-09-15'),
(1, 6, '2023-09-20'),
(3, 7, '2023-09-25'),
(4, 8, '2023-10-01');

insert into vacunacion (id_animal, id_vacuna, fecha) values
(3, 2, '2023-03-20'),
(4, 3, '2024-07-10'),
(5, 4, '2023-08-25'),
(6, 5, '2023-09-15'),
(2, 6, '2023-10-05'),
(1, 7, '2023-11-01'),
(5, 8, '2023-11-15');

insert into adopcion (id_animal, id_adoptante, fecha_adopcion) values
(1, 2, '2023-05-10'),
(2, 3, '2023-06-15'),
(4, 4, '2024-08-01'),
(5, 5, '2023-09-20'),
(6, 6, '2023-10-10'),
(1, 7, '2023-11-12'),
(2, 8, '2023-12-01'),
(3, 2, '2024-01-05'),
(4, 3, '2024-02-14');


--

/*
select * from especie;
select * from animal;
select * from cuidador;
select * from adoptante;
select * from vacuna;
select * from animal_cuidador;
select * from vacunacion;
select * from adopcion;
select a.nombre as animal, ac.fecha_asignacion, c.nombre as cuidador
from animal as a
inner join animal_cuidador as ac on a.id_animal = ac.id_animal
inner join cuidador as c on ac.id_cuidador = c.id_cuidador;
select an.nombre as animal, ad.nombre as adoptante, ad.direccion
from animal as an
right join adopcion as ad on an.id_animal = ad.id_animal;
select a.nombre as animal, c.nombre as cuidador
from animal as a
left join animal_cuidador as ac on a.id_animal = ac.id_animal
left join cuidador as c on ac.id_cuidador = c.id_cuidador;
select a.nombre as animal, c.nombre as cuidador
from animal as a
left join animal_cuidador as ac on a.id_animal = ac.id_animal
left join cuidador as c on ac.id_cuidador = c.id_cuidador
union
select
    a.nombre as animal,
    c.nombre as cuidador
from cuidador as c
left join animal_cuidador as ac on c.id_cuidador = ac.id_cuidador
left join animal as a on ac.id_animal = a.id_animal;
select
    e.nombre_especie,
    count(a.id_animal) as cantidad
from especie as e
left join animal as a on e.id_especie = a.id_especie
group by e.nombre_especie;
select
    count(*) as total_julio
from animal
where month(fecha_ingreso) = 7;
select
    avg(cast(edad as decimal)) as edad_promedio
from animal;
select
    nombre, edad
from animal
where edad = (select max(edad) from animal);
select
    nombre, edad
from animal
where edad = (select min(edad) from animal);
select count(distinct sexo) as sexos_distintos
from animal;
select nombre
from animal
where id_animal in (
    select id_animal
    from vacunacion
    group by id_animal
    having count(id_vacuna) > 1
);
select nombre from animal where edad > 2 and sexo = 'm';
update animal set edad = 4 where id_animal = 1;
delete from adopcion where id_animal = 3;
*/