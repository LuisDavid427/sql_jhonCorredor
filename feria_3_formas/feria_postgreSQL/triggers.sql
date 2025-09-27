
-- feria (insert, update, delete)
create or replace function trg_feria_log()
returns trigger as
$$
declare
    datos_old text;
    datos_new text;
begin
    if (tg_op = 'insert') then
        datos_new := 'id_feria=' || new.id_feria::text || '; nombre=' || new.nombre || '; descripcion=' || new.descripcion;
        perform ins_log('feria', 'insert', null, datos_new);
        return new;
    elsif (tg_op = 'update') then
        datos_old := 'id_feria=' || old.id_feria::text || '; nombre=' || old.nombre || '; descripcion=' || old.descripcion;
        datos_new := 'id_feria=' || new.id_feria::text || '; nombre=' || new.nombre || '; descripcion=' || new.descripcion;
        perform ins_log('feria', 'update', datos_old, datos_new);
        return new;
    elsif (tg_op = 'delete') then
        datos_old := 'id_feria=' || old.id_feria::text || '; nombre=' || old.nombre || '; descripcion=' || old.descripcion;
        perform ins_log('feria', 'delete', datos_old, null);
        return old;
    end if;
    return null;
end;
$$
language plpgsql;

create trigger trg_feria
after insert or update or delete on feria
for each row
execute function trg_feria_log();

-- tematica (insert, update, delete)
create or replace function trg_tematica_log()
returns trigger as
$$
declare
    datos_old text;
    datos_new text;
begin
    if (tg_op = 'insert') then
        datos_new := 'id_tematica=' || new.id_tematica::text || '; tematica=' || new.tematica;
        perform ins_log('tematica', 'insert', null, datos_new);
        return new;
    elsif (tg_op = 'update') then
        datos_old := 'id_tematica=' || old.id_tematica::text || '; tematica=' || old.tematica;
        datos_new := 'id_tematica=' || new.id_tematica::text || '; tematica=' || new.tematica;
        perform ins_log('tematica', 'update', datos_old, datos_new);
        return new;
    elsif (tg_op = 'delete') then
        datos_old := 'id_tematica=' || old.id_tematica::text || '; tematica=' || old.tematica;
        perform ins_log('tematica', 'delete', datos_old, null);
        return old;
    end if;
    return null;
end;
$$
language plpgsql;

create trigger trg_tematica
after insert or update or delete on tematica
for each row
execute function trg_tematica_log();

-- pabellon (insert, update, delete)
create or replace function trg_pabellon_log()
returns trigger as
$$
declare
    datos_old text;
    datos_new text;
begin
    if (tg_op = 'insert') then
        datos_new := 'id_pabellon=' || new.id_pabellon::text || '; nombre=' || new.nombre || '; id_tematica=' || new.id_tematica::text || '; id_feria=' || new.id_feria::text;
        perform ins_log('pabellon', 'insert', null, datos_new);
        return new;
    elsif (tg_op = 'update') then
        datos_old := 'id_pabellon=' || old.id_pabellon::text || '; nombre=' || old.nombre || '; id_tematica=' || old.id_tematica::text || '; id_feria=' || old.id_feria::text;
        datos_new := 'id_pabellon=' || new.id_pabellon::text || '; nombre=' || new.nombre || '; id_tematica=' || new.id_tematica::text || '; id_feria=' || new.id_feria::text;
        perform ins_log('pabellon', 'update', datos_old, datos_new);
        return new;
    elsif (tg_op = 'delete') then
        datos_old := 'id_pabellon=' || old.id_pabellon::text || '; nombre=' || old.nombre || '; id_tematica=' || old.id_tematica::text || '; id_feria=' || old.id_feria::text;
        perform ins_log('pabellon', 'delete', datos_old, null);
        return old;
    end if;
    return null;
end;
$$
language plpgsql;

create trigger trg_pabellon
after insert or update or delete on pabellon
for each row
execute function trg_pabellon_log();

-- empresa (insert, update, delete)
create or replace function trg_empresa_log()
returns trigger as
$$
declare
    datos_old text;
    datos_new text;
begin
    if (tg_op = 'insert') then
        datos_new := 'id_empresa=' || new.id_empresa::text || '; nombre_empresa=' || new.nombre_empresa || '; descripcion=' || new.descripcion;
        perform ins_log('empresa', 'insert', null, datos_new);
        return new;
    elsif (tg_op = 'update') then
        datos_old := 'id_empresa=' || old.id_empresa::text || '; nombre_empresa=' || old.nombre_empresa || '; descripcion=' || old.descripcion;
        datos_new := 'id_empresa=' || new.id_empresa::text || '; nombre_empresa=' || new.nombre_empresa || '; descripcion=' || new.descripcion;
        perform ins_log('empresa', 'update', datos_old, datos_new);
        return new;
    elsif (tg_op = 'delete') then
        datos_old := 'id_empresa=' || old.id_empresa::text || '; nombre_empresa=' || old.nombre_empresa || '; descripcion=' || old.descripcion;
        perform ins_log('empresa', 'delete', datos_old, null);
        return old;
    end if;
    return null;
