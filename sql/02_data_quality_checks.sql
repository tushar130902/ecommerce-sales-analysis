
USE ecommerce_analysis;

-- 1. Total records
SELECT COUNT(*) AS total_records
FROM raw_online_retail;

-- 2. Missing customer IDs
SELECT
    SUM(CustomerID IS NULL) AS missing_customer_ids,
    SUM(CustomerID = 0) AS zero_customer_ids
FROM raw_online_retail_staging;

-- 3. Missing descriptions
SELECT
    SUM(Description IS NULL) AS missing_descriptions
FROM raw_online_retail_staging;

-- 4. Cancelled transactions
SELECT COUNT(*) AS cancelled_transactions
FROM raw_online_retail
WHERE InvoiceNo LIKE 'C%';

-- 5. Invalid quantity
SELECT COUNT(*) AS invalid_quantity
FROM raw_online_retail
WHERE Quantity <= 0;

-- 6. Invalid price
SELECT COUNT(*) AS invalid_price
FROM raw_online_retail
WHERE UnitPrice <= 0;

-- 7. Date range
SELECT
    MIN(InvoiceDate) AS first_date,
    MAX(InvoiceDate) AS last_date
FROM raw_online_retail_staging;
