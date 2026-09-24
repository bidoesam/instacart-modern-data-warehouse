/* 
================================================================================== 
DDL Script: Create Silver Tables 
================================================================================== 
Script Purpose: 
    This script creates the Silver layer tables for the Instacart Data Warehouse.
    Existing tables are dropped and recreated to ensure a clean and consistent
    schema definition for transformed and standardized data.

    Run this script to initialize or re-define the DDL structure of the
    Silver layer tables.
================================================================================== 
*/

IF OBJECT_ID('silver.aisles' , 'U') IS NOT NULL
	DROP TABLE silver.aisles; 
CREATE TABLE silver.aisles 
(
	aisle_id INT,
	aisle VARCHAR(100),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

GO

IF OBJECT_ID('silver.departments' , 'U') IS NOT NULL
	DROP TABLE silver.departments;
CREATE TABLE silver.departments
(
	department_id INT,
	department VARCHAR(100),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

GO

IF OBJECT_ID('silver.order_products_prior' , 'U') IS NOT NULL
	DROP TABLE silver.order_products_prior;
CREATE TABLE silver.order_products_prior
(
	order_id INT,
	product_id INT,
	add_to_cart_order INT,
	reordered INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

GO

IF OBJECT_ID('silver.order_products_train' , 'U') IS NOT NULL
	DROP TABLE silver.order_products_train;
CREATE TABLE silver.order_products_train
(
	order_id INT,
	product_id INT,
	add_to_cart_order INT,
	reordered INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

GO

IF OBJECT_ID('silver.orders' , 'U') IS NOT NULL
	DROP TABLE silver.orders;
CREATE TABLE silver.orders
(
	order_id INT,
	user_id INT,
	eval_set VARCHAR(100),
	order_number INT,
	order_dow INT,
	order_hour_of_day INT,
	days_since_prior_order FLOAT ,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

GO

IF OBJECT_ID('silver.products' , 'U') IS NOT NULL
	DROP TABLE silver.products;
CREATE TABLE silver.products
(
	product_id INT,
	product_name VARCHAR(500),
	aisle_id INT,
	department_id INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
