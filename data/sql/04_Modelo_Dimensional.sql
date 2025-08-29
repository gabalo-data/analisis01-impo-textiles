-- ====================================================================================
-- ARCHIVO 4: CREACIÓN Y POBLADO DE LAS TABLAS DE DIMENSIÓN
-- Autor: Gabriel Abalo
-- Fecha: 28/08/2025
-- Objetivo: Crear la estructura del modelo de estrella, extrayendo los valores
-- únicos directamente de la tabla consolidada `impo_totales`.
-- ====================================================================================

-- 1. Dimensión de Importadores
-- --------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS proyect.dim_importadores (
    ID_IMPORTADOR INT AUTO_INCREMENT PRIMARY KEY,
    BUSSINES_NAME VARCHAR(255) NOT NULL,
    CUIT VARCHAR(255) NOT NULL UNIQUE
);

-- Se completa con datos únicos de la tabla consolidada.
INSERT INTO proyect.dim_importadores (CUIT, BUSSINES_NAME)
SELECT DISTINCT CUIT, BUSSINES_NAME 
FROM proyect.impo_totales 
WHERE CUIT IS NOT NULL AND CUIT != '';

-- 2. Dimensión de Países
-- --------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS proyect.dim_country (
    id_country INT AUTO_INCREMENT PRIMARY KEY,
    COUNTRY_OF_ORIGIN VARCHAR(255) UNIQUE
);

-- Se puebla con datos únicos de la tabla consolidada.
INSERT INTO proyect.dim_country (COUNTRY_OF_ORIGIN)
SELECT DISTINCT `COUNTRY_OF_ORIGIN` 
FROM proyect.impo_totales 
WHERE `COUNTRY_OF_ORIGIN` IS NOT NULL AND `COUNTRY_OF_ORIGIN` != '';

-- 3. Dimensión de Posiciones Arancelarias / Categorías
-- --------------------------------------------------------------------
-- Creación de la tabla que clasifica cada posición arancelaria
SELECT 'TARIFF_POSITION', 'POSITION_DESCRIPTION'		-- Para los headers
UNION ALL
SELECT DISTINCT TARIFF_POSITION, POSITION_DESCRIPTION
FROM proyect.impo_totales
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pos_aranc.csv'
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';		-- Exportando los datos a un csv para trabajarlos

CREATE TABLE IF NOT EXISTS proyect.dim_pos_aranc(
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    tariff_position VARCHAR(255) UNIQUE,
    position_description TEXT,
    CAPITULO VARCHAR(100),
    PARTIDA VARCHAR(100),
    TITULO_CAPITULO VARCHAR(100),
    TIPO_MERC VARCHAR(100),
    CATEGORIA VARCHAR(100)
);

-- Carga de datos trabajados del CSV a la tabla:

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pos_aranc.csv'
IGNORE			-- como son datos únicos, se introduce el Ignore por cualquier problema de duplicación
INTO TABLE proyect.dim_pos_aranc
CHARACTER SET latin1 	-- modificar en caso de ser necesario 
FIELDS TERMINATED BY ';'
IGNORE 1 ROWS
(tariff_position, position_description, CAPITULO, PARTIDA, TITULO_CAPITULO, TIPO_MERC, CATEGORIA);