CREATE OR ALTER PROCEDURE ej_objetos_malditos
    @ruta_archivo NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️⃣ Recrear la base de datos
    IF DB_ID('objetos_malditos') IS NOT NULL
    BEGIN
        ALTER DATABASE objetos_malditos SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE objetos_malditos;
    END;
    CREATE DATABASE objetos_malditos;

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
    
    -- Vista 1: Objetos asignados a cada curador
    EXEC objetos_malditos.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_objetos_por_curador AS
    SELECT c.nombre AS curador_asignado, o.nombre AS objeto_maldito, o.peligro
    FROM dbo.curador c
    JOIN dbo.curador_objeto co ON c.id_curador = co.id_curador
    JOIN dbo.objeto o ON co.id_objeto = o.id_objeto;';

    -- Vista 2: Eventos asociados a cada objeto
    EXEC objetos_malditos.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_eventos_por_objeto AS
    SELECT o.nombre AS objeto_maldito, e.descripcion AS evento_registrado, e.fecha
    FROM dbo.objeto o
    JOIN dbo.objeto_evento oe ON o.id_objeto = oe.id_objeto
    JOIN dbo.evento e ON oe.id_evento = e.id_evento;';

    -- Vista 3: Resumen de investigaciones
    EXEC objetos_malditos.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_investigaciones_resumen AS
    SELECT i.id_investigacion, o.nombre AS objeto_investigado, i.resumen, i.fecha
    FROM dbo.investigacion i
    JOIN dbo.objeto o ON i.id_objeto = o.id_objeto;';

    -- Vista 4: Detalles de origen de los objetos
    EXEC objetos_malditos.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_origen_objetos AS
    SELECT o.nombre AS objeto_maldito, orig.ubicacion, orig.fecha AS fecha_hallazgo
    FROM dbo.objeto o
    JOIN dbo.origen orig ON o.id_objeto = orig.id_origen;';

    -- Vista 5: Total de eventos por objeto
    EXEC objetos_malditos.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_conteo_eventos_por_objeto AS
    SELECT o.nombre AS objeto_maldito, COUNT(oe.id_evento) AS total_eventos
    FROM dbo.objeto o
    LEFT JOIN dbo.objeto_evento oe ON o.id_objeto = oe.id_objeto
    GROUP BY o.nombre;';

END;
GO
drop database 

ALTER DATABASE objetos_malditos
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;

EXEC ej_objetos_malditos N'E:\ADSO\jhon_corredor\10_SQLServer\objetos_malditos.sql';
