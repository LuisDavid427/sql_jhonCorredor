use feria;
go

create procedure ins_log(
    @p_tabla varchar(60),
    @p_sentencia varchar(20),
    @p_datos_old varchar(max),
    @p_datos_new varchar(max))
as
begin
    insert into log (tabla, sentencia, usuario, fecha, datos_old, datos_new)
    values (@p_tabla, @p_sentencia, user_name(), getdate(), @p_datos_old, @p_datos_new);
end
go

-- feria (insert, update, delete)
create trigger ins_feria
on feria
after insert
as
begin
    declare @datos_new varchar(max);
    select @datos_new = 'id_feria=' + cast(i.id_feria as varchar(10)) 
                      + '; nombre=' + i.nombre 
                      + '; descripcion=' + i.descripcion
    from inserted i;
    exec ins_log 'feria', 'insert', null, @datos_new;
end
go

create trigger upd_feria
on feria
after update
as
begin
    declare @datos_old varchar(max), @datos_new varchar(max);
    select @datos_old = 'id_feria=' + cast(d.id_feria as varchar(10)) 
                      + '; nombre=' + d.nombre 
                      + '; descripcion=' + d.descripcion
    from deleted d;
    select @datos_new = 'id_feria=' + cast(i.id_feria as varchar(10)) 
                      + '; nombre=' + i.nombre 
                      + '; descripcion=' + i.descripcion
    from inserted i;
    exec ins_log 'feria', 'update', @datos_old, @datos_new;
end
go

create trigger del_feria
on feria
after delete
as
begin
    declare @datos_old varchar(max);
    select @datos_old = 'id_feria=' + cast(d.id_feria as varchar(10)) 
                      + '; nombre=' + d.nombre 
                      + '; descripcion=' + d.descripcion
    from deleted d;
    exec ins_log 'feria', 'delete', @datos_old, null;
end
go

-- tematica (insert, update, delete)
create trigger ins_tematica
on tematica
after insert
as
begin
    declare @datos_new varchar(max);
    select @datos_new = 'id_tematica=' + cast(i.id_tematica as varchar(10)) 
                      + '; tematica=' + i.tematica
    from inserted i;
    exec ins_log 'tematica', 'insert', null, @datos_new;
end
go

create trigger upd_tematica
on tematica
after update
as
begin
    declare @datos_old varchar(max), @datos_new varchar(max);
    select @datos_old = 'id_tematica=' + cast(d.id_tematica as varchar(10)) 
                      + '; tematica=' + d.tematica
    from deleted d;
    select @datos_new = 'id_tematica=' + cast(i.id_tematica as varchar(10)) 
                      + '; tematica=' + i.tematica
    from inserted i;
    exec ins_log 'tematica', 'update', @datos_old, @datos_new;
end
go

create trigger del_tematica
on tematica
after delete
as
begin
    declare @datos_old varchar(max);
    select @datos_old = 'id_tematica=' + cast(d.id_tematica as varchar(10)) 
                      + '; tematica=' + d.tematica
    from deleted d;
    exec ins_log 'tematica', 'delete', @datos_old, null;
end
go

-- pabellon (insert, update, delete)
create trigger ins_pabellon
on pabellon
after insert
as
begin
    declare @datos_new varchar(max);
    select @datos_new = 'id_pabellon=' + cast(i.id_pabellon as varchar(10)) 
                      + '; nombre=' + i.nombre 
                      + '; id_tematica=' + cast(i.id_tematica as varchar(10)) 
                      + '; id_feria=' + cast(i.id_feria as varchar(10))
    from inserted i;
    exec ins_log 'pabellon', 'insert', null, @datos_new;
end
go

