
# 📊 Walmart Sales Data Analysis Using SQL

## 🧠 Project Goal

To analyze Walmart sales data using SQL to uncover insights about product performance, customer behavior, revenue trends, and branch-specific patterns. The goal is to practice SQL querying skills and derive meaningful business insights from transactional data.

---

## 🛠️ Tools Used

* **SQL**: MySQL
* **Dataset**: Walmart Sales Data (Structured in a relational database with a `sales` table)

---

## 🔍 Key Tasks Performed

### ✅ Data Preparation & Feature Engineering

* Created the `walmartSales` database and `sales` table with relevant columns.
* Engineered new features:

  * `time_of_day`: Categorized time into **Morning**, **Afternoon**, **Evening**.
  * `day_name`: Extracted day of the week from `date`.
  * `month_name`: Extracted month name from `date`.

### 🧾 General Overview Queries

* Identified unique cities and mapped branch locations.
* Counted unique product lines and payment methods.

### 📦 Product-Level Analysis

* Most selling product lines.
* Highest revenue-generating product lines.
* Product lines with the highest VAT.
* Average rating per product line.
* Categorized product lines as “Good” or “Bad” based on average sales.

### 🌆 City and Branch Analysis

* City with the highest revenue.
* Branches that sold more than the average.
* Gender distribution across branches.
* Which branch had the best average ratings on each day of the week.

### 📅 Time-Based Analysis

* Sales volume during different times of the day.
* Revenue and COGS by month.
* Day of the week with best average ratings.
* Time of day with highest average customer ratings.

### 👥 Customer Insights

* Most frequent customer types.
* Customer type generating the most revenue.
* Gender distribution and preferences.
* Customer type paying the most VAT.

---

## 📌 Key Findings

* **City Insights**: The city generating the highest revenue and paying the highest average VAT was identified.
* **Product Performance**: Certain product lines were labeled "Good" for being above average in sales quantity.
* **Customer Behavior**:

  * **Member customers** contributed more to total revenue.
  * **Male customers** were slightly more in number, and certain gender-product combinations were more dominant.
* **Time Trends**:

  * Sales were highest in the **Evening**.
  * Ratings were best on a specific **day of the week** and during **Afternoon**.
* **Branch Insights**:

  * Branch-specific top-performing days were identified based on average customer ratings.

---

## 📈 Impact

This analysis demonstrates how SQL can be used to:

* Perform descriptive analytics on structured retail data.
* Generate actionable insights for marketing, operations, and sales strategy.
* Segment customers and optimize offerings based on time, location, and behavior.

