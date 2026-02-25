# Construction Company Operational Analysis

---

## Project Overview

This project presents a comprehensive SQL analysis of a construction company database implemented in PostgreSQL.

The analysis focuses on:

- Project portfolio performance
- Workforce structure and salary costs
- Cash flow dynamics
- Manager performance evaluation
- Revenue concentration by customer

All analytical tasks are implemented using pure SQL queries.

---

## Business Context

The construction company manages multiple projects across different regions and works with various contractors.

The management requires analytical reporting to:

- Monitor signed projects and their cost
- Analyze completed projects
- Evaluate employee structure and salary distribution
- Track accumulated payments
- Assess bonus calculation for project managers
- Analyze customer revenue concentration

The database includes projects, payments, employees, company hierarchy and customer data.

---

## Data Structure

The relational PostgreSQL database contains:

- Projects
- Project payments
- Employees and salary history
- Organizational hierarchy (recursive structure)
- Customers and types of work
- Geographic hierarchy (Country → City → Address)

The schema is normalized and built with foreign key constraints.

---

## Key Analytical Tasks

- Count projects signed in 2023
- Calculate total age of employees hired in 2022
- Identify longest-working employees
- Calculate average age of dismissed employees
- Calculate total payments from customers in specific locations
- Determine highest manager bonus (1% of completed projects)
- Calculate cumulative advance payments per month
- Perform recursive salary aggregation by department
- Apply rolling average calculations on payments
- Create a materialized reporting view

---

## Analytical Logic

The project demonstrates:

- Multi-table JOIN logic
- Common Table Expressions (CTE)
- Recursive CTE for hierarchical structures
- Window functions (ROW_NUMBER, RANK, AVG OVER, cumulative SUM)
- Date and interval calculations
- Conditional filtering
- LATERAL joins
- Materialized view creation

All calculations are performed using PostgreSQL.

---

## Project Structure

- business_queries.sql
- materialized_view.sql
- database_schema.png