end;
$$
language plpgsql;

create trigger trg_empresa
after insert or update or delete on empresa
for each row
execute function trg_empresa_log();

-- stand (insert, update, delete)
create or replace function trg_stand_log()
returns trigger as
$$
declare
    datos_old text;
    datos_new text;
begin
    if (tg_op = 'insert') then
        datos_new := 'id_stand=' || new.id_stand::text || '; nombre_stand=' || new.nombre_stand || '; id_pabellon=' || new.id_pabellon::text || '; id_empresa=' || new.id_empresa::text;
        perform ins_log('stand', 'insert', null, datos_new);
        return new;
    elsif (tg_op = 'update') then
        datos_old := 'id_stand=' || old.id_stand::text || '; nombre_stand=' || old.nombre_stand || '; id_pabellon=' || old.id_pabellon::text || '; id_empresa=' || old.id_empresa::text;
        datos_new := 'id_stand=' || new.id_stand::text || '; nombre_stand=' || new.nombre_stand || '; id_pabellon=' || new.id_pabellon::text || '; id_empresa=' || new.id_empresa::text;
        perform ins_log('stand', 'update', datos_old, datos_new);
        return new;
    elsif (tg_op = 'delete') then
        datos_old := 'id_stand=' || old.id_stand::text || '; nombre_stand=' || old.nombre_stand || '; id_pabellon=' || old.id_pabellon::text || '; id_empresa=' || old.id_empresa::text;
        perform ins_log('stand', 'delete', datos_old, null);
        return old;
    end if;
    return null;
end;
$$
language plpgsql;

create trigger trg_stand
after insert or update or delete on stand
for each row
execute function trg_stand_log();

-- producto (insert, update, delete)
create or replace function trg_producto_log()
returns trigger as
$$
declare
    datos_old text;
    datos_new text;
begin
    if (tg_op = 'insert') then
        datos_new := 'id_producto=' || new.id_producto::text || '; nombre_producto=' || new.nombre_producto || '; id_stand=' || new.id_stand::text;
        perform ins_log('producto', 'insert', null, datos_new);
        return new;
    elsif (tg_op = 'update') then
        datos_old := 'id_producto=' || old.id_producto::text || '; nombre_producto=' || old.nombre_producto || '; id_stand=' || old.id_stand::text;
        datos_new := 'id_producto=' || new.id_producto::text || '; nombre_producto=' || new.nombre_producto || '; id_stand=' || new.id_stand::text;
        perform ins_log('producto', 'update', datos_old, datos_new);
        return new;
    elsif (tg_op = 'delete') then
        datos_old := 'id_producto=' || old.id_producto::text || '; nombre_producto=' || old.nombre_producto || '; id_stand=' || old.id_stand::text;
        perform ins_log('producto', 'delete', datos_old, null);
        return old;
    end if;
    return null;
end;
$$
language plpgsql;

create trigger trg_producto
after insert or update or delete on producto
for each row
execute function trg_producto_log();

-- persona (insert, update, delete)
create or replace function trg_persona_log()
returns trigger as
$$
declare
    datos_old text;
    datos_new text;
begin
    if (tg_op = 'insert') then
        datos_new := 'id_persona=' || new.id_persona::text || '; nombre=' || new.nombre || '; dni=' || new.dni || '; telefono=' || new.telefono;
        perform ins_log('persona', 'insert', null, datos_new);
        return new;
    elsif (tg_op = 'update') then
        datos_old := 'id_persona=' || old.id_persona::text || '; nombre=' || old.nombre || '; dni=' || old.dni || '; telefono=' || old.telefono;
        datos_new := 'id_persona=' || new.id_persona::text || '; nombre=' || new.nombre || '; dni=' || new.dni || '; telefono=' || new.telefono;
        perform ins_log('persona', 'update', datos_old, datos_new);
        return new;
    elsif (tg_op = 'delete') then
        datos_old := 'id_persona=' || old.id_persona::text || '; nombre=' || old.nombre || '; dni=' || old.dni || '; telefono=' || old.telefono;
        perform ins_log('persona', 'delete', datos_old, null);
        return old;
    end if;
    return null;
end;
$$
language plpgsql;

create trigger trg_persona
after insert or update or delete on persona
for each row
execute function trg_persona_log();

-- responsable (insert, update, delete)
create or replace function trg_responsable_log()
returns trigger as
$$
declare
    datos_old text;
    datos_new text;
