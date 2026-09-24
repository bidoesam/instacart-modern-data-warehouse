/* 
=============================================================================== 
Stored Procedure: Load Silver Layer (Bronze -> Silver) 
=============================================================================== 
Script Purpose: 
    This stored procedure loads data from the Bronze layer into the Silver 
    layer of the Instacart Data Warehouse.

    It performs the following actions:
    - Truncates the Silver tables before loading data.
    - Applies basic data cleansing and standardization.
    - Loads transformed data from Bronze tables.
    - Records row counts, execution times, and load status.
    - Logs load details and errors in the 'etl.load_log' table.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC silver.load_silver;
=============================================================================== 
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN 
DECLARE @batch_id UNIQUEIDENTIFIER, @table_name VARCHAR(50), @rows_loaded BIGINT ,@status VARCHAR(50), @error_message NVARCHAR(MAX), @start_time DATETIME2, @end_time DATETIME2, @batch_start_time DATETIME2, @batch_end_time DATETIME2;
	BEGIN TRY
		 SET @batch_id = NEWID();
		 SET @batch_start_time = GETDATE();
		 -- ==========================================
		 --	silver.aisles 
		 -- ==========================================
		 SET @start_time = GETDATE();
		 SET @table_name = 'silver.aisles';
			PRINT '>> Truncating Table: silver.aisles';

			TRUNCATE TABLE silver.aisles;
			PRINT '>> Loading Table: ' + @table_name;
			INSERT INTO silver.aisles 
			(
				aisle_id, 
				aisle
			) 
			SELECT
				aisle_id, 
				aisle
			FROM bronze.aisles;
		 SET @end_time = GETDATE();
		 SELECT @rows_loaded = COUNT(*) FROM silver.aisles;
		 SET @status = 'SUCCESS';
		 INSERT INTO etl.load_log(batch_id, table_name, start_time, end_time, duration_ms, rows_loaded, status, error_message) VALUES (@batch_id, @table_name, @start_time, @end_time, DATEDIFF(MILLISECOND, @start_time, @end_time), @rows_loaded, @status, NULL);	
		 PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS VARCHAR(20));
		 PRINT '>> ---------------';

		 -- ==========================================
		 --	silver.departments 
		 -- ==========================================
		SET @start_time = GETDATE();
		SET @table_name = 'silver.departments';
		 PRINT '>> Truncating Table: silver.departments ';
		 TRUNCATE TABLE silver.departments ;

		 PRINT '>> Loading Table: ' + @table_name;
		 INSERT INTO silver.departments 
		 (
			department_id,
			department
		 )
		 SELECT 
			department_id,
			department
		 FROM bronze.departments;
	   SET @end_time = GETDATE();
		 SELECT @rows_loaded = COUNT(*) FROM silver.departments;
	   SET @status = 'SUCCESS';
		 INSERT INTO etl.load_log(batch_id, table_name, start_time, end_time, duration_ms, rows_loaded, status, error_message) VALUES (@batch_id, @table_name, @start_time, @end_time, DATEDIFF(MILLISECOND, @start_time, @end_time), @rows_loaded, @status, NULL);	
		 PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS VARCHAR(20));
		 PRINT '>> ---------------';

		 -- ==========================================
		 --	silver.order_products_prior 
		 -- ==========================================
		SET @start_time = GETDATE();
		SET @table_name = 'silver.order_products_prior';
		 PRINT '>> Truncating Table: silver.order_products_prior ';
		 TRUNCATE TABLE silver.order_products_prior ;

		 PRINT '>> Loading Table: ' + @table_name;
		 INSERT INTO silver.order_products_prior
		 (
			order_id,
			product_id,
			add_to_cart_order,
			reordered
		 )
		 SELECT 
			 order_id,
			 product_id,
			 add_to_cart_order,
			 reordered
		 FROM bronze.order_products_prior
	   SET @end_time = GETDATE();
		 SELECT @rows_loaded = COUNT(*) FROM silver.order_products_prior;
	   SET @status = 'SUCCESS';
		 INSERT INTO etl.load_log(batch_id, table_name, start_time, end_time, duration_ms, rows_loaded, status, error_message) VALUES (@batch_id, @table_name, @start_time, @end_time, DATEDIFF(MILLISECOND, @start_time, @end_time), @rows_loaded, @status, NULL);	
		 PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS VARCHAR(20));
		 PRINT '>> ---------------';

		 -- ==========================================
		 --	silver.order_products_train
		 -- ==========================================
		SET @start_time = GETDATE();
		SET @table_name = 'silver.order_products_train';
		 PRINT '>> Truncating Table: silver.order_products_train';
		 TRUNCATE TABLE silver.order_products_train ;

		 PRINT '>> Loading Table: ' + @table_name;
		 INSERT INTO silver.order_products_train
		 (
			order_id,
			product_id,
			add_to_cart_order,
			reordered
		 )
		 SELECT 
			order_id,
			product_id,
			add_to_cart_order,
	 		reordered
		 FROM bronze.order_products_train;
		SET @end_time = GETDATE();
		 SELECT @rows_loaded = COUNT(*) FROM silver.order_products_train;
		SET @status = 'SUCCESS';
		 INSERT INTO etl.load_log(batch_id, table_name, start_time, end_time, duration_ms, rows_loaded, status, error_message) VALUES (@batch_id, @table_name, @start_time, @end_time, DATEDIFF(MILLISECOND, @start_time, @end_time), @rows_loaded, @status, NULL);	
		 PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS VARCHAR(20));
		 PRINT '>> ---------------';
		 -- ==========================================
		 --	silver.orders
		 -- ==========================================
		SET @start_time = GETDATE();
		SET @table_name = 'silver.orders';
		 PRINT '>> Truncating Table: silver.orders';
		 TRUNCATE TABLE silver.orders ;

		 PRINT '>> Loading Table: ' + @table_name;
		 INSERT INTO silver.orders
		 (
			order_id,
			user_id,
			eval_set,
			order_number,
			order_dow,
			order_hour_of_day ,
			days_since_prior_order
		 )
		 SELECT 
			order_id,
			user_id,
			LOWER(TRIM(eval_set)) AS eval_set,
			order_number,
			order_dow,
			order_hour_of_day ,
			days_since_prior_order
		 FROM bronze.orders;
	   SET @end_time = GETDATE();
		 SELECT @rows_loaded = COUNT(*) FROM silver.orders;
	   SET @status = 'SUCCESS';
		 INSERT INTO etl.load_log(batch_id, table_name, start_time, end_time, duration_ms, rows_loaded, status, error_message) VALUES (@batch_id, @table_name, @start_time, @end_time, DATEDIFF(MILLISECOND, @start_time, @end_time), @rows_loaded, @status, NULL);	
		 PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS VARCHAR(20));
		 PRINT '>> ---------------';

		 -- ==========================================
		 --	silver.products
		 -- ==========================================
		SET @start_time = GETDATE();
		SET @table_name = 'silver.products';
		 PRINT '>> Truncating Table: silver.products';
		 TRUNCATE TABLE silver.products ;

		 PRINT '>> Loading Table: ' + @table_name;
		 INSERT INTO silver.products 
		 (
	 		product_id,
			product_name,
			aisle_id,
			department_id
		 )
		 SELECT 
			product_id,
			TRIM(product_name) AS product_name,
			aisle_id,
			department_id
		 FROM bronze.products;
	   SET @end_time = GETDATE();
		 SELECT @rows_loaded = COUNT(*) FROM silver.products;
	   SET @status = 'SUCCESS';
		 INSERT INTO etl.load_log(batch_id, table_name, start_time, end_time, duration_ms, rows_loaded, status, error_message) VALUES (@batch_id, @table_name, @start_time, @end_time, DATEDIFF(MILLISECOND, @start_time, @end_time), @rows_loaded, @status, NULL);	
		 PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS VARCHAR(20));
		 PRINT '>> ---------------';
	   SET @batch_end_time = GETDATE();
	   	PRINT '===========================================';
		PRINT 'Loading Silver Layer is Completed';
		PRINT '	  -	Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '===========================================';
	END TRY

	BEGIN CATCH
		SET @end_time = GETDATE();
		SET @status = 'FAILS';
		SET @error_message = ERROR_MESSAGE();
		INSERT INTO etl.load_log(batch_id, table_name, start_time, end_time, duration_ms, rows_loaded, status, error_message) VALUES (@batch_id, @table_name, @start_time, @end_time, DATEDIFF(MILLISECOND, @start_time, @end_time), NULL, @status, @error_message);
		PRINT '===========================================';
		PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
		PRINT 'Table: ' + @table_name;
		PRINT 'Error: ' + @error_message;
		PRINT '===========================================';
		THROW;
	END CATCH
END


SELECT * FROM etl.load_log
