-- ====================================================================================
-- ARCHIVO 2: CARGA DE DATOS DESDE CSV
-- Autor: Gabriel Abalo
-- Fecha: 28/08/2025
-- Objetivo: Cargar los datos desde los archivos CSV a las tablas raw correspondientes.
-- Fue prueba y error hasta encontrar los parámetros correctos (delimitador, set de caracteres)
-- para cada archivo. Los csv tenían una codificación fuera de lo habitual.
-- ====================================================================================

-- Carga de datos de importaciones anuales (repetir para cada año)
-- *Verificar desde que carpeta permite subir: SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ARGACTIMP_TEXTIL_2021.csv'
INTO TABLE proyect.impo_raw_2021
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;	-- Porque los .cvs tienen los encabezados de columna como fila 1.

-- En caso de necesitar cambiar la extensión del VARCHAR de alguna de las columnas:
-- ALTER TABLE proyect.impo_raw_2021
-- MODIFY COLUMN SUB_ITEMS_SUFFIXES VARCHAR(1500);

-- Si mysql tira error de "Lost Connection", corregir en edit/preferences/sql editor/
-- y aumentar los tiempos en segundos de "mysql session"

-- En caso de haber duplicado los registros por error en la carga:
-- TRUNCATE TABLE proyect.impo_raw_2021; -- y luego volver a cargar el csv