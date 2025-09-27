--create database teorias_conspirativas;

use teorias_conspirativas;

create table teorias(
  id_teoria   int identity(1,1) primary key,
  nombre      varchar(50)
);
create table fuentes(
  id_fuente   int identity(1,1) primary key,
  nombre      varchar(50)
);
create table eventos(
  id_evento   int identity(1,1) primary key,
  nombre      varchar(50),
  fecha       date
);
create table autores(
  id_autor    int identity(1,1) primary key,
  nombre      varchar(50)
);
create table teoria_fuente(
  id_tf       int identity(1,1) primary key,
  id_teoria   int,
  id_fuente   int,
  foreign key (id_teoria) references teorias(id_teoria),
  foreign key (id_fuente) references fuentes(id_fuente)
);
create table teoria_evento(
  id_te        int identity(1,1) primary key,
  id_teoria    int,
  id_evento    int,
  foreign key (id_teoria) references teorias(id_teoria),
  foreign key (id_evento) references eventos(id_evento)
);
create table autor_teoria(
  id_at       int identity(1,1) primary key,
  id_autor    int,
  id_teoria   int,
  foreign key (id_autor) references autores(id_autor),
  foreign key (id_teoria) references teorias(id_teoria)
);
insert into teorias (nombre) values
('teoria 1'),
('teoria 2'),
('teoria 3');
insert into fuentes (nombre) values
('fuente a'),
('fuente b'),
('fuente c');
insert into eventos (nombre, fecha) values
('evento x', '2024-01-15'),
('evento y', '2024-02-20'),
('evento z', '2024-03-10');
insert into autores (nombre) values
('autor i'),
('autor ii'),
('autor iii');
insert into teoria_fuente (id_teoria, id_fuente) values
(1, 1),
(1, 2),
(2, 2);
insert into teoria_evento (id_teoria, id_evento) values
(1, 1),
(2, 2);
insert into autor_teoria (id_autor, id_teoria) values
(1, 1),
(2, 2);

-- nuevas inserciones

insert into teorias (nombre) values
('teoria 4'),
('teoria 5'),
('teoria 6'),
('teoria 7'),
('teoria 8'),
('teoria 9'),
('teoria 10');

insert into fuentes (nombre) values
('fuente d'),
('fuente e'),
('fuente f'),
('fuente g'),
('fuente h'),
('fuente i'),
('fuente j');

insert into eventos (nombre, fecha) values
('evento a', '2024-04-01'),
('evento b', '2024-05-12'),
('evento c', '2024-06-25'),
('evento d', '2024-07-08'),
('evento e', '2024-08-19'),
('evento f', '2024-09-30'),
('evento g', '2024-10-15');

insert into autores (nombre) values
('autor iv'),
('autor v'),
('autor vi'),
('autor vii'),
('autor viii'),
('autor ix'),
('autor x');

insert into teoria_fuente (id_teoria, id_fuente) values
(2, 3),
(3, 1),
(3, 4),
(4, 5),
(5, 6),
(6, 7),
(7, 8);

insert into teoria_evento (id_teoria, id_evento) values
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(1, 2),
(2, 1),
(3, 2);

insert into autor_teoria (id_autor, id_teoria) values
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(1, 2),
(2, 3),
(3, 1);


---

/*
select * from teorias;
select * from fuentes;
select * from eventos;
select * from autores;
select * from teoria_fuente;
select * from teoria_evento;
select * from autor_teoria;
update teorias set nombre = 'teoria actualizada' where id_teoria = 1;
delete from teoria_fuente where id_teoria = 1;
delete from autores where id_autor = 1;
select t.nombre as teoria, f.nombre as fuente
from teorias t
inner join teoria_fuente tf on t.id_teoria = tf.id_teoria
inner join fuentes f          on tf.id_fuente = f.id_fuente;
select t.nombre as teoria, e.nombre as evento
from teorias t
left join teoria_evento te on t.id_teoria = te.id_teoria
left join eventos e         on te.id_evento = e.id_evento;
select a.nombre as autor, t.nombre as teoria
from teorias t
right join autor_teoria at on t.id_teoria = at.id_teoria
right join autores a        on at.id_autor = a.id_autor;
select t.nombre, count(tf.id_tf) as total_fuentes
from teorias t
left join teoria_fuente tf on t.id_teoria = tf.id_teoria
group by t.nombre;
select t.nombre, count(tf.id_tf) as num_fuentes
from teorias t
join teoria_fuente tf on t.id_teoria = tf.id_teoria
group by t.nombre
having count(tf.id_tf) > 1;
select nombre from teorias where nombre like 't%';
select nombre, nombre
from teorias
union
select nombre, nombre
from fuentes;
*/