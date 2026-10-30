
USE ecommerce_analysis;

-- 1. Top 3 products in each country
WITH product_sales AS (
    SELECT
        Country,
        StockCode,
        MAX(Description) AS product_name,
        SUM(Quantity * UnitPrice) AS revenue
    FROM clean_online_retail
    GROUP BY Country, StockCode
),
ranked_products AS (
    SELECT
        Country,
        StockCode,
        product_name,
        revenue,
        DENSE_RANK() OVER (
            PARTITION BY Country
            ORDER BY revenue DESC
        ) AS product_rank
    FROM product_sales
)
SELECT *
FROM ranked_products
WHERE product_rank <= 3
ORDER BY Country, product_rank;


-- 2. Month-over-month sales growth
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(InvoiceDate, '%Y-%m') AS sales_month,
        SUM(Quantity * UnitPrice) AS revenue
    FROM clean_online_retail
    GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m')
),
sales_comparison AS (
    SELECT
        sales_month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY sales_month
        ) AS previous_revenue
    FROM monthly_sales
)
SELECT
    sales_month,
    ROUND(revenue, 2) AS current_revenue,
    ROUND(previous_revenue, 2) AS previous_revenue,
    ROUND(
        100 * (revenue - previous_revenue)
        / NULLIF(previous_revenue, 0),
        2
    ) AS growth_percentage
FROM sales_comparison
ORDER BY sales_month;


-- 3. Customer segmentation
WITH customer_sales AS (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS total_orders,
        SUM(Quantity * UnitPrice) AS total_spent
    FROM clean_online_retail
    WHERE CustomerID > 0
    GROUP BY CustomerID
)
SELECT
    CustomerID,
    total_orders,
    ROUND(total_spent, 2) AS total_spent,
    CASE
        WHEN total_spent >= 10000 THEN 'High Value'
        WHEN total_spent >= 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_sales
ORDER BY total_spent DESC;


-- 4. Above-average spending customers
SELECT
    CustomerID,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_spent
FROM clean_online_retail
WHERE CustomerID > 0
GROUP BY CustomerID
HAVING SUM(Quantity * UnitPrice) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT
            SUM(Quantity * UnitPrice) AS customer_total
        FROM clean_online_retail
        WHERE CustomerID > 0
        GROUP BY CustomerID
    ) AS customer_summary
)
ORDER BY total_spent DESC;


-- 5. Monthly sales ranking
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(InvoiceDate, '%Y-%m') AS sales_month,
        SUM(Quantity * UnitPrice) AS revenue
    FROM clean_online_retail
    GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m')
)
SELECT
    sales_month,
    ROUND(revenue, 2) AS revenue,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS sales_rank
FROM monthly_sales
ORDER BY sales_rank;
