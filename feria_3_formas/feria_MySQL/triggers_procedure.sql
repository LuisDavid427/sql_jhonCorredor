use feria;

delimiter //
create procedure ins_log(
    in p_tabla varchar(60),
    in p_sentencia varchar(20),
    in p_datos_old text,
    in p_datos_new text)
begin
    insert into log (tabla, sentencia, usuario, fecha, datos_old, datos_new)
    values (p_tabla, p_sentencia, current_user(), now(), p_datos_old, p_datos_new);
end//

create trigger ins_feria
after insert on feria
for each row
begin
    call ins_log('feria','insert',null,
        concat('id_feria=',new.id_feria,'; nombre=',new.nombre,'; descripcion=',new.descripcion)
    );
end//

create trigger upd_feria
after update on feria
for each row
begin
    call ins_log('feria','update',
        concat('id_feria=',old.id_feria,'; nombre=',old.nombre,'; descripcion=',old.descripcion),
        concat('id_feria=',new.id_feria,'; nombre=',new.nombre,'; descripcion=',new.descripcion)
    );
end//

create trigger del_feria
after delete on feria
for each row
begin
    call ins_log('feria','delete',
        concat('id_feria=',old.id_feria,'; nombre=',old.nombre,'; descripcion=',old.descripcion),
        null
    );
end//

create trigger ins_tematica
after insert on tematica
for each row
begin
    call ins_log('tematica','insert',null,
        concat('id_tematica=',new.id_tematica,'; tematica=',new.tematica)
    );
end//

create trigger upd_tematica
after update on tematica
for each row
begin
    call ins_log('tematica','update',
        concat('id_tematica=',old.id_tematica,'; tematica=',old.tematica),
        concat('id_tematica=',new.id_tematica,'; tematica=',new.tematica)
    );
end//

create trigger del_tematica
after delete on tematica
for each row
begin
    call ins_log('tematica','delete',
        concat('id_tematica=',old.id_tematica,'; tematica=',old.tematica),
        null
    );
end//

create trigger ins_pabellon
after insert on pabellon
for each row
begin
    call ins_log('pabellon','insert',null,
        concat('id_pabellon=',new.id_pabellon,'; nombre=',new.nombre,'; id_tematica=',new.id_tematica,'; id_feria=',new.id_feria)
    );
end//

create trigger upd_pabellon
after update on pabellon
for each row
begin
    call ins_log('pabellon','update',
        concat('id_pabellon=',old.id_pabellon,'; nombre=',old.nombre,'; id_tematica=',old.id_tematica,'; id_feria=',old.id_feria),
        concat('id_pabellon=',new.id_pabellon,'; nombre=',new.nombre,'; id_tematica=',new.id_tematica,'; id_feria=',new.id_feria)
    );
end//

create trigger del_pabellon
after delete on pabellon
for each row
begin
    call ins_log('pabellon','delete',
        concat('id_pabellon=',old.id_pabellon,'; nombre=',old.nombre,'; id_tematica=',old.id_tematica,'; id_feria=',old.id_feria),
        null
    );
end//

create trigger ins_empresa
after insert on empresa
for each row
begin
    call ins_log('empresa','insert',null,
        concat('id_empresa=',new.id_empresa,'; nombre_empresa=',new.nombre_empresa,'; descripcion=',new.descripcion)
    );
end//

create trigger upd_empresa
after update on empresa
for each row
begin
    call ins_log('empresa','update',
        concat('id_empresa=',old.id_empresa,'; nombre_empresa=',old.nombre_empresa,'; descripcion=',old.descripcion),
        concat('id_empresa=',new.id_empresa,'; nombre_empresa=',new.nombre_empresa,'; descripcion=',new.descripcion)
    );
end//

create trigger del_empresa
after delete on empresa
for each row
begin
    call ins_log('empresa','delete',
        concat('id_empresa=',old.id_empresa,'; nombre_empresa=',old.nombre_empresa,'; descripcion=',old.descripcion),
        null
    );
end//

create trigger ins_stand
after insert on stand
for each row
begin
    call ins_log('stand','insert',null,
        concat('id_stand=',new.id_stand,'; nombre_stand=',new.nombre_stand,'; id_pabellon=',new.id_pabellon,'; id_empresa=',new.id_empresa)
    );
end//

create trigger upd_stand
after update on stand
for each row
begin
    call ins_log('stand','update',
        concat('id_stand=',old.id_stand,'; nombre_stand=',old.nombre_stand,'; id_pabellon=',old.id_pabellon,'; id_empresa=',old.id_empresa),
        concat('id_stand=',new.id_stand,'; nombre_stand=',new.nombre_stand,'; id_pabellon=',new.id_pabellon,'; id_empresa=',new.id_empresa)
    );
