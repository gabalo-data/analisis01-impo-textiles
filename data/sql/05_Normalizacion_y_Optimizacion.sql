-- ====================================================================================
-- ARCHIVO 5: NORMALIZACIÓN FINAL Y OPTIMIZACIÓN
-- Autor: Gabriel Abalo
-- Fecha: 28/08/2025
-- Objetivo: Conectar la tabla de hechos con las dimensiones, eliminar las columnas
-- de texto redundantes y añadir índices.
-- ====================================================================================

-- 1. Añadir columnas para las claves foráneas a `impo_totales`
-- --------------------------------------------------------------------
ALTER TABLE proyect.impo_totales 
ADD COLUMN id_importador INT NULL,
ADD COLUMN id_country INT NULL
ADD COLUMN id_categoria INT NULL
;

-- 2. Completar los datos de las claves foráneas usando UPDATE/JOINs
-- --------------------------------------------------------------------
UPDATE proyect.impo_totales it 
JOIN proyect.dim_importadores di 
ON it.CUIT = di.CUIT 
SET it.ID_IMPORTADOR = di.ID_IMPORTADOR;

UPDATE proyect.impo_totales it 
JOIN proyect.dim_country dc 
ON it.COUNTRY_OF_ORIGIN = dc.COUNTRY_OF_ORIGIN 
SET it.id_country = dc.id_country;

UPDATE proyect.impo_totales it 
JOIN proyect.dim_pos_aranc dpa 
ON it.TARIFF_POSITION = dpa.tariff_position 
SET it.id_categoria = dpa.id_categoria;


-- 3. Limpiar columnas redundantes de la tabla de hechos
-- --------------------------------------------------------------------
ALTER TABLE proyect.impo_totales
  DROP COLUMN BUSSINES_NAME,
  DROP COLUMN CUIT,
  DROP COLUMN COUNTRY_OF_ORIGIN,
  DROP COLUMN TARIFF_POSITION,
  DROP COLUMN POSITION_DESCRIPTION;
  -- (Y cualquier otra columna original del CSV que ya no se necesite, por ejemplo SUB_ITEMS_UP_CURRENCY
  -- si vamos a realizar nuestro análisis en dólares)


-- 4. Optimización final de la tabla de hechos
-- --------------------------------------------------------------------
-- Añadir clave primaria
ALTER TABLE proyect.impo_totales 
ADD COLUMN id_hecho INT AUTO_INCREMENT PRIMARY KEY FIRST;

-- Añadir claves foráneas
ALTER TABLE proyect.impo_totales 
ADD CONSTRAINT fk_importador FOREIGN KEY (ID_IMPORTADOR) REFERENCES dim_importadores(ID_IMPORTADOR),
ADD CONSTRAINT fk_country FOREIGN KEY (id_country) REFERENCES dim_country(id_country),
ADD CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES dim_pos_aranc(id_categoria);
-- Con esto se formalizan las relaciones del modelo para que Power Bi lo importe.