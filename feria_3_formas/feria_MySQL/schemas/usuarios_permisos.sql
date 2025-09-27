create user 'user_adminferia'@'%' identified by 'admin';
create user 'user_estructura'@'%' identified by 'estructura';
create user 'user_empresarial'@'%' identified by 'empresarial';
create user 'user_personaa'@'%' identified by 'personaa';


grant all privileges on estructura.* to 'user_adminferia'@'%';
grant all privileges on sector_empresarial.* to 'user_adminferia'@'%';
grant all privileges on personas_actividades.* to 'user_adminferia'@'%';

grant select, insert, update, delete on estructura.* to 'user_estructura'@'%';

grant select, insert, update, delete on sector_empresarial.* to 'user_empresarial'@'%';

grant select, insert, update, delete on personas_actividades.* to 'user_personaa'@'%';