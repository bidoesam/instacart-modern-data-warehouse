/*
========================================================================================
Quality Checks
========================================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency, 
    and accuracy of the Gold Layer. These checks ensure:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model for analytics purpose.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
========================================================================================
*/

-- ======================================
-- Check 'gold.dim_aisles'
-- ======================================
-- Check for Duplicate Surrogate Keys
-- Expectation: No Result
SELECT
    aisle_key,
    COUNT(*)
FROM gold.dim_aisles
GROUP BY aisle_key
HAVING COUNT(*) > 1;

-- Check for Null Keys
-- Expectation: No Result
SELECT *
FROM gold.dim_aisles
WHERE aisle_key IS NULL;

-- Check Row Count
-- Expectation: Matches silver.aisles
SELECT COUNT(*) AS row_count
FROM gold.dim_aisles;

-- ======================================
-- Check 'gold.dim_departments'
-- ======================================
-- Check for Duplicate Surrogate Keys
-- Expectation: No Result
SELECT
    department_key,
    COUNT(*)
FROM gold.dim_departments
GROUP BY department_key
HAVING COUNT(*) > 1;

-- Check for Null Keys
-- Expectation: No Result
SELECT *
FROM gold.dim_departments
WHERE department_key IS NULL;

-- Check Row Count
-- Expectation: Matches silver.departments
SELECT COUNT(*) AS row_count
FROM gold.dim_departments;

-- ======================================
-- Check 'gold.dim_products'
-- ======================================
-- Check for Duplicate Surrogate Keys
-- Expectation: No Result
SELECT
    product_key,
    COUNT(*)
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- Check for Null Keys
-- Expectation: No Result
SELECT *
FROM gold.dim_products
WHERE product_key IS NULL;

-- Check for Missing Aisle Relationships
-- Expectation: No Result
SELECT *
FROM gold.dim_products
WHERE aisle_key IS NULL;

-- Check for Missing Department Relationships
-- Expectation: No Result
SELECT *
FROM gold.dim_products
WHERE department_key IS NULL;

-- Check Row Count
-- Expectation: Matches silver.products
SELECT COUNT(*) AS row_count
FROM gold.dim_products;

-- ======================================
-- Check 'gold.fact_orders'
-- ======================================
-- Check for Null Product Keys
-- Expectation: No Result
SELECT *
FROM gold.fact_orders
WHERE product_key IS NULL;

-- Check Product Dimension Referential Integrity
-- Expectation: No Result
SELECT *
FROM gold.fact_orders f
LEFT JOIN gold.dim_products p
    ON f.product_key = p.product_key
WHERE p.product_key IS NULL;

-- Check for Duplicate Order-Product Records
-- Expectation: No Result
SELECT
    order_id,
    product_key,
    COUNT(*)
FROM gold.fact_orders
GROUP BY
    order_id,
    product_key
HAVING COUNT(*) > 1;

-- Check Row Count
-- Expectation: Matches Combined Prior and Train Order Items
SELECT COUNT(*) AS row_count
FROM gold.fact_orders;