create trigger upd_pabellon
on pabellon
after update
as
begin
    declare @datos_old varchar(max), @datos_new varchar(max);
    select @datos_old = 'id_pabellon=' + cast(d.id_pabellon as varchar(10)) 
                      + '; nombre=' + d.nombre 
                      + '; id_tematica=' + cast(d.id_tematica as varchar(10)) 
                      + '; id_feria=' + cast(d.id_feria as varchar(10))
    from deleted d;
    select @datos_new = 'id_pabellon=' + cast(i.id_pabellon as varchar(10)) 
                      + '; nombre=' + i.nombre 
                      + '; id_tematica=' + cast(i.id_tematica as varchar(10)) 
                      + '; id_feria=' + cast(i.id_feria as varchar(10))
    from inserted i;
    exec ins_log 'pabellon', 'update', @datos_old, @datos_new;
end
go

create trigger del_pabellon
on pabellon
after delete
as
begin
    declare @datos_old varchar(max);
    select @datos_old = 'id_pabellon=' + cast(d.id_pabellon as varchar(10)) 
                      + '; nombre=' + d.nombre 
                      + '; id_tematica=' + cast(d.id_tematica as varchar(10)) 
                      + '; id_feria=' + cast(d.id_feria as varchar(10))
    from deleted d;
    exec ins_log 'pabellon', 'delete', @datos_old, null;
end
go

-- empresa (insert, update, delete)
create trigger ins_empresa
on empresa
after insert
as
begin
    declare @datos_new varchar(max);
    select @datos_new = 'id_empresa=' + cast(i.id_empresa as varchar(10)) 
                      + '; nombre_empresa=' + i.nombre_empresa 
                      + '; descripcion=' + i.descripcion
    from inserted i;
    exec ins_log 'empresa', 'insert', null, @datos_new;
end
go

create trigger upd_empresa
on empresa
after update
as
begin
    declare @datos_old varchar(max), @datos_new varchar(max);
    select @datos_old = 'id_empresa=' + cast(d.id_empresa as varchar(10)) 
                      + '; nombre_empresa=' + d.nombre_empresa 
                      + '; descripcion=' + d.descripcion
    from deleted d;
    select @datos_new = 'id_empresa=' + cast(i.id_empresa as varchar(10)) 
                      + '; nombre_empresa=' + i.nombre_empresa 
                      + '; descripcion=' + i.descripcion
    from inserted i;
    exec ins_log 'empresa', 'update', @datos_old, @datos_new;
end
go

create trigger del_empresa
on empresa
after delete
as
begin
    declare @datos_old varchar(max);
    select @datos_old = 'id_empresa=' + cast(d.id_empresa as varchar(10)) 
                      + '; nombre_empresa=' + d.nombre_empresa 
                      + '; descripcion=' + d.descripcion
    from deleted d;
    exec ins_log 'empresa', 'delete', @datos_old, null;
end
go

-- stand (insert, update, delete)
create trigger ins_stand
on stand
after insert
as
begin
    declare @datos_new varchar(max);
    select @datos_new = 'id_stand=' + cast(i.id_stand as varchar(10)) 
                      + '; nombre_stand=' + i.nombre_stand 
                      + '; id_pabellon=' + cast(i.id_pabellon as varchar(10)) 
                      + '; id_empresa=' + cast(i.id_empresa as varchar(10))
    from inserted i;
    exec ins_log 'stand', 'insert', null, @datos_new;
end
go

create trigger upd_stand
on stand
after update
as
begin
    declare @datos_old varchar(max), @datos_new varchar(max);
    select @datos_old = 'id_stand=' + cast(d.id_stand as varchar(10)) 
                      + '; nombre_stand=' + d.nombre_stand 
                      + '; id_pabellon=' + cast(d.id_pabellon as varchar(10)) 
                      + '; id_empresa=' + cast(d.id_empresa as varchar(10))
    from deleted d;
    select @datos_new = 'id_stand=' + cast(i.id_stand as varchar(10)) 
                      + '; nombre_stand=' + i.nombre_stand 
                      + '; id_pabellon=' + cast(i.id_pabellon as varchar(10)) 
                      + '; id_empresa=' + cast(i.id_empresa as varchar(10))
    from inserted i;
    exec ins_log 'stand', 'update', @datos_old, @datos_new;
end
go

