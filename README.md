# Customer Cohort Analysis (SQL + Power BI)
## 📌 Project Overview
This project demonstrates a Customer **Cohort Analysis** for a retail business using the **AdventureWorksDW** dataset.
The goal is to analyze customer **retention** and **revenue** behavior over time, based on the month of a customer’s first purchase.
All cohort calculations are performed in **SQL**, and the final results are visualized in **Power BI**.

---

## 🗂 Dataset
Source: **AdventureWorksDW**

Main Tables Used:
- `FactInternetSales`
- `DimCustomer`
- `DimDate`

---

## 🧮 Phase 1: Cohort & Retention Analysis in SQL
In this phase, customers are grouped into cohorts based on their first purchase month.

The SQL logic:
- Identifies the first purchase date per customer
- Assigns each customer to a cohort month
- Calculates the number of months since first purchase (MonthIndex)
  
Computes:
- Active customers per cohort & month
- Cohort size
- Retention Rate (%)
- Revenue per cohort & month
All heavy calculations are handled in SQL to keep Power BI simple and performant.

---

## 📈 Phase 2: Power BI Dashboard
- Cohort Retention Matrix
- Revenue Cohort Matrix

---

## 📬 Contact

If you’d like to discuss this project or collaborate:

[LinkedIn](https://www.linkedin.com/in/mostafa-yaazdani/)
