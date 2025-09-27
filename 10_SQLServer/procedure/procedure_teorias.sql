CREATE OR ALTER PROCEDURE ej_teorias_conspirativas
    @ruta_archivo NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️⃣ Recrear la base de datos
    IF DB_ID('teorias_conspirativas') IS NOT NULL
    BEGIN
        ALTER DATABASE teorias_conspirativas SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE teorias_conspirativas;
    END;
    CREATE DATABASE teorias_conspirativas;

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
    
    -- Vista 1: Teorías y sus fuentes
    EXEC teorias_conspirativas.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_teorias_y_fuentes AS
    SELECT t.nombre AS nombre_teoria, f.nombre AS nombre_fuente
    FROM dbo.teorias t
    JOIN dbo.teoria_fuente tf ON t.id_teoria = tf.id_teoria
    JOIN dbo.fuentes f ON tf.id_fuente = f.id_fuente;';

    -- Vista 2: Eventos relacionados con cada teoría
    EXEC teorias_conspirativas.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_eventos_por_teoria AS
    SELECT t.nombre AS nombre_teoria, e.nombre AS nombre_evento, e.fecha
    FROM dbo.teorias t
    JOIN dbo.teoria_evento te ON t.id_teoria = te.id_teoria
    JOIN dbo.eventos e ON te.id_evento = e.id_evento;';

    -- Vista 3: Autores y las teorías que han creado
    EXEC teorias_conspirativas.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_autores_por_teoria AS
    SELECT a.nombre AS nombre_autor, t.nombre AS nombre_teoria
    FROM dbo.autores a
    JOIN dbo.autor_teoria at ON a.id_autor = at.id_autor
    JOIN dbo.teorias t ON at.id_teoria = t.id_teoria;';

    -- Vista 4: Teorías y el número de fuentes que las respaldan
    EXEC teorias_conspirativas.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_conteo_fuentes_por_teoria AS
    SELECT t.nombre AS nombre_teoria, COUNT(tf.id_fuente) AS total_fuentes
    FROM dbo.teorias t
    LEFT JOIN dbo.teoria_fuente tf ON t.id_teoria = tf.id_teoria
    GROUP BY t.nombre;';

    -- Vista 5: Eventos sin teoría asignada
    EXEC teorias_conspirativas.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_eventos_sin_teoria AS
    SELECT e.nombre AS nombre_evento, e.fecha
    FROM dbo.eventos e
    LEFT JOIN dbo.teoria_evento te ON e.id_evento = te.id_evento
    WHERE te.id_teoria IS NULL;';
    
END;
GO


exec ej_teorias_conspirativas N'E:\ADSO\jhon_corredor\10_SQLServer\teorias.sql';


use teorias_conspirativas;
select * from v_conteo_fuentes_por_teoria;