--create database objetos_malditos;

use objetos_malditos;

create table objeto(
  id_objeto    int identity(1,1) primary key,
  nombre       varchar(50),
  peligro      varchar(20)
);
create table curador(
  id_curador   int identity(1,1) primary key,
  nombre       varchar(50)
);
create table origen(
  id_origen    int identity(1,1) primary key,
  ubicacion    varchar(50),
  fecha        date
);
create table evento(
  id_evento    int identity(1,1) primary key,
  descripcion  varchar(100),
  fecha        date
);
create table investigacion(
  id_investigacion int identity(1,1) primary key,
  id_objeto        int,
  resumen          varchar(100),
  fecha            date,
  foreign key (id_objeto) references objeto(id_objeto)
);
create table objeto_evento(
  id_oe       int identity(1,1) primary key,
  id_objeto   int,
  id_evento   int,
  foreign key (id_objeto) references objeto(id_objeto),
  foreign key (id_evento) references evento(id_evento)
);
create table curador_objeto(
  id_co       int identity(1,1) primary key,
  id_curador  int,
  id_objeto   int,
  foreign key (id_curador) references curador(id_curador),
  foreign key (id_objeto) references objeto(id_objeto)
);
insert into objeto (nombre, peligro) values
('anillo de lican', 'alto'),
('espejo de la locura', 'medio'),
('daga de la traicion', 'extremo'),
('libro de los lamentos', 'bajo'),
('collar de la sirena', 'medio');
insert into curador (nombre) values
('agente smith'),
('dr. morgana'),
('agente jones');
insert into origen (ubicacion, fecha) values
('bosque a', '2023-01-15'),
('cueva b', '2022-11-20'),
('catacumbas c', '2023-05-10');
insert into evento (descripcion, fecha) values
('manifestacion sombria', '2024-05-10'),
('poltergeist', '2024-05-11'),
('alucinacion', '2024-05-12'),
('posesion', '2024-05-13');
insert into investigacion (id_objeto, resumen, fecha) values
(1, 'primer informe, el anillo parece tener una maldicion', '2024-01-20'),
(3, 'la daga de la traicion esta ligada a un culto', '2024-02-25');
insert into objeto_evento (id_objeto, id_evento) values
(1, 1),
(1, 2),
(2, 3),
(3, 4);
insert into curador_objeto (id_curador, id_objeto) values
(1, 1),
(1, 2),
(2, 3),
(3, 4);


-- nuevas inserciones

insert into objeto (nombre, peligro) values
('mascara de las sombras', 'alto'),
('craneo del oraculo', 'extremo'),
('caja del olvido', 'medio'),
('amuletos de la peste', 'bajo'),
('espada de fuego eterno', 'extremo');

insert into curador (nombre) values
('profesor darko'),
('hermana isabel'),
('capitan rojas'),
('sor clara'),
('dr. vega'),
('maestro leon'),
('sra. blanca');

insert into origen (ubicacion, fecha) values
('templo olvidado', '2021-07-12'),
('mina abandonada', '2020-09-22'),
('ruinas del sur', '2019-04-15'),
('pantano negro', '2023-08-03'),
('valle de los ecos', '2021-11-11'),
('castillo derruido', '2022-06-18'),
('aldea fantasma', '2024-01-01');

insert into evento (descripcion, fecha) values
('aparicion espectral', '2024-05-14'),
('susurros nocturnos', '2024-05-15'),
('explosion de energia', '2024-05-16'),
('llanto de niño', '2024-05-17'),
('sombras errantes', '2024-05-18'),
('gritos en la niebla', '2024-05-19');

insert into investigacion (id_objeto, resumen, fecha) values
(2, 'el espejo genera visiones perturbadoras', '2024-03-10'),
(4, 'el libro altera los sueños de los lectores', '2024-04-12'),
(5, 'el collar produce cantos al acercarse al agua', '2024-05-05'),
(6, 'la mascara libera entidades hostiles', '2024-06-01'),
(7, 'el craneo parece comunicar mensajes ocultos', '2024-06-15'),
(8, 'la caja genera perdidas de memoria', '2024-07-01'),
(9, 'los amuletos provocan fiebres repentinas', '2024-07-10'),
(10, 'la espada emite calor aun sin fuego', '2024-08-01');

insert into objeto_evento (id_objeto, id_evento) values
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 9),
(9, 10),
(10, 1),
(2, 4),
(3, 2),
(5, 3);

insert into curador_objeto (id_curador, id_objeto) values
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(2, 9),
(3, 10),
(1, 6),
(2, 7),
(3, 8),
(4, 9);


-------




/*
select * from objeto;
select * from curador;
select * from origen;
select * from evento;
select * from investigacion;
select * from objeto_evento;
select * from curador_objeto;
select c.nombre, o.nombre
from curador_objeto as co
inner join curador as c on co.id_curador=c.id_curador
inner join objeto as o on co.id_objeto=o.id_objeto;
select o.nombre, e.descripcion
from objeto o
left join objeto_evento oe on o.id_objeto=oe.id_objeto
left join evento e on oe.id_evento=e.id_evento;
select c.nombre, o.nombre
from curador c
right join curador_objeto co on c.id_curador=co.id_curador
right join objeto o on co.id_objeto=o.id_objeto;
select o.nombre, count(oe.id_evento) as total_eventos
from objeto o
left join objeto_evento oe on o.id_objeto=oe.id_objeto
group by o.nombre;
select o.nombre, count(i.id_investigacion) as total_invest
from objeto o
join investigacion i on o.id_objeto=i.id_objeto
group by o.nombre;
select avg(cast(t.cnt as decimal)) as avg_eventos from (
  select count(*) as cnt
  from objeto_evento
  group by id_objeto
) t;
select nombre, cnt from (
  select o.nombre, count(oe.id_evento) as cnt
  from objeto o
  join objeto_evento oe on o.id_objeto=oe.id_objeto
  group by o.nombre
) sub
where cnt = (
  select max(cnt) from (
    select count(*) as cnt
    from objeto_evento
    group by id_objeto
  ) sub2
);
select nombre, cnt from (
  select o.nombre, count(oe.id_evento) as cnt
  from objeto o
  join objeto_evento oe on o.id_objeto=oe.id_objeto
  group by o.nombre
) sub
where cnt = (
  select min(cnt) from (
    select count(*) as cnt
    from objeto_evento
    group by id_objeto
  ) sub2
);
select o.nombre, o.peligro from objeto as o
union
select o.nombre, i.resumen from objeto as o
left join investigacion as i on o.id_objeto = i.id_objeto
where i.resumen is not null;
update objeto set peligro = 'bajo' where id_objeto = 1;
delete from objeto where id_objeto = 4;
*/