begin
    if (tg_op = 'insert') then
        datos_new := 'id_responsable=' || new.id_responsable::text || '; id_producto=' || new.id_producto::text || '; id_persona=' || new.id_persona::text;
        perform ins_log('responsable', 'insert', null, datos_new);
        return new;
    elsif (tg_op = 'update') then
        datos_old := 'id_responsable=' || old.id_responsable::text || '; id_producto=' || old.id_producto::text || '; id_persona=' || old.id_persona::text;
        datos_new := 'id_responsable=' || new.id_responsable::text || '; id_producto=' || new.id_producto::text || '; id_persona=' || new.id_persona::text;
        perform ins_log('responsable', 'update', datos_old, datos_new);
        return new;
    elsif (tg_op = 'delete') then
        datos_old := 'id_responsable=' || old.id_responsable::text || '; id_producto=' || old.id_producto::text || '; id_persona=' || old.id_persona::text;
        perform ins_log('responsable', 'delete', datos_old, null);
        return old;
    end if;
    return null;
end;
$$
language plpgsql;

create trigger trg_responsable
after insert or update or delete on responsable
for each row
execute function trg_responsable_log();

-- ponente (insert, update, delete)
create or replace function trg_ponente_log()
returns trigger as
$$
declare
    datos_old text;
    datos_new text;
begin
    if (tg_op = 'insert') then
        datos_new := 'id_ponente=' || new.id_ponente::text || '; id_persona=' || new.id_persona::text;
        perform ins_log('ponente', 'insert', null, datos_new);
        return new;
    elsif (tg_op = 'update') then
        datos_old := 'id_ponente=' || old.id_ponente::text || '; id_persona=' || old.id_persona::text;
        datos_new := 'id_ponente=' || new.id_ponente::text || '; id_persona=' || new.id_persona::text;
        perform ins_log('ponente', 'update', datos_old, datos_new);
        return new;
    elsif (tg_op = 'delete') then
        datos_old := 'id_ponente=' || old.id_ponente::text || '; id_persona=' || old.id_persona::text;
        perform ins_log('ponente', 'delete', datos_old, null);
        return old;
    end if;
    return null;
end;
$$
language plpgsql;

create trigger trg_ponente
after insert or update or delete on ponente
for each row
execute function trg_ponente_log();

-- tipo_visitante (insert, update, delete)
create or replace function trg_tipo_visitante_log()
returns trigger as
$$
declare
    datos_old text;
    datos_new text;
begin
    if (tg_op = 'insert') then
        datos_new := 'id_tipo=' || new.id_tipo::text || '; tipo=' || new.tipo;
        perform ins_log('tipo_visitante', 'insert', null, datos_new);
        return new;
    elsif (tg_op = 'update') then
        datos_old := 'id_tipo=' || old.id_tipo::text || '; tipo=' || old.tipo;
        datos_new := 'id_tipo=' || new.id_tipo::text || '; tipo=' || new.tipo;
        perform ins_log('tipo_visitante', 'update', datos_old, datos_new);
        return new;
    elsif (tg_op = 'delete') then
        datos_old := 'id_tipo=' || old.id_tipo::text || '; tipo=' || old.tipo;
        perform ins_log('tipo_visitante', 'delete', datos_old, null);
        return old;
    end if;
    return null;
end;
$$
language plpgsql;

create trigger trg_tipo_visitante
after insert or update or delete on tipo_visitante
for each row
execute function trg_tipo_visitante_log();

-- visitante (insert, update, delete)
create or replace function trg_visitante_log()
returns trigger as
$$
declare
    datos_old text;
    datos_new text;
begin
    if (tg_op = 'insert') then
        datos_new := 'id_visitante=' || new.id_visitante::text || '; id_persona=' || new.id_persona::text || '; id_tipo=' || new.id_tipo::text;
        perform ins_log('visitante', 'insert', null, datos_new);
        return new;
    elsif (tg_op = 'update') then
        datos_old := 'id_visitante=' || old.id_visitante::text || '; id_persona=' || old.id_persona::text || '; id_tipo=' || old.id_tipo::text;
        datos_new := 'id_visitante=' || new.id_visitante::text || '; id_persona=' || new.id_persona::text || '; id_tipo=' || new.id_tipo::text;
        perform ins_log('visitante', 'update', datos_old, datos_new);
        return new;
    elsif (tg_op = 'delete') then
        datos_old := 'id_visitante=' || old.id_visitante::text || '; id_persona=' || old.id_persona::text || '; id_tipo=' || old.id_tipo::text;
        perform ins_log('visitante', 'delete', datos_old, null);
        return old;
    end if;
    return null;
end;
$$
language plpgsql;

create trigger trg_visitante
after insert or update or delete on visitante
for each row
execute function trg_visitante_log();

-- charla (insert, update, delete)
create or replace function trg_charla_log()
returns trigger as
$$
declare
    datos_old text;
    datos_new text;
