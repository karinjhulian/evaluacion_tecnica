-- ============================================================
-- EVALUACION TECNICA - DATA & ANALYTICS
-- Script 01: Creacion del schema y tablas
-- Motor compatible: MySQL 8+ / PostgreSQL 13+ / SQL Server 2019+
-- ============================================================

-- Crear base de datos (MySQL / SQL Server)
-- En PostgreSQL usar: CREATE DATABASE evaluacion_analytics;
CREATE DATABASE IF NOT EXISTS evaluacion_analytics;
USE evaluacion_analytics;

-- ------------------------------------------------------------
-- TABLA: clientes
-- ------------------------------------------------------------
CREATE TABLE clientes (
    id_cliente      INT             PRIMARY KEY,
    nombre          VARCHAR(100)    NOT NULL,
    ciudad          VARCHAR(60)     NOT NULL,
    segmento        VARCHAR(40)     NOT NULL,   -- 'Corporativo', 'PYME', 'Persona Natural'
    fecha_registro  DATE            NOT NULL
);

-- ------------------------------------------------------------
-- TABLA: productos
-- ------------------------------------------------------------
CREATE TABLE productos (
    id_producto     INT             PRIMARY KEY,
    nombre          VARCHAR(100)    NOT NULL,
    categoria       VARCHAR(60)     NOT NULL,
    precio_unitario DECIMAL(12, 2)  NOT NULL
);

-- ------------------------------------------------------------
-- TABLA: ventas
-- ------------------------------------------------------------
CREATE TABLE ventas (
    id_venta        INT             PRIMARY KEY,
    id_cliente      INT             NOT NULL,
    id_producto     INT             NOT NULL,
    cantidad        INT             NOT NULL,
    fecha_venta     DATE            NOT NULL,
    canal           VARCHAR(40)     NOT NULL,   -- 'Tienda Fisica', 'E-commerce', 'Distribuidores', 'Catalogo', 'App Movil'
    CONSTRAINT fk_ventas_cliente  FOREIGN KEY (id_cliente)  REFERENCES clientes(id_cliente),
    CONSTRAINT fk_ventas_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ------------------------------------------------------------
-- TABLA: devoluciones
-- ------------------------------------------------------------
CREATE TABLE devoluciones (
    id_devolucion   INT             PRIMARY KEY,
    id_venta        INT             NOT NULL,
    fecha_devolucion DATE           NOT NULL,
    motivo          VARCHAR(120)    NOT NULL,   -- 'Producto defectuoso', 'Error de envio', 'No cumple expectativas', 'Talla incorrecta'
    CONSTRAINT fk_dev_venta FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
);

-- ============================================================
-- INDICES SUGERIDOS (no crearlos aun - son parte del ejercicio 4.2)
-- ============================================================
-- CREATE INDEX idx_ventas_fecha     ON ventas(fecha_venta);
-- CREATE INDEX idx_ventas_cliente   ON ventas(id_cliente);
-- CREATE INDEX idx_clientes_ciudad  ON clientes(ciudad);
-- CREATE INDEX idx_clientes_seg     ON clientes(segmento);
