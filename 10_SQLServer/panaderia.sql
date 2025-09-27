--create database panaderiadb;

use panaderiadb;

create table cliente (
    id_cliente int identity(1,1) primary key,
    nombre varchar(100),
    telefono varchar(20),
    direccion varchar(150)
);
create table empleado (
    id_empleado int identity(1,1) primary key,
    nombre varchar(100),
    cargo varchar(50)
);
create table producto (
    id_producto int identity(1,1) primary key,
    nombre varchar(100),
    precio decimal(10, 2),
    descripcion text
);
create table receta (
    id_receta int identity(1,1) primary key,
    id_producto int,
    instrucciones text,
    foreign key (id_producto) references producto(id_producto)
);
create table ingrediente (
    id_ingrediente int identity(1,1) primary key,
    nombre varchar(100),
    unidad_medida varchar(20)
);
create table detalle_receta (
    id_detalle int identity(1,1) primary key,
    id_receta int,
    id_ingrediente int,
    cantidad decimal(10, 2),
    foreign key (id_receta) references receta(id_receta),
    foreign key (id_ingrediente) references ingrediente(id_ingrediente)
);
create table venta (
    id_venta int identity(1,1) primary key,
    fecha date,
    total decimal(10, 2),
    id_cliente int,
    id_empleado int,
    id_producto int,
    foreign key (id_cliente) references cliente(id_cliente),
    foreign key (id_empleado) references empleado(id_empleado),
    foreign key (id_producto) references producto(id_producto)
);
insert into cliente (nombre, telefono, direccion) values
('ana lopez', '3101234567', 'calle 10 #1'),
('juan perez', '3209876543', 'carrera 5 #2');
insert into empleado (nombre, cargo) values
('carlos ruiz', 'panadero'),
('maria garcia', 'cajero');
insert into producto (nombre, precio, descripcion) values
('pan de yuca', 2500, 'pan de yuca tradicional'),
('pandebono', 2000, 'pandebono con queso'),
('buñuelo', 1500, 'buñuelo frito');
insert into receta (id_producto, instrucciones) values
(1, 'mezclar yuca, queso y hornear'),
(2, 'mezclar almidon, queso, huevos y hornear'),
(3, 'mezclar maicena, huevos, azucar, queso y freir');
insert into ingrediente (nombre, unidad_medida) values
('yuca', 'gramos'),
('queso', 'gramos'),
('almidon', 'gramos'),
('huevo', 'unidades'),
('azucar', 'gramos');
insert into detalle_receta (id_receta, id_ingrediente, cantidad) values
(1, 1, 500),
(1, 2, 200),
(2, 3, 400),
(2, 2, 300),
(2, 4, 2);
insert into venta (fecha, total, id_cliente, id_empleado, id_producto) values
('2024-05-10', 4500, 1, 1, 1),
('2024-05-10', 4000, 2, 2, 2),
('2024-05-11', 1500, 1, 2, 3);




-- nuevas inserciones


insert into cliente (nombre, telefono, direccion) values
('laura martinez', '3112223344', 'avenida 15 #23'),
('pedro gomez', '3125566778', 'carrera 12 #45'),
('sofia ramirez', '3139988776', 'calle 20 #10'),
('luis fernandez', '3143344556', 'carrera 7 #8'),
('camila torres', '3156677889', 'calle 8 #14'),
('ricardo muñoz', '3161122334', 'avenida 30 #56'),
('juliana soto', '3174455667', 'carrera 18 #22'),
('felipe alvarez', '3182233445', 'calle 12 #17');

insert into empleado (nombre, cargo) values
('andres castro', 'repartidor'),
('paula lozano', 'panadera'),
('daniel ortega', 'cajero'),
('valentina arenas', 'administradora'),
('sergio velasquez', 'panadero'),
('monica vargas', 'ayudante'),
('gustavo lara', 'repartidor'),
('adriana rios', 'cajero');

