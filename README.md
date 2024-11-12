# Super-Store-Retail-Sales-Data-Analysis

# Comprehensive SQL Data Analysis Project

This repository contains a comprehensive SQL data analysis project focused on sales data. The project includes data setup, data cleaning, and advanced SQL queries to derive insights from the dataset. The aim is to perform a thorough analysis that covers customer segmentation, sales trends, profit margin analysis, and more. The project also demonstrates best practices in SQL querying and data analysis techniques.

## Table of Contents
- [Dataset](#dataset)
- [Installation](#installation)
  - [MySQL Setup](#mysql-setup)
  - [Python Setup](#python-setup)
- [Data Cleaning](#data-cleaning)
- [Data Analysis](#data-analysis)
  - [Basic Queries](#basic-queries)
  - [Advanced Queries](#advanced-queries)
  - [Visualization and Reporting](#visualization-and-reporting)
- [Contributing](#contributing)
- [Conclusion of Data Analysis](#conclusion-of-data-analysis)
- [Recommendations](#recommendations)
- [Acknowledgements](#acknowledgements)

## Dataset
The dataset used in this project includes the following columns:
- Ship_Mode (text)
- Segment (text)
- Country (text)
- City (text)
- State (text)
- Postal_Code (int)
- Region (text)
- Category (text)
- Sub_Category (text)
- Sales (double)
- Quantity (int)
- Discount (double)
- Profit (double)

## Installation
To replicate this analysis, you need the following software installed on your machine:
- MySQL Workbench
- MySQL Server
- Python (optional, for data cleaning and preprocessing)
- Excel (optional, for initial data cleaning)

### MySQL Setup
1. Install MySQL Server and MySQL Workbench.
2. Create a new database in MySQL Workbench.
3. Import the cleaned CSV file into the database using the MySQL Workbench Import Wizard.

### Python Setup (Optional)
If you want to perform data cleaning using Python, install the necessary libraries:
```sh pip install pandas```

## Data Cleaning
To clean the data, perform the following queries:

1. **Remove Duplicates:**
    ```sql
    DELETE FROM salesdata
    WHERE id NOT IN (
        SELECT MIN(id) 
        FROM salesdata 
        GROUP BY Ship_Mode, Segment, Country, City, State, Postal_Code, Region, Category, Sub_Category, Sales, Quantity, Discount, Profit
    );
    ```

2. **Handle Null Values:**
    ```sql
    UPDATE salesdata
    SET Postal_Code = 0
    WHERE Postal_Code IS NULL;
    ```

## Data Analysis

### Basic Queries

1. **Check Data:**
    ```sql
    SELECT * FROM salesdata LIMIT 10;
    ```

2. **Summary Statistics:**
    ```sql
    SELECT 
        COUNT(*) AS Total_Records, 
        AVG(Sales) AS Avg_Sales, 
        AVG(Profit) AS Avg_Profit
    FROM salesdata;
    ```

3. **Remove Duplicates:**
    ```sql
    DELETE FROM salesdata
    WHERE id NOT IN (
        SELECT MIN(id) 
        FROM salesdata 
        GROUP BY Ship_Mode, Segment, Country, City, State, Postal_Code, Region, Category, Sub_Category, Sales, Quantity, Discount, Profit
    );
    ```

4. **Handle Null Values:**
    ```sql
    UPDATE salesdata
    SET Postal_Code = 0
    WHERE Postal_Code IS NULL;
    ```

### Advanced Queries

1. **Customer Segmentation Analysis:**
    ```sql
    SELECT 
        Segment, 
        COUNT(*) AS Customer_Count, 
        SUM(Sales) AS Total_Sales, 
        SUM(Profit) AS Total_Profit
    FROM salesdata
    GROUP BY Segment
    ORDER BY Total_Sales DESC;
    ```

2. **Top N Products by Sales:**
    ```sql
    SELECT 
        Sub_Category, 
        SUM(Sales) AS Total_Sales
    FROM salesdata
    GROUP BY Sub_Category
    ORDER BY Total_Sales DESC
    LIMIT 5;
    ```

3. **Profit Margin Analysis:**
    ```sql
    SELECT 
        Category, 
        SUM(Sales) AS Total_Sales, 
        SUM(Profit) AS Total_Profit, 
        (SUM(Profit) / SUM(Sales)) * 100 AS Profit_Margin
    FROM salesdata
    GROUP BY Category
    ORDER BY Profit_Margin DESC;
    ```

4. **Correlation Between Discount and Sales:**
    ```sql
    SELECT 
        Discount, 
        SUM(Sales) AS Total_Sales, 
        AVG(Sales) AS Avg_Sales, 
        COUNT(*) AS Transaction_Count
    FROM salesdata
    GROUP BY Discount
    ORDER BY Discount;
    ```

5. **Sales Contribution by Region and Category:**
    ```sql
    SELECT 
        Region, 
        Category, 
        SUM(Sales) AS Total_Sales, 
        SUM(Profit) AS Total_Profit
    FROM salesdata
    GROUP BY Region, Category
    ORDER BY Region, Total_Sales DESC;
    ```

6. **State-Level Analysis:**
    ```sql
    SELECT 
        State, 
        SUM(Sales) AS Total_Sales, 
        SUM(Profit) AS Total_Profit
    FROM salesdata
    GROUP BY State
    ORDER BY Total_Sales DESC;
    ```

### Visualization and Reporting

After running these queries, you can use visualization tools like Power BI, Tableau, or even Excel to create insightful dashboards. Here are some visualization ideas:

- **Bar Charts**: Sales by Category, Sales by Region
- **Line Charts**: Sales Trends Over Time
- **Pie Charts**: Sales Contribution by Segment
- **Heatmaps**: Sales Correlation Between Discount and Profit
- **Geographical Maps**: Sales Distribution by State

## Contributing
Contributions are welcome! Please fork this repository and submit a pull request for any improvements or additional features.

## Conclusion of Data Analysis

In conclusion, the SQL data analysis conducted on the sales data has provided several valuable insights into various aspects of the business. The data analysis process involved thorough data cleaning, including the removal of duplicates and handling of null values, ensuring the integrity and accuracy of the dataset. The following key findings were derived from the analysis:

1. **Customer Segmentation:**
   - The segmentation analysis revealed that the 'Consumer' segment generated the highest total sales and profit, indicating that individual consumers are a significant market segment. However, the 'Corporate' segment also showed substantial contributions, suggesting potential areas for targeted marketing strategies.

3. **Product Performance:**
   - Analysis of the top products by sales highlighted the best-performing sub-categories, such as 'Phones' and 'Chairs.' This information is crucial for inventory management and focusing promotional efforts on high-demand products.
   - The correlation between discounts and sales indicated that while discounts drive higher sales volumes, the impact on overall profit must be carefully managed to avoid eroding profit margins.

4. **Geographical Insights:**
   - The geographical analysis showed that regions like 'West' and 'East' had higher sales and profit contributions, which can inform regional marketing campaigns and distribution strategies.
   - State-level analysis identified key states with the highest sales, allowing for more localized and targeted business strategies.

5. **Operational Metrics:**
   - Operational metrics such as average sales and transaction counts provided a benchmark for evaluating performance and identifying areas for improvement.

### Recommendations:
Based on the insights obtained from the analysis, the following recommendations can be made:
1. **Targeted Marketing:**
   - Develop targeted marketing campaigns for the 'Consumer' and 'Corporate' segments to capitalize on their significant contributions to sales and profit.
   - Focus promotional efforts on high-demand sub-categories identified in the top product analysis.

2. **Pricing and Discount Strategies:**
   - Implement dynamic pricing strategies for high-margin product categories to enhance profitability.
   - Carefully manage discount offerings to balance between increasing sales volumes and maintaining healthy profit margins.

3. **Regional Focus:**
   - Invest in marketing and distribution channels in regions and states with higher sales and profit contributions to strengthen market presence and customer engagement.

4. **Inventory Management:**
   - Optimize inventory levels based on the sales trends and product performance analysis to reduce holding costs and improve turnover rates.

5. **Future Analysis:**
   - Conduct further analysis on customer behavior and preferences to refine marketing strategies and improve customer satisfaction.

Overall, the comprehensive SQL data analysis has provided actionable insights that can significantly enhance business decision-making and strategic planning.

## Acknowledgments
1. Kaggle for providing the Superstore Sales Data Analysis.
2. The open-source community for tools and resources.
3. MySQL for database management.
