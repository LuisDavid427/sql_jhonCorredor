
create schema estructura;
create schema sector_empresarial;
create schema personas_actividades;


alter table public.feria set schema estructura;
alter table public.tematica set schema estructura;
alter table public.pabellon set schema estructura;

alter table public.empresa set schema sector_empresarial;
alter table public.stand set schema sector_empresarial;
alter table public.producto set schema sector_empresarial;
alter table public.responsable set schema sector_empresarial;


alter table public.persona set schema personas_actividades;
alter table public.ponente set schema personas_actividades;
alter table public.tipo_visitante set schema personas_actividades;
alter table public.visitante set schema personas_actividades;
alter table public.charla set schema personas_actividades;
alter table public.demostracion set schema personas_actividades;
alter table public.registro set schema personas_actividades;


alter view public.estructura_f_t_p set schema estructura;
alter view public.visitantes_con_tipo set schema personas_actividades;


create or replace view sector_empresarial.responsable_producto_empresa as
select
	p.nombre as responsable,
	pro.nombre_producto,
	e.nombre_empresa
from sector_empresarial.responsable r
inner join personas_actividades.persona p on r.id_persona = p.id_persona
inner join sector_empresarial.producto pro on r.id_producto = pro.id_producto
inner join sector_empresarial.stand s on s.id_stand = pro.id_stand
inner join sector_empresarial.empresa e on e.id_empresa = s.id_empresa;


