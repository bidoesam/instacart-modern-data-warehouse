# Data Catalog - Gold Layer

## Overview

The Gold Layer provides a business-oriented representation of the Instacart dataset, structured to support analytical and reporting use cases. It consists of dimension views and a fact view that integrate cleaned Silver Layer data into a dimensional model using surrogate keys for relationships.

---

## 1. gold.dim_aisles

- **Purpose:** Stores aisle information and provides a surrogate key for identifying aisles within the Gold Layer.
- **Columns:**

| Column Name | Data Type | Description |
|------------|-----------|-------------|
| aisle_key | BIGINT | Surrogate key uniquely identifying each aisle within the Gold Layer. |
| aisle_id | INT | Original source identifier assigned to the aisle. |
| aisle_name | VARCHAR(100) | Descriptive name of the aisle. |

---

## 2. gold.dim_departments

- **Purpose:** Stores department information and provides a surrogate key for identifying departments within the Gold Layer.
- **Columns:**

| Column Name | Data Type | Description |
|------------|-----------|-------------|
| department_key | BIGINT | Surrogate key uniquely identifying each department within the Gold Layer. |
| department_id | INT | Original source identifier assigned to the department. |
| department_name | VARCHAR(100) | Descriptive name of the department. |

---

## 3. gold.dim_products

- **Purpose:** Provides product information enriched with aisle and department attributes. Surrogate keys are used to establish relationships with the corresponding Gold dimensions.
- **Columns:**

| Column Name | Data Type | Description |
|------------|-----------|-------------|
| product_key | BIGINT | Surrogate key uniquely identifying each product within the Gold Layer. |
| product_id | INT | Original source identifier assigned to the product. |
| product_name | VARCHAR(500) | Descriptive name of the product. |
| aisle_key | BIGINT | Surrogate key linking the product to the gold.dim_aisles dimension. |
| aisle_name | VARCHAR(100) | Name of the aisle to which the product belongs. |
| department_key | BIGINT | Surrogate key linking the product to the gold.dim_departments dimension. |
| department_name | VARCHAR(100) | Name of the department to which the product belongs. |

---

## 4. gold.fact_orders

- **Purpose:** Stores order-product transaction records for analytical purposes. The fact view combines prior and train order-product data with order details and product dimension information.
- **Grain:** One row represents one product within one order.
- **Columns:**

| Column Name | Data Type | Description |
|------------|-----------|-------------|
| product_key | BIGINT | Surrogate key linking the order item to the gold.dim_products dimension. |
| user_id | INT | Original source identifier of the user associated with the order. |
| order_dow | INT | Numeric representation of the day of the week when the order was placed, ranging from 0 to 6. |
| order_day | VARCHAR(50) | Name of the day when the order was placed, such as Sunday or Monday. |
| order_hour_of_day | INT | Hour of the day when the order was placed, ranging from 0 to 23. |
| day_period | VARCHAR(50) | Time period in which the order was placed, such as Morning, Afternoon, Evening, or Night. |
| days_since_prior_order | FLOAT | Number of days since the user's previous order. |
| order_id | INT | Original source identifier assigned to the order. |
| order_number | INT | Sequential order number representing the user's order sequence. |
| add_to_cart_order | INT | Position of the product within the order's add-to-cart sequence. |
| order_type | VARCHAR(50) | Indicates whether the product was reordered or added for the first time, such as Reordered or First Time. |
| order_set | VARCHAR(100) | Dataset classification of the order, such as prior, train, or test. |

---

## Gold Layer Relationships

The Gold Layer uses surrogate keys to establish relationships between dimensions and facts.

| Parent | Key | Child | Foreign Key |
|-------|-----|-------|-------------|
| gold.dim_aisles | aisle_key | gold.dim_products | aisle_key |
| gold.dim_departments | department_key | gold.dim_products | department_key |
| gold.dim_products | product_key | gold.fact_orders | product_key |

### Relationship Diagram

```text
gold.dim_aisles
    │
    │ aisle_key
    ▼
gold.dim_products
    ▲
    │ department_key
    │
gold.dim_departments

gold.dim_products
    │
    │ product_key
    ▼
gold.fact_orders
