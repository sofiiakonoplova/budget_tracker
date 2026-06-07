# Metabase Financial Dashboard

This dashboard visualizes personal finance data from a MySQL database connected to a Flask budgeting application.

It provides insights into income, expenses, category spending, and budget utilization over time.

## Data Source

- Database: MySQL (Budget_db)
- Tables:
  - transactions
  - categories
  - accounts
  - budgets
- Data is inserted via Flask web application

## Purpose

The dashboard is designed to:

- Track monthly spending patterns
- Compare income vs expenses
- Monitor category-level budget usage
- Identify overspending trends

## Key Visualizations

### 1. Biggest Monthly Expenses
Shows top 3 biggest expenses per month.

### 2. Category Breakdown
Displays spending distribution across categories.

### 3. Budget vs Actual Spending
Compares planned budgets with actual expenses.

### 4. Income vs Expenses
Highlights financial balance per month.

## SQL Queries





---

## Key Insights

- Food and Rent are the highest expense categories
- Spending spikes occur at month-end
- Budget overruns happen mainly in discretionary categories

## Dashboard Preview

![Metabase Dashboard](/screenshots/metabase-dashboard.png)