begin
    if (tg_op = 'insert') then
        datos_new := 'id_charla=' || new.id_charla::text || '; nombre_charla=' || new.nombre_charla || '; descripcion=' || new.descripcion;
        perform ins_log('charla', 'insert', null, datos_new);
        return new;
    elsif (tg_op = 'update') then
        datos_old := 'id_charla=' || old.id_charla::text || '; nombre_charla=' || old.nombre_charla || '; descripcion=' || old.descripcion;
        datos_new := 'id_charla=' || new.id_charla::text || '; nombre_charla=' || new.nombre_charla || '; descripcion=' || new.descripcion;
        perform ins_log('charla', 'update', datos_old, datos_new);
        return new;
    elsif (tg_op = 'delete') then
        datos_old := 'id_charla=' || old.id_charla::text || '; nombre_charla=' || old.nombre_charla || '; descripcion=' || old.descripcion;
        perform ins_log('charla', 'delete', datos_old, null);
        return old;
    end if;
    return null;
end;
$$
language plpgsql;

create trigger trg_charla
after insert or update or delete on charla
for each row
execute function trg_charla_log();

-- demostracion (insert, update, delete)
create or replace function trg_demostracion_log()
returns trigger as
$$
declare
    datos_old text;
    datos_new text;
begin
    if (tg_op = 'insert') then
        datos_new := 'id_demostracion=' || new.id_demostracion::text || '; nombre_demostracion=' || new.nombre_demostracion || '; descripcion=' || new.descripcion;
        perform ins_log('demostracion', 'insert', null, datos_new);
        return new;
    elsif (tg_op = 'update') then
        datos_old := 'id_demostracion=' || old.id_demostracion::text || '; nombre_demostracion=' || old.nombre_demostracion || '; descripcion=' || old.descripcion;
        datos_new := 'id_demostracion=' || new.id_demostracion::text || '; nombre_demostracion=' || new.nombre_demostracion || '; descripcion=' || new.descripcion;
        perform ins_log('demostracion', 'update', datos_old, datos_new);
        return new;
    elsif (tg_op = 'delete') then
        datos_old := 'id_demostracion=' || old.id_demostracion::text || '; nombre_demostracion=' || old.nombre_demostracion || '; descripcion=' || old.descripcion;
        perform ins_log('demostracion', 'delete', datos_old, null);
        return old;
    end if;
    return null;
end;
$$
language plpgsql;

create trigger trg_demostracion
after insert or update or delete on demostracion
for each row
execute function trg_demostracion_log();

-- registro (insert, update, delete)
create or replace function trg_registro_log()
returns trigger as
$$
declare
    datos_old text;
    datos_new text;
begin
    if (tg_op = 'insert') then
        datos_new := 'id_registro=' || new.id_registro::text || '; id_feria=' || new.id_feria::text || '; id_stand=' || new.id_stand::text || '; id_empresa=' || new.id_empresa::text || '; id_charla=' || new.id_charla::text || '; id_demostracion=' || new.id_demostracion::text || '; id_ponente=' || new.id_ponente::text || '; id_visitante=' || new.id_visitante::text;
        perform ins_log('registro', 'insert', null, datos_new);
        return new;
    elsif (tg_op = 'update') then
        datos_old := 'id_registro=' || old.id_registro::text || '; id_feria=' || old.id_feria::text || '; id_stand=' || old.id_stand::text || '; id_empresa=' || old.id_empresa::text || '; id_charla=' || old.id_charla::text || '; id_demostracion=' || old.id_demostracion::text || '; id_ponente=' || old.id_ponente::text || '; id_visitante=' || old.id_visitante::text;
        datos_new := 'id_registro=' || new.id_registro::text || '; id_feria=' || new.id_feria::text || '; id_stand=' || new.id_stand::text || '; id_empresa=' || new.id_empresa::text || '; id_charla=' || new.id_charla::text || '; id_demostracion=' || new.id_demostracion::text || '; id_ponente=' || new.id_ponente::text || '; id_visitante=' || new.id_visitante::text;
        perform ins_log('registro', 'update', datos_old, datos_new);
        return new;
    elsif (tg_op = 'delete') then
        datos_old := 'id_registro=' || old.id_registro::text || '; id_feria=' || old.id_feria::text || '; id_stand=' || old.id_stand::text || '; id_empresa=' || old.id_empresa::text || '; id_charla=' || old.id_charla::text || '; id_demostracion=' || old.id_demostracion::text || '; id_ponente=' || old.id_ponente::text || '; id_visitante=' || old.id_visitante::text;
        perform ins_log('registro', 'delete', datos_old, null);
        return old;
    end if;
    return null;
end;
$$
language plpgsql;

create trigger trg_registro
after insert or update or delete on registro
for each row
execute function trg_registro_log();