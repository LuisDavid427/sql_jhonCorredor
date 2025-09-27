--create database viajes_espaciales;

use viajes_espaciales;

create table astronauta(
  id_astronauta    int identity(1,1) primary key,
  nombre           varchar(50)
);
create table nave(
  id_nave          int identity(1,1) primary key,
  nombre           varchar(50)
);
create table mision(
  id_mision           int identity(1,1) primary key,
  nombre              varchar(50),
  id_nave             int,
  fecha_lanzamiento   date,
  foreign key (id_nave) references nave(id_nave)
);
create table planeta(
  id_planeta  int identity(1,1) primary key,
  nombre       varchar(50),
  tipo         varchar(30)
);
create table reporte(
  id_reporte   int identity(1,1) primary key,
  id_mision    int,
  resumen      varchar(100),
  fecha        date,
  foreign key (id_mision) references mision(id_mision)
);
create table tripulacion(
  id_mision       int,
  id_astronauta   int,
  primary key (id_mision,id_astronauta),
  foreign key (id_mision)     references mision(id_mision),
  foreign key (id_astronauta) references astronauta(id_astronauta)
);
create table mision_planeta(
  id_mp       int identity(1,1) primary key,
  id_mision   int,
  id_planeta  int,
  foreign key (id_mision)  references mision(id_mision),
  foreign key (id_planeta) references planeta(id_planeta)
);
insert into astronauta (nombre) values
('neil armstrong'),
('buzz aldrin'),
('yuri gagarin');
insert into nave (nombre) values
('apollo 11'),
('vostok 1'),
('saturno v');
insert into mision (nombre, id_nave, fecha_lanzamiento) values
('mision apolo', 1, '1969-07-16'),
('mision vostok', 2, '1961-04-12');
insert into planeta (nombre, tipo) values
('marte', 'terrestre'),
('júpiter', 'gaseoso');
insert into reporte (id_mision, resumen, fecha) values
(1, 'alunizaje exitoso', '1969-07-20'),
(2, 'orbitó la tierra', '1961-04-12');
insert into tripulacion (id_mision, id_astronauta) values
(1, 1),
(1, 2),
(2, 3);
insert into mision_planeta (id_mision, id_planeta) values
(1, 1),
(2, 2);

-- nuevas inserciones

insert into astronauta (nombre) values
('valentina tereshkova'),
('chris hadfield'),
('sally ride'),
('john glenn'),
('alan shepard'),
('peggy whitson'),
('mae jemison');


insert into nave (nombre) values
('discovery'),
('endeavour'),
('columbia'),
('challenger'),
('soyuz'),
('dragon'),
('starship');


insert into mision (nombre, id_nave, fecha_lanzamiento) values
('mision discovery', 4, '1984-08-30'),
('mision endeavour', 5, '1992-05-07'),
('mision columbia', 6, '1981-04-12'),
('mision challenger', 7, '1983-04-04'),
('mision soyuz', 8, '1967-04-23'),
('mision dragon', 9, '2020-05-30'),
('mision starship', 10, '2025-01-01'),
('mision marte', 1, '2030-06-15');


insert into planeta (nombre, tipo) values
('venus', 'terrestre'),
('saturno', 'gaseoso'),
('urano', 'gaseoso'),
('neptuno', 'gaseoso'),
('mercurio', 'terrestre'),
('plutón', 'enano'),
('titan', 'luna'),
('europa', 'luna');


insert into reporte (id_mision, resumen, fecha) values
(3, 'primer vuelo del discovery', '1984-08-30'),
(4, 'primer vuelo del endeavour', '1992-05-07'),
(5, 'primer vuelo del columbia', '1981-04-12'),
(6, 'primer vuelo del challenger', '1983-04-04'),
(7, 'primer vuelo de soyuz', '1967-04-23'),
(8, 'primer vuelo del dragon', '2020-05-30'),
(9, 'primer prototipo starship', '2025-01-01'),
(10, 'inicio de la misión a marte', '2030-06-15');


insert into tripulacion (id_mision, id_astronauta) values
(3, 4),
(3, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 9),
(8, 10);


insert into mision_planeta (id_mision, id_planeta) values
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 1),
(10, 2);

--
/*
select * from astronauta;
select * from nave;
select * from mision;
select * from planeta;
select * from reporte;
select * from tripulacion;
select * from mision_planeta;
select m.nombre as mision, n.nombre as nave, m.fecha_lanzamiento
from mision as m
inner join nave as n on m.id_nave = n.id_nave;
select a.nombre as astronauta, m.nombre as mision
from astronauta as a
left join tripulacion as t on a.id_astronauta = t.id_astronauta
left join mision as m on t.id_mision = m.id_mision;
select p.nombre as planeta, m.nombre as mision
from planeta p
right join mision_planeta mp on p.id_planeta = mp.id_planeta
right join mision m          on mp.id_mision   = m.id_mision;
select n.nombre            as nave,
       count(m.id_mision)  as total_misiones
from nave n
left join mision m on n.id_nave = m.id_nave
group by n.nombre;
select m.nombre           as mision,
       count(t.id_mision) as tripulantes
from mision m
join tripulacion t on m.id_mision = t.id_mision
group by m.nombre;
select avg(cast(cnt as decimal)) as promedio_tripulacion from (
  select count(*) as cnt
  from tripulacion
  group by id_mision
) as sub;
select nombre, cnt from (
  select m.nombre, count(*) as cnt
  from mision m
  join tripulacion t on m.id_mision = t.id_mision
  group by m.nombre
) as temp
where cnt = (
  select max(cnt2) from (
    select count(*) as cnt2
    from tripulacion
    group by id_mision
  ) as temp2
);
select nombre, cnt from (
  select m.nombre, count(*) as cnt
  from mision m
  join tripulacion t on m.id_mision = t.id_mision
  group by m.nombre
) as temp
where cnt = (
  select min(cnt2) from (
    select count(*) as cnt2
    from tripulacion
    group by id_mision
  ) as temp2
);
select m.nombre, r.resumen from mision as m
left join reporte as r on m.id_mision = r.id_mision
union
select m.nombre, r.resumen from mision as m
right join reporte as r on m.id_mision = r.id_mision;
update astronauta set nombre = 'alan shepard' where id_astronauta = 3;
delete from reporte where id_reporte = 1;
*/