end//

create trigger del_stand
after delete on stand
for each row
begin
    call ins_log('stand','delete',
        concat('id_stand=',old.id_stand,'; nombre_stand=',old.nombre_stand,'; id_pabellon=',old.id_pabellon,'; id_empresa=',old.id_empresa),
        null
    );
end//

create trigger ins_producto
after insert on producto
for each row
begin
    call ins_log('producto','insert',null,
        concat('id_producto=',new.id_producto,'; nombre_producto=',new.nombre_producto,'; id_stand=',new.id_stand)
    );
end//

create trigger upd_producto
after update on producto
for each row
begin
    call ins_log('producto','update',
        concat('id_producto=',old.id_producto,'; nombre_producto=',old.nombre_producto,'; id_stand=',old.id_stand),
        concat('id_producto=',new.id_producto,'; nombre_producto=',new.nombre_producto,'; id_stand=',new.id_stand)
    );
end//

create trigger del_producto
after delete on producto
for each row
begin
    call ins_log('producto','delete',
        concat('id_producto=',old.id_producto,'; nombre_producto=',old.nombre_producto,'; id_stand=',old.id_stand),
        null
    );
end//

create trigger ins_persona
after insert on persona
for each row
begin
    call ins_log('persona','insert',null,
        concat('id_persona=',new.id_persona,'; nombre=',new.nombre,'; dni=',new.dni,'; telefono=',new.telefono)
    );
end//

create trigger upd_persona
after update on persona
for each row
begin
    call ins_log('persona','update',
        concat('id_persona=',old.id_persona,'; nombre=',old.nombre,'; dni=',old.dni,'; telefono=',old.telefono),
        concat('id_persona=',new.id_persona,'; nombre=',new.nombre,'; dni=',new.dni,'; telefono=',new.telefono)
    );
end//

create trigger del_persona
after delete on persona
for each row
begin
    call ins_log('persona','delete',
        concat('id_persona=',old.id_persona,'; nombre=',old.nombre,'; dni=',old.dni,'; telefono=',old.telefono),
        null
    );
end//

create trigger ins_responsable
after insert on responsable
for each row
begin
    call ins_log('responsable','insert',null,
        concat('id_responsable=',new.id_responsable,'; id_producto=',new.id_producto,'; id_persona=',new.id_persona)
    );
end//

create trigger upd_responsable
after update on responsable
for each row
begin
    call ins_log('responsable','update',
        concat('id_responsable=',old.id_responsable,'; id_producto=',old.id_producto,'; id_persona=',old.id_persona),
        concat('id_responsable=',new.id_responsable,'; id_producto=',new.id_producto,'; id_persona=',new.id_persona)
    );
end//

create trigger del_responsable
after delete on responsable
for each row
begin
    call ins_log('responsable','delete',
        concat('id_responsable=',old.id_responsable,'; id_producto=',old.id_producto,'; id_persona=',old.id_persona),
        null
    );
end//

create trigger ins_ponente
after insert on ponente
for each row
begin
    call ins_log('ponente','insert',null,
        concat('id_ponente=',new.id_ponente,'; id_persona=',new.id_persona)
    );
end//

create trigger upd_ponente
after update on ponente
for each row
begin
    call ins_log('ponente','update',
        concat('id_ponente=',old.id_ponente,'; id_persona=',old.id_persona),
        concat('id_ponente=',new.id_ponente,'; id_persona=',new.id_persona)
    );
end//

create trigger del_ponente
after delete on ponente
for each row
begin
    call ins_log('ponente','delete',
        concat('id_ponente=',old.id_ponente,'; id_persona=',old.id_persona),
        null
    );
end//

create trigger ins_tipo_visitante
after insert on tipo_visitante
for each row
begin
    call ins_log('tipo_visitante','insert',null,
        concat('id_tipo=',new.id_tipo,'; tipo=',new.tipo)
    );
end//

create trigger upd_tipo_visitante
after update on tipo_visitante
for each row
begin
    call ins_log('tipo_visitante','update',
        concat('id_tipo=',old.id_tipo,'; tipo=',old.tipo),
        concat('id_tipo=',new.id_tipo,'; tipo=',new.tipo)
    );
end//

create trigger del_tipo_visitante
after delete on tipo_visitante
for each row
begin
    call ins_log('tipo_visitante','delete',
        concat('id_tipo=',old.id_tipo,'; tipo=',old.tipo),
        null
    );
