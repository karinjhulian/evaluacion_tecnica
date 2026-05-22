# Sección Power BI — Instrucciones

## Fuente de datos

Usa el archivo `../datos/ventas_2024.csv` **ya limpio** (aplica las mismas transformaciones del ejercicio Python o limpia directamente en Power Query).

---

## Ejercicio 3.1 — Modelo de datos (8 pts)

Construye un **modelo estrella** con la siguiente estructura mínima:

```
[dim_tiempo] ──┐
[dim_region]  ──┤── [fact_ventas] ──┤── [dim_producto]
[dim_canal]   ──┘
```

### Requisitos del modelo

- [ ] Tabla de hechos `fact_ventas` con las métricas numéricas
- [ ] Al menos 3 tablas de dimensión separadas
- [ ] Tabla calendario (`dim_tiempo`) creada con DAX o Power Query que incluya: fecha, año, mes número, nombre del mes, trimestre, semana del año
- [ ] Relaciones correctamente definidas (cardinalidad 1:N, filtro de dimensión a hecho)
- [ ] Sin relaciones ambiguas ni ciclos en el modelo

### Tabla calendario mínima en DAX

```dax
dim_tiempo =
ADDCOLUMNS(
    CALENDAR(DATE(2024,1,1), DATE(2024,12,31)),
    "Año",          YEAR([Date]),
    "Mes Num",      MONTH([Date]),
    "Nombre Mes",   FORMAT([Date], "MMMM"),
    "Trimestre",    "Q" & QUARTER([Date]),
    "Semana",       WEEKNUM([Date])
)
```

---

## Ejercicio 3.2 — Medidas DAX (10 pts)

Crea las siguientes medidas en una tabla dedicada llamada `_Medidas`:

| Medida | Descripción |
|---|---|
| `Ventas Totales` | Suma del ingreso neto (unidades × precio × (1 - descuento)) |
| `Ventas YTD` | Acumulado del año usando `TOTALYTD` |
| `Variacion MoM %` | Cambio porcentual vs mes anterior con `DATEADD` |
| `% Participacion Categoria` | Proporción de cada categoría sobre el total |
| `Ticket Promedio` | Ingreso neto promedio por transacción |

### Plantilla de medidas

```dax
-- Ventas Totales
Ventas Totales =
SUMX(
    fact_ventas,
    fact_ventas[unidades] * fact_ventas[precio] * (1 - fact_ventas[descuento])
)

-- Ventas YTD
Ventas YTD =
TOTALYTD([Ventas Totales], dim_tiempo[Date])

-- Variacion MoM %
Variacion MoM % =
VAR VentasMesActual = [Ventas Totales]
VAR VentasMesAnterior =
    CALCULATE([Ventas Totales], DATEADD(dim_tiempo[Date], -1, MONTH))
RETURN
    DIVIDE(VentasMesActual - VentasMesAnterior, VentasMesAnterior)

-- % Participacion Categoria
% Participacion Categoria =
DIVIDE(
    [Ventas Totales],
    CALCULATE([Ventas Totales], ALL(dim_producto[categoria]))
)

-- Ticket Promedio
Ticket Promedio =
DIVIDE([Ventas Totales], COUNTROWS(fact_ventas))
```

---

## Ejercicio 3.3 — Dashboard (12 pts)

### Estructura esperada (máximo 2 páginas)

**Página 1 — Resumen Ejecutivo**

```
┌─────────────────────────────────────────────────────────┐
│  FILTROS: [Año] [Trimestre] [Región] [Canal]            │
├──────────┬──────────┬──────────┬──────────┬─────────────┤
│  Ventas  │  MoM %   │  Ticket  │ Transacc │  YTD        │
│  Totales │          │ Promedio │          │             │
├──────────┴──────────┴──────────┴──────────┴─────────────┤
│                                                         │
│         Tendencia de Ventas Mensual (línea)             │
│                                                         │
├───────────────────────┬─────────────────────────────────┤
│  Ventas por Región    │  % Participación por Categoría  │
│  (barras horizontales)│  (dona o barras apiladas)       │
└───────────────────────┴─────────────────────────────────┘
```

**Página 2 — Detalle por Canal y Producto**

```
┌─────────────────────────────────────────────────────────┐
│  FILTROS: [Mes] [Categoría]                             │
├───────────────────────┬─────────────────────────────────┤
│  Top 5 Productos      │  Ventas por Canal               │
│  (tabla o barras)     │  (barras agrupadas)             │
├───────────────────────┴─────────────────────────────────┤
│         Dispersión: Descuento vs Unidades Vendidas      │
└─────────────────────────────────────────────────────────┘
```

### Criterios de diseño

- [ ] Tipografía legible (mínimo 11pt en etiquetas)
- [ ] Paleta de colores consistente (máximo 4 colores)
- [ ] Todos los gráficos con título descriptivo
- [ ] Valores monetarios formateados (COP o $ con separador de miles)
- [ ] Sin elementos decorativos innecesarios (imágenes de fondo, bordes excesivos)

---

## Entrega

1. Guarda el archivo como `dashboard_[tu_nombre].pbix`
2. Súbelo a la carpeta `entregas/seccion_powerbi/`
3. Si no tienes Power BI Desktop, descárgalo gratis en: https://powerbi.microsoft.com/desktop
