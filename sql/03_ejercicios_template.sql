-- ============================================================
-- EVALUACION TECNICA - DATA & ANALYTICS
-- Script 03: Template de respuestas SQL
-- Instrucciones:
--   1. Completa cada ejercicio debajo de su enunciado
--   2. No borres los comentarios de enunciado
--   3. Sube este archivo en: entregas/seccion_sql/
-- ============================================================

USE evaluacion_analytics;

-- ============================================================
-- EJERCICIO 1.1 — Consulta basica (5 pts)
-- Obtén el listado de clientes registrados en 2024 que
-- pertenezcan al segmento 'Corporativo', ordenados por
-- ciudad de forma ascendente.
-- ============================================================

-- ESCRIBE TU CONSULTA AQUI:


-- ============================================================
-- EJERCICIO 1.2 — Agregaciones (5 pts)
-- Calcula el total de ventas (cantidad × precio_unitario) por
-- categoria de producto para el ultimo trimestre disponible
-- en los datos. Muestra solo categorias con ventas > 50,000,000.
-- ============================================================

-- ESCRIBE TU CONSULTA AQUI:


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


-- ============================================================
-- EJERCICIO 1.4 — Funciones de ventana (8 pts)
-- Parte A: Para cada mes, identifica el producto mas vendido
--          por canal (segun cantidad total).
-- Parte B: Ranking de top 3 clientes por monto total
--          por mes (cantidad × precio_unitario).
-- ============================================================

-- PARTE A:


-- PARTE B:


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


-- INDICES PROPUESTOS (CREATE INDEX ...):


-- EXPLICACION DE PROBLEMAS ENCONTRADOS (como comentarios SQL):
-- Problema 1:
-- Problema 2:
-- Problema 3:
