-- ====================================================================================
-- ARCHIVO 3: CONSOLIDACIÓN Y LIMPIEZA INICIAL
-- AUTOR: Gabriel Abalo
-- FECHA: 28/08/2025
--
-- PROPÓSITO:
-- 1. Unir todas las tablas anuales en una única tabla consolidada (impo_totales).
-- 2. Realizar la limpieza inicial: corregir tipos de datos.
-- ====================================================================================

-- 1. Crear la tabla consolidada `impo_totales` con la totalidad de las tablas
CREATE TABLE proyect.impo_totales AS
SELECT * FROM proyect.impo_raw_2019
UNION ALL
SELECT * FROM proyect.impo_raw_2020
UNION ALL
SELECT * FROM proyect.impo_raw_2021
UNION ALL
SELECT * FROM proyect.impo_raw_2022
UNION ALL
SELECT * FROM proyect.impo_raw_2023
UNION ALL
SELECT * FROM proyect.impo_raw_2024
UNION ALL
SELECT * FROM proyect.impo_raw_2025;

-- 2. LIMPIEZA INICIAL EN `impo_totales`
-- --------------------------------------------------------------------
-- Borré estas pos. arancelarias porque el archivo original las traía y eran
-- irrelevantes para el análisis a desarrollar.
DELETE FROM proyect.impo_totales
WHERE TARIFF_POSITION LIKE '64%' OR TARIFF_POSITION LIKE '65%' OR TARIFF_POSITION LIKE '66%';

-- 3. CORRECCIÓN DE TIPOS DE DATOS ESENCIALES
-- --------------------------------------------------------------------

-- Para la conversión a valores numéricos de las columnas correspondientes (por ejemplo 'FOB_VALUE_U$S',
-- 'CIF_VALUE_U$S', entre otros), se realiza la siguiente instrucción:

ALTER TABLE proyect.impo_totales 
MODIFY COLUMN CIF_VALUE_U$S DECIMAL(18, 2),
MODIFY COLUMN FOB_VALUE_U$S DECIMAL(18, 2)
MODIFY COLUMN FREIGHT_VALUE_U$S DECIMAL(18, 2),
MODIFY COLUMN INSURANCE_VALUE_U$S DECIMAL(18, 2),
MODIFY COLUMN CIF_VALUE_U$S DECIMAL(18, 2),
MODIFY COLUMN NET_KGS_VALUE DECIMAL(18, 2)
;

-- Para cambiar los '.' por coma en caso de no convertir a Decimal:
-- UPDATE proyect.impo_totales
-- SET FOB_VALUE_U$S = REPLACE(TRIM(FOB_VALUE_U$S),'.',',');

-- Convertimos la fecha
ALTER TABLE proyect.impo_totales 
ADD COLUMN fecha DATE NULL;
UPDATE proyect.impo_totales 
SET fecha = STR_TO_DATE(`DATE`, '%d/%m/%Y');
ALTER TABLE proyect.impo_totales 
DROP COLUMN `DATE`; -- Se elimina la columna de texto original.