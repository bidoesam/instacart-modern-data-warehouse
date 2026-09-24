/*
================================================================================
Quality Checks
================================================================================
Script Purpose:
    This script performs data quality validation checks on the Silver layer
    tables of the Instacart Data Warehouse.

    It includes checks for:
    - Null or duplicate primary/business keys.
    - Unwanted spaces in text columns.
    - Data standardization and consistency.
    - Invalid or unexpected values.
    - Referential integrity (orphan records).
    - Business rule violations and data anomalies.

Usage Notes:
    - Run these checks after executing the Silver layer load process.
    - Investigate and resolve any records returned by the validation queries.
    - A successful check should return no results unless otherwise stated.
================================================================================
*/

-- --------------------------------------
-- Checking silver.aisles
-- --------------------------------------
-- Check for Nulls or Duplicates in Primary Key 
-- Expectation: No Result
SELECT 
	aisle_id,
	COUNT(*)
FROM silver.aisles
GROUP BY aisle_id
HAVING COUNT(*) > 1 OR aisle_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Result
SELECT 
	aisle
FROM silver.aisles 
WHERE aisle != TRIM(aisle);

-- --------------------------------------
-- Checking silver.departments
-- --------------------------------------
-- Check for Nulls or Duplicates in Primary Key 
-- Expectation: No Result
SELECT 
	department_id,
	COUNT(*)
FROM silver.departments
GROUP BY department_id
HAVING COUNT(*) > 1 OR department_id IS NULL;

-- Check for Unwanted Spaces
-- Expectation: No Result
SELECT 
	department
FROM silver.departments
WHERE department != TRIM(department);

SELECT * FROM silver.departments;

-- --------------------------------------
-- Checking silver.order_products_prior
-- --------------------------------------
-- Check for Duplicate Order-Product Combinations
-- Expectation: No Result
SELECT 
	order_id,
	product_id,
	COUNT(*) 
FROM silver.order_products_prior
GROUP BY 
	order_id,
	product_id
HAVING COUNT(*) > 1;

-- Check for Null or Invalid Values in add_to_cart_order
-- Expectation: No Result
SELECT 
* 
FROM silver.order_products_prior
WHERE add_to_cart_order <= 0 OR add_to_cart_order IS NULL;

-- Check for Invalid Values in reordered
-- Expectation: No Result
SELECT 
* 
FROM silver.order_products_prior 
WHERE reordered IS NULL OR reordered NOT IN (0,1);

-- --------------------------------------
-- Checking silver.order_products_train
-- --------------------------------------
-- Check for Nulls in order_id
-- Expectation: No Result
SELECT 
*
FROM silver.order_products_train
WHERE order_id IS NULL;

-- Check for Nulls in product_id
-- Expectation: No Result
SELECT 
*
FROM silver.order_products_train
WHERE product_id IS NULL;

-- Check for Duplicates in the Composite Business Key (order_id, product_id)
-- Expectation: No Result
SELECT
	order_id,
	product_id,
COUNT(*)
FROM silver.order_products_train
GROUP BY 
	order_id,
	product_id
HAVING COUNT(*) > 1;

-- Check for Null or Invalid Values in add_to_cart_order
-- Expectation: No Result
SELECT 
* 
FROM silver.order_products_train
WHERE add_to_cart_order <= 0 OR add_to_cart_order IS NULL;

-- Check for Invalid Values in add_to_cart_order
-- Expectation: No Result
SELECT 
* 
FROM silver.order_products_train
WHERE reordered IS NULL OR reordered NOT IN (0,1);

-- --------------------------------------
-- Checking silver.orders
-- --------------------------------------

SELECT
	order_id,
	COUNT(*)
FROM silver.orders
GROUP BY order_id
HAVING COUNT(*) > 1 OR order_id IS NULL;

-- Check for Nulls in user_id
-- Expectation: No Result
SELECT
*
FROM silver.orders
WHERE user_id IS NULL;

-- Check for Unwanted Spaces 
-- Expectation: No Result
SELECT
	eval_set
FROM silver.orders
WHERE eval_set != TRIM(eval_set); 

-- Data Standardization & Consistency
SELECT DISTINCT eval_set
FROM silver.orders;

--	Check for Invalid Values in eval_set
SELECT
eval_set
FROM silver.orders
WHERE eval_set NOT IN ('prior', 'train', 'test') 
   OR eval_set IS NULL;

-- Check for Invalid Values in order_number
SELECT 
	order_number
FROM silver.orders
WHERE order_number IS NULL 
   OR order_number < 1;

-- Check for Null or Invalid Values in order_dow
SELECT
	order_dow
FROM silver.orders
WHERE order_dow IS NULL
   OR order_dow NOT BETWEEN 0 AND 6;

-- Check for Invalid Values in order_hour_of_day
SELECT 
	order_hour_of_day
FROM silver.orders
WHERE order_hour_of_day IS NULL 
   OR order_hour_of_day NOT BETWEEN 0 AND 23;

-- Check for Unexpected Nulls in days_since_prior_order
-- Expectation: No Result
SELECT
days_since_prior_order
FROM silver.orders
WHERE order_number > 1 
  AND days_since_prior_order IS NULL;

-- Check for Negative Values in days_since_prior_order
-- Expectation: No Result

SELECT
    days_since_prior_order
FROM silver.orders
WHERE days_since_prior_order < 0;

-- --------------------------------------
-- Checking silver.products
-- --------------------------------------
-- Check for Nulls or Duplicates in Primary key
-- Expectation: No Result
SELECT
	product_id,
	COUNT(*)
FROM silver.products
GROUP BY product_id
HAVING COUNT(*) > 1 OR product_id IS NULL;

-- Check for Unwanted Spaces 
-- Expectation: No Result
SELECT
	product_name
FROM silver.products
WHERE product_name != TRIM(product_name);

-- Check for Nulls in product_name
-- Expectation: No Result
SELECT
	product_name
FROM silver.products
WHERE product_name IS NULL;

-- Check for Orphan aisle_id Values
-- Expectation: No Result
SELECT 
	product_id,
	product_name,
	aisle_id,
	department_id
FROM silver.products
WHERE aisle_id NOT IN (SELECT aisle_id FROM bronze.aisles);

-- Check for Orphan department_id Values
-- Expectation: No Result
SELECT 
	product_id,
	product_name,
	aisle_id,
	department_id
FROM silver.products
WHERE department_id NOT IN (SELECT department_id FROM bronze.departments);
