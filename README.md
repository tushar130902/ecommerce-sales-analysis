# ecommerce-sales-analysis


# E-Commerce Sales Analysis Using MySQL

## Project Overview

This project analyzes real-world online retail transaction
data using MySQL to identify sales trends, product
performance, customer purchasing behavior and
country-wise revenue.

## Dataset

Source: UCI Machine Learning Repository

Dataset: Online Retail

Dataset Link:
https://archive.ics.uci.edu/dataset/352/online+retail

Original Records: 541,909

Clean Records: 530,100

Period: December 2010 - December 2011

## Tools & Technologies

- MySQL 9.7
- MySQL Workbench
- VS Code
- Git
- GitHub

## Database Tables

1. raw_online_retail
2. raw_online_retail_staging
3. clean_online_retail

## Data Cleaning

- Removed cancelled invoices from primary sales analysis.
- Excluded non-positive quantities.
- Excluded non-positive unit prices.
- Converted invoice dates into DATETIME format.
- Preserved original raw data.
- Handled missing customer IDs separately in customer analysis.

## SQL Concepts Used

- SELECT, WHERE, ORDER BY
- GROUP BY and HAVING
- INNER JOIN and other JOIN operations
- Aggregate Functions
- Subqueries
- Common Table Expressions (CTEs)
- CASE WHEN
- Window Functions
- RANK(), DENSE_RANK(), LAG()
- Views
- Date Functions

## Business Questions

1. What is the overall sales revenue?
2. Which months generated the highest revenue?
3. Which products generated the highest sales?
4. Which countries contributed the most revenue?
5. Who are the repeat customers?
6. What is the average order value?
7. Which products rank in the top 3 for each country?
8. What is the month-over-month revenue growth?
9. How can customers be segmented based on spending?

## Project Structure

- data/: Dataset instructions
- sql/: SQL scripts
- screenshots/: Query results and analysis screenshots

## Revenue Calculation

Revenue = Quantity * UnitPrice

Revenue represents gross sales value, not net profit.

## Data Source Attribution

Chen, D. (2015). Online Retail.
UCI Machine Learning Repository.
https://doi.org/10.24432/C5BW33

Dataset license: CC BY 4.0.