create trigger del_stand
on stand
after delete
as
begin
    declare @datos_old varchar(max);
    select @datos_old = 'id_stand=' + cast(d.id_stand as varchar(10)) 
                      + '; nombre_stand=' + d.nombre_stand 
                      + '; id_pabellon=' + cast(d.id_pabellon as varchar(10)) 
                      + '; id_empresa=' + cast(d.id_empresa as varchar(10))
    from deleted d;
    exec ins_log 'stand', 'delete', @datos_old, null;
end
go

-- producto (insert, update, delete)
create trigger ins_producto
on producto
after insert
as
begin
    declare @datos_new varchar(max);
    select @datos_new = 'id_producto=' + cast(i.id_producto as varchar(10)) 
                      + '; nombre_producto=' + i.nombre_producto 
                      + '; id_stand=' + cast(i.id_stand as varchar(10))
    from inserted i;
    exec ins_log 'producto', 'insert', null, @datos_new;
end
go

create trigger upd_producto
on producto
after update
as
begin
    declare @datos_old varchar(max), @datos_new varchar(max);
    select @datos_old = 'id_producto=' + cast(d.id_producto as varchar(10)) 
                      + '; nombre_producto=' + d.nombre_producto 
                      + '; id_stand=' + cast(d.id_stand as varchar(10))
    from deleted d;
    select @datos_new = 'id_producto=' + cast(i.id_producto as varchar(10)) 
                      + '; nombre_producto=' + i.nombre_producto 
                      + '; id_stand=' + cast(i.id_stand as varchar(10))
    from inserted i;
    exec ins_log 'producto', 'update', @datos_old, @datos_new;
end
go

create trigger del_producto
on producto
after delete
as
begin
    declare @datos_old varchar(max);
    select @datos_old = 'id_producto=' + cast(d.id_producto as varchar(10)) 
                      + '; nombre_producto=' + d.nombre_producto 
                      + '; id_stand=' + cast(d.id_stand as varchar(10))
    from deleted d;
    exec ins_log 'producto', 'delete', @datos_old, null;
end
go

-- persona (insert, update, delete)
create trigger ins_persona
on persona
after insert
as
begin
    declare @datos_new varchar(max);
    select @datos_new = 'id_persona=' + cast(i.id_persona as varchar(10)) 
                      + '; nombre=' + i.nombre 
                      + '; dni=' + i.dni 
                      + '; telefono=' + i.telefono
    from inserted i;
    exec ins_log 'persona', 'insert', null, @datos_new;
end
go

create trigger upd_persona
on persona
after update
as
begin
    declare @datos_old varchar(max), @datos_new varchar(max);
    select @datos_old = 'id_persona=' + cast(d.id_persona as varchar(10)) 
                      + '; nombre=' + d.nombre 
                      + '; dni=' + d.dni 
                      + '; telefono=' + d.telefono
    from deleted d;
    select @datos_new = 'id_persona=' + cast(i.id_persona as varchar(10)) 
                      + '; nombre=' + i.nombre 
                      + '; dni=' + i.dni 
                      + '; telefono=' + i.telefono
    from inserted i;
    exec ins_log 'persona', 'update', @datos_old, @datos_new;
end
go

create trigger del_persona
on persona
after delete
as
begin
    declare @datos_old varchar(max);
    select @datos_old = 'id_persona=' + cast(d.id_persona as varchar(10)) 
                      + '; nombre=' + d.nombre 
                      + '; dni=' + d.dni 
                      + '; telefono=' + d.telefono
    from deleted d;
    exec ins_log 'persona', 'delete', @datos_old, null;
end
go

-- responsable (insert, update, delete)
create trigger ins_responsable
on responsable
after insert
as
begin
    declare @datos_new varchar(max);
    select @datos_new = 'id_responsable=' + cast(i.id_responsable as varchar(10)) 
                      + '; id_producto=' + cast(i.id_producto as varchar(10)) 
                      + '; id_persona=' + cast(i.id_persona as varchar(10))
    from inserted i;
    exec ins_log 'responsable', 'insert', null, @datos_new;
