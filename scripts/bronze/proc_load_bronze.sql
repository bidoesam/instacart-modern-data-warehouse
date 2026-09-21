#/*
===============================================================================
 Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads the Instacart source data from external CSV
    files into the 'bronze' schema.

```
It performs the following actions:
- Truncates the Bronze tables before loading new data.
- Uses BULK INSERT to load data from CSV files.
- Records row counts, execution times, and load status.
- Logs successful and failed loads in the 'etl.load_log' table.
- Displays loading progress and errors for monitoring and troubleshooting.
```

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME2 , @end_time DATETIME2, @batch_start_time DATETIME2, @batch_end_time DATETIME2, @batch_id UNIQUEIDENTIFIER , @table_name VARCHAR(50),@rows_loaded BIGINT, @status VARCHAR(20), @error_message NVARCHAR(MAX);
	BEGIN TRY 
		SET @batch_start_time = GETDATE();
		PRINT '==============================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==============================================';

		-- ==========================================
		-- Loading Table: bronze.aisles
		-- ==========================================

		SET @table_name = 'bronze.aisles';
		SET @start_time = GETDATE();
		SET @batch_id = NEWID();
		PRINT '>> Truncating Table: bronze.aisles';
		TRUNCATE TABLE bronze.aisles;

		PRINT '>> Loading Table: ' + @table_name;
		BULK INSERT bronze.aisles
		FROM 'C:\Users\abdel\OneDrive\Desktop\DE\Instcart Market Basket Analysis\Datasets\aisles.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',' ,
			ROWTERMINATOR = '0x0A',
			TABLOCK
		)
		SET @end_time = GETDATE();
		SELECT @rows_loaded = COUNT(*) FROM bronze.aisles
		SET @status = 'SUCCESS'; 
		INSERT INTO etl.load_log(batch_id, table_name, start_time, end_time, duration_ms, rows_loaded, status, error_message) VALUES (@batch_id, @table_name, @start_time, @end_time, DATEDIFF(MILLISECOND, @start_time, @end_time), @rows_loaded, @status, NULL);
		PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS VARCHAR(20));
		PRINT '>> ---------------';
		-- ==========================================
		-- Loading Table: bronze.departments
		-- ==========================================

		SET @table_name = 'bronze.departments';
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.departments';
		TRUNCATE TABLE bronze.departments;

		PRINT '>> Loading Table: ' + @table_name;
		BULK INSERT bronze.departments
		FROM 'C:\Users\abdel\OneDrive\Desktop\DE\Instcart Market Basket Analysis\Datasets\departments.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0A',
			TABLOCK
		)
		SET @end_time = GETDATE();
		SELECT @rows_loaded = COUNT(*) FROM bronze.departments
		SET @status = 'SUCCESS'; 
		INSERT INTO etl.load_log(batch_id, table_name, start_time, end_time, duration_ms, rows_loaded, status, error_message) VALUES (@batch_id, @table_name, @start_time, @end_time, DATEDIFF(MILLISECOND, @start_time, @end_time), @rows_loaded, @status, NULL);		
		PRINT '>> ---------------';

		-- ==========================================
		-- Loading Table: bronze.order_products_prior
		-- ==========================================

		SET @table_name = 'bronze.order_products_prior';
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.order_products_prior';
		TRUNCATE TABLE bronze.order_products_prior;

		PRINT '>> Loading Table: ' + @table_name;
		BULK INSERT bronze.order_products_prior 
		FROM 'C:\Users\abdel\OneDrive\Desktop\DE\Instcart Market Basket Analysis\Datasets\order_products__prior.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0A',
			TABLOCK
		)
		SET @end_time = GETDATE();
		SELECT @rows_loaded = COUNT(*) FROM bronze.order_products_prior
		SET @status = 'SUCCESS';
		INSERT INTO etl.load_log(batch_id, table_name, start_time, end_time, duration_ms, rows_loaded, status, error_message) VALUES (@batch_id, @table_name, @start_time, @end_time, DATEDIFF(MILLISECOND, @start_time, @end_time), @rows_loaded, @status, NULL);		
		PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS VARCHAR(20));
		PRINT '>> ---------------';

		-- ==========================================
		-- Loading Table: bronze.order_products_train
		-- ==========================================

		SET @table_name = 'bronze.order_products_train';
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.order_products_train';
		TRUNCATE TABLE bronze.order_products_train;

		PRINT '>> Loading Table: ' + @table_name;
		BULK INSERT bronze.order_products_train 
		FROM 'C:\Users\abdel\OneDrive\Desktop\DE\Instcart Market Basket Analysis\Datasets\order_products__train.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0A',
			TABLOCK
		)
		SET @end_time = GETDATE();
		SELECT @rows_loaded = COUNT(*) FROM bronze.order_products_train
		SET @status = 'SUCCESS';
		INSERT INTO etl.load_log(batch_id, table_name, start_time, end_time, duration_ms, rows_loaded, status, error_message) VALUES (@batch_id, @table_name, @start_time, @end_time, DATEDIFF(MILLISECOND, @start_time, @end_time), @rows_loaded, @status, NULL);		
		PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS VARCHAR(20));
		PRINT '>> ---------------';

		-- ==========================================
		-- Loading Table: bronze.orders
		-- ==========================================

		SET @table_name = 'bronze.orders';
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.orders';
		TRUNCATE TABLE bronze.orders;

		PRINT '>> Loading Table: ' + @table_name;
		BULK INSERT bronze.orders
		FROM 'C:\Users\abdel\OneDrive\Desktop\DE\Instcart Market Basket Analysis\Datasets\orders.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0A',
			TABLOCK
		)
		SET @end_time = GETDATE();
		SELECT @rows_loaded = COUNT(*) FROM bronze.orders
		SET @status = 'SUCCESS';
		INSERT INTO etl.load_log(batch_id, table_name, start_time, end_time, duration_ms, rows_loaded, status, error_message) VALUES (@batch_id, @table_name, @start_time, @end_time, DATEDIFF(MILLISECOND, @start_time, @end_time), @rows_loaded, @status, NULL);		
		PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS VARCHAR(20));
		PRINT '>> ---------------';

		-- ==========================================
		-- Loading Table: bronze.products
		-- ==========================================
		SET @table_name = 'bronze.products';
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.products';
		TRUNCATE TABLE bronze.products;

		PRINT '>> Loading Table: ' + @table_name;
		BULK INSERT bronze.products
		FROM 'C:\Users\abdel\OneDrive\Desktop\DE\Instcart Market Basket Analysis\Datasets\products.csv'
		WITH (
			FORMAT = 'CSV', -- Because the dataset has quoted fields
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0A',
			FIRSTROW = 2,
			TABLOCK
		)
		SET @end_time = GETDATE();
		SELECT @rows_loaded = COUNT(*) FROM bronze.products
		SET @status = 'SUCCESS';
		INSERT INTO etl.load_log(batch_id, table_name, start_time, end_time, duration_ms, rows_loaded, status, error_message) VALUES (@batch_id, @table_name, @start_time, @end_time, DATEDIFF(MILLISECOND, @start_time, @end_time), @rows_loaded, @status, NULL);		
		PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS VARCHAR(20));
		PRINT '>> ---------------';
		
		SET @batch_end_time = GETDATE();
		PRINT '===========================================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '	  -	Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '===========================================';
	END TRY
	BEGIN CATCH
		SET @end_time = GETDATE();
		SET @status = 'FAILS';
		SET @error_message = ERROR_MESSAGE();
		INSERT INTO etl.load_log(batch_id, table_name, start_time, end_time, duration_ms, rows_loaded, status, error_message) VALUES (@batch_id, @table_name, @start_time, @end_time, DATEDIFF(MILLISECOND, @start_time, @end_time), @rows_loaded, @status, NULL);		
		PRINT '===========================================';
		PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
		PRINT 'Table: ' + @table_name;
		PRINT 'Error: ' + @error_message;
		PRINT '===========================================';
		
		THROW;
	END CATCH
END
