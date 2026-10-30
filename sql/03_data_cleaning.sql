
USE ecommerce_analysis;

-- Clean table creation
CREATE TABLE IF NOT EXISTS clean_online_retail (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(30),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    CustomerID INT,
    Country VARCHAR(100)
);

-- Data cleaning and date conversion
-- Execute only once on an empty clean table

INSERT INTO clean_online_retail (
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
)
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    STR_TO_DATE(
        InvoiceDate,
        '%m/%d/%Y %H:%i:%s'
    ),
    UnitPrice,
    CustomerID,
    Country
FROM raw_online_retail_staging
WHERE InvoiceNo NOT LIKE 'C%'
  AND Quantity > 0
  AND UnitPrice > 0
  AND STR_TO_DATE(
      InvoiceDate,
      '%m/%d/%Y %H:%i:%s'
  ) IS NOT NULL;



-- Cleaning rules:
-- - Cancelled invoices exclude kiye.
-- - Zero ya negative quantity exclude ki.
-- - Zero ya negative price exclude ki.
-- - Date format ko DATETIME mein convert kiya.
-- - Original raw data preserve kiya.
-- - Missing CustomerID wale sales records ko clean table se remove nahi kiya; 
-- customer-specific analysis mein exclude kiya jayega.