end
go

create trigger upd_responsable
on responsable
after update
as
begin
    declare @datos_old varchar(max), @datos_new varchar(max);
    select @datos_old = 'id_responsable=' + cast(d.id_responsable as varchar(10)) 
                      + '; id_producto=' + cast(d.id_producto as varchar(10)) 
                      + '; id_persona=' + cast(d.id_persona as varchar(10))
    from deleted d;
    select @datos_new = 'id_responsable=' + cast(i.id_responsable as varchar(10)) 
                      + '; id_producto=' + cast(i.id_producto as varchar(10)) 
                      + '; id_persona=' + cast(i.id_persona as varchar(10))
    from inserted i;
    exec ins_log 'responsable', 'update', @datos_old, @datos_new;
end
go

create trigger del_responsable
on responsable
after delete
as
begin
    declare @datos_old varchar(max);
    select @datos_old = 'id_responsable=' + cast(d.id_responsable as varchar(10)) 
                      + '; id_producto=' + cast(d.id_producto as varchar(10)) 
                      + '; id_persona=' + cast(d.id_persona as varchar(10))
    from deleted d;
    exec ins_log 'responsable', 'delete', @datos_old, null;
end
go

-- ponente (insert, update, delete)
create trigger ins_ponente
on ponente
after insert
as
begin
    declare @datos_new varchar(max);
    select @datos_new = 'id_ponente=' + cast(i.id_ponente as varchar(10)) 
                      + '; id_persona=' + cast(i.id_persona as varchar(10))
    from inserted i;
    exec ins_log 'ponente', 'insert', null, @datos_new;
end
go

create trigger upd_ponente
on ponente
after update
as
begin
    declare @datos_old varchar(max), @datos_new varchar(max);
    select @datos_old = 'id_ponente=' + cast(d.id_ponente as varchar(10)) 
                      + '; id_persona=' + cast(d.id_persona as varchar(10))
    from deleted d;
    select @datos_new = 'id_ponente=' + cast(i.id_ponente as varchar(10)) 
                      + '; id_persona=' + cast(i.id_persona as varchar(10))
    from inserted i;
    exec ins_log 'ponente', 'update', @datos_old, @datos_new;
end
go

create trigger del_ponente
on ponente
after delete
as
begin
    declare @datos_old varchar(max);
    select @datos_old = 'id_ponente=' + cast(d.id_ponente as varchar(10)) 
                      + '; id_persona=' + cast(d.id_persona as varchar(10))
    from deleted d;
    exec ins_log 'ponente', 'delete', @datos_old, null;
end
go

-- tipo_visitante (insert, update, delete)
create trigger ins_tipo_visitante
on tipo_visitante
after insert
as
begin
    declare @datos_new varchar(max);
    select @datos_new = 'id_tipo=' + cast(i.id_tipo as varchar(10)) 
                      + '; tipo=' + i.tipo
    from inserted i;
    exec ins_log 'tipo_visitante', 'insert', null, @datos_new;
end
go

create trigger upd_tipo_visitante
on tipo_visitante
after update
as
begin
    declare @datos_old varchar(max), @datos_new varchar(max);
    select @datos_old = 'id_tipo=' + cast(d.id_tipo as varchar(10)) 
                      + '; tipo=' + d.tipo
    from deleted d;
    select @datos_new = 'id_tipo=' + cast(i.id_tipo as varchar(10)) 
                      + '; tipo=' + i.tipo
    from inserted i;
    exec ins_log 'tipo_visitante', 'update', @datos_old, @datos_new;
end
go

create trigger del_tipo_visitante
on tipo_visitante
after delete
as
begin
    declare @datos_old varchar(max);
    select @datos_old = 'id_tipo=' + cast(d.id_tipo as varchar(10)) 
                      + '; tipo=' + d.tipo
    from deleted d;
    exec ins_log 'tipo_visitante', 'delete', @datos_old, null;
end
go

