# Instacart OLTP Dataset

This folder represents the source datasets used in the **Instacart Data Engineering Project**.

## Dataset Overview

The project uses the **Instacart Online Grocery Shopping Dataset**, which contains transactional data related to customers, orders, products, aisles, departments, and order-product relationships.

## Dataset Availability

The original dataset files are **not included in this repository** due to their large size.

To reproduce the project, obtain the source dataset from its original public source and place the extracted CSV files in this directory.

## Expected Structure

```text
source_instacart_oltp_system/
│
├── aisles.csv
├── departments.csv
├── orders.csv
├── products.csv
├── order_products__prior.csv
└── order_products__train.csv
```

## Usage

The source files are used as the input layer for the project's **Medallion Architecture**:

**Source → Bronze → Silver → Gold**

The raw data is loaded into the Bronze layer before undergoing data cleaning, transformation, integration, and modeling in the subsequent layers.

> **Note:** The dataset files are intentionally excluded from this repository because of their large file size.
