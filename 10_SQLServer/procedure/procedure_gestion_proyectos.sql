CREATE OR ALTER PROCEDURE ej_gestion_proyectos
    @ruta_archivo NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️⃣ Recrear la base de datos
    IF DB_ID('gestion_proyectos') IS NOT NULL
    BEGIN
        ALTER DATABASE gestion_proyectos SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE gestion_proyectos;
    END;
    CREATE DATABASE gestion_proyectos;

    -- 2️⃣ Ejecutar script de tablas e inserciones
    DECLARE @sql NVARCHAR(MAX);
    DECLARE @command NVARCHAR(MAX);

    SET @command = '
        SELECT @sql_out = BulkColumn
        FROM OPENROWSET(
            BULK N''' + @ruta_archivo + ''',
            SINGLE_CLOB
        ) AS x;
    ';
    EXEC sp_executesql @command, N'@sql_out NVARCHAR(MAX) OUTPUT', @sql_out = @sql OUTPUT;
    EXEC sp_executesql @sql;

    -- 3️⃣ Crear las vistas individualmente
    
    -- Vista 1: Proyectos y sus equipos asignados
    EXEC gestion_proyectos.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_proyectos_y_equipos AS
    SELECT p.nombre AS nombre_proyecto, e.nombre AS nombre_equipo
    FROM dbo.proyecto p
    JOIN dbo.proyecto_equipo pe ON p.id_proyecto = pe.id_proyecto
    JOIN dbo.equipo e ON pe.id_equipo = e.id_equipo;';

    -- Vista 2: Tareas y su estado por proyecto
    EXEC gestion_proyectos.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_tareas_por_proyecto AS
    SELECT p.nombre AS nombre_proyecto, t.titulo AS titulo_tarea, t.estado
    FROM dbo.proyecto p
    JOIN dbo.tarea t ON p.id_proyecto = t.id_proyecto;';

    -- Vista 3: Horas registradas por cada usuario y tarea
    EXEC gestion_proyectos.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_horas_por_usuario_tarea AS
    SELECT u.nombre AS nombre_usuario, t.titulo AS titulo_tarea, rt.horas
    FROM dbo.usuario u
    JOIN dbo.registro_tiempo rt ON u.id_usuario = rt.id_usuario
    JOIN dbo.tarea t ON rt.id_tarea = t.id_tarea;';

    -- Vista 4: Total de horas registradas por cada proyecto
    EXEC gestion_proyectos.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_total_horas_por_proyecto AS
    SELECT p.nombre AS nombre_proyecto, SUM(rt.horas) AS total_horas_registradas
    FROM dbo.proyecto p
    JOIN dbo.tarea t ON p.id_proyecto = t.id_proyecto
    JOIN dbo.registro_tiempo rt ON t.id_tarea = rt.id_tarea
    GROUP BY p.nombre;';

    -- Vista 5: Usuarios y los equipos a los que pertenecen
    EXEC gestion_proyectos.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_usuarios_por_equipo AS
    SELECT e.nombre AS nombre_equipo, u.nombre AS nombre_usuario
    FROM dbo.equipo e
    JOIN dbo.equipo_usuario eu ON e.id_equipo = eu.id_equipo
    JOIN dbo.usuario u ON eu.id_usuario = u.id_usuario;';

END;
GO

EXEC ej_gestion_proyectos N'E:\ADSO\jhon_corredor\10_SQLServer\gestion_proyectos.sql';



use gestion_proyectos
select * from v_usuarios_por_equipo