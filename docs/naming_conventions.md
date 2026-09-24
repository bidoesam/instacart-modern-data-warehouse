# Naming Conventions

This document defines the naming standards used across the Instacart Data Warehouse project, including schemas, views, columns, and stored procedures. Consistent naming improves readability, maintainability, and collaboration.

## Table of Contents

1. [General Principles](#general-principles)
2. [Object Naming Conventions](#object-naming-conventions)

   * [Bronze Layer](#bronze-layer)
   * [Silver Layer](#silver-layer)
   * [Gold Layer](#gold-layer)
3. [Column Naming Conventions](#column-naming-conventions)

   * [Surrogate Keys](#surrogate-keys)
   * [Technical Columns](#technical-columns)
4. [Stored Procedure Naming Conventions](#stored-procedure-naming-conventions)

---

## General Principles

* Use **snake_case** naming format.
* Use **lowercase letters** only.
* Separate words using underscores (`_`).
* Use **English** for all object names.
* Avoid SQL reserved keywords as object names.
* Use clear and meaningful names that accurately describe the business entity.

---

## Object Naming Conventions

### Bronze Layer

Bronze objects store raw data exactly as received from source files.

#### Pattern

```text
<entity>
```

#### Rules

* Preserve source file naming whenever possible.
* Store data with minimal transformation.
* No business-driven renaming should occur in this layer.

#### Examples

| Object Name          |
| -------------------- |
| aisles               |
| departments          |
| products             |
| orders               |
| order_products_prior |
| order_products_train |

---

### Silver Layer

Silver objects contain cleansed, standardized, and transformed data.

#### Pattern

```text
<entity>
```

#### Rules

* Preserve original object identity.
* Apply transformations without unnecessary renaming.
* Use business-friendly column names when deriving new attributes.

#### Examples

| Object Name          |
| -------------------- |
| aisles               |
| departments          |
| products             |
| orders               |
| order_products_prior |
| order_products_train |

---

### Gold Layer

Gold views represent business-ready dimensional models optimized for reporting and analytics.

#### Pattern

```text
<category>_<entity>
```

#### Components

* **category**: Identifies the view type.
* **entity**: Business-oriented entity name.

#### Examples

| View Name       | Description          |
| --------------- | -------------------- |
| dim_aisles      | Aisle dimension      |
| dim_departments | Department dimension |
| dim_products    | Product dimension    |
| fact_orders     | Orders fact view     |

---

### Category Glossary

| Prefix | Meaning        | Example      |
| ------ | -------------- | ------------ |
| dim_   | Dimension view | dim_products |
| fact_  | Fact view      | fact_orders  |

---

## Column Naming Conventions

### Surrogate Keys

All dimension surrogate keys must use the suffix `_key`.

#### Pattern

```text
<entity>_key
```

#### Examples

| Column Name    |
| -------------- |
| aisle_key      |
| department_key |
| product_key    |

---

### Source Identifiers

Business/source identifiers must use the suffix `_id`.

#### Pattern

```text
<entity>_id
```

#### Examples

| Column Name   |
| ------------- |
| aisle_id      |
| department_id |
| product_id    |
| order_id      |
| user_id       |

---

### Technical Columns

System-generated metadata columns must use the prefix `dwh_`.

#### Pattern

```text
dwh_<column_name>
```

#### Examples

| Column Name     | Description               |
| --------------- | ------------------------- |
| dwh_create_date | Record creation timestamp |

---

## Stored Procedure Naming Conventions

Stored procedures responsible for loading data into warehouse layers must follow the pattern below.

#### Pattern

```text
load_<layer>
```

#### Examples

| Procedure Name | Description                                      |
| -------------- | ------------------------------------------------ |
| load_bronze    | Loads source data into the Bronze layer          |
| load_silver    | Cleans and transforms data into the Silver layer |

---

## Examples from This Project

### Schemas

```text
bronze
silver
gold
etl
```

### Bronze Objects

```text
bronze.aisles
bronze.departments
bronze.products
bronze.orders
bronze.order_products_prior
bronze.order_products_train
```

### Silver Objects

```text
silver.aisles
silver.departments
silver.products
silver.orders
silver.order_products_prior
silver.order_products_train
```

### Gold Views

```text
gold.dim_aisles
gold.dim_departments
gold.dim_products
gold.fact_orders
```

### Surrogate Keys

```text
aisle_key
department_key
product_key
```

### Technical Columns

```text
dwh_create_date
```

### Stored Procedures

```text
bronze.load
```
