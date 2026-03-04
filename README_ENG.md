# Construction Company SQL Analysis (PostgreSQL)

## Project Overview

This project represents a comprehensive operational and financial SQL analysis of a construction company database implemented in PostgreSQL.

The objective is to extract business-critical insights using advanced SQL logic applied to a fully normalized relational schema.

The analysis covers:

- Project portfolio performance
- Cash flow dynamics
- Workforce structure and payroll costs
- Manager bonus evaluation
- Revenue concentration
- Operational reporting automation

All analytical tasks are implemented using pure SQL.

---

## Database Structure

The PostgreSQL database includes the following entities:

- Projects
- Project payments (planned and actual)
- Employees
- Salary history
- Organizational hierarchy (recursive structure)
- Customers
- Types of work
- Geographic hierarchy (Country → City → Address)

The schema is fully normalized and built with foreign key constraints.

Database diagram: `database_schema.png`


---

## Key Business Insights

### Stable Contract Flow

The company signed **54 projects in 2023**, indicating stable operational workload and sustained demand.

### Experienced Workforce Structure

Employees hired in 2022 represent a combined age exceeding **127 years**, suggesting a focus on experienced professionals rather than junior hires.

### Long-Term Retention

The longest-working employee has been with the company since **2015**, indicating organizational stability and institutional knowledge retention.

### Workforce Optimization Pattern

The average dismissal age of **43.75 years** may indicate mid-career restructuring or cost optimization strategies.

### Regional Revenue Concentration

Payments from a specific region total **31.78 million**, revealing geographic revenue dependency and potential regional risk exposure.

### Manager Bonus Concentration

The highest manager bonus equals **904,814.22**, reflecting uneven distribution of high-value projects.

### Strong Liquidity Structure

Cumulative advance payments exceed the defined threshold early in the month, demonstrating strong liquidity and front-loaded cash inflows.

### Hierarchical Salary Burden

Recursive salary aggregation for a department equals **3,540,000**, highlighting the financial weight of hierarchical structure.

### Portfolio Value Shift in 2024

Total project cost in 2024 (**169,148,040**) falls below rolling average threshold, potentially indicating margin compression or smaller contract sizes.

### Reporting Automation

A materialized view consolidates:

- Last payment date
- Last payment amount
- Project manager
- Customer
- Types of work

This enables fast executive-level reporting and reduces analytical overhead.

---

## SQL Techniques Demonstrated

- Complex multi-table JOIN operations
- Common Table Expressions (CTE)
- Recursive CTE
- Window functions (ROW_NUMBER, SUM OVER, AVG OVER)
- Rolling averages
- Cumulative sums
- Date interval calculations
- LATERAL joins
- Conditional filtering
- Materialized view creation

All logic implemented in PostgreSQL.


---

## Project Structure

- business_queries.sql
- materialized_view.sql
- database_schema.png
