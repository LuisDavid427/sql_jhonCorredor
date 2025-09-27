create user user_adminferia with password 'admin';
create user user_estructura with password 'estructura';
create user user_empresarial with password 'empresarial';
create user user_personaa with password 'personaa';


-- permisos de admin
grant all privileges on all tables in schema estructura to user_adminferia;
grant all privileges on all sequences in schema estructura to user_adminferia; 
grant usage on schema estructura to user_adminferia;

grant all privileges on all tables in schema sector_empresarial to user_adminferia;
grant all privileges on all sequences in schema sector_empresarial to user_adminferia;
grant usage on schema sector_empresarial to user_adminferia;

grant all privileges on all tables in schema personas_actividades to user_adminferia;
grant all privileges on all sequences in schema personas_actividades to user_adminferia;
grant usage on schema personas_actividades to user_adminferia;


-- permisis de los demas usuarios

-- usuario estructura
grant select, insert, update, delete on all tables in schema estructura to user_estructura;
grant usage on schema estructura to user_estructura;
grant usage, select on all sequences in schema estructura to user_estructura;
-- usuario empresarial
grant select, insert, update, delete on all tables in schema sector_empresarial to user_empresarial;
grant usage on schema sector_empresarial to user_empresarial;
grant usage, select on all sequences in schema sector_empresarial to user_empresarial;

-- usuario personaa
grant select, insert, update, delete on all tables in schema personas_actividades to user_personaa;
grant usage on schema personas_actividades to user_personaa;
grant usage, select on all sequences in schema personas_actividades to user_personaa;

