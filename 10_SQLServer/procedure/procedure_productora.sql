CREATE OR ALTER PROCEDURE ej_productora_musical
    @ruta_archivo NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️⃣ Recrear la base de datos
    IF DB_ID('productora_musical') IS NOT NULL
    BEGIN
        ALTER DATABASE productora_musical SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE productora_musical;
    END;
    CREATE DATABASE productora_musical;

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

    -- Vista 1: Artistas y los álbumes que han lanzado
    EXEC productora_musical.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_artistas_y_albums AS
    SELECT a.nombre AS nombre_artista, a.genero, al.titulo AS titulo_album, al.año
    FROM dbo.artista a
    JOIN dbo.artista_album aa ON a.id_artista = aa.id_artista
    JOIN dbo.album al ON aa.id_album = al.id_album;';

    -- Vista 2: Canciones por álbum
    EXEC productora_musical.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_canciones_por_album AS
    SELECT al.titulo AS titulo_album, c.titulo AS titulo_cancion, c.duracion
    FROM dbo.album al
    JOIN dbo.cancion c ON al.id_album = c.id_album;';

    -- Vista 3: Productores y las canciones en las que trabajaron
    EXEC productora_musical.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_productores_y_canciones AS
    SELECT p.nombre AS nombre_productor, p.experiencia_anios, c.titulo AS titulo_cancion
    FROM dbo.productor p
    JOIN dbo.cancion_productor cp ON p.id_productor = cp.id_productor
    JOIN dbo.cancion c ON cp.id_cancion = c.id_cancion;';

    -- Vista 4: Estudios y las canciones grabadas en ellos
    EXEC productora_musical.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_estudios_y_canciones AS
    SELECT e.nombre AS nombre_estudio, e.ciudad, c.titulo AS titulo_cancion
    FROM dbo.estudio e
    JOIN dbo.cancion_estudio ce ON e.id_estudio = ce.id_estudio
    JOIN dbo.cancion c ON ce.id_cancion = c.id_cancion;';

    -- Vista 5: Canciones sin un álbum asignado
    EXEC productora_musical.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_canciones_sin_album AS
    SELECT titulo AS titulo_cancion, duracion
    FROM dbo.cancion
    WHERE id_album IS NULL;';
    
END;
GO


exec ej_productora_musical N'E:\ADSO\jhon_corredor\10_SQLServer\productora.sql';


use productora_musical
select * from v_estudios_y_canciones