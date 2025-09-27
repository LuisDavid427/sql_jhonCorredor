-- creacion de logins

create login login_adminFeria with password = 'admin', check_policy = off;
create login login_estructura with password = 'estructura', check_policy = off;
create login login_empresarial with password = 'empresarial', check_policy = off;
create login login_personaa with password = 'personaa', check_policy = off;


-- creacion de usuarios

create user admin_feria for login login_adminFeria;
create user user_estructura for login login_estructura;
create user user_empresarial for login login_empresarial;
create user user_personaa for login login_personaa;
go

-- gestion de permisos para el admin_feria
grant control on schema::estructura to admin_feria;
grant control on schema::sector_empresarial to admin_feria;
grant control on schema::personas_actividades to admin_feria;
go

-- gestion de permisos para los otros usuarios
grant select, delete, update, insert on schema::estructura to user_estructura;
go
grant select, delete, update, insert on schema::sector_empresarial to user_empresarial;
go
grant select, delete, update, insert on schema::personas_actividades to user_personaa;
go

