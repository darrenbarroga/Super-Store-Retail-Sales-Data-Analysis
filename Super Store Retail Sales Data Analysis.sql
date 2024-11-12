## Data Checking
## Table Structure Check
DESCRIBE salesdata;

## Data Preview
SELECT * FROM salesdata LIMIT 10;

## Row Count
SELECT COUNT(*) FROM salesdata;

## Data Cleaning
## Check for Null values
SELECT 
    SUM(CASE WHEN Ship_Mode IS NULL THEN 1 ELSE 0 END) AS Ship_Mode_Null,
    SUM(CASE WHEN Segment IS NULL THEN 1 ELSE 0 END) AS Segment_Null,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Country_Null,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS City_Null,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null,
    SUM(CASE WHEN Postal_Code IS NULL THEN 1 ELSE 0 END) AS Postal_Code_Null,
    SUM(CASE WHEN Region IS NULL THEN 1 ELSE 0 END) AS Region_Null,
    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS Category_Null,
    SUM(CASE WHEN Sub_Category IS NULL THEN 1 ELSE 0 END) AS Sub_Category_Null,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Sales_Null,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Quantity_Null,
    SUM(CASE WHEN Discount IS NULL THEN 1 ELSE 0 END) AS Discount_Null,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS Profit_Null
FROM salesdata;

## Removing Duplicates
DELETE FROM salesdata
WHERE (Ship_Mode, Segment, Country, City, State, Postal_Code, Region, Category, Sub_Category, Sales, Quantity, Discount, Profit) 
IN (SELECT Ship_Mode, Segment, Country, City, State, Postal_Code, Region, Category, Sub_Category, Sales, Quantity, Discount, Profit
FROM (
SELECT Ship_Mode, Segment, Country, City, State, Postal_Code, Region, Category, Sub_Category, Sales, Quantity, Discount, Profit,
ROW_NUMBER() OVER (PARTITION BY Ship_Mode, Segment, Country, City, State, Postal_Code, Region, Category, Sub_Category, Sales, Quantity, Discount, Profit 
ORDER BY (SELECT NULL)) AS row_num
FROM salesdata
) t
WHERE t.row_num > 1);

## Processing Null values
DELETE FROM salesdata WHERE 
    Ship_Mode IS NULL OR
    Segment IS NULL OR
    Country IS NULL OR
    City IS NULL OR
    State IS NULL OR
    Postal_Code IS NULL OR
    Region IS NULL OR
    Category IS NULL OR
    Sub_Category IS NULL OR
    Sales IS NULL OR
    Quantity IS NULL OR
    Discount IS NULL OR
    Profit IS NULL;

## Replacing Null values
UPDATE salesdata
SET Ship_Mode = COALESCE(Ship_Mode, 'Unknown'),
    Segment = COALESCE(Segment, 'Unknown'),
    Country = COALESCE(Country, 'Unknown'),
    City = COALESCE(City, 'Unknown'),
    State = COALESCE(State, 'Unknown'),
    Postal_Code = COALESCE(Postal_Code, 0),
    Region = COALESCE(Region, 'Unknown'),
    Category = COALESCE(Category, 'Unknown'),
    Sub_Category = COALESCE(Sub_Category, 'Unknown'),
    Sales = COALESCE(Sales, 0),
    Quantity = COALESCE(Quantity, 0),
    Discount = COALESCE(Discount, 0),
    Profit = COALESCE(Profit, 0);

## Data Formatting
## Trimming
UPDATE salesdata
SET Ship_Mode = UPPER(TRIM(Ship_Mode)),
    Segment = UPPER(TRIM(Segment)),
    Country = UPPER(TRIM(Country)),
    City = UPPER(TRIM(City)),
    State = UPPER(TRIM(State)),
    Region = UPPER(TRIM(Region)),
    Category = UPPER(TRIM(Category)),
    Sub_Category = UPPER(TRIM(Sub_Category));

## Data Analysis
## Descriptive Statistics
SELECT 
    COUNT(*) AS Total_Records,
    AVG(Sales) AS Avg_Sales,
    AVG(Quantity) AS Avg_Quantity,
    AVG(Discount) AS Avg_Discount,
    AVG(Profit) AS Avg_Profit,
    SUM(Sales) AS Total_Sales,
    SUM(Quantity) AS Total_Quantity,
    SUM(Discount) AS Total_Discount,
    SUM(Profit) AS Total_Profit
FROM salesdata;

## Sales by Category and Sub-Category
SELECT Category, Sub_Category, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM salesdata
GROUP BY Category, Sub_Category
ORDER BY Total_Sales DESC;

## Sales by Region
SELECT Region, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM salesdata
GROUP BY Region
ORDER BY Total_Sales DESC;

## Top 12 Cities by Sales
SELECT City, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM salesdata
GROUP BY City
ORDER BY Total_Sales DESC
LIMIT 10;

## Sales by Ship Mode
SELECT Ship_Mode, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM salesdata
GROUP BY Ship_Mode
ORDER BY Total_Sales DESC;

## Advanced Statistics
## Discount on Profit
SELECT Discount, AVG(Profit) AS Avg_Profit, SUM(Profit) AS Total_Profit
FROM salesdata
GROUP BY Discount
ORDER BY Discount;

## Advanced Queries
## Customer Segmentation Analysis
SELECT Segment, COUNT(*) AS Customer_Count, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM salesdata
GROUP BY Segment
ORDER BY Total_Sales DESC;

## Top N Products by Sales
SELECT Sub_Category, SUM(Sales) AS Total_Sales
FROM salesdata
GROUP BY Sub_Category
ORDER BY Total_Sales DESC
LIMIT 5;

## Profit Margin Analysis
SELECT Category, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit, (SUM(Profit) / SUM(Sales)) * 100 AS Profit_Margin
FROM salesdata
GROUP BY Category
ORDER BY Profit_Margin DESC;

## Correlation Between Discount and Sales
SELECT Discount, SUM(Sales) AS Total_Sales, AVG(Sales) AS Avg_Sales, COUNT(*) AS Transaction_Count
FROM salesdata
GROUP BY Discount
ORDER BY Discount;

## Sales Contribution by Region and Category
SELECT Region, Category, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM salesdata
GROUP BY Region, Category
ORDER BY Region, Total_Sales DESC;

## State-level Analysis
SELECT State, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM salesdata
GROUP BY State
ORDER BY Total_Sales DESC;

## Advanced Conceppts
## Window Function
SELECT Category, Sub_Category, Sales, SUM(Sales) OVER (PARTITION BY Category ORDER BY Sales) AS Cumulative_Sales
FROM salesdata;

## Subqueries and Common Table Expressions (CTEs)
WITH sales_by_category AS (
    SELECT Category, SUM(Sales) AS Total_Sales
    FROM salesdata
    GROUP BY Category
)
SELECT Category, Total_Sales, Total_Sales / (SELECT SUM(Total_Sales) FROM sales_by_category) * 100 AS Sales_Percentage
FROM sales_by_category;

## Pivoting Data
SELECT 
	Segment,
    SUM(CASE WHEN Category = 'Technology' THEN Sales ELSE 0 END) AS Technology_Sales,
	SUM(CASE WHEN Category = 'Furniture' THEN Sales ELSE 0 END) AS Furniture_Sales, 
    SUM(CASE WHEN Category = 'Office Supplies' THEN Sales ELSE 0 END) AS Office_Supplies_Sales
FROM salesdata
GROUP BY Segment;
