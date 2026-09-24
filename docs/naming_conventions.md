# Naming Conventions

This document defines the naming standards used across the Data Warehouse project, including schemas, tables, columns, and stored procedures. Consistent naming improves readability, maintainability, and collaboration.

## Table of Contents

1. [General Principles](#general-principles)
2. [Table Naming Conventions](#table-naming-conventions)
   - [Bronze Layer](#bronze-layer)
   - [Silver Layer](#silver-layer)
   - [Gold Layer](#gold-layer)
3. [Column Naming Conventions](#column-naming-conventions)
   - [Surrogate Keys](#surrogate-keys)
   - [Technical Columns](#technical-columns)
4. [Stored Procedure Naming Conventions](#stored-procedure-naming-conventions)

---

## General Principles

- Use **snake_case** naming format.
- Use **lowercase letters** only.
- Separate words using underscores (`_`).
- Use **English** for all object names.
- Avoid SQL reserved keywords as object names.
- Use clear and meaningful names that accurately describe the business entity.

---

## Table Naming Conventions

### Bronze Layer

Bronze tables store raw data exactly as received from source systems.

#### Pattern

```text
<sourcesystem>_<entity>
```

#### Rules

- Table names must begin with the source system name.
- Table names should remain identical to the source table names whenever possible.
- No business-driven renaming should occur in this layer.

#### Examples

| Table Name |
|------------|
| crm_cust_info |
| crm_prd_info |
| crm_sales_details |
| erp_cust_az12 |
| erp_loc_a101 |

---

### Silver Layer

Silver tables contain cleansed, standardized, and transformed data.

#### Pattern

```text
<sourcesystem>_<entity>
```

#### Rules

- Retain source system prefixes.
- Preserve original table identity.
- Apply transformations without changing naming conventions.

#### Examples

| Table Name |
|------------|
| crm_cust_info |
| crm_prd_info |
| crm_sales_details |
| erp_cust_az12 |
| erp_loc_a101 |

---

### Gold Layer

Gold tables represent business-ready data models optimized for reporting and analytics.

#### Pattern

```text
<category>_<entity>
```

#### Components

- **category**: Identifies the table type.
- **entity**: Business-oriented table name.

#### Examples

| Table Name | Description |
|------------|-------------|
| dim_customers | Customer dimension |
| dim_products | Product dimension |
| fact_sales | Sales fact table |
| report_sales_monthly | Monthly sales report |

---

### Category Glossary

| Prefix | Meaning | Example |
|----------|----------|----------|
| dim_ | Dimension table | dim_customers |
| fact_ | Fact table | fact_sales |
| report_ | Reporting table | report_sales_monthly |

---

## Column Naming Conventions

### Surrogate Keys

All dimension table primary keys must use the suffix `_key`.

#### Pattern

```text
<entity>_key
```

#### Examples

| Column Name |
|-------------|
| customer_key |
| product_key |
| sales_key |

---

### Technical Columns

System-generated metadata columns must use the prefix `dwh_`.

#### Pattern

```text
dwh_<column_name>
```

#### Examples

| Column Name | Description |
|-------------|-------------|
| dwh_create_date | Record creation timestamp |
| dwh_load_date | Data load date |
| dwh_update_date | Record update timestamp |

---

## Stored Procedure Naming Conventions

Stored procedures responsible for loading data into warehouse layers must follow the pattern below.

#### Pattern

```text
load_<layer>
```

#### Examples

| Procedure Name | Description |
|----------------|-------------|
| load_bronze | Loads data into the Bronze layer |
| load_silver | Loads data into the Silver layer |
| load_gold | Loads data into the Gold layer |

---

## Examples from This Project

### Schemas

```text
bronze
silver
gold
```

### Tables

```text
bronze.crm_cust_info
bronze.crm_prd_info
silver.crm_cust_info
silver.crm_prd_info
gold.dim_customers
gold.dim_products
gold.fact_sales
```

### Technical Columns

```text
dwh_create_date
dwh_load_date
```

### Stored Procedures

```text
bronze.load_bronze
silver.load_silver
gold.load_gold
```
