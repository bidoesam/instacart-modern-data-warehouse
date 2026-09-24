/*
==============================================================================
DDL Script: Create Gold Views
==============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse.
    The Gold layer represents the final dimension and fact views (Star Schema).

    Each view transforms and combines data from the Silver layer to produce
    clean, enriched, and business-ready data.

Usage:
    - These views can be queried directly for analytics and reporting.
==============================================================================
*/

-- ==============================================
-- Create Dimension Table: 'gold.dim_aisles'
-- ==============================================
IF OBJECT_ID('gold.dim_aisles','V') IS NOT NULL
	DROP VIEW gold.dim_aisles;
GO

CREATE VIEW gold.dim_aisles AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY aisle_id) AS aisle_key,
	aisle_id,
	aisle AS aisle_name
FROM silver.aisles;

GO
  
-- ==============================================
-- Create Dimension Table: 'gold.dim_departments'
-- ==============================================
IF OBJECT_ID('gold.dim_departments','V') IS NOT NULL
	DROP VIEW gold.dim_departments;
GO

CREATE VIEW gold.dim_departments AS
SELECT
	ROW_NUMBER() OVER(ORDER BY department_id) AS department_key,
	department_id,
	department AS department_name
FROM silver.departments;

GO
  
-- ==============================================
-- Create Dimension Table: 'gold.dim_products'
-- ==============================================
IF OBJECT_ID('gold.dim_products','V') IS NOT NULL
	DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT
	ROW_NUMBER() OVER(ORDER BY p.product_id) AS product_key,
	p.product_id,
	p.product_name,
	a.aisle_key,
	a.aisle_name ,
	d.department_key,
	d.department_name AS department_name
FROM silver.products p
LEFT JOIN gold.dim_aisles a
ON a.aisle_id = p.aisle_id
LEFT JOIN gold.dim_departments d
ON d.department_id = p.department_id;

GO
  
-- ==============================================
-- Create Fact Table: 'gold.fact_orders'
-- ==============================================
IF OBJECT_ID('gold.fact_orders','V') IS NOT NULL
	DROP VIEW gold.fact_orders;
GO

CREATE VIEW gold.fact_orders AS
WITH order_items AS
(
SELECT 
	order_id,
	product_id,
	add_to_cart_order,
	reordered,
	order_type
FROM silver.order_products_prior

UNION ALL

SELECT 
	order_id,
	product_id,
	add_to_cart_order,
	reordered,
	order_type
FROM silver.order_products_train
)
SELECT
	dp.product_key,
	o.user_id,
	o.order_dow,
	o.order_day,
	o.order_hour_of_day,
	o.day_period,
	o.days_since_prior_order,
	oi.order_id,
	o.order_number,
	oi.add_to_cart_order,
	oi.order_type,
	o.eval_set AS order_set
FROM order_items oi
LEFT JOIN silver.orders o
	ON oi.order_id = o.order_id
LEFT JOIN gold.dim_products dp
	ON oi.product_id = dp.product_id;
