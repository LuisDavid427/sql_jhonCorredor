create or replace view visitantes_con_tipo as
select per.nombre, tv.tipo
from visitante v
inner join persona per on v.id_persona = per.id_persona
inner join tipo_visitante tv on v.id_tipo = tv.id_tipo;

create or replace view registros_por_feria_y_empresa as
select per.nombre as visitante, tv.tipo, f.nombre as feria, e.nombre_empresa
from registro r
inner join visitante v on r.id_visitante = v.id_visitante
inner join persona per on v.id_persona = per.id_persona
inner join tipo_visitante tv on v.id_tipo = tv.id_tipo
inner join feria f on r.id_feria = f.id_feria
inner join empresa e on r.id_empresa = e.id_empresa;

create or replace view total_stands_por_feria as
select f.nombre as feria, count(s.id_stand) as total_stands
from feria f
inner join pabellon p on f.id_feria = p.id_feria
inner join stand s on p.id_pabellon = s.id_pabellon
group by f.nombre;

create or replace view responsables_de_productos_por_empresa as
select per.nombre as responsable, pr.nombre_producto, e.nombre_empresa
from responsable r
inner join persona per on r.id_persona = per.id_persona
inner join producto pr on r.id_producto = pr.id_producto
inner join stand s on pr.id_stand = s.id_stand
inner join empresa e on s.id_empresa = e.id_empresa;

create or replace view estructura_f_t_p as
select f.nombre as feria, t.tematica, p.nombre as pabellon
from feria f
inner join pabellon p on f.id_feria = p.id_feria
inner join tematica t on p.id_tematica = t.id_tematica;

select * from responsables_de_productos_por_empresa;