insert into producto (nombre, precio, descripcion) values
('croissant', 3000, 'croissant frances'),
('torta de chocolate', 12000, 'torta de chocolate casera'),
('galleta de avena', 1000, 'galleta integral de avena'),
('pan integral', 3500, 'pan integral saludable'),
('empanada', 2000, 'empanada de carne'),
('roscon', 4000, 'roscon con bocadillo'),
('muffin', 2500, 'muffin de arandanos');

insert into receta (id_producto, instrucciones) values
(4, 'mezclar harina integral, agua y hornear'),
(5, 'rellenar masa con carne y freir'),
(6, 'amasar harina, azucar, bocadillo y hornear'),
(7, 'mezclar harina, arandanos y hornear'),
(1, 'amasar harina y mantequilla, hornear'),
(2, 'batir huevos, cacao, harina y hornear'),
(3, 'mezclar avena, azucar, huevos y hornear');

insert into ingrediente (nombre, unidad_medida) values
('harina', 'gramos'),
('leche', 'mililitros'),
('mantequilla', 'gramos'),
('carne', 'gramos'),
('bocadillo', 'gramos');

insert into detalle_receta (id_receta, id_ingrediente, cantidad) values
(3, 5, 100),
(4, 1, 500),
(4, 2, 300),
(5, 4, 150),
(6, 1, 400),
(6, 2, 200),
(7, 3, 100),
(7, 2, 150),
(7, 1, 250),
(3, 4, 50);

insert into venta (fecha, total, id_cliente, id_empleado, id_producto) values
('2024-05-12', 3000, 3, 3, 4),
('2024-05-12', 12000, 4, 4, 5),
('2024-05-13', 1000, 5, 5, 6),
('2024-05-13', 3500, 6, 6, 7),
('2024-05-14', 2000, 7, 7, 1),
('2024-05-14', 4000, 8, 8, 2),
('2024-05-15', 2500, 1, 1, 3);




-----

/*
select * from cliente;
select * from empleado;
select * from producto;
select * from receta;
select * from ingrediente;
select * from detalle_receta;
select * from venta;
select v.fecha, c.nombre as cliente, p.nombre as producto, v.total
from venta as v
inner join cliente as c on v.id_cliente = c.id_cliente
inner join producto as p on v.id_producto = p.id_producto;
select p.nombre as producto, r.instrucciones
from producto as p
right join receta as r on p.id_producto = r.id_producto;
select r.instrucciones, i.nombre as ingrediente, dr.cantidad
from receta as r
left join detalle_receta as dr on r.id_receta = dr.id_receta
left join ingrediente as i on dr.id_ingrediente = i.id_ingrediente;
select r.instrucciones, i.nombre as ingrediente, dr.cantidad, p.nombre as producto
from receta as r
left join detalle_receta as dr on r.id_receta = dr.id_receta
left join ingrediente as i on dr.id_ingrediente = i.id_ingrediente
inner join producto as p on r.id_producto = p.id_producto;
select
    i.nombre as ingrediente,
    dr.cantidad,
    r.id_receta
from detalle_receta as dr
right join ingrediente as i on dr.id_ingrediente = i.id_ingrediente
left join receta as r on dr.id_receta = r.id_receta;
select
    p.nombre as producto,
    sum(v.total) as total_vendido
from venta as v
inner join producto as p on v.id_producto = p.id_producto
group by p.nombre;
select
    c.nombre as cliente,
    count(v.id_venta) as cantidad_ventas
from venta as v
inner join cliente as c on v.id_cliente = c.id_cliente
group by c.nombre;
select
    c.nombre as cliente,
    avg(v.total) as promedio_gasto
from venta as v
inner join cliente as c on v.id_cliente = c.id_cliente
group by c.nombre;
select
    p.nombre as producto,
    p.precio
from producto as p
where p.precio = (select max(precio) from producto);
select
    p.nombre as producto,
    p.precio
from producto as p
where p.precio = (select min(precio) from producto);
update producto set precio = 2700 where id_producto = 1;
delete from venta where id_venta = 3;
*/