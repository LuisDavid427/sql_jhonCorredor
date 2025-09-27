CREATE OR ALTER PROCEDURE ej_conjunto_residencial
    @ruta_archivo NVARCHAR(255)  -- Nuevo parámetro para la ruta
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️⃣ Recrear la base de datos
    IF DB_ID('conjunto_residencial') IS NOT NULL
    BEGIN
        ALTER DATABASE conjunto_residencial SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE conjunto_residencial;
    END;
    CREATE DATABASE conjunto_residencial;

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

    EXEC conjunto_residencial.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_apartamentos_con_residentes AS
    SELECT a.numero AS numero_apartamento, a.torre, a.piso,
           r.nombre AS nombre_residente, r.telefono, r.correo,
           ar.fecha_inicio
    FROM dbo.apartamento a
    JOIN dbo.apartamento_residente ar ON a.id_apartamento = ar.id_apartamento
    JOIN dbo.residente r ON ar.id_residente = r.id_residente;';

    -- Vista 2: Información de Visitas por Apartamento
    EXEC conjunto_residencial.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_visitas_por_apartamento AS
    SELECT rv.fecha AS fecha_visita, a.numero AS apartamento,
           v.nombre AS nombre_visitante, v.cedula
    FROM dbo.registro_visita rv
    JOIN dbo.visita v ON rv.id_visita = v.id_visita
    JOIN dbo.apartamento a ON rv.id_apartamento = a.id_apartamento;';

    -- Vista 3: Pagos Totales por Residente
    EXEC conjunto_residencial.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_pagos_totales_residente AS
    SELECT r.nombre AS residente,
           SUM(p.valor) AS valor_total_pagos,
           COUNT(p.id_pago) AS cantidad_pagos
    FROM dbo.residente r
    LEFT JOIN dbo.pago p ON r.id_residente = p.id_residente
    GROUP BY r.nombre;';

    -- Vista 4: Detalles de Parqueadero con su Apartamento
    EXEC conjunto_residencial.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_parqueaderos_asignados AS
    SELECT p.numero AS numero_parqueadero, p.tipo,
           a.numero AS apartamento, a.torre
    FROM dbo.parqueadero p
    JOIN dbo.apartamento a ON p.id_apartamento = a.id_apartamento;';

        -- Vista 5: Conteo de visitas por apartamento
    EXEC conjunto_residencial.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_conteo_visitas_por_apartamento AS
    SELECT a.numero AS apartamento, a.torre,
           COUNT(rv.id_registro) AS total_visitas
    FROM dbo.apartamento a
    LEFT JOIN dbo.registro_visita rv ON a.id_apartamento = rv.id_apartamento
    GROUP BY a.numero, a.torre;';

END;
GO

EXEC ej_conjunto_residencial N'E:\ADSO\jhon_corredor\10_SQLServer\conjunto_residencial.sql';


use conjunto_residencial;
select * from v_parqueaderos_asignados