CREATE OR ALTER PROCEDURE ejecutar_script_externo
    @ruta_archivo NVARCHAR(255)  -- Nuevo parámetro para la ruta
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️⃣ Recrear la base de datos
    IF DB_ID('agenciaviajesdb') IS NOT NULL
    BEGIN
        ALTER DATABASE agenciaviajesdb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE agenciaviajesdb;
    END;
    CREATE DATABASE agenciaviajesdb;

    -- 2️⃣ Ejecutar script de tablas e inserciones usando la variable
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

    -- 3️⃣ Crear vistas en la base de datos correcta
    EXEC agenciaviajesdb.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_reservas_cliente AS
    SELECT r.id_reserva, c.nombre AS cliente, c.email, c.telefono, 
           p.nombre AS paquete, r.fecha, r.personas
    FROM dbo.reserva r
    JOIN dbo.cliente c ON r.id_cliente = c.id_cliente
    JOIN dbo.paquete p ON r.id_paquete = p.id_paquete;';

    EXEC agenciaviajesdb.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_paquetes_destino_guia AS
    SELECT p.id_paquete, p.nombre AS paquete, p.precio, p.duracion_dias, 
           d.ciudad, d.pais, g.nombre AS guia, g.idioma AS idioma_guia
    FROM dbo.paquete p
    JOIN dbo.destino d ON p.id_destino = d.id_destino
    LEFT JOIN dbo.guia g ON p.id_guia = g.id_guia;';

    EXEC agenciaviajesdb.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_actividades_por_paquete AS
    SELECT p.nombre AS paquete, a.nombre AS actividad, a.tipo
    FROM dbo.actividad a
    JOIN dbo.paquete p ON a.id_paquete = p.id_paquete;';

    EXEC agenciaviajesdb.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_reservas_totales_cliente AS
    SELECT c.nombre AS cliente, COUNT(r.id_reserva) AS total_reservas, 
           SUM(r.personas) AS total_personas
    FROM dbo.cliente c
    LEFT JOIN dbo.reserva r ON c.id_cliente = r.id_cliente
    GROUP BY c.nombre;';

    EXEC agenciaviajesdb.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_ingresos_por_paquete AS
    SELECT p.nombre AS paquete, COUNT(r.id_reserva) AS total_reservas, 
           SUM(r.personas * p.precio) AS ingresos_totales
    FROM dbo.paquete p
    LEFT JOIN dbo.reserva r ON p.id_paquete = r.id_paquete
    GROUP BY p.nombre;';
END;
GO

EXEC ejecutar_script_externo N'C:\Users\Aprendiz\Desktop\agencia_viajes.sql';