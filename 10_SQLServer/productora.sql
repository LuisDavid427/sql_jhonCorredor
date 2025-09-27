--create database productora_musical;

use productora_musical;

create table artista (
    id_artista int identity(1,1) primary key,
    nombre varchar(100),
    genero varchar(50),
    nacionalidad varchar(50)
);
create table album (
    id_album int identity(1,1) primary key,
    titulo varchar(100),
    año int,
    duracion_total time
);
create table cancion (
    id_cancion int identity(1,1) primary key,
    titulo varchar(100),
    duracion time,
    id_album int,
    foreign key (id_album) references album(id_album)
);
create table productor (
    id_productor int identity(1,1) primary key,
    nombre varchar(100),
    experiencia_anios int
);
create table estudio (
    id_estudio int identity(1,1) primary key,
    nombre varchar(100),
    ciudad varchar(50)
);
create table artista_album (
    id_relacion int identity(1,1) primary key,
    id_artista int,
    id_album int,
    foreign key (id_artista) references artista(id_artista),
    foreign key (id_album) references album(id_album)
);
create table cancion_productor (
    id_relacion int identity(1,1) primary key,
    id_cancion int,
    id_productor int,
    foreign key (id_cancion) references cancion(id_cancion),
    foreign key (id_productor) references productor(id_productor)
);
create table cancion_estudio (
    id_relacion int identity(1,1) primary key,
    id_cancion int,
    id_estudio int,
    foreign key (id_cancion) references cancion(id_cancion),
    foreign key (id_estudio) references estudio(id_estudio)
);
insert into artista (nombre, genero, nacionalidad) values
('arctic monkeys', 'indie rock', 'reino unido'),
('daft punk', 'electronica', 'francia'),
('pink floyd', 'rock progresivo', 'reino unido');
insert into album (titulo, año, duracion_total) values
('am', 2013, '00:41:43'),
('random access memories', 2013, '01:14:24'),
('the dark side of the moon', 1973, '00:43:00');
insert into cancion (titulo, duracion, id_album) values
('do i wanna know?', '00:04:32', 1),
('get lucky', '00:06:09', 2),
('breathe', '00:02:44', 3),
('starboy', '00:03:50', null);
insert into productor (nombre, experiencia_anios) values
('productor a', 10),
('productor b', 15);
insert into estudio (nombre, ciudad) values
('estudio a', 'los angeles'),
('estudio b', 'londres');
insert into artista_album (id_artista, id_album) values
(1, 1),
(2, 2),
(3, 3);
insert into cancion_productor (id_cancion, id_productor) values
(1, 1),
(2, 2),
(3, 1);
insert into cancion_estudio (id_cancion, id_estudio) values
(1, 1),
(2, 1),
(3, 2);


-- nuevas inserciones


insert into artista (nombre, genero, nacionalidad) values
('the strokes', 'rock alternativo', 'estados unidos'),
('tame impala', 'psicodelia', 'australia'),
('radiohead', 'rock alternativo', 'reino unido'),
('kendrick lamar', 'hip hop', 'estados unidos'),
('billie eilish', 'pop', 'estados unidos'),
('rosalía', 'flamenco pop', 'españa'),
('bts', 'k-pop', 'corea del sur');

insert into album (titulo, año, duracion_total) values
('is this it', 2001, '00:36:30'),
('currents', 2015, '00:51:12'),
('ok computer', 1997, '01:12:00'),
('to pimp a butterfly', 2015, '01:19:23'),
('when we all fall asleep, where do we go?', 2019, '00:42:00'),
('el mal querer', 2018, '00:49:00'),
('map of the soul: 7', 2020, '01:15:00');

insert into cancion (titulo, duracion, id_album) values
('last nite', '00:03:13', 4),
('the less i know the better', '00:03:38', 5),
('paranoid android', '00:06:27', 6),
('alright', '00:03:39', 7),
('bad guy', '00:03:14', 8),
('malamente', '00:02:29', 9),
('black swan', '00:03:18', 10);

insert into productor (nombre, experiencia_anios) values
('productor c', 8),
('productor d', 20),
('productor e', 12),
('productor f', 18),
('productor g', 25),
('productor h', 5),
('productor i', 14),
('productor j', 30);

insert into estudio (nombre, ciudad) values
('estudio c', 'parís'),
('estudio d', 'berlín'),
('estudio e', 'tokio'),
('estudio f', 'madrid'),
('estudio g', 'nueva york'),
('estudio h', 'sídney'),
('estudio i', 'toronto'),
('estudio j', 'seúl');

insert into artista_album (id_artista, id_album) values
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

insert into cancion_productor (id_cancion, id_productor) values
(4, 2),
(5, 3),
(6, 4),
(7, 5),
(8, 6),
(9, 7),
(10, 8);

insert into cancion_estudio (id_cancion, id_estudio) values
(4, 3),
(5, 4),
(6, 5),
(7, 6),
(8, 7),
(9, 8),
(10, 9);



---

/*

select * from artista;
select * from album;
select * from cancion;
select * from productor;
select * from estudio;
select * from artista_album;
select * from cancion_productor;
select * from cancion_estudio;
select a.titulo as album, ar.nombre as artista
from album as a
inner join artista_album as aa on a.id_album = aa.id_album
inner join artista as ar on aa.id_artista = ar.id_artista;
select ar.nombre as artista, a.titulo as album
from artista as ar
right join artista_album as aa on ar.id_artista = aa.id_artista
right join album as a on aa.id_album = a.id_album;
select c.titulo as cancion, p.nombre as productor, e.nombre as estudio
from cancion as c
left join cancion_productor as cp on c.id_cancion = cp.id_cancion
left join productor as p on cp.id_productor = p.id_productor
left join cancion_estudio as ce on c.id_cancion = ce.id_cancion
left join estudio as e on ce.id_estudio = e.id_estudio;
select ar.nombre as artista, a.titulo as album
from artista as ar
left join artista_album as aa on ar.id_artista = aa.id_artista
left join album as a on aa.id_album = a.id_album;
select a.titulo as album, count(c.id_cancion) as total_canciones
from album as a
left join cancion as c on a.id_album = c.id_album
group by a.titulo;
select convert(varchar(8), dateadd(second, sum(datediff(second, '00:00:00', c.duracion)), '00:00:00'), 108) as duracion_total
from cancion as c;
select a.titulo as album, convert(varchar(8), dateadd(second, avg(datediff(second, '00:00:00', c.duracion)), '00:00:00'), 108) as promedio
from cancion as c
inner join album as a on c.id_album = a.id_album
group by a.titulo;
select titulo, duracion
from cancion
where duracion = (select max(duracion) from cancion);
select titulo, duracion
from cancion
where duracion = (select min(duracion) from cancion);
select count(distinct nacionalidad) as nacionalidades_distintas
from artista;
select a.titulo as album
from album as a
where a.id_album in (
    select id_album
    from cancion
    where duracion > '00:03:30'
);
select nombre from artista
where nombre like 'a%';
select c.titulo as cancion, c.duracion, a.titulo as album
from cancion c
left join album a on c.id_album = a.id_album
union
select c.titulo, c.duracion, a.titulo
from cancion c
right join album a on c.id_album = a.id_album;
update artista set nacionalidad = 'estados unidos' where id_artista = 1;
delete from cancion where id_cancion = 4;
*/