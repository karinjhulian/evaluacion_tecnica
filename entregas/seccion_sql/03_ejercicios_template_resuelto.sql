-- ============================================================
-- EVALUACION TECNICA - DATA & ANALYTICS
-- Script 03: Template de respuestas SQL
-- Instrucciones:
--   1. Completa cada ejercicio debajo de su enunciado
--   2. No borres los comentarios de enunciado
--   3. Sube este archivo en: entregas/seccion_sql/
-- ============================================================
--KARIN JHULIAN ROCHA GONZALES
USE evaluacion_analytics;

-- ============================================================
-- EJERCICIO 1.1 — Consulta basica (5 pts)
-- Obtén el listado de clientes registrados en 2024 que
-- pertenezcan al segmento 'Corporativo', ordenados por
-- ciudad de forma ascendente.
-- ============================================================

-- ESCRIBE TU CONSULTA AQUI:
-- La pregunta o consulta es capciosa ya que a simple vista con una consulta para visualizar la tabla clientes
-- se puede ver como ningún usuario es registrado en 2024:
select * from clientes;

-- De todas formas sería así:
select * from clientes 
where year(fecha_registro) = 2024 and segmento = 'Corporativo' 
order by ciudad asc;


-- ============================================================
-- EJERCICIO 1.2 — Agregaciones (5 pts)
-- Calcula el total de ventas (cantidad × precio_unitario) por
-- categoria de producto para el ultimo trimestre disponible
-- en los datos. Muestra solo categorias con ventas > 50,000,000.
-- ============================================================

-- ESCRIBE TU CONSULTA AQUI:
select max(fecha_venta) from ventas;
select p.categoria, SUM(v.cantidad * p.precio_unitario) as total_ventas
from ventas v join productos p on v.id_producto = p.id_producto
where quarter(v.fecha_venta) = (select quarter(MAX(fecha_venta))
from ventas)
and year(v.fecha_venta) = (select year(MAX(fecha_venta))
from ventas)
group by p.categoria having total_ventas > 50000000;

-- ============================================================
-- EJERCICIO 1.3 — JOINs (7 pts)
-- Genera un reporte con:
--   - nombre del cliente
--   - ciudad
--   - total de compras realizadas
--   - total en devoluciones
--   - tasa de devolucion (devoluciones / compras)
-- Incluye solo clientes con al menos 3 compras.
-- ============================================================

-- ESCRIBE TU CONSULTA AQUI:
SELECT c.nombre, c.ciudad,
    COUNT(v.id_venta) AS total_compras,
    COUNT(d.id_devolucion) AS total_devoluciones,
    COUNT(d.id_devolucion) / COUNT(v.id_venta) AS tasa_devolucion
FROM clientes c JOIN ventas v
    ON c.id_cliente = v.id_cliente
LEFT JOIN devoluciones d
    ON v.id_venta = d.id_venta
GROUP BY c.id_cliente, c.nombre, c.ciudad
HAVING COUNT(v.id_venta) >= 3;

-- ============================================================
-- EJERCICIO 1.4 — Funciones de ventana (8 pts)
-- Parte A: Para cada mes, identifica el producto mas vendido
--          por canal (segun cantidad total).
-- Parte B: Ranking de top 3 clientes por monto total
--          por mes (cantidad × precio_unitario).
-- ============================================================

-- PARTE A:
WITH ventas_agrupadas AS (SELECT MONTHNAME(v.fecha_venta) AS mes, v.canal, p.nombre AS producto,
        SUM(v.cantidad) AS total_vendido, ROW_NUMBER() OVER(PARTITION BY MONTH(v.fecha_venta), v.canal
            ORDER BY SUM(v.cantidad) DESC) AS ranking
    FROM ventas v JOIN productos p
        ON v.id_producto = p.id_producto
    GROUP BY MONTH(v.fecha_venta), MONTHNAME(v.fecha_venta), v.canal, p.nombre
	)

SELECT mes, canal, producto, total_vendido FROM ventas_agrupadas WHERE ranking = 1;

-- PARTE B:
WITH ranking_clientes AS (
    SELECT MONTHNAME(v.fecha_venta) AS mes, c.nombre AS cliente,
        SUM(v.cantidad * p.precio_unitario) AS monto_total,
        RANK() OVER(
            PARTITION BY MONTH(v.fecha_venta)
            ORDER BY SUM(v.cantidad * p.precio_unitario) DESC
        ) AS ranking
    FROM ventas v JOIN clientes c ON v.id_cliente = c.id_cliente
    JOIN productos p ON v.id_producto = p.id_producto
    GROUP BY MONTH(v.fecha_venta), MONTHNAME(v.fecha_venta), c.nombre
)
SELECT mes, cliente, monto_total, ranking FROM ranking_clientes WHERE ranking <= 3;

-- ============================================================
-- EJERCICIO 4.2 — Optimizacion de consulta (8 pts)
-- La siguiente consulta tarda mas de 20 segundos en produccion.
-- Identifica los problemas, rescribela y explica los indices
-- que crearias.
--
-- CONSULTA ORIGINAL (NO MODIFICAR):
-- SELECT *
-- FROM ventas v
-- JOIN clientes c ON v.id_cliente = c.id_cliente
-- WHERE YEAR(v.fecha_venta) = 2024
--   AND c.ciudad LIKE '%Bogota%'
-- ORDER BY v.fecha_venta DESC
-- ============================================================

-- CONSULTA OPTIMIZADA:
SELECT v.id_venta, v.fecha_venta, v.canal, c.nombre, c.ciudad
FROM ventas v JOIN clientes c
    ON v.id_cliente = c.id_cliente
WHERE v.fecha_venta >= '2024-01-01' AND v.fecha_venta < '2025-01-01'
    AND c.ciudad = 'Bogota'
ORDER BY v.fecha_venta DESC;

-- INDICES PROPUESTOS (CREATE INDEX ...):
CREATE INDEX idx_ventas_fecha ON ventas(fecha_venta);
CREATE INDEX idx_ventas_cliente ON ventas(id_cliente);
CREATE INDEX idx_clientes_ciudad ON clientes(ciudad);
CREATE INDEX idx_clientes_seg ON clientes(segmento);

-- EXPLICACION DE PROBLEMAS ENCONTRADOS (como comentarios SQL):
-- Problema 1:
-- Se utilizaba SELECT * trayendo columnas innecesarias,
-- aumentando consumo de memoria y tiempo de lectura.

-- Problema 2:
-- El uso de YEAR(fecha_venta) impedia el uso eficiente
-- de indices sobre la columna fecha_venta.

-- Problema 3:
-- El filtro LIKE '%Bogota%' forzaba escaneo completo
-- de la tabla al utilizar comodin inicial.

-- Problema extra:
-- La consulta no contaba con indices optimizados para
-- filtros, joins y ordenamiento.