end//

create trigger ins_visitante
after insert on visitante
for each row
begin
    call ins_log('visitante','insert',null,
        concat('id_visitante=',new.id_visitante,'; id_persona=',new.id_persona,'; id_tipo=',new.id_tipo)
    );
end//

create trigger upd_visitante
after update on visitante
for each row
begin
    call ins_log('visitante','update',
        concat('id_visitante=',old.id_visitante,'; id_persona=',old.id_persona,'; id_tipo=',old.id_tipo),
        concat('id_visitante=',new.id_visitante,'; id_persona=',new.id_persona,'; id_tipo=',new.id_tipo)
    );
end//

create trigger del_visitante
after delete on visitante
for each row
begin
    call ins_log('visitante','delete',
        concat('id_visitante=',old.id_visitante,'; id_persona=',old.id_persona,'; id_tipo=',old.id_tipo),
        null
    );
end//

create trigger ins_charla
after insert on charla
for each row
begin
    call ins_log('charla','insert',null,
        concat('id_charla=',new.id_charla,'; nombre_charla=',new.nombre_charla,'; descripcion=',new.descripcion)
    );
end//

create trigger upd_charla
after update on charla
for each row
begin
    call ins_log('charla','update',
        concat('id_charla=',old.id_charla,'; nombre_charla=',old.nombre_charla,'; descripcion=',old.descripcion),
        concat('id_charla=',new.id_charla,'; nombre_charla=',new.nombre_charla,'; descripcion=',new.descripcion)
    );
end//

create trigger del_charla
after delete on charla
for each row
begin
    call ins_log('charla','delete',
        concat('id_charla=',old.id_charla,'; nombre_charla=',old.nombre_charla,'; descripcion=',old.descripcion),
        null
    );
end//

create trigger ins_demostracion
after insert on demostracion
for each row
begin
    call ins_log('demostracion','insert',null,
        concat('id_demostracion=',new.id_demostracion,'; nombre_demostracion=',new.nombre_demostracion,'; descripcion=',new.descripcion)
    );
end//

create trigger upd_demostracion
after update on demostracion
for each row
begin
    call ins_log('demostracion','update',
        concat('id_demostracion=',old.id_demostracion,'; nombre_demostracion=',old.nombre_demostracion,'; descripcion=',old.descripcion),
        concat('id_demostracion=',new.id_demostracion,'; nombre_demostracion=',new.nombre_demostracion,'; descripcion=',new.descripcion)
    );
end//

create trigger del_demostracion
after delete on demostracion
for each row
begin
    call ins_log('demostracion','delete',
        concat('id_demostracion=',old.id_demostracion,'; nombre_demostracion=',old.nombre_demostracion,'; descripcion=',old.descripcion),
        null
    );
end//

create trigger ins_registro
after insert on registro
for each row
begin
    call ins_log('registro','insert',null,
        concat('id_registro=',new.id_registro,
               '; id_feria=',new.id_feria,
               '; id_stand=',new.id_stand,
               '; id_empresa=',new.id_empresa,
               '; id_charla=',new.id_charla,
               '; id_demostracion=',new.id_demostracion,
               '; id_ponente=',new.id_ponente,
               '; id_visitante=',new.id_visitante)
    );
end//

create trigger upd_registro
after update on registro
for each row
begin
    call ins_log('registro','update',
        concat('id_registro=',old.id_registro,
               '; id_feria=',old.id_feria,
               '; id_stand=',old.id_stand,
               '; id_empresa=',old.id_empresa,
               '; id_charla=',old.id_charla,
               '; id_demostracion=',old.id_demostracion,
               '; id_ponente=',old.id_ponente,
               '; id_visitante=',old.id_visitante),
        concat('id_registro=',new.id_registro,
               '; id_feria=',new.id_feria,
               '; id_stand=',new.id_stand,
               '; id_empresa=',new.id_empresa,
               '; id_charla=',new.id_charla,
               '; id_demostracion=',new.id_demostracion,
               '; id_ponente=',new.id_ponente,
               '; id_visitante=',new.id_visitante)
    );
end//

create trigger del_registro
after delete on registro
for each row
begin
    call ins_log('registro','delete',
        concat('id_registro=',old.id_registro,
               '; id_feria=',old.id_feria,
               '; id_stand=',old.id_stand,
               '; id_empresa=',old.id_empresa,
               '; id_charla=',old.id_charla,
               '; id_demostracion=',old.id_demostracion,
               '; id_ponente=',old.id_ponente,
               '; id_visitante=',old.id_visitante),
        null
    );
end//

delimiter ;