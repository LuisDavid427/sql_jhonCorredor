use feria;
select * from feria;
select * from tematica;
select * from pabellon;
select * from empresa;
select * from stand;
select * from producto;
select * from persona;
select * from responsable;
select * from ponente;
select * from tipo_visitante;
select * from visitante;
select * from charla;
select * from demostracion;
select * from registro;


select * 
from feria as f
inner join pabellon as p on f.id_feria = f.id_feria;

select * 
from tematica as t
inner join pabellon as p on t.id_tematica = p.id_tematica;

select *
from pabellon as p
inner join stand as s on p.id_pabellon = s.id_pabellon;

select *
from stand as s
inner join empresa as e on e.id_empresa = s.id_empresa;

select * 
from stand as s
inner join producto as p on p.id_stand = s.id_stand;

select * 
from producto as p 
inner join responsable as r on r.id_producto = p.id_producto;

select * 
from persona as p
inner join responsable as r on r.id_persona = p.id_persona;

select *
from persona as p
inner join ponente as po on po.id_persona = p.id_persona;

select * 
from persona as p
inner join visitante as v on v.id_persona = p.id_persona;

select * 
from visitante as v
inner join tipo_visitante as tv on tv.id_tipo = v.id_tipo;

select *
from registro as r
inner join feria as f on r.id_feria = f.id_feria
inner join stand as s on r.id_stand = s.id_stand
inner join empresa as e on r.id_empresa = e.id_empresa
inner join charla as ch on r.id_charla = ch.id_charla
inner join demostracion as d on r.id_demostracion = d.id_demostracion
inner join ponente as p on r.id_ponente = p.id_ponente
inner join visitante as v on r.id_visitante = v.id_visitante;

-- registros

select per.nombre, tv.tipo as tipo_visitante
from visitante v
inner join persona per on v.id_persona = per.id_persona
inner join tipo_visitante tv on v.id_tipo = tv.id_tipo;

select per.nombre as visitante, tv.tipo as tipo_visitante,
       f.nombre as feria, e.nombre_empresa
from registro r
inner join visitante v on r.id_visitante = v.id_visitante
inner join persona per on v.id_persona = per.id_persona
inner join tipo_visitante tv on v.id_tipo = tv.id_tipo
inner join feria f on r.id_feria = f.id_feria
inner join empresa e on r.id_empresa = e.id_empresa;

select f.nombre as feria, count(s.id_stand) as total_stands
from feria f
inner join pabellon p on f.id_feria = p.id_feria
inner join stand s on p.id_pabellon = s.id_pabellon
group by f.nombre;

select per.nombre as responsable, pr.nombre_producto, e.nombre_empresa
from responsable r
inner join persona per on r.id_persona = per.id_persona
inner join producto pr on r.id_producto = pr.id_producto
inner join stand s on pr.id_stand = s.id_stand
inner join empresa e on s.id_empresa = e.id_empresa;


