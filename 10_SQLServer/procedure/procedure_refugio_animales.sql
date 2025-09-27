CREATE OR ALTER PROCEDURE ej_refugio_animales
    @ruta_archivo NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️⃣ Recrear la base de datos
    IF DB_ID('refugio_animales') IS NOT NULL
    BEGIN
        ALTER DATABASE refugio_animales SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE refugio_animales;
    END;
    CREATE DATABASE refugio_animales;

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
    
    -- Vista 1: Animales con su especie y fecha de ingreso
    EXEC refugio_animales.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_animales_y_especie AS
    SELECT a.nombre AS nombre_animal, a.edad, e.nombre_especie AS especie, a.fecha_ingreso
    FROM dbo.animal a
    JOIN dbo.especie e ON a.id_especie = e.id_especie;';

    -- Vista 2: Cuáles animales están a cargo de cada cuidador
    EXEC refugio_animales.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_animales_por_cuidador AS
    SELECT c.nombre AS nombre_cuidador, a.nombre AS nombre_animal_cuidado, ac.fecha_asignacion
    FROM dbo.cuidador c
    JOIN dbo.animal_cuidador ac ON c.id_cuidador = ac.id_cuidador
    JOIN dbo.animal a ON ac.id_animal = a.id_animal;';

    -- Vista 3: Animales con sus vacunas registradas
    EXEC refugio_animales.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_animales_vacunados AS
    SELECT a.nombre AS nombre_animal, v.nombre AS nombre_vacuna, vac.fecha AS fecha_vacunacion
    FROM dbo.animal a
    JOIN dbo.vacunacion vac ON a.id_animal = vac.id_animal
    JOIN dbo.vacuna v ON vac.id_vacuna = v.id_vacuna;';

    -- Vista 4: Adopciones registradas con información de adoptantes y animales
    EXEC refugio_animales.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_adopciones_registradas AS
    SELECT ad.fecha_adopcion, adt.nombre AS nombre_adoptante, adt.telefono, a.nombre AS nombre_animal, e.nombre_especie AS especie
    FROM dbo.adopcion ad
    JOIN dbo.adoptante adt ON ad.id_adoptante = adt.id_adoptante
    JOIN dbo.animal a ON ad.id_animal = a.id_animal
    JOIN dbo.especie e ON a.id_especie = e.id_especie;';

    -- Vista 5: Conteo de animales por especie
    EXEC refugio_animales.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_conteo_animales_por_especie AS
    SELECT e.nombre_especie, COUNT(a.id_animal) AS total_animales
    FROM dbo.especie e
    LEFT JOIN dbo.animal a ON e.id_especie = a.id_especie
    GROUP BY e.nombre_especie;';

END;
GO


exec ej_refugio_animales N'E:\ADSO\jhon_corredor\10_SQLServer\refugio_animales.sql';


use refugio_animales;
select * from v_conteo_animales_por_especie;