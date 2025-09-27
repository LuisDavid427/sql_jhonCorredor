use feria;
go

create schema estructura authorization dbo;
go

create schema sector_empresarial authorization dbo;
go

create schema personas_actividades authorization dbo;
go

-- estructura
alter schema estructura transfer dbo.feria;
alter schema estructura transfer dbo.tematica;
alter schema estructura transfer dbo.pabellon;
go


-- sector_empresarial
alter schema sector_empresarial transfer dbo.empresa;
alter schema sector_empresarial transfer dbo.stand;
alter schema sector_empresarial transfer dbo.producto;
alter schema sector_empresarial transfer dbo.responsable;
go


-- personas_actividades
alter schema personas_actividades transfer dbo.persona;
alter schema personas_actividades transfer dbo.ponente;
alter schema personas_actividades transfer dbo.tipo_visitante;
alter schema personas_actividades transfer dbo.visitante;
alter schema personas_actividades transfer dbo.charla;
alter schema personas_actividades transfer dbo.demostracion;
alter schema personas_actividades transfer dbo.registro;
go




-- vista estuctura
alter schema estructura transfer dbo.estructura_f_t_p;
go

-- vista sector_empresarial

create view sector_empresarial.responsable_producto_empresa
as
select
	p.nombre as responsable,
	pro.nombre_producto,
	e.nombre_empresa
from sector_empresarial.responsable r
inner join personas_actividades.persona p on r.id_persona = p.id_persona
inner join sector_empresarial.producto pro on r.id_producto = pro.id_producto
inner join sector_empresarial.stand s on s.id_stand = pro.id_stand
inner join sector_empresarial.empresa e on e.id_empresa = s.id_empresa;
go

-- vista personas_actividades
alter schema personas_actividades transfer dbo.visitantes_con_tipo;
go
