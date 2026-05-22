# Evaluación Técnica — Pasantía Data & Analytics

Bienvenido/a a la prueba técnica para la pasantía de **Data & Analytics**.  
Esta evaluación mide tus habilidades en SQL, Python, Power BI y gestión de bases de datos.

---

## Antes de comenzar

### 1. Haz fork de este repositorio

En GitHub, haz clic en el botón **Fork** (esquina superior derecha) para crear tu copia personal del repositorio.

### 2. Clona tu fork localmente

```bash
git clone https://github.com/TU_USUARIO/evaluacion-data-analytics.git
cd evaluacion-data-analytics
```

### 3. Configura tu entorno Python

```bash
pip install -r python/requirements.txt
```

### 4. Levanta la base de datos SQL

Ejecuta los scripts en orden en tu motor preferido (MySQL, PostgreSQL o SQL Server):

```sql
-- Paso 1: Crear tablas
\i sql/01_schema.sql

-- Paso 2: Cargar datos de muestra
\i sql/02_datos_muestra.sql
```

---

## Estructura del repositorio

```
evaluacion-data-analytics/
│
├── datos/
│   └── ventas_2024.csv          ← Dataset con errores intencionales (ejercicio Python)
│
├── sql/
│   ├── 01_schema.sql            ← DDL: creación de tablas
│   ├── 02_datos_muestra.sql     ← Datos de muestra (150 clientes, 1200 ventas)
│   ├── 03_ejercicios_template.sql  ← ⭐ TU ARCHIVO DE RESPUESTAS SQL
│   └── 04_ddl_ejercicio.sql     ← ⭐ TU ARCHIVO DDL (ejercicio 4.1)
│
├── python/
│   ├── notebook_template.ipynb  ← ⭐ TU NOTEBOOK DE RESPUESTAS
│   └── requirements.txt         ← Dependencias Python
│
├── powerbi/
│   └── instrucciones_powerbi.md ← Instrucciones y plantillas DAX
│
├── entregas/                    ← ⭐ SUBE AQUÍ TUS ARCHIVOS FINALES
│   ├── seccion_sql/             ← Archivos .sql completados
│   ├── seccion_python/          ← Notebook .ipynb con salidas
│   └── seccion_powerbi/         ← Archivo .pbix
│
└── README.md
```

---

## Secciones de la evaluación

| Sección | Herramienta | Puntos | Tiempo estimado |
|---|---|---|---|
| 1. Consultas SQL | SQL (MySQL / PostgreSQL / SQL Server) | 25 | 45 min |
| 2. Análisis en Python | Python + Jupyter Notebook | 30 | 60 min |
| 3. Dashboard | Power BI Desktop | 30 | 60 min |
| 4. Gestión de BD | SQL | 15 | 30 min |
| **Total** | | **100** | **~3.5 hrs** |

---

## Detalle por sección

### Sección 1 — SQL

Trabaja sobre el archivo `sql/03_ejercicios_template.sql`.  
Tienes acceso a las tablas: `clientes`, `productos`, `ventas`, `devoluciones`.

| Ejercicio | Descripción | Pts |
|---|---|---|
| 1.1 | Consulta básica con filtros | 5 |
| 1.2 | Agregaciones y HAVING | 5 |
| 1.3 | JOINs múltiples y métricas | 7 |
| 1.4 | Funciones de ventana (ROW_NUMBER, RANK) | 8 |

### Sección 2 — Python

Trabaja en `python/notebook_template.ipynb`.  
El archivo `datos/ventas_2024.csv` contiene **840 registros con 4 tipos de errores intencionales** que debes identificar y corregir.

| Ejercicio | Descripción | Pts |
|---|---|---|
| 2.1 | Carga, exploración y limpieza de datos | 8 |
| 2.2 | Transformación y cálculo de métricas | 10 |
| 2.3 | Visualizaciones con matplotlib/seaborn | 7 |
| 2.4 | Función reutilizable con manejo de errores | 5 |

### Sección 3 — Power BI

Sigue las instrucciones en `powerbi/instrucciones_powerbi.md`.  
Entrega el archivo `.pbix` en `entregas/seccion_powerbi/`.

| Ejercicio | Descripción | Pts |
|---|---|---|
| 3.1 | Modelo estrella + tabla calendario | 8 |
| 3.2 | 5 medidas DAX | 10 |
| 3.3 | Dashboard en 2 páginas | 12 |

### Sección 4 — Gestión de BD

Archivos: `sql/04_ddl_ejercicio.sql` y `sql/03_ejercicios_template.sql` (ejercicio 4.2).

| Ejercicio | Descripción | Pts |
|---|---|---|
| 4.1 | Diseño de modelo + DDL para campañas de marketing | 7 |
| 4.2 | Diagnóstico y optimización de consulta lenta | 8 |

---

## Criterios de evaluación

| Dimensión | Peso |
|---|---|
| Correctitud técnica | 40% |
| Calidad del código / estructura DAX | 20% |
| Claridad en la comunicación de hallazgos | 20% |
| Criterio analítico y decisiones justificadas | 20% |

---

## Cómo entregar

1. Completa los archivos marcados con ⭐ en la estructura
2. Copia tus archivos finales a la carpeta `entregas/`
3. Haz commit y push a tu fork:

```bash
git add entregas/
git commit -m "Entrega evaluación técnica - [Tu Nombre]"
git push origin main
```

4. Envía el **link de tu repositorio** al correo indicado por el evaluador

---

## Requisitos de herramientas

| Herramienta | Versión mínima | Descarga |
|---|---|---|
| Python | 3.9+ | https://python.org |
| Jupyter Notebook | incluido en requirements.txt | `pip install jupyter` |
| MySQL / PostgreSQL / SQL Server | cualquiera reciente | según preferencia |
| Power BI Desktop | cualquiera 2024+ | https://powerbi.microsoft.com/desktop |
| Git | 2.x | https://git-scm.com |

---

## Preguntas frecuentes

**¿Puedo usar Google Colab en lugar de Jupyter local?**  
Sí. Sube el CSV a Colab y trabaja ahí. Descarga el `.ipynb` al terminar y súbelo a tu entrega.

**¿Qué motor SQL debo usar?**  
El que prefieras. Los scripts son compatibles con MySQL 8+, PostgreSQL 13+ y SQL Server 2019+. Si usas PostgreSQL, reemplaza `USE evaluacion_analytics;` por `SET search_path TO evaluacion_analytics;`.

**¿Puedo usar librerías Python adicionales?**  
Sí, siempre que las agregues al `requirements.txt` en tu entrega.

**¿Puedo consultar documentación oficial?**  
Sí. Puedes consultar documentación de pandas, matplotlib, SQL y Power BI. No se permite usar herramientas de IA para generar el código.

---

*Duración total estimada: 3 a 4 horas — Éxito en la evaluación.*
