CREATE OR ALTER PROCEDURE ej_panaderiadb
    @ruta_archivo NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️⃣ Recrear la base de datos
    IF DB_ID('panaderiadb') IS NOT NULL
    BEGIN
        ALTER DATABASE panaderiadb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE panaderiadb;
    END;
    CREATE DATABASE panaderiadb;

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
    
    -- Vista 1: Clientes y sus compras recientes
    EXEC panaderiadb.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_clientes_compras AS
    SELECT c.nombre AS cliente, v.fecha AS fecha_compra, p.nombre AS producto_comprado, v.total
    FROM dbo.cliente c
    JOIN dbo.venta v ON c.id_cliente = v.id_cliente
    JOIN dbo.producto p ON v.id_producto = p.id_producto;';

    -- Vista 2: Empleados y las ventas que han gestionado
    EXEC panaderiadb.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_empleados_ventas AS
    SELECT e.nombre AS empleado, e.cargo, COUNT(v.id_venta) AS total_ventas_gestionadas, SUM(v.total) AS total_dinero_ventas
    FROM dbo.empleado e
    JOIN dbo.venta v ON e.id_empleado = v.id_empleado
    GROUP BY e.nombre, e.cargo;';

    -- Vista 3: Recetas con sus ingredientes y cantidades
    EXEC panaderiadb.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_recetas_ingredientes AS
    SELECT pr.nombre AS producto, i.nombre AS ingrediente, dr.cantidad, i.unidad_medida
    FROM dbo.receta r
    JOIN dbo.producto pr ON r.id_producto = pr.id_producto
    JOIN dbo.detalle_receta dr ON r.id_receta = dr.id_receta
    JOIN dbo.ingrediente i ON dr.id_ingrediente = i.id_ingrediente;';

    -- Vista 4: Productos con sus precios e instrucciones de receta
    EXEC panaderiadb.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_productos_y_recetas AS
    SELECT p.nombre AS nombre_producto, p.precio, p.descripcion, r.instrucciones
    FROM dbo.producto p
    LEFT JOIN dbo.receta r ON p.id_producto = r.id_producto;';

    -- Vista 5: Resumen de ventas por producto
    EXEC panaderiadb.dbo.sp_executesql N'
    CREATE OR ALTER VIEW dbo.v_resumen_ventas_producto AS
    SELECT p.nombre AS producto, COUNT(v.id_venta) AS total_vendido, SUM(v.total) AS ingresos_totales
    FROM dbo.producto p
    JOIN dbo.venta v ON p.id_producto = v.id_producto
    GROUP BY p.nombre;';

END;
GO

exec ej_panaderiadb N'E:\ADSO\jhon_corredor\10_SQLServer\panaderia.sql';


use panaderiadb 
select * from v_productos_y_recetas