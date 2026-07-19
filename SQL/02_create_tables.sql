/*
====================================================
SMART RETAIL ANALYTICS & DECISION SUPPORT SYSTEM
Create Tables Script
====================================================
*/

-- Create Database
CREATE DATABASE SmartRetailAnalytics;

-- Use Database
USE SmartRetailAnalytics;

----------------------------------------------------
-- Customers Table
----------------------------------------------------

CREATE TABLE Customers (
    CustomerID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    City VARCHAR(50),
    State VARCHAR(50),
    Segment VARCHAR(50)
);

----------------------------------------------------
-- Products Table
----------------------------------------------------

CREATE TABLE Products (
    ProductID VARCHAR(20) PRIMARY KEY,
    ProductName VARCHAR(150) NOT NULL,
    Category VARCHAR(100),
    CostPrice DECIMAL(10,2)
);

----------------------------------------------------
-- Orders Table
----------------------------------------------------

CREATE TABLE Orders (
    OrderID VARCHAR(20) PRIMARY KEY,
    CustomerID VARCHAR(20) NOT NULL,
    ProductID VARCHAR(20) NOT NULL,
    OrderDate DATE,
    Quantity INT NOT NULL,
    Sales DECIMAL(12,2),
    Profit DECIMAL(12,2),

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT FK_Orders_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);

----------------------------------------------------
-- Inventory Table
----------------------------------------------------

CREATE TABLE Inventory (
    ProductID VARCHAR(20) PRIMARY KEY,
    CurrentStock INT,

    CONSTRAINT FK_Inventory_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);

----------------------------------------------------
-- Sales Targets Table
----------------------------------------------------

CREATE TABLE SalesTargets (
    Month VARCHAR(20),
    TargetSales DECIMAL(12,2)
);

----------------------------------------------------
-- Verify Tables
----------------------------------------------------

SHOW TABLES;

DESC Customers;
DESC Products;
DESC Orders;
DESC Inventory;
DESC SalesTargets;
