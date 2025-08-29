-- ====================================================================================
-- ARCHIVO 1: CREACIÓN DE LAS TABLAS RAW
-- Autor: Gabriel Abalo
-- Fecha 28/08/2025
-- Objetivo: Crear tablas temporales para cada año que coincidan con la estructura de los archivos CSV originales. 
-- Todas las columnas se definen como VARCHAR para evitar errores al cargar los datos.
-- Se realizaron pasos redundantes, como por ej. cargar tablas temporales año por año, con el fin
-- de poder agotar las posibilidades de surgimiento de errores durante todo el proceso (fines educativos).
-- ====================================================================================
-- ACLARACION: Este bloque CREATE TABLE se repite para cada año de los datos (ej: impo_raw_2019, impo_raw_2020, etc.)

CREATE TABLE IF NOT EXISTS proyect.impo_raw_2021 (
    `BUSSINES_NAME` VARCHAR(255),
    `CUIT` VARCHAR(255),
    `SUB_ITEMS_UP_U$S` VARCHAR(255),
    `SUB_ITEMS_UP_CURRENCY` VARCHAR(255),
    `SUB_ITEMS_QUANTITY` VARCHAR(255),
    `SUB_ITEMS_FOB_U$S` VARCHAR(255),
    `SUB_ITEMS_FOB_CURRENCY` VARCHAR(255),
    `SHIPMENT_CURRENCY` VARCHAR(255),
    `COUNTRY_OF_ORIGIN` VARCHAR(1500),
    `COUNTRY_OF_PROVENANCE` VARCHAR(255),
    `CUSTOMS` VARCHAR(255),
    `TRANSPORTATION` VARCHAR(255),
    `DATE` VARCHAR(255),
    `SHIPPING` VARCHAR(255),
    `ITEM` VARCHAR(255),
    `SUB_ITEMS_SUBITEM` VARCHAR(255),
    `TARIFF_POSITION` VARCHAR(255),
    `POSITION_DESCRIPTION` VARCHAR(255),
    `QUANTITY_SUBITEMS` VARCHAR(255),
    `SUB_ITEMS_ITEM_CODE` VARCHAR(255),
    `SUB_ITEMS_SUFFIXES` VARCHAR(1500),
    `DOCUMENT_TYPE` VARCHAR(255),
    `SHIPMENT_TYPE` VARCHAR(255),
    `DESTINATION_TYPE` VARCHAR(255),
    `HARBOR` VARCHAR(255),
    `FOB_VALUE_U$S` VARCHAR(255),
    `VALUE_FOB_CURRENCY` VARCHAR(255),
    `AVERAGE_UP_U$S` VARCHAR(255),
    `AVERAGE_UP_CURRENCY` VARCHAR(255),
    `FREIGHT_VALUE_U$S` VARCHAR(255),
    `VALUE_FREIGHT_CURRENCY` VARCHAR(255),
    `INSURANCE_VALUE_U$S` VARCHAR(255),
    `CURRENCY_INSURANCE_VALUE` VARCHAR(255),
    `CIF_VALUE_U$S` VARCHAR(255),
    `EXCHANGE_RATE` VARCHAR(255),
    `AMOUNT_VALUE` VARCHAR(255),
    `MEASUREMENT` VARCHAR(255),
    `VALUE_QUANTITY_KILOS` VARCHAR(255),
    `TAXABLE_INCOME` VARCHAR(255),
    `MOMENT_DATE` VARCHAR(255),
    `FOB_CURRENCY` VARCHAR(255),
    `NET_KGS_VALUE` VARCHAR(255),
    `BRANCH` VARCHAR(255),
    `DECLARATION_STATUS` VARCHAR(255),
    `CONDITION` VARCHAR(255),
    `CONDITION_OF_SALE` VARCHAR(255),
    `ITEM_TYPE` VARCHAR(255),
    `WRITES` VARCHAR(1500)
);