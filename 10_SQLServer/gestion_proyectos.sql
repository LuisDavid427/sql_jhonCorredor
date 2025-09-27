--create database gestion_proyectos;

use gestion_proyectos;

create table usuario (
  id_usuario int identity(1,1) primary key,
  nombre     varchar(50) not null
);
create table proyecto (
  id_proyecto int identity(1,1) primary key,
  nombre      varchar(50) not null
);
create table equipo (
  id_equipo int identity(1,1) primary key,
  nombre    varchar(50) not null
);
create table tarea (
  id_tarea    int identity(1,1) primary key,
  id_proyecto int not null,
  titulo      varchar(100) not null,
  estado      varchar(30) default 'pendiente',
  foreign key (id_proyecto) references proyecto(id_proyecto) on delete cascade
);
create table registro_tiempo (
  id_registro int identity(1,1) primary key,
  id_tarea    int not null,
  id_usuario  int not null,
  horas       decimal(4,2) not null,
  foreign key (id_tarea) references tarea(id_tarea) on delete cascade,
  foreign key (id_usuario) references usuario(id_usuario) on delete cascade
);
create table equipo_usuario (
  id_equipo  int not null,
  id_usuario int not null,
  primary key (id_equipo, id_usuario),
  foreign key (id_equipo) references equipo(id_equipo) on delete cascade,
  foreign key (id_usuario) references usuario(id_usuario) on delete cascade
);
create table proyecto_equipo (
  id_proyecto int not null,
  id_equipo   int not null,
  primary key (id_proyecto, id_equipo),
  foreign key (id_proyecto) references proyecto(id_proyecto) on delete cascade,
  foreign key (id_equipo) references equipo(id_equipo) on delete cascade
);
insert into usuario (nombre) values
('juan'),
('maria'),
('pedro');
insert into proyecto (nombre) values
('proyecto a'),
('proyecto b');
insert into equipo (nombre) values
('equipo 1'),
('equipo 2');
insert into tarea (id_proyecto, titulo, estado) values
(1, 'diseñar interfaz', 'en progreso'),
(1, 'desarrollar backend', 'pendiente'),
(2, 'crear base de datos', 'finalizada');
insert into registro_tiempo (id_tarea, id_usuario, horas) values
(1, 1, 8.50),
(1, 2, 6.00),
(2, 1, 4.00),
(3, 3, 10.00),
(3, 1, 2.00);
insert into equipo_usuario (id_equipo, id_usuario) values
(1, 1),
(1, 2),
(2, 3);
insert into proyecto_equipo (id_proyecto, id_equipo) values
(1, 1),
(2, 2);

-- nuevas inserciones
insert into usuario (nombre) values
('carlos'),
('laura'),
('sofia'),
('andres'),
('valentina'),
('camilo'),
('paola');

insert into proyecto (nombre) values
('proyecto c'),
('proyecto d'),
('proyecto e'),
('proyecto f'),
('proyecto g'),
('proyecto h'),
('proyecto i'),
('proyecto j');

insert into equipo (nombre) values
('equipo 3'),
('equipo 4'),
('equipo 5'),
('equipo 6'),
('equipo 7'),
('equipo 8'),
('equipo 9'),
('equipo 10');

insert into tarea (id_proyecto, titulo, estado) values
(1, 'documentar requisitos', 'pendiente'),
(2, 'pruebas unitarias', 'en progreso'),
(3, 'maquetar landing page', 'pendiente'),
(4, 'optimizar consultas SQL', 'finalizada'),
(5, 'configurar servidor', 'pendiente'),
(6, 'crear API rest', 'en progreso'),
(7, 'revisión de código', 'pendiente');

insert into registro_tiempo (id_tarea, id_usuario, horas) values
(4, 4, 3.50),
(5, 5, 6.25),
(6, 6, 7.00),
(7, 7, 5.75),
(2, 2, 2.50);

insert into equipo_usuario (id_equipo, id_usuario) values
(2, 4),
(3, 5),
(4, 6),
(5, 7),
(6, 1),
(7, 2),
(8, 3);

insert into proyecto_equipo (id_proyecto, id_equipo) values
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

----------------
/*
select * from usuario;
select * from proyecto;
select * from equipo;
select * from tarea;
select * from registro_tiempo;
select * from equipo_usuario;
select * from proyecto_equipo;
select u.nombre as usuario, p.nombre as proyecto
from usuario as u
join registro_tiempo as rt on u.id_usuario = rt.id_usuario
join tarea as t on rt.id_tarea = t.id_tarea
join proyecto as p on t.id_proyecto = p.id_proyecto
where u.nombre = 'juan';
select u.nombre as usuario, e.nombre as equipo
from usuario u
left join equipo_usuario eu on u.id_usuario = eu.id_usuario
left join equipo e on eu.id_equipo = e.id_equipo;
select p.nombre as proyecto, count(t.id_tarea) as total_tareas
from proyecto p
left join tarea t on p.id_proyecto = t.id_proyecto
group by p.nombre;
select p.nombre as proyecto, sum(rt.horas) as horas_totales
from proyecto p
join tarea t on p.id_proyecto = t.id_proyecto
join registro_tiempo rt on t.id_tarea = rt.id_tarea
group by p.nombre;
select t.titulo as tarea, avg(rt.horas) as horas_promedio
from tarea t
join registro_tiempo rt on t.id_tarea = rt.id_tarea
group by t.titulo;
select top 1 t.titulo, max(rt.horas) as max_horas
from tarea t
join registro_tiempo rt on t.id_tarea = rt.id_tarea
group by t.titulo
order by max_horas desc;
select top 1 with ties e.nombre, count(eu.id_usuario) as miembros
from equipo e
join equipo_usuario eu on e.id_equipo = eu.id_equipo
group by e.nombre
order by miembros desc;
update usuario set nombre = 'juan perez' where id_usuario = 1;
delete from tarea where id_tarea = 2;
*/