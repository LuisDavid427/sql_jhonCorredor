

create schema estructura;
create schema sector_empresarial;
create schema personas_actividades;

rename table feria.feria to estructura.feria;
rename table feria.tematica to estructura.tematica;
rename table feria.pabellon to estructura.pabellon;

rename table feria.empresa to sector_empresarial.empresa;
rename table feria.stand to sector_empresarial.stand;
rename table feria.producto to sector_empresarial.producto;
rename table feria.responsable to sector_empresarial.responsable;

rename table feria.persona to personas_actividades.persona;
rename table feria.ponente to personas_actividades.ponente;
rename table feria.tipo_visitante to personas_actividades.tipo_visitante;
rename table feria.visitante to personas_actividades.visitante;
rename table feria.charla to personas_actividades.charla;
rename table feria.demostracion to personas_actividades.demostracion;
rename table feria.registro to personas_actividades.registro;

