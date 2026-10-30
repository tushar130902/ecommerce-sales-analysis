CREATE DATABASE IF NOT EXISTS ecommerce_analysis;

use ecommerce_analysis;

CREATE table IF NOT EXISTS raw_online_retail(
    InvoiceNo   VARCHAR(20),
    StockCode   VARCHAR(30),
    Description VARCHAR(255),
    Quantity    INT,
    InvoiceDate DATETIME,
    UnitPrice   DECIMAL(10, 2),
    CustomerID  INT NULL,
    Country     VARCHAR(100)
);