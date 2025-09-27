use feria;
go

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
('cafe cerro', 'productores de cafe de alta calidad'),
('punto de red', 'desarrollo de software y soluciones ti'),
('desarrollo limpio', 'productos de limpieza biodegradables'),
('dulces el sabor', 'dulces artesanales con recetas unicas'),
('autos del huila', 'concesionario de vehiculos de alta gama'),
('diseños lola', 'diseño y confeccion de ropa exclusiva'),
('salud al dia', 'clinica y centro de atencion medica'),
('libro abierto', 'editorial de libros de ficcion y no ficcion'),
('tech revolution', 'innovacion en dispositivos electronicos'),
('sena sennova', 'educacion tecnica y tecnologica');

insert into stand (nombre_stand, id_pabellon, id_empresa) values
('stand del cafe cerro', 3, 1),
('stand del punto de red', 1, 2),
('stand de desarrollo limpio', 10, 3),
('stand de dulces el sabor', 4, 4),
('stand de autos del huila', 10, 5),
('stand de diseños lola', 8, 6),
('stand de salud al dia', 9, 7),
('stand de libro abierto', 7, 8),
('stand de tech revolution', 5, 9),
('stand de sena sennova', 9, 10);

insert into producto (nombre_producto, id_stand) values
('cafe tostado', 1),
('software de contabilidad', 2),
('jabon biodegradable', 3),
('torta de chocolate', 4),
('vehiculo electrico', 5),
('vestido de noche', 6),
('kit de primeros auxilios', 7),
('libro de ciencia ficcion', 8),
('smartwatch', 9),
('curso de programacion', 10);

insert into persona (nombre, dni, telefono) values
('juan perez', '123456789', '3001234567'),
('ana gomez', '987654321', '3012345678'),
('carlos lopez', '1122334455', '3023456789'),
('maria rodriguez', '1012131415', '3034567890'),
('david martinez', '1213141516', '3045678901'),
('laura sanchez', '1314151617', '3056789012'),
('sofia diaz', '1415161718', '3067890123'),
('jorge ruiz', '1516171819', '3078901234'),
('elena torres', '1617181920', '3089012345'),
('andres gutierrez', '1718192021', '3090123456'),
('pedro ramirez', '2012345678', '3101122334'),
('camila fernandez', '2023456789', '3112233445'),
('daniel gomez', '2034567890', '3123344556'),
('isabella perez', '2045678901', '3134455667'),
('manuel lopez', '2056789012', '3145566778'),
('valentina sanchez', '2067890123', '3156677889'),
('sebastian diaz', '2078901234', '3167788990'),
('lucia torres', '2089012345', '3178899001'),
('mateo ruiz', '2090123456', '3189900112'),
('valeria gutierrez', '2091234567', '3190011223');

insert into responsable (id_producto, id_persona) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

insert into ponente (id_persona) values
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

insert into tipo_visitante (tipo) values
('estudiante'),
('profesor'),
('empleado'),
('cliente'),
('inversionista'),
('particular'),
('empresario'),
('jubilado'),
('extranjero'),
('niño');

insert into visitante (id_persona, id_tipo) values
(11, 1),
(12, 2),
(13, 3),
(14, 4),
(15, 5),
(16, 6),
(17, 7),
(18, 8),
(19, 9),
(20, 10);

insert into charla (nombre_charla, descripcion) values
('innovacion en la agricultura', 'nuevas tecnicas de cultivo'),
('desarrollo de software', 'tendencias en programacion'),
('sostenibilidad ambiental', 'practicas ecoamigables'),
('salud y bienestar', 'habitos de vida saludables'),
('el arte del negocio', 'estrategias para emprendedores'),
('literatura contemporanea', 'autores y generos actuales'),
('tendencias de moda', 'futuro de la industria textil'),
('ciberseguridad', 'protege tus datos en internet'),
('importancia de la lectura', 'beneficios de los habitos'),
('vehiculos electricos', 'el futuro del transporte');

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
(1, 1, 1, 1, 1, 1, 1),
(1, 2, 2, 2, 2, 2, 2),
(1, 3, 3, 3, 3, 3, 3),
(3, 4, 4, 4, 4, 4, 4),
(5, 5, 5, 5, 5, 5, 5),
(2, 6, 6, 6, 6, 6, 6),
(4, 7, 7, 7, 7, 7, 7),
(8, 8, 8, 8, 8, 8, 8),
(9, 9, 9, 9, 9, 9, 9),
(10, 10, 10, 10, 10, 10, 10);

go

