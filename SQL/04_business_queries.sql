/*
=====================================================================
SMART RETAIL ANALYTICS & DECISION SUPPORT SYSTEM
Business Analysis Queries

Author : Vivek Rajeev

Description:
This file contains SQL queries used for business analysis,
executive reporting and dashboard development.

=====================================================================
*/

USE SmartRetailAnalytics;

-- ==========================================================
-- SECTION 1 : EXECUTIVE DASHBOARD
-- ==========================================================

-- 1 Total Sales

SELECT
ROUND(SUM(Sales),2) AS TotalSales
FROM Orders;

-------------------------------------------------------------

-- 2 Total Profit

SELECT
ROUND(SUM(Profit),2) AS TotalProfit
FROM Orders;

-------------------------------------------------------------

-- 3 Total Orders

SELECT
COUNT(OrderID) AS TotalOrders
FROM Orders;

-------------------------------------------------------------

-- 4 Total Customers

SELECT
COUNT(CustomerID) AS TotalCustomers
FROM Customers;

-------------------------------------------------------------

-- 5 Average Order Value

SELECT
ROUND(AVG(Sales),2) AS AverageOrderValue
FROM Orders;

-------------------------------------------------------------

-- 6 Profit Margin

SELECT
ROUND(
SUM(Profit)/SUM(Sales)*100,
2
) AS ProfitMargin
FROM Orders;

-------------------------------------------------------------

-- ==========================================================
-- SECTION 2 : CUSTOMER ANALYTICS
-- ==========================================================

-- 7 Top 10 Customers

SELECT
c.CustomerID,
c.Name,
SUM(o.Sales) AS TotalSales
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID
GROUP BY
c.CustomerID,
c.Name
ORDER BY TotalSales DESC
LIMIT 10;

-------------------------------------------------------------

-- 8 Customer Segment Distribution

SELECT
Segment,
COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Segment
ORDER BY TotalCustomers DESC;

-------------------------------------------------------------

-- 9 Sales by Segment

SELECT
c.Segment,
SUM(o.Sales) AS Sales
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID
GROUP BY c.Segment
ORDER BY Sales DESC;

-------------------------------------------------------------

-- 10 Profit by Segment

SELECT
c.Segment,
SUM(o.Profit) AS Profit
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID
GROUP BY c.Segment
ORDER BY Profit DESC;

-------------------------------------------------------------

-- 11 Top Cities by Sales

SELECT
c.City,
SUM(o.Sales) AS Sales
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID
GROUP BY c.City
ORDER BY Sales DESC
LIMIT 10;

-------------------------------------------------------------

-- 12 State Wise Sales

SELECT
c.State,
SUM(o.Sales) AS Sales
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID
GROUP BY c.State
ORDER BY Sales DESC;

-------------------------------------------------------------

-- ==========================================================
-- SECTION 3 : PRODUCT ANALYTICS
-- ==========================================================

-- 13 Best Selling Products

SELECT
p.ProductName,
SUM(o.Quantity) AS QuantitySold
FROM Products p
JOIN Orders o
ON p.ProductID=o.ProductID
GROUP BY p.ProductName
ORDER BY QuantitySold DESC
LIMIT 10;

-------------------------------------------------------------

-- 14 Highest Revenue Products

SELECT
p.ProductName,
SUM(o.Sales) AS Revenue
FROM Products p
JOIN Orders o
ON p.ProductID=o.ProductID
GROUP BY p.ProductName
ORDER BY Revenue DESC
LIMIT 10;

-------------------------------------------------------------

-- 15 Most Profitable Products

SELECT
p.ProductName,
SUM(o.Profit) AS Profit
FROM Products p
JOIN Orders o
ON p.ProductID=o.ProductID
GROUP BY p.ProductName
ORDER BY Profit DESC
LIMIT 10;

-------------------------------------------------------------

-- 16 Category Wise Sales

SELECT
p.Category,
SUM(o.Sales) AS Sales
FROM Products p
JOIN Orders o
ON p.ProductID=o.ProductID
GROUP BY p.Category
ORDER BY Sales DESC;

-------------------------------------------------------------

-- 17 Category Wise Profit

SELECT
p.Category,
SUM(o.Profit) AS Profit
FROM Products p
JOIN Orders o
ON p.ProductID=o.ProductID
GROUP BY p.Category
ORDER BY Profit DESC;

-------------------------------------------------------------

-- ==========================================================
-- SECTION 4 : SALES ANALYTICS
-- ==========================================================

-- 18 Monthly Sales

SELECT
YEAR(Date) AS Year,
MONTH(Date) AS Month,
SUM(Sales) AS Sales
FROM Orders
GROUP BY
YEAR(Date),
MONTH(Date)
ORDER BY
Year,
Month;

-------------------------------------------------------------

-- 19 Monthly Profit

SELECT
YEAR(Date) AS Year,
MONTH(Date) AS Month,
SUM(Profit) AS Profit
FROM Orders
GROUP BY
YEAR(Date),
MONTH(Date)
ORDER BY
Year,
Month;

-------------------------------------------------------------

-- 20 Average Quantity Sold

SELECT
ROUND(AVG(Quantity),2) AS AvgQuantity
FROM Orders;

-------------------------------------------------------------

-- ==========================================================
-- SECTION 5 : INVENTORY ANALYTICS
-- ==========================================================

-- 21 Products To Reorder

SELECT
ProductID,
CurrentStock,
ReorderLevel
FROM Inventory
WHERE CurrentStock < ReorderLevel;

-------------------------------------------------------------

-- 22 Inventory Status

SELECT
ReorderStatus,
COUNT(*) AS Products
FROM Inventory
GROUP BY ReorderStatus;

-------------------------------------------------------------

-- 23 Current Inventory Value

SELECT
SUM(i.CurrentStock*p.CostPrice)
AS InventoryValue
FROM Inventory i
JOIN Products p
ON i.ProductID=p.ProductID;

-------------------------------------------------------------

-- ==========================================================
-- SECTION 6 : ADVANCED BUSINESS INSIGHTS
-- ==========================================================

-- 24 Top 5 Products by Profit

SELECT
p.ProductName,
SUM(o.Profit) AS Profit
FROM Products p
JOIN Orders o
ON p.ProductID=o.ProductID
GROUP BY p.ProductName
ORDER BY Profit DESC
LIMIT 5;

-------------------------------------------------------------

-- 25 Top 5 Customers by Profit

SELECT
c.Name,
SUM(o.Profit) AS Profit
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID
GROUP BY c.Name
ORDER BY Profit DESC
LIMIT 5;

-------------------------------------------------------------

-- 26 Highest Revenue Category

SELECT
Category,
SUM(Sales) AS Revenue
FROM Products p
JOIN Orders o
ON p.ProductID=o.ProductID
GROUP BY Category
ORDER BY Revenue DESC
LIMIT 1;

-------------------------------------------------------------

-- 27 Sales Per Customer

SELECT
ROUND(
SUM(Sales)/COUNT(DISTINCT CustomerID),
2
) AS SalesPerCustomer
FROM Orders;

-------------------------------------------------------------

-- 28 Average Profit Per Order

SELECT
ROUND(AVG(Profit),2)
AS AverageProfit
FROM Orders;

-------------------------------------------------------------

-- 29 Products Never Sold

SELECT
ProductID,
ProductName
FROM Products
WHERE ProductID
NOT IN
(
SELECT DISTINCT ProductID
FROM Orders
);

-------------------------------------------------------------

-- 30 Top Revenue States

SELECT
c.State,
SUM(o.Sales) AS Revenue
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID
GROUP BY c.State
ORDER BY Revenue DESC;
