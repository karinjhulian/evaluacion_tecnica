-- ============================================================
-- EVALUACION TECNICA - DATA & ANALYTICS
-- Script 04: Template DDL — Ejercicio 4.1
-- ============================================================
--
-- REQUERIMIENTO:
-- La empresa quiere registrar campañas de marketing, asociar
-- qué clientes fueron impactados por cada campaña, y medir si
-- ese cliente realizó una compra dentro de los 30 dias
-- siguientes al impacto.
--
-- SE PIDE:
--   1. Diseña el modelo entidad-relacion (puedes dibujarlo
--      en papel/herramienta y subir la imagen a entregas/)
--   2. Escribe los scripts DDL con:
--      - Tipos de dato apropiados
--      - Constraints de integridad referencial
--      - Indices necesarios para consultas frecuentes
--   3. Escribe una consulta de ejemplo que responda:
--      "¿Cuántos clientes impactados por la campaña X
--       realizaron al menos una compra en los 30 dias
--       siguientes al impacto?"
-- ============================================================

USE evaluacion_analytics;

-- TABLA 1: Escribe aqui tu primera tabla
CREATE TABLE campanas (id_campana INT PRIMARY KEY AUTO_INCREMENT,
    nombre_campana VARCHAR(100) NOT NULL,
    canal VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    presupuesto DECIMAL(12,2)
);

-- TABLA 2: Escribe aqui tu segunda tabla
CREATE TABLE impactos_campana (id_impacto INT PRIMARY KEY AUTO_INCREMENT,
    id_campana INT NOT NULL,
    id_cliente INT NOT NULL,
    fecha_impacto DATE NOT NULL,
    medio_contacto VARCHAR(50),
    CONSTRAINT fk_impacto_campana
        FOREIGN KEY (id_campana)
        REFERENCES campanas(id_campana),
    CONSTRAINT fk_impacto_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);


-- TABLA 3 (si aplica):


-- INDICES:
CREATE INDEX idx_impactos_campana
ON impactos_campana(id_campana);

CREATE INDEX idx_impactos_cliente
ON impactos_campana(id_cliente);

CREATE INDEX idx_impactos_fecha
ON impactos_campana(fecha_impacto);

CREATE INDEX idx_ventas_cliente_fecha
ON ventas(id_cliente, fecha_venta);

--INSERTS PARA PROBAR CONSULTA:
INSERT INTO campanas
(nombre_campana, canal, fecha_inicio, fecha_fin, presupuesto)
VALUES('Campaña Verano', 'Email', '2024-01-01', '2024-01-31', 50000),
('Campaña Tecnología', 'Redes Sociales', '2024-03-01', '2024-03-31', 80000);

INSERT INTO impactos_campana
(id_campana, id_cliente, fecha_impacto, medio_contacto)
VALUES(1, 1, '2024-01-10', 'Email'),
(1, 2, '2024-01-12', 'Email'), (1, 3, '2024-01-15', 'Email'),
(2, 4, '2024-03-05', 'Instagram'), (2, 5, '2024-03-07', 'Facebook');

-- CONSULTA DE VALIDACION:
SELECT c.nombre_campana, COUNT(DISTINCT i.id_cliente) AS clientes_convertidos
FROM campanas c JOIN impactos_campana i
    ON c.id_campana = i.id_campana
JOIN ventas v
    ON i.id_cliente = v.id_cliente
WHERE c.id_campana = 1
    AND v.fecha_venta BETWEEN
        i.fecha_impacto
        AND DATE_ADD(i.fecha_impacto, INTERVAL 30 DAY)
GROUP BY c.nombre_campana;