/*
==================================================================
SMART RETAIL ANALYTICS & DECISION SUPPORT SYSTEM

SQL Interview Queries

Author : Vivek Rajeev

Description:
This file contains advanced SQL interview questions and solutions
using the Smart Retail Analytics database.

==================================================================
*/

USE SmartRetailAnalytics;

-- ==========================================================
-- BASIC SQL
-- ==========================================================

-- 1. Display all customers

SELECT *
FROM Customers;

-------------------------------------------------------------

-- 2. Display all products

SELECT *
FROM Products;

-------------------------------------------------------------

-- 3. Display orders with Sales greater than 50000

SELECT *
FROM Orders
WHERE Sales > 50000;

-------------------------------------------------------------

-- 4. Display Electronics products

SELECT *
FROM Products
WHERE Category='Electronics';

-------------------------------------------------------------

-- ==========================================================
-- AGGREGATE FUNCTIONS
-- ==========================================================

-- 5. Maximum Sale

SELECT MAX(Sales)
AS HighestSale
FROM Orders;

-------------------------------------------------------------

-- 6. Minimum Profit

SELECT MIN(Profit)
AS LowestProfit
FROM Orders;

-------------------------------------------------------------

-- 7. Average Sales

SELECT AVG(Sales)
AS AverageSales
FROM Orders;

-------------------------------------------------------------

-- 8. Total Quantity Sold

SELECT SUM(Quantity)
AS TotalQuantity
FROM Orders;

-------------------------------------------------------------

-- ==========================================================
-- GROUP BY
-- ==========================================================

-- 9. Orders by Category

SELECT
p.Category,
COUNT(*) AS Orders
FROM Orders o
JOIN Products p
ON o.ProductID=p.ProductID
GROUP BY p.Category;

-------------------------------------------------------------

-- 10. Profit by State

SELECT
c.State,
SUM(o.Profit)
AS TotalProfit
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID
GROUP BY c.State;

-------------------------------------------------------------

-- ==========================================================
-- HAVING
-- ==========================================================

-- 11. Categories with Sales above 1 Million

SELECT
p.Category,
SUM(o.Sales)
AS TotalSales
FROM Products p
JOIN Orders o
ON p.ProductID=o.ProductID
GROUP BY p.Category
HAVING SUM(o.Sales)>1000000;

-------------------------------------------------------------

-- ==========================================================
-- JOINS
-- ==========================================================

-- 12. INNER JOIN

SELECT
o.OrderID,
c.Name,
p.ProductName,
o.Sales
FROM Orders o
JOIN Customers c
ON o.CustomerID=c.CustomerID
JOIN Products p
ON o.ProductID=p.ProductID;

-------------------------------------------------------------

-- 13. LEFT JOIN

SELECT
c.CustomerID,
c.Name,
o.OrderID
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID=o.CustomerID;

-------------------------------------------------------------

-- ==========================================================
-- SUBQUERY
-- ==========================================================

-- 14. Products above Average Cost Price

SELECT
ProductName,
CostPrice
FROM Products
WHERE CostPrice >
(
SELECT AVG(CostPrice)
FROM Products
);

-------------------------------------------------------------

-- ==========================================================
-- CASE
-- ==========================================================

-- 15. Sales Category

SELECT
OrderID,
Sales,

CASE

WHEN Sales>=50000
THEN 'High'

WHEN Sales>=20000
THEN 'Medium'

ELSE 'Low'

END AS SalesCategory

FROM Orders;

-------------------------------------------------------------

-- ==========================================================
-- WINDOW FUNCTIONS
-- ==========================================================

-- 16. ROW_NUMBER

SELECT
OrderID,
Sales,

ROW_NUMBER()
OVER
(
ORDER BY Sales DESC
)
AS RowNum

FROM Orders;

-------------------------------------------------------------

-- 17. RANK

SELECT
OrderID,
Sales,

RANK()
OVER
(
ORDER BY Sales DESC
)
AS SalesRank

FROM Orders;

-------------------------------------------------------------

-- 18. DENSE_RANK

SELECT
OrderID,
Sales,

DENSE_RANK()
OVER
(
ORDER BY Sales DESC
)
AS DenseRank

FROM Orders;

-------------------------------------------------------------

-- ==========================================================
-- CTE
-- ==========================================================

-- 19. Top Customers using CTE

WITH CustomerSales AS
(
SELECT
CustomerID,
SUM(Sales)
AS TotalSales

FROM Orders

GROUP BY CustomerID
)

SELECT *
FROM CustomerSales
ORDER BY TotalSales DESC
LIMIT 10;

-------------------------------------------------------------

-- ==========================================================
-- EXISTS
-- ==========================================================

-- 20. Customers who placed Orders

SELECT
CustomerID,
Name
FROM Customers c

WHERE EXISTS
(
SELECT 1
FROM Orders o
WHERE o.CustomerID=c.CustomerID
);

-------------------------------------------------------------

-- ==========================================================
-- NOT EXISTS
-- ==========================================================

-- 21. Customers with No Orders

SELECT
CustomerID,
Name
FROM Customers c

WHERE NOT EXISTS
(
SELECT 1
FROM Orders o
WHERE o.CustomerID=c.CustomerID
);

-------------------------------------------------------------

-- ==========================================================
-- INVENTORY
-- ==========================================================

-- 22. Products Needing Reorder

SELECT *
FROM Inventory
WHERE CurrentStock < ReorderLevel;

-------------------------------------------------------------

-- ==========================================================
-- TOP PRODUCT
-- ==========================================================

-- 23. Highest Revenue Product

SELECT
p.ProductName,
SUM(o.Sales)
AS Revenue

FROM Products p
JOIN Orders o

ON p.ProductID=o.ProductID

GROUP BY p.ProductName

ORDER BY Revenue DESC

LIMIT 1;

-------------------------------------------------------------

-- ==========================================================
-- TOP CUSTOMER
-- ==========================================================

-- 24. Highest Spending Customer

SELECT
c.Name,
SUM(o.Sales)
AS Revenue

FROM Customers c
JOIN Orders o

ON c.CustomerID=o.CustomerID

GROUP BY c.Name

ORDER BY Revenue DESC

LIMIT 1;

-------------------------------------------------------------

-- ==========================================================
-- DATE FUNCTIONS
-- ==========================================================

-- 25. Year Wise Sales

SELECT

YEAR(Date) AS Year,

SUM(Sales)
AS Sales

FROM Orders

GROUP BY YEAR(Date)

ORDER BY Year;

-------------------------------------------------------------

-- End of File
