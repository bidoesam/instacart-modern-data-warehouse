/*
==================================================================================
DDL Script: Create Bronze Tables
==================================================================================
Script Purpose:
    This script creates the Bronze layer tables for the Instacart Data Warehouse.
    Existing tables are dropped and recreated to ensure a clean and consistent
    schema definition for the raw source data.

```
It also creates the ETL load log table to track batch execution details,
including row counts, duration, status, and error messages.

Run this script to initialize or re-define the DDL structure of the
Bronze and ETL logging tables.
```
==================================================================================
*/

IF OBJECT_ID('bronze.aisles' , 'U') IS NOT NULL
	DROP TABLE bronze.aisles; 
CREATE TABLE bronze.aisles 
(
aisle_id  INT,
aisle     VARCHAR(100)
);

IF OBJECT_ID('bronze.departments' , 'U') IS NOT NULL
	DROP TABLE bronze.departments;
CREATE TABLE bronze.departments
(
department_id INT,
department    VARCHAR(100)
);

IF OBJECT_ID('bronze.order_products_prior' , 'U') IS NOT NULL
	DROP TABLE bronze.order_products_prior;
CREATE TABLE bronze.order_products_prior
(
order_id          INT,
product_id        INT,
add_to_cart_order INT,
reordered         INT
);

IF OBJECT_ID('bronze.order_products_train' , 'U') IS NOT NULL
	DROP TABLE bronze.order_products_train;
CREATE TABLE bronze.order_products_train
(
order_id          INT,
product_id        INT,
add_to_cart_order INT,
reordered         INT
);

IF OBJECT_ID('bronze.orders' , 'U') IS NOT NULL
	DROP TABLE bronze.orders;
CREATE TABLE bronze.orders
(
order_id                INT,
user_id                 INT,
eval_set                VARCHAR(100),
order_number            INT,
order_dow               INT,
order_hour_of_day       INT,
days_since_prior_order FLOAT 
);

IF OBJECT_ID('bronze.products' , 'U') IS NOT NULL
	DROP TABLE bronze.products;
CREATE TABLE bronze.products
(
product_id    INT,
product_name  VARCHAR (500),
aisle_id      INT,
department_id INT
);
  
IF OBJECT_ID('etl.load_log' , 'U') IS NOT NULL
	DROP TABLE etl.load_log;
CREATE TABLE etl.load_log
(
	batch_id                      UNIQUEIDENTIFIER ,
    log_id                      INT IDENTITY(1,1) PRIMARY KEY,
    table_name                  VARCHAR(50),
    rows_loaded                 INT,
    start_time                  DATETIME2,
    end_time                    DATETIME2,
    duration_ms                 INT,
    status                      VARCHAR(20),
    error_message               NVARCHAR(MAX),
    load_date DATETIME2 DEFAULT GETDATE()
);
