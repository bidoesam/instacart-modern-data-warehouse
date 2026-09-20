/*
===============================================================================
Database Initialization: InstacartDWH
===============================================================================
- Checks whether the InstacartDWH database already exists.
- Drops and recreates the database to ensure a clean environment.
- Creates the Bronze, Silver, and Gold schemas following the
  Medallion Architecture.
===============================================================================
*/
	
USE master;
GO

	 -- Drop and recreate the 'InstacartDWH' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'InstacartDWH')
	BEGIN
		ALTER DATABASE InstacartDWH SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE InstacartDWH;
	END;
GO
	
	-- Create the 'InstacartDWH' database	
CREATE DATABASE InstacartDWH;
GO

USE InstacartDWH;
GO

	-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
