## Domino’s Pizza Sales – SQL Data Analysis Project
### Project Overview
This project analyzes Domino’s Pizza sales data using SQL to understand sales performance, product popularity, and revenue trends.
The goal is to practice real‑world database querying and business analytics techniques as part of my Data Science learning journey, similar in structure to my Zepto Product & Inventory Analysis project.
​The dataset contains information on orders, pizzas, pizza types, and order details. Using SQL queries, insights are generated about revenue, customer preferences, and category‑wise performance.

### Objectives
Load and structure raw CSV/SQL data into MySQL.
Write SQL queries to explore orders, products, categories, and revenue.
Identify trends in top‑selling pizzas, popular sizes, and time‑based ordering patterns.
Generate insights useful for restaurant chains and food‑delivery platforms.
Document results and build a SQL‑based data analytics case study.
​

### Dataset Information
Domain: Food Delivery / QSR (Domino’s‑like dataset)
Format: CSV + SQL script imported into MySQL
### Core Tables:
orders – order ID, date, time.

order_details – order line items (pizza, quantity).

pizzas – individual pizza SKUs (size, price, type ID).

pizza_types – pizza names, categories (e.g., Classic, Veggie).

### Key fields include:
orders: order_id, order_date, order_time

order_details: order_details_id, order_id, pizza_id, quantity

pizzas: pizza_id, pizza_type_id, size, price

pizza_types: pizza_type_id, name, category
​

### Skills and Tools Used
SQL / MySQL
SQL queries: Aggregation, Filtering, Grouping, Sorting
#### Multiple table JOINs
Subqueries and Window functions (for ranking and cumulative metrics)
Business analytics mindset (revenue contribution, peak demand analysis)
SQL script‑driven data analysis workflow
​

#### Key SQL Concepts Applied
SELECT, WHERE, ORDER BY, GROUP BY, LIMIT
Aggregate functions: COUNT, SUM, AVG, MAX, MIN
JOIN between orders, order_details, pizzas, pizza_types
CASE statements for classification (e.g., high vs low revenue pizzas)
#### Derived metrics: total revenue, revenue share, cumulative revenue
Window functions (e.g., RANK() OVER, running revenue) where applicable
​

### Example Business Questions Solved
What is the total number of orders placed?

What is the total revenue generated from pizza sales?

Which are the top 5 most ordered pizza types and their quantities?

Which pizza categories contribute the most to total revenue?

Which pizza sizes are most popular with customers?

How do orders and revenue trend by hour and by day?

What is the revenue share (%) of each pizza category and pizza type?

What are the top 3 pizza types by revenue overall and within each category?​

### Learning Outcomes
Deeper understanding of SQL‑based sales analysis workflow.

Ability to join multiple tables and write analytical SQL queries for business insights.

Experience converting raw transactional data into actionable recommendations.

Built a complete SQL case study project, parallel to the Zepto inventory project.
​

### Future Improvements
Adding customer and store tables for richer segmentation.

Building a Power BI / Tableau dashboard using SQL outputs for visual insights.

Integrating Python (Pandas + SQL) for advanced analysis and automation.

Exploring RFM segmentation if customer data is added.

Using time‑series models for sales forecasting and staffing/inventory planning.


