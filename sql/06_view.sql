
USE ecommerce_analysis;

-- Monthly sales view
CREATE OR REPLACE VIEW monthly_sales_view AS
SELECT
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS sales_month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM clean_online_retail
GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m');


-- Country sales view
CREATE OR REPLACE VIEW country_sales_view AS
SELECT
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM clean_online_retail
GROUP BY Country;


-- Product sales view
CREATE OR REPLACE VIEW product_sales_view AS
SELECT
    StockCode,
    MAX(Description) AS product_name,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue
FROM clean_online_retail
GROUP BY StockCode;


-- Test views
SELECT * FROM monthly_sales_view;
SELECT * FROM country_sales_view;
SELECT * FROM product_sales_view
ORDER BY revenue DESC
LIMIT 10;
