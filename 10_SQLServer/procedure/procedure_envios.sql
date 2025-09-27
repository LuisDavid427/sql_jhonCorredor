CREATE OR ALTER PROCEDURE ej_empresa_envios
    @ruta_archivo NVARCHAR(255)  -- Nuevo parámetro para la ruta
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️⃣ Recrear la base de datos
    IF DB_ID('empresa_envios') IS NOT NULL
    BEGIN
        ALTER DATABASE empresa_envios SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE empresa_envios;
    END;
    CREATE DATABASE empresa_envios;

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

    -- Vista 1: Detalles de envíos con información de clientes y paquetes
    EXEC empresa_envios.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_detalles_envios AS
    SELECT 
        e.id_envio,
        c.nombre AS cliente,
        c.direccion AS direccion_cliente,
        p.descripcion AS paquete,
        p.peso,
        p.dimensiones,
        r.nombre AS repartidor,
        es.descripcion AS estado_actual,
        e.fecha_envio,
        e.fecha_entrega
    FROM dbo.envio e
    JOIN dbo.cliente c ON e.id_cliente = c.id_cliente
    JOIN dbo.paquete p ON e.id_paquete = p.id_paquete
    JOIN dbo.repartidor r ON e.id_repartidor = r.id_repartidor
    JOIN dbo.estado_envio es ON e.id_estado = es.id_estado;';

    -- Vista 2: Envíos asignados a cada repartidor
    EXEC empresa_envios.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_envios_por_repartidor AS
    SELECT 
        r.nombre AS nombre_repartidor,
        r.zona,
        COUNT(e.id_envio) AS total_envios_asignados,
        SUM(CASE WHEN es.descripcion = ''entregado'' THEN 1 ELSE 0 END) AS envios_entregados
    FROM dbo.repartidor r
    LEFT JOIN dbo.envio e ON r.id_repartidor = e.id_repartidor
    LEFT JOIN dbo.estado_envio es ON e.id_estado = es.id_estado
    GROUP BY r.nombre, r.zona;';

    -- Vista 3: Paquetes y sus rutas
    EXEC empresa_envios.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_rutas_paquetes AS
    SELECT 
        pa.descripcion AS descripcion_paquete,
        ru.origen,
        ru.destino,
        ru.distancia_km
    FROM dbo.paquete pa
    JOIN dbo.envio en ON pa.id_paquete = en.id_paquete
    JOIN dbo.ruta ru ON en.id_ruta = ru.id_ruta;';

    -- Vista 4: Clientes con envíos pendientes
    EXEC empresa_envios.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_clientes_envios_pendientes AS
    SELECT 
        c.nombre AS nombre_cliente,
        c.telefono,
        c.direccion,
        COUNT(e.id_envio) AS total_envios_pendientes
    FROM dbo.cliente c
    JOIN dbo.envio e ON c.id_cliente = e.id_cliente
    JOIN dbo.estado_envio es ON e.id_estado = es.id_estado
    WHERE es.descripcion <> ''entregado''
    GROUP BY c.nombre, c.telefono, c.direccion;';
    
    -- Vista 5: Rutas y repartidores asignados
    EXEC empresa_envios.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_rutas_y_repartidores AS
    SELECT 
        ru.origen,
        ru.destino,
        ru.distancia_km,
        r.nombre AS nombre_repartidor
    FROM dbo.ruta ru
    JOIN dbo.repartidor_ruta rr ON ru.id_ruta = rr.id_ruta
    JOIN dbo.repartidor r ON rr.id_repartidor = r.id_repartidor;';

END;
GO

EXEC ej_empresa_envios N'E:\ADSO\jhon_corredor\10_SQLServer\empresa_envios.sql';


use empresa_envios;
select * from v_rutas_y_repartidores

drop database empresa_envios