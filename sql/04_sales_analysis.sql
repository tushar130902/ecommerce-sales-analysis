
USE ecommerce_analysis;

-- 1. Overall sales performance
SELECT
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    COUNT(DISTINCT CustomerID) AS total_customers,
    SUM(Quantity) AS total_units_sold
FROM clean_online_retail;

-- 2. Monthly sales analysis
SELECT
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS sales_month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS monthly_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM clean_online_retail
GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m')
ORDER BY sales_month;

-- 3. Top 10 products by revenue
SELECT
    StockCode,
    MAX(Description) AS product_name,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue
FROM clean_online_retail
GROUP BY StockCode
ORDER BY revenue DESC
LIMIT 10;

-- 4. Country-wise revenue
SELECT
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    COUNT(DISTINCT CustomerID) AS customers
FROM clean_online_retail
GROUP BY Country
ORDER BY revenue DESC;

-- 5. Repeat customers
SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_spent
FROM clean_online_retail
WHERE CustomerID > 0
GROUP BY CustomerID
HAVING COUNT(DISTINCT InvoiceNo) > 1
ORDER BY total_orders DESC
LIMIT 20;

-- 6. Average order value
WITH invoice_sales AS (
    SELECT
        InvoiceNo,
        SUM(Quantity * UnitPrice) AS order_value
    FROM clean_online_retail
    GROUP BY InvoiceNo
)
SELECT
    COUNT(*) AS total_orders,
    ROUND(AVG(order_value), 2) AS average_order_value,
    ROUND(MAX(order_value), 2) AS highest_order_value
FROM invoice_sales;

-- 7. Country-wise revenue contribution
WITH country_sales AS (
    SELECT
        Country,
        SUM(Quantity * UnitPrice) AS revenue
    FROM clean_online_retail
    GROUP BY Country
)
SELECT
    Country,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        revenue * 100 / SUM(revenue) OVER (),
        2
    ) AS revenue_percentage
FROM country_sales
ORDER BY revenue DESC;
