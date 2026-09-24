/*
==============================================================================
DDL Script: Create ETL Load Log Table
==============================================================================
Script Purpose:
    This script creates the ETL load log table used to track data load
    executions across the warehouse layers.

    The table stores batch information, execution times, row counts,
    load status, and error details for monitoring and troubleshooting.

Usage:
    - Populated automatically by ETL stored procedures.
    - Supports auditing, monitoring, and error tracking.
==============================================================================
*/

IF OBJECT_ID('etl.load_log' , 'U') IS NOT NULL
	DROP TABLE etl.load_log;
CREATE TABLE etl.load_log
(
	batch_id UNIQUEIDENTIFIER ,
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    table_name VARCHAR(50),
    rows_loaded INT,
    start_time DATETIME2,
    end_time DATETIME2,
    duration_ms INT,
    status VARCHAR(20),
    error_message NVARCHAR(MAX),
    load_date DATETIME2 DEFAULT GETDATE()
);
