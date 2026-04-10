
??? Customer Behavior Analysis Dashboard
This project delivers an end-to-end data analytics solution to understand customer shopping behavior using Python, SQL, and Power BI. It covers data cleaning, KPI generation, and interactive dashboard visualization.

?? Project Overview
The goal of this project is to analyze customer purchasing patterns and generate actionable insights such as:
* Customer segmentation 
* Revenue trends 
* Product performance 
* Subscription impact on spending 
The final output is a Power BI dashboard that enables dynamic exploration of these insights.

??? Dashboard Preview


?? Folder Structure
* 01.Data/ 
o customer_shopping_behavior.csv ? Raw dataset 
o customer_shopping_behavior_clean.csv ? Cleaned dataset (generated using Python) 
* 02.Python/ 
o Jupyter Notebook (.ipynb) 
o Performs data cleaning, transformation, and feature engineering using Pandas 
* 03.SQL/ 
o SQL scripts to calculate KPIs and perform analytical queries 
* 04.Power BI/ 
o Power BI dashboard file (.pbix) 
o Contains interactive visualizations and insights 

?? Data Pipeline Workflow
1?? Data Cleaning (Python - Pandas)
* Handled missing values (e.g., review ratings filled using median by category) 
* Standardized column names 
* Feature engineering: 
o age_group segmentation 
o purchase_frequency_days mapping 
* Removed redundant columns 
* Exported cleaned dataset 

2?? Data Analysis (SQL)
Key business questions answered:
* Revenue comparison by gender 
* Impact of discounts on high-value purchases 
* Top-performing products by rating 
* Subscription vs non-subscription spending behavior 
* Customer segmentation (New, Returning, Loyal) 
* Discount usage trends 
* Revenue contribution by age group 
* Seasonal and category-wise purchase behavior 

3?? Data Visualization (Power BI)
The dashboard provides:
* KPIs 
o Total Customers: 3.9K 
o Average Purchase Amount: $59.76 
o Average Review Rating: 3.75 
* Interactive Filters 
o Subscription Status 
o Gender 
o Category 
o Shipping Type 
* Key Visuals 
o Subscription distribution 
o Revenue by category 
o Sales by category 
o Revenue by age group 

?? Key Insights
* Non-subscribed customers form the majority (~73%) 
* Clothing category generates the highest revenue 
* Adult and middle-aged groups contribute the most revenue 
* Discounts significantly influence purchase behavior 
* Loyal customers drive higher total revenue 

?? How to Run
1. Run the Python notebook to clean the raw dataset 
2. Execute SQL scripts on the cleaned data to generate KPIs 
3. Open the Power BI dashboard to explore insights 

??? Tech Stack
* Python (Pandas) – Data cleaning & preprocessing 
* SQL – Data analysis & KPI generation 
* Power BI – Data visualization & dashboarding 
* Databricks – Data processing environment 

?? Future Improvements
* Add predictive analytics (customer churn, purchase prediction) 
* Automate pipeline using scheduling tools 
* Integrate real-time data sources 

? Why This Project Stands Out
* Complete end-to-end pipeline 
* Strong use of feature engineering 
* Business-focused SQL insights 
* Clean and interactive dashboard design 