-- visitante (insert, update, delete)
create trigger ins_visitante
on visitante
after insert
as
begin
    declare @datos_new varchar(max);
    select @datos_new = 'id_visitante=' + cast(i.id_visitante as varchar(10)) 
                      + '; id_persona=' + cast(i.id_persona as varchar(10)) 
                      + '; id_tipo=' + cast(i.id_tipo as varchar(10))
    from inserted i;
    exec ins_log 'visitante', 'insert', null, @datos_new;
end
go

create trigger upd_visitante
on visitante
after update
as
begin
    declare @datos_old varchar(max), @datos_new varchar(max);
    select @datos_old = 'id_visitante=' + cast(d.id_visitante as varchar(10)) 
                      + '; id_persona=' + cast(d.id_persona as varchar(10)) 
                      + '; id_tipo=' + cast(d.id_tipo as varchar(10))
    from deleted d;
    select @datos_new = 'id_visitante=' + cast(i.id_visitante as varchar(10)) 
                      + '; id_persona=' + cast(i.id_persona as varchar(10)) 
                      + '; id_tipo=' + cast(i.id_tipo as varchar(10))
    from inserted i;
    exec ins_log 'visitante', 'update', @datos_old, @datos_new;
end
go

create trigger del_visitante
on visitante
after delete
as
begin
    declare @datos_old varchar(max);
    select @datos_old = 'id_visitante=' + cast(d.id_visitante as varchar(10)) 
                      + '; id_persona=' + cast(d.id_persona as varchar(10)) 
                      + '; id_tipo=' + cast(d.id_tipo as varchar(10))
    from deleted d;
    exec ins_log 'visitante', 'delete', @datos_old, null;
end
go

-- charla (insert, update, delete)
create trigger ins_charla
on charla
after insert
as
begin
    declare @datos_new varchar(max);
    select @datos_new = 'id_charla=' + cast(i.id_charla as varchar(10)) 
                      + '; nombre_charla=' + i.nombre_charla 
                      + '; descripcion=' + i.descripcion
    from inserted i;
    exec ins_log 'charla', 'insert', null, @datos_new;
end
go

create trigger upd_charla
on charla
after update
as
begin
    declare @datos_old varchar(max), @datos_new varchar(max);
    select @datos_old = 'id_charla=' + cast(d.id_charla as varchar(10)) 
                      + '; nombre_charla=' + d.nombre_charla 
                      + '; descripcion=' + d.descripcion
    from deleted d;
    select @datos_new = 'id_charla=' + cast(i.id_charla as varchar(10)) 
                      + '; nombre_charla=' + i.nombre_charla 
                      + '; descripcion=' + i.descripcion
    from inserted i;
    exec ins_log 'charla', 'update', @datos_old, @datos_new;
end
go

create trigger del_charla
on charla
after delete
as
begin
    declare @datos_old varchar(max);
    select @datos_old = 'id_charla=' + cast(d.id_charla as varchar(10)) 
                      + '; nombre_charla=' + d.nombre_charla 
                      + '; descripcion=' + d.descripcion
    from deleted d;
    exec ins_log 'charla', 'delete', @datos_old, null;
end
go

-- demostracion (insert, update, delete)
create trigger ins_demostracion
on demostracion
after insert
as
begin
    declare @datos_new varchar(max);
    select @datos_new = 'id_demostracion=' + cast(i.id_demostracion as varchar(10)) 
                      + '; nombre_demostracion=' + i.nombre_demostracion 
                      + '; descripcion=' + i.descripcion
    from inserted i;
    exec ins_log 'demostracion', 'insert', null, @datos_new;
end
go

create trigger upd_demostracion
on demostracion
after update
as
begin
    declare @datos_old varchar(max), @datos_new varchar(max);
    select @datos_old = 'id_demostracion=' + cast(d.id_demostracion as varchar(10)) 
                      + '; nombre_demostracion=' + d.nombre_demostracion 
                      + '; descripcion=' + d.descripcion
    from deleted d;
    select @datos_new = 'id_demostracion=' + cast(i.id_demostracion as varchar(10)) 
                      + '; nombre_demostracion=' + i.nombre_demostracion 
                      + '; descripcion=' + i.descripcion
    from inserted i;
    exec ins_log 'demostracion', 'update', @datos_old, @datos_new;
