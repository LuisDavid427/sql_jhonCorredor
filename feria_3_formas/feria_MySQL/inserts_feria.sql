use feria;
insert into feria (nombre, descripcion) values
('feria de neiva', 'exposicion de productos de todo tipo'),
('feria del arte', 'exhibicion de arte contemporaneo'),
('feria gastronomica', 'festival de comida internacional'),
('feria del libro', 'encuentro literario con autores'),
('feria de tecnologia', 'innovaciones en tecnologia'),
('feria de artesanias', 'artesanias tradicionales'),
('feria de automoviles', 'vehiculos nuevos y clasicos'),
('feria de moda', 'desfiles de diseñadores'),
('feria de salud', 'bienestar y medicina'),
('feria de educacion', 'oferta academica');

insert into tematica (tematica) values
('tecnologia'),
('agricultura'),
('gastronomia'),
('arte'),
('moda'),
('libros'),
('salud'),
('automoviles'),
('educacion'),
('hogar');

insert into pabellon (nombre, id_tematica, id_feria) values
('pabellon del software', 1, 1),
('pabellon del hardware', 1, 1),
('pabellon del cafe', 2, 1),
('pabellon de la carne', 3, 3),
('pabellon de tecnologia', 1, 5),
('pabellon del arte', 4, 2),
('pabellon de libros', 6, 4),
('pabellon de moda', 5, 8),
('pabellon de la salud', 7, 9),
('pabellon de automoviles', 8, 7);

insert into empresa (nombre_empresa, descripcion) values
('Cafe Cerro-Neiva', 'cultivo y procesamiento de cafe'),
('Punto De Red', 'servicio de infraestructura de red'),
('Desarrollo Limpio', 'soluciones con software'),
('Dulces El Sabor', 'empresa de dulces y postres'),
('Vision Digital', 'desarrollo de aplicaciones moviles'),
('Libreria El Sabio', 'venta de libros'),
('Modas Trendy', 'ropa de ultima moda'),
('Clinica Bienestar', 'servicios medicos y chequeos'),
('Autos Veloz', 'distribucion de vehiculos'),
('Universidad Futuro', 'oferta de carreras universitarias');

insert into stand (nombre_stand, id_pabellon, id_empresa) values
('el mejor cafe', 3, 1),
('lo mejor para redes', 2, 2),
('software personalizado', 1, 3),
('stand de dulces', 4, 4),
('apps innovadoras', 5, 5),
('libros para todos', 7, 6),
('lo ultimo en moda', 8, 7),
('chequeo medico', 9, 8),
('vehiculos nuevos', 10, 9),
('carreras del futuro', 10, 10);

insert into producto (nombre_producto, id_stand) values
('Cafe Cerro-Neiva', 1),
('routerPRD', 2),
('inventario', 3),
('dulce de leche', 4),
('app de finanzas', 5),
('libro de historia', 6),
('vestido de noche', 7),
('fisioterapia', 8),
('coche electrico', 9),
('carrera de programacion', 10);

insert into persona (nombre, dni, telefono) values
('fernando flores', '1111111111', '1111111111'),
('jordi wild', '2222222222', '2222222222'),
('federico', '3333333333', '3333333333'),
('jose luis', '4444444444', '4444444444'),
('manue', '5555555555', '5555555555'),
('marcos perez', '6666666666', '6666666666'),
('ana lopez', '7777777777', '7777777777'),
('juan garcia', '8888888888', '8888888888'),
('maria diaz', '9999999999', '9999999999'),
('carlos sanchez', '1234567890', '1234567890');

insert into responsable (id_persona, id_producto) values
(1, 1),
(2, 2),
(3, 3),
(4, 3),
(5, 4),
(6, 5),
(7, 6),
(8, 7),
(9, 8),
(10, 9);


insert into ponente (id_persona) values
(5),
(6),
(7),
(8),
(9),
(10),
(1),
(2),
(3),
(4);

insert into tipo_visitante (tipo) values
('vip'),
('general'),
('estudiante');

insert into visitante (id_persona, id_tipo) values
(5, 1),
(4, 2),
(6, 3),
(7, 1),
(8, 2),
(9, 3),
(10, 2),
(1, 1),
(2, 2),
(3, 3);

insert into charla (nombre_charla, descripcion) values
('importancia del software', 'ver la importancia del software en todos los campos'),
('beneficios del arte', 'impacto del arte en la sociedad'),
('cocina saludable', 'tips para preparar comidas nutritivas'),
('moda sostenible', 'diseño de ropa ecologica'),
('futuro de la programacion', 'tendencias en el desarrollo'),
('finanzas personales', 'consejos para manejar ahorros'),
('historia del automovil', 'evolucion de los coches'),
('nutricion infantil', 'alimentacion para niños'),
('importancia de la lectura', 'beneficios de los habitos'),
('ciberseguridad', 'protege tus datos en internet');

insert into demostracion (nombre_demostracion, descripcion) values
('degustacion del cafe', 'demostracion de nuestro producto'),
('exhibicion de arte', 'muestra de obras de artistas'),
('degustacion de postres', 'prueba los nuevos dulces'),
('demo de app movil', 'funcionamiento de la aplicacion'),
('pasarela de moda', 'nuevas colecciones en desfile'),
('clase de yoga', 'tecnicas de relajacion'),
('prueba de manejo', 'test drive de vehiculos electricos'),
('lectura en voz alta', 'sesion de lectura de un libro'),
('taller de programacion', 'taller basico de programacion'),
('charla de salud', 'sesion de preguntas con medicos');


insert into registro (id_feria, id_empresa, id_stand, id_charla, id_demostracion, id_ponente, id_visitante) values
(1, 1, 1, 1, 1, 1, 1),   -- Cafe Cerro-Neiva -> charla 1, demo 1
(1, 2, 2, 2, 2, 2, 2),   -- Punto De Red -> charla 2, demo 2
(1, 3, 3, 3, 3, 3, 3),   -- Desarrollo Limpio -> charla 3, demo 3
(3, 4, 4, 4, 4, 4, 4),   -- Dulces El Sabor -> charla 4, demo 4
(5, 5, 5, 5, 5, 5, 5),   -- Vision Digital -> charla 5, demo 5
(4, 6, 6, 6, 6, 6, 6),   -- Libreria El Sabio -> charla 6, demo 6
(8, 7, 7, 7, 7, 7, 7),   -- Modas Trendy -> charla 7, demo 7
(9, 8, 8, 8, 8, 8, 8),   -- Clinica Bienestar -> charla 8, demo 8
(7, 9, 9, 9, 9, 9, 9),   -- Autos Veloz -> charla 9, demo 9
(10, 10, 10, 10, 10, 10, 10); -- Universidad Futuro -> charla 10, demo 10