end
go

create trigger del_demostracion
on demostracion
after delete
as
begin
    declare @datos_old varchar(max);
    select @datos_old = 'id_demostracion=' + cast(d.id_demostracion as varchar(10)) 
                      + '; nombre_demostracion=' + d.nombre_demostracion 
                      + '; descripcion=' + d.descripcion
    from deleted d;
    exec ins_log 'demostracion', 'delete', @datos_old, null;
end
go

-- registro (insert, update, delete)
create trigger ins_registro
on registro
after insert
as
begin
    declare @datos_new varchar(max);
    select @datos_new = 'id_registro=' + cast(i.id_registro as varchar(10)) 
                      + '; id_feria=' + cast(i.id_feria as varchar(10)) 
                      + '; id_stand=' + cast(i.id_stand as varchar(10)) 
                      + '; id_empresa=' + cast(i.id_empresa as varchar(10)) 
                      + '; id_charla=' + cast(i.id_charla as varchar(10)) 
                      + '; id_demostracion=' + cast(i.id_demostracion as varchar(10)) 
                      + '; id_ponente=' + cast(i.id_ponente as varchar(10)) 
                      + '; id_visitante=' + cast(i.id_visitante as varchar(10))
    from inserted i;
    exec ins_log 'registro', 'insert', null, @datos_new;
end
go

create trigger upd_registro
on registro
after update
as
begin
    declare @datos_old varchar(max), @datos_new varchar(max);
    select @datos_old = 'id_registro=' + cast(d.id_registro as varchar(10)) 
                      + '; id_feria=' + cast(d.id_feria as varchar(10)) 
                      + '; id_stand=' + cast(d.id_stand as varchar(10)) 
                      + '; id_empresa=' + cast(d.id_empresa as varchar(10)) 
                      + '; id_charla=' + cast(d.id_charla as varchar(10)) 
                      + '; id_demostracion=' + cast(d.id_demostracion as varchar(10)) 
                      + '; id_ponente=' + cast(d.id_ponente as varchar(10)) 
                      + '; id_visitante=' + cast(d.id_visitante as varchar(10))
    from deleted d;
    select @datos_new = 'id_registro=' + cast(i.id_registro as varchar(10)) 
                      + '; id_feria=' + cast(i.id_feria as varchar(10)) 
                      + '; id_stand=' + cast(i.id_stand as varchar(10)) 
                      + '; id_empresa=' + cast(i.id_empresa as varchar(10)) 
                      + '; id_charla=' + cast(i.id_charla as varchar(10)) 
                      + '; id_demostracion=' + cast(i.id_demostracion as varchar(10)) 
                      + '; id_ponente=' + cast(i.id_ponente as varchar(10)) 
                      + '; id_visitante=' + cast(i.id_visitante as varchar(10))
    from inserted i;
    exec ins_log 'registro', 'update', @datos_old, @datos_new;
end
go

create trigger del_registro
on registro
after delete
as
begin
    declare @datos_old varchar(max);
    select @datos_old = 'id_registro=' + cast(d.id_registro as varchar(10)) 
                      + '; id_feria=' + cast(d.id_feria as varchar(10)) 
                      + '; id_stand=' + cast(d.id_stand as varchar(10)) 
                      + '; id_empresa=' + cast(d.id_empresa as varchar(10)) 
                      + '; id_charla=' + cast(d.id_charla as varchar(10)) 
                      + '; id_demostracion=' + cast(d.id_demostracion as varchar(10)) 
                      + '; id_ponente=' + cast(d.id_ponente as varchar(10)) 
                      + '; id_visitante=' + cast(d.id_visitante as varchar(10))
    from deleted d;
    exec ins_log 'registro', 'delete', @datos_old, null;
end
go
