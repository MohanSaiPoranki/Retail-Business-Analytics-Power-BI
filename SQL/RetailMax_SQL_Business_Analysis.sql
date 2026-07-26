/*
===========================================================
RetailMax Business Intelligence & Profit Optimization Platform
SQL Business Analysis
100 Business-Oriented SQL Queries for Retail Analytics
Author: Mohan Sai Poranki
===========================================================
*/

CREATE DATABASE RetailDW;
USE RetailDW;

CREATE TABLE DimCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

CREATE TABLE DimRegion (
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(100),
    Zone VARCHAR(50)
);

CREATE TABLE DimPromotion (
    PromotionID INT PRIMARY KEY,
    CampaignName VARCHAR(150),
    DiscountPercent DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE,
    PromotionType VARCHAR(50)
);

CREATE TABLE DimSupplier_Enterprise (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(150),
    City VARCHAR(100),
    State VARCHAR(100),
    Rating DECIMAL(3,1),
    LeadTimeDays INT
);

CREATE TABLE DimEmployee_Enterprise (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(150),
    Department VARCHAR(100),
    Designation VARCHAR(100),
    HireDate DATE,
    Salary DECIMAL(12,2),
    StoreID INT,
    Status VARCHAR(30)
);

CREATE TABLE DimStore_Enterprise (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(150),
    RegionID INT,
    StoreType VARCHAR(50),
    OpenDate DATE,
    ManagerID INT
);

CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    Day INT,
    Month INT,
    MonthName VARCHAR(20),
    Quarter INT,
    Year INT,
    Week INT,
    DayName VARCHAR(20),
    IsWeekend VARCHAR(5)
);

CREATE TABLE DimCustomer_Enterprise (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(150),
    Gender VARCHAR(20),
    Age INT,
    City VARCHAR(100),
    State VARCHAR(100),
    RegionID INT,
    CustomerSegment VARCHAR(50),
    JoinDate DATE,
    Email VARCHAR(150),
    Phone VARCHAR(20),
    Status VARCHAR(20)
);

CREATE TABLE DimProduct_Enterprise (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(200),
    CategoryID INT,
    SupplierID INT,
    Brand VARCHAR(100),
    CostPrice DECIMAL(10,2),
    SellingPrice DECIMAL(10,2),
    LaunchDate DATE,
    Rating DECIMAL(3,1),
    Status VARCHAR(20)
);

CREATE TABLE FactOrders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    StoreID INT,
    PromotionID INT,
    OrderDateKey INT,
    OrderChannel VARCHAR(50),
    OrderStatus VARCHAR(50),
    TotalAmount DECIMAL(12,2)
);

CREATE TABLE FactOrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(5,2),
    Tax DECIMAL(10,2),
    LineTotal DECIMAL(12,2)
);

CREATE TABLE FactPayments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentMethod VARCHAR(50),
    PaymentStatus VARCHAR(50),
    PaymentDate DATE,
    PaidAmount DECIMAL(12,2)
);

CREATE TABLE FactReturns (
    ReturnID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    ReturnReason VARCHAR(200),
    ReturnDate DATE,
    RefundAmount DECIMAL(12,2)
);

CREATE TABLE FactInventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    StoreID INT,
    StockAvailable INT,
    ReorderLevel INT,
    LastRestocked DATE
);

CREATE TABLE FactShipments (
    ShipmentID INT PRIMARY KEY,
    OrderID INT,
    Courier VARCHAR(100),
    DispatchDate DATE,
    DeliveryDate DATE,
    DeliveryStatus VARCHAR(50)
);

CREATE TABLE FactMarketing (
    CampaignID INT PRIMARY KEY,
    PromotionID INT,
    Channel VARCHAR(50),
    Cost DECIMAL(12,2),
    Impressions INT,
    Clicks INT,
    Conversions INT
);

CREATE TABLE FactWebsiteTraffic (
    SessionID INT NULL,
    CustomerID INT,
    VisitDate DATE,
    Device VARCHAR(50),
    TrafficSource VARCHAR(100),
    SessionDuration_Min DECIMAL(8,2),
    PagesViewed INT,
    Purchased VARCHAR(5)
);
DROP TABLE FactWebsiteTraffic;
SELECT COUNT(*) FROM DimCategory;
SELECT COUNT(*) FROM DimRegion;
SELECT COUNT(*) FROM DimPromotion;
SELECT COUNT(*) FROM DimSupplier_Enterprise;
SELECT COUNT(*) FROM DimEmployee_Enterprise;
SELECT COUNT(*) FROM DimStore_Enterprise;
SELECT COUNT(*) FROM DimDate;
SELECT COUNT(*) FROM DimCustomer_Enterprise;
SELECT COUNT(*) FROM DimProduct_Enterprise;
SELECT COUNT(*) FROM FactOrders;
 SELECT COUNT(*) FROM FactOrderDetails;
SELECT COUNT(*) FROM FactPayments;
SELECT COUNT(*) FROM FactReturns;
SELECT COUNT(*) FROM FactInventory;
SELECT COUNT(*) FROM FactShipments;
SELECT COUNT(*) FROM FactMarketing;
SELECT COUNT(*) FROM FactWebsiteTraffic;

SELECT * FROM DimCategory WHERE CategoryID = 0;
INSERT INTO DimCustomer_Enterprise(CustomerID,CustomerName,CustomerSegment,Status)VALUES(0,'Unknown Customer','Unknown','Unknown');
SELECT * FROM DimCustomer_Enterprise WHERE CustomerID = 0;

ALTER TABLE DimCustomer_Enterprise
ADD CONSTRAINT FK_Customer_Region
FOREIGN KEY (RegionID)
REFERENCES DimRegion(RegionID);

SELECT DISTINCT c.RegionID
FROM DimCustomer_Enterprise c
LEFT JOIN DimRegion r
ON c.RegionID = r.RegionID
WHERE c.RegionID IS NOT NULL
  AND r.RegionID IS NULL;
  
SELECT *
FROM DimRegion
WHERE RegionID IN (29, 30);

SELECT MIN(RegionID) AS MinRegionID,
       MAX(RegionID) AS MaxRegionID,
       COUNT(*) AS TotalRegions
FROM DimRegion;

SELECT *
FROM DimRegion
ORDER BY RegionID;

SELECT RegionID, COUNT(*) AS Customers
FROM DimCustomer_Enterprise
WHERE RegionID IN (29, 30)
GROUP BY RegionID;

SELECT RegionID, RegionName
FROM DimRegion
ORDER BY RegionID;

UPDATE DimCustomer_Enterprise
SET RegionID = 28
WHERE RegionID = 29;

UPDATE DimCustomer_Enterprise
SET RegionID = 28
WHERE RegionID = 30;

SELECT DISTINCT RegionID
FROM DimCustomer_Enterprise
WHERE RegionID NOT IN (
    SELECT RegionID
    FROM DimRegion
);

ALTER TABLE DimCustomer_Enterprise
ADD CONSTRAINT FK_Customer_Region
FOREIGN KEY (RegionID)
REFERENCES DimRegion(RegionID);

SET SQL_SAFE_UPDATES = 0;

UPDATE DimCustomer_Enterprise
SET RegionID = 28
WHERE RegionID = 29;

UPDATE DimCustomer_Enterprise
SET RegionID = 28
WHERE RegionID = 30;

SELECT DISTINCT RegionID
FROM DimCustomer_Enterprise
WHERE RegionID NOT IN (
    SELECT RegionID
    FROM DimRegion);

UPDATE DimCustomer_Enterprise
SET RegionID = 28
WHERE RegionID = 29;

SELECT DISTINCT RegionID
FROM DimCustomer_Enterprise
WHERE RegionID NOT IN (
    SELECT RegionID
    FROM DimRegion
);

ALTER TABLE DimCustomer_Enterprise
ADD CONSTRAINT FK_Customer_Region
FOREIGN KEY (RegionID)
REFERENCES DimRegion(RegionID);

SELECT DISTINCT s.RegionID
FROM DimStore_Enterprise s
LEFT JOIN DimRegion r
ON s.RegionID = r.RegionID
WHERE s.RegionID IS NOT NULL
AND r.RegionID IS NULL;

SELECT DISTINCT e.StoreID
FROM DimEmployee_Enterprise e
LEFT JOIN DimStore_Enterprise s
ON e.StoreID = s.StoreID
WHERE e.StoreID IS NOT NULL
AND s.StoreID IS NULL;

SELECT DISTINCT p.CategoryID
FROM DimProduct_Enterprise p
LEFT JOIN DimCategory c
ON p.CategoryID = c.CategoryID
WHERE p.CategoryID IS NOT NULL
AND c.CategoryID IS NULL;

SELECT DISTINCT p.SupplierID
FROM DimProduct_Enterprise p
LEFT JOIN DimSupplier_Enterprise s
ON p.SupplierID = s.SupplierID
WHERE p.SupplierID IS NOT NULL
AND s.SupplierID IS NULL;

SELECT DISTINCT c.RegionID
FROM DimCustomer_Enterprise c
LEFT JOIN DimRegion r
ON c.RegionID = r.RegionID
WHERE c.RegionID IS NOT NULL
AND r.RegionID IS NULL;

SELECT DISTINCT o.CustomerID
FROM FactOrders o
LEFT JOIN DimCustomer_Enterprise c
ON o.CustomerID = c.CustomerID
WHERE o.CustomerID IS NOT NULL
AND c.CustomerID IS NULL;

SELECT DISTINCT o.EmployeeID
FROM FactOrders o
LEFT JOIN DimEmployee_Enterprise e
ON o.EmployeeID = e.EmployeeID
WHERE o.EmployeeID IS NOT NULL
AND e.EmployeeID IS NULL;

SELECT DISTINCT o.StoreID
FROM FactOrders o
LEFT JOIN DimStore_Enterprise s
ON o.StoreID = s.StoreID
WHERE o.StoreID IS NOT NULL
AND s.StoreID IS NULL;

SELECT DISTINCT od.OrderID
FROM FactOrderDetails od
LEFT JOIN FactOrders o
ON od.OrderID = o.OrderID
WHERE od.OrderID IS NOT NULL
AND o.OrderID IS NULL;

SELECT DISTINCT od.ProductID
FROM FactOrderDetails od
LEFT JOIN DimProduct_Enterprise p
ON od.ProductID = p.ProductID
WHERE od.ProductID IS NOT NULL
AND p.ProductID IS NULL;

SELECT DISTINCT i.ProductID
FROM FactInventory i
LEFT JOIN DimProduct_Enterprise p
ON i.ProductID = p.ProductID
WHERE i.ProductID IS NOT NULL
AND p.ProductID IS NULL;

SELECT DISTINCT i.StoreID
FROM FactInventory i
LEFT JOIN DimStore_Enterprise s
ON i.StoreID = s.StoreID
WHERE i.StoreID IS NOT NULL
AND s.StoreID IS NULL;

SELECT DISTINCT m.PromotionID
FROM FactMarketing m
LEFT JOIN DimPromotion p
ON m.PromotionID = p.PromotionID
WHERE m.PromotionID IS NOT NULL
AND p.PromotionID IS NULL;

SELECT DISTINCT r.OrderID
FROM FactReturns r
LEFT JOIN FactOrders o
ON r.OrderID = o.OrderID
WHERE r.OrderID IS NOT NULL
AND o.OrderID IS NULL;

SELECT DISTINCT s.OrderID
FROM FactShipments s
LEFT JOIN FactOrders o
ON s.OrderID = o.OrderID
WHERE s.OrderID IS NOT NULL
AND o.OrderID IS NULL;

SELECT DISTINCT w.CustomerID
FROM FactWebsiteTraffic w
LEFT JOIN DimCustomer_Enterprise 
ON w.CustomerID = c.CustomerID
WHERE w.CustomerID IS NOT NULL
AND c.CustomerID IS NULL;

SELECT RegionID, COUNT(*) AS Stores
FROM DimStore_Enterprise
WHERE RegionID IN (29,30,35)
GROUP BY RegionID;

SELECT *
FROM DimStore_Enterprise
WHERE StoreID = 99;

SELECT COUNT(*)
FROM DimEmployee_Enterprise
WHERE StoreID = 99;

SELECT *
FROM DimCustomer_Enterprise
WHERE CustomerID = 999999;

SELECT COUNT(*)
FROM FactOrders
WHERE CustomerID = 999999;

SELECT *
FROM FactOrders
WHERE OrderID = 999999;

SELECT COUNT(*)
FROM FactReturns
WHERE OrderID = 999999;

UPDATE DimStore_Enterprise
SET RegionID = 28
WHERE RegionID IN (29,30,35);

UPDATE DimEmployee_Enterprise
SET StoreID = 50
WHERE StoreID = 99;

UPDATE FactOrders
SET CustomerID = 0
WHERE CustomerID = 999999;

DELETE
FROM FactReturns
WHERE OrderID = 999999;

ALTER TABLE DimCustomer_Enterprise
ADD CONSTRAINT FK_Customer_Region
FOREIGN KEY (RegionID)
REFERENCES DimRegion(RegionID);

ALTER TABLE DimStore_Enterprise
ADD CONSTRAINT FK_Store_Region
FOREIGN KEY (RegionID)
REFERENCES DimRegion(RegionID);

ALTER TABLE DimEmployee_Enterprise
ADD CONSTRAINT FK_Employee_Store
FOREIGN KEY (StoreID)
REFERENCES DimStore_Enterprise(StoreID);

ALTER TABLE FactOrders
ADD CONSTRAINT FK_Orders_Customer
FOREIGN KEY (CustomerID)
REFERENCES DimCustomer_Enterprise(CustomerID);

ALTER TABLE FactOrders
ADD CONSTRAINT FK_Orders_Store
FOREIGN KEY (StoreID)
REFERENCES DimStore_Enterprise(StoreID);

ALTER TABLE FactOrders
ADD CONSTRAINT FK_Orders_Promotion
FOREIGN KEY (PromotionID)
REFERENCES DimPromotion(PromotionID);

-- FactOrderDetails → FactOrders
ALTER TABLE FactOrderDetails
ADD CONSTRAINT FK_OrderDetails_Order
FOREIGN KEY (OrderID)
REFERENCES FactOrders(OrderID);

-- FactOrderDetails → DimProduct
ALTER TABLE FactOrderDetails
ADD CONSTRAINT FK_OrderDetails_Product
FOREIGN KEY (ProductID)
REFERENCES DimProduct_Enterprise(ProductID);

-- FactInventory → DimProduct
ALTER TABLE FactInventory
ADD CONSTRAINT FK_Inventory_Product
FOREIGN KEY (ProductID)
REFERENCES DimProduct_Enterprise(ProductID);

-- FactInventory → DimStore
ALTER TABLE FactInventory
ADD CONSTRAINT FK_Inventory_Store
FOREIGN KEY (StoreID)
REFERENCES DimStore_Enterprise(StoreID);

-- FactMarketing → DimPromotion
ALTER TABLE FactMarketing
ADD CONSTRAINT FK_Marketing_Promotion
FOREIGN KEY (PromotionID)
REFERENCES DimPromotion(PromotionID);

-- FactReturns → FactOrders
ALTER TABLE FactReturns
ADD CONSTRAINT FK_Returns_Order
FOREIGN KEY (OrderID)
REFERENCES FactOrders(OrderID);

-- FactShipments → FactOrders
ALTER TABLE FactShipments
ADD CONSTRAINT FK_Shipments_Order
FOREIGN KEY (OrderID)
REFERENCES FactOrders(OrderID);

-- FactWebsiteTraffic → DimCustomer
ALTER TABLE FactWebsiteTraffic
ADD CONSTRAINT FK_WebsiteTraffic_Customer
FOREIGN KEY (CustomerID)
REFERENCES DimCustomer_Enterprise(CustomerID);

SELECT COUNT(*) AS TotalForeignKeys
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'RetailDW'
AND REFERENCED_TABLE_NAME IS NOT NULL;

SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME
FROM information_schema.REFERENTIAL_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = DATABASE()
ORDER BY TABLE_NAME;

-- Basic SQL Queries --

SELECT * FROM DimCustomer_Enterprise;
SELECT * FROM DimCustomer_Enterprise WHERE Status = 'Active';
SELECT * FROM DimProduct_Enterprise WHERE SellingPrice > 1000;
SELECT ProductID,ProductName, SellingPrice FROM DimProduct_Enterprise ORDER BY SellingPrice DESC LIMIT 10;
SELECT COUNT(*) AS Total_Customers FROM DimCustomer_Enterprise WHERE CustomerID <> 0;
SELECT COUNT(*) AS Total_Products FROM DimProduct_Enterprise;
SELECT * FROM DimCustomer_Enterprise WHERE State = 'Telangana';
SELECT ROUND(AVG(SellingPrice),2) AS Average_SellingPrice FROM DimProduct_Enterprise;
SELECT ProductID, ProductName, SellingPrice FROM DimProduct_Enterprise ORDER BY SellingPrice DESC LIMIT 1;
SELECT ProductID,ProductName, SellingPrice FROM DimProduct_Enterprise ORDER BY SellingPrice LIMIT 1;
SELECT State, COUNT(*) AS Total_Customers FROM DimCustomer_Enterprise GROUP BY State ORDER BY Total_Customers DESC;
SELECT CustomerSegment,COUNT(*) AS Total_Customers FROM DimCustomer_Enterprise GROUP BY CustomerSegment ORDER BY Total_Customers DESC;
SELECT COUNT(*) AS Total_Orders FROM FactOrders;
SELECT OrderStatus, COUNT(*) AS Total_Orders FROM FactOrders GROUP BY OrderStatus;
SELECT PaymentMethod, COUNT(*) AS Total_Transactions FROM FactPayments GROUP BY PaymentMethod;
SELECT ROUND(SUM(TotalAmount),2) AS Total_Revenue FROM FactOrders;
SELECT ROUND(AVG(TotalAmount),2) AS Average_Order_Value FROM FactOrders;
SELECT
    MONTH(OrderDateKey) AS Month_No,
    MONTHNAME(OrderDateKey) AS Month_Name,
    COUNT(*) AS Total_Orders
FROM FactOrders GROUP BY MONTH(OrderDateKey), MONTHNAME(OrderDateKey) ORDER BY Month_No;
SELECT
    MONTH(OrderDateKey) AS Month_No,
    MONTHNAME(OrderDateKey) AS Month_Name,
    ROUND(SUM(TotalAmount),2) AS Revenue
FROM FactOrders GROUP BY MONTH(OrderDateKey),MONTHNAME(OrderDateKey) ORDER BY Month_No;
SELECT ROUND(AVG(Age),2) AS Average_Age FROM DimCustomer_Enterprise;

-- Aggregation & Business Summary Queries --

SELECT Gender,COUNT(*) AS Total_Customers FROM DimCustomer_Enterprise GROUP BY Gender;
SELECT City, COUNT(*) AS Total_Customers FROM DimCustomer_Enterprise GROUP BY City HAVING COUNT(*) > 50 ORDER BY Total_Customers DESC;
SELECT r.RegionName,COUNT(s.StoreID) AS Total_Stores FROM DimStore_Enterprise s
JOIN DimRegion r ON s.RegionID = r.RegionID
GROUP BY r.RegionName ORDER BY Total_Stores DESC;
SELECT
    p.ProductID,
    p.ProductName,
    i.StockQuantity,
    i.ReorderLevel
FROM FactInventory i JOIN DimProduct_Enterprise p ON i.ProductID = p.ProductID WHERE i.StockQuantity < i.ReorderLevel;
SELECT COUNT(*) AS Total_Returned_Orders FROM FactReturns;
SELECT
    c.CustomerName,
    o.OrderID,
    o.OrderDateKey,
    o.TotalAmount,
    o.OrderStatus
FROM FactOrders o
JOIN DimCustomer_Enterprise c ON o.CustomerID = c.CustomerID ORDER BY c.CustomerName;
SELECT
    o.OrderID,
    s.StoreName,
    s.StoreType,
    o.TotalAmount,
    o.OrderStatus
FROM FactOrders o
JOIN DimStore_Enterprise s ON o.StoreID = s.StoreID;
SELECT
    p.ProductName,
    c.CategoryName,
    p.SellingPrice
FROM DimProduct_Enterprise p
JOIN DimCategory c ON p.CategoryID = c.CategoryID;
SELECT
    p.ProductName,
    s.SupplierName
FROM DimProduct_Enterprise p
JOIN DimSupplier_Enterprise s ON p.SupplierID = s.SupplierID;
SELECT
    o.OrderID,
    e.EmployeeName,
    s.StoreName
FROM FactOrders o
JOIN DimStore_Enterprise s ON o.StoreID = s.StoreID
JOIN DimEmployee_Enterprise e ON s.StoreID = e.StoreID;
SELECT
    o.OrderID,
    p.PromotionType,
    p.DiscountPercent,
    o.TotalAmount
FROM FactOrders o JOIN DimPromotion p ON o.PromotionID = p.PromotionID;
SELECT
    c.CustomerName,
    r.RegionName,
    r.Zone
FROM DimCustomer_Enterprise c JOIN DimRegion r ON c.RegionID = r.RegionID;
SELECT
    od.OrderID,
    p.ProductName,
    od.Quantity,
    od.LineTotal
FROM FactOrderDetails od JOIN DimProduct_Enterprise p ON od.ProductID = p.ProductID;
SELECT
    s.StoreName,
    ROUND(SUM(o.TotalAmount),2) AS Revenue
FROM FactOrders o JOIN DimStore_Enterprise s ON o.StoreID = s.StoreID
GROUP BY s.StoreName ORDER BY Revenue DESC;
SELECT
    c.CustomerSegment,
    ROUND(SUM(o.TotalAmount),2) AS Revenue
FROM FactOrders o
JOIN DimCustomer_Enterprise c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerSegment ORDER BY Revenue DESC;
SELECT
    c.CategoryName,
    COUNT(DISTINCT od.OrderID) AS Total_Orders
FROM FactOrderDetails od
JOIN DimProduct_Enterprise p ON od.ProductID = p.ProductID
JOIN DimCategory c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName ORDER BY Total_Orders DESC;
SELECT
    e.EmployeeName,
    ROUND(SUM(o.TotalAmount),2) AS Total_Sales
FROM FactOrders o
JOIN DimStore_Enterprise s ON o.StoreID = s.StoreID
JOIN DimEmployee_Enterprise e ON s.StoreID = e.StoreID
GROUP BY e.EmployeeName ORDER BY Total_Sales DESC;
SELECT
    s.SupplierName,
    SUM(od.Quantity) AS Units_Sold
FROM FactOrderDetails od
JOIN DimProduct_Enterprise p ON od.ProductID = p.ProductID
JOIN DimSupplier_Enterprise s ON p.SupplierID = s.SupplierID
GROUP BY s.SupplierName ORDER BY Units_Sold DESC;
SELECT
    r.OrderID,
    p.ProductName,
    r.ReturnReason
FROM FactReturns r
JOIN FactOrderDetails od ON r.OrderID = od.OrderID
JOIN DimProduct_Enterprise p ON od.ProductID = p.ProductID;
SELECT
    c.CustomerName,
    p.PaymentMethod,
    p.PaymentStatus,
    o.TotalAmount
FROM FactPayments p 
JOIN FactOrders o ON p.OrderID = o.OrderID
JOIN DimCustomer_Enterprise c ON o.CustomerID = c.CustomerID;

-- Joins & Business Analysis Queries --

SELECT
    s.StoreName,
    p.ProductName,
    i.StockAvailable
FROM FactInventory i
JOIN DimStore_Enterprise s
    ON i.StoreID = s.StoreID
JOIN DimProduct_Enterprise p
    ON i.ProductID = p.ProductID
ORDER BY s.StoreName, p.ProductName;
SELECT
    c.CustomerName,
    o.OrderID,
    sh.DeliveryStatus
FROM FactShipments sh
JOIN FactOrders o
    ON sh.OrderID = o.OrderID
JOIN DimCustomer_Enterprise c
    ON o.CustomerID = c.CustomerID
ORDER BY o.OrderID;
SELECT
    dp.CampaignName,
    SUM(fm.Cost) AS Total_Cost
FROM FactMarketing fm
JOIN DimPromotion dp
    ON fm.PromotionID = dp.PromotionID
GROUP BY dp.CampaignName
ORDER BY Total_Cost DESC;
SELECT
    r.RegionName,
    COUNT(o.OrderID) AS Total_Orders
FROM FactOrders o
JOIN DimCustomer_Enterprise c
    ON o.CustomerID = c.CustomerID
JOIN DimRegion r
    ON c.RegionID = r.RegionID
GROUP BY r.RegionName
ORDER BY Total_Orders DESC;
SELECT
    c.CustomerName,
    SUM(o.TotalAmount) AS Revenue
FROM FactOrders o
JOIN DimCustomer_Enterprise c
    ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY Revenue DESC
LIMIT 10;
SELECT
    p.ProductName,
    SUM(od.Quantity) AS Total_Quantity
FROM FactOrderDetails od
JOIN DimProduct_Enterprise p
    ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY Total_Quantity DESC
LIMIT 10;
SELECT
    o.OrderID,
    c.CustomerName,
    sh.DispatchDate,
    sh.DeliveryDate,
    sh.DeliveryStatus
FROM FactShipments sh
JOIN FactOrders o
    ON sh.OrderID = o.OrderID
JOIN DimCustomer_Enterprise c
    ON o.CustomerID = c.CustomerID
WHERE sh.DeliveryStatus <> 'Delivered';
SELECT
    c.CategoryName,
    SUM(od.LineTotal) AS Revenue
FROM FactOrderDetails od
JOIN DimProduct_Enterprise p
    ON od.ProductID = p.ProductID
JOIN DimCategory c
    ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY Revenue DESC;
SELECT
    p.ProductID,
    p.ProductName
FROM DimProduct_Enterprise p
LEFT JOIN FactOrderDetails od
    ON p.ProductID = od.ProductID
WHERE od.ProductID IS NULL;
SELECT
    o.OrderID,
    c.CustomerName,
    s.StoreName,
    dp.CampaignName,
    o.OrderDateKey,
    o.OrderStatus,
    o.TotalAmount
FROM FactOrders o
JOIN DimCustomer_Enterprise c
    ON o.CustomerID = c.CustomerID
JOIN DimStore_Enterprise s
    ON o.StoreID = s.StoreID
LEFT JOIN DimPromotion dp
    ON o.PromotionID = dp.PromotionID
ORDER BY o.OrderID;
SELECT
    OrderID,
    TotalAmount,
    CASE
        WHEN TotalAmount < 1000 THEN 'Low'
        WHEN TotalAmount BETWEEN 1000 AND 5000 THEN 'Medium'
        ELSE 'High'
    END AS Order_Category
FROM FactOrders
ORDER BY TotalAmount DESC;
SELECT
    CustomerID,
    CustomerName,
    Age,
    CASE
        WHEN Age < 25 THEN 'Young'
        WHEN Age BETWEEN 25 AND 40 THEN 'Adult'
        WHEN Age BETWEEN 41 AND 60 THEN 'Middle Age'
        ELSE 'Senior'
    END AS Age_Group
FROM DimCustomer_Enterprise;
SELECT
    ProductID,
    ProductName,
    SellingPrice
FROM DimProduct_Enterprise
WHERE SellingPrice >
(
    SELECT AVG(SellingPrice)
    FROM DimProduct_Enterprise
);
SELECT
    c.CustomerID,
    c.CustomerName,
    SUM(o.TotalAmount) AS Total_Spending
FROM FactOrders o
JOIN DimCustomer_Enterprise c
ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING SUM(o.TotalAmount) >
(
    SELECT AVG(Customer_Total)
    FROM
    (
        SELECT SUM(TotalAmount) AS Customer_Total
        FROM FactOrders
        GROUP BY CustomerID
    ) AS AvgSpend
);
SELECT
    s.StoreName,
    SUM(o.TotalAmount) AS Revenue
FROM FactOrders o
JOIN DimStore_Enterprise s
ON o.StoreID = s.StoreID
GROUP BY s.StoreID, s.StoreName
ORDER BY Revenue DESC
LIMIT 1;
SELECT
    p.ProductName,
    SUM(od.Quantity) AS Total_Quantity
FROM FactOrderDetails od
JOIN DimProduct_Enterprise p
ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
HAVING SUM(od.Quantity) >
(
    SELECT AVG(Product_Qty)
    FROM
    (
        SELECT SUM(Quantity) AS Product_Qty
        FROM FactOrderDetails
        GROUP BY ProductID
    ) AS AvgQty
);
WITH MonthlyRevenue AS
(
    SELECT
        LEFT(OrderDateKey,6) AS YearMonth,
        SUM(TotalAmount) AS Revenue
    FROM FactOrders
    GROUP BY LEFT(OrderDateKey,6)
)
SELECT *
FROM MonthlyRevenue
ORDER BY YearMonth;
WITH CustomerRevenue AS
(
    SELECT
        c.CustomerID,
        c.CustomerName,
        SUM(o.TotalAmount) AS Revenue
    FROM FactOrders o
    JOIN DimCustomer_Enterprise c
    ON o.CustomerID = c.CustomerID
    GROUP BY c.CustomerID, c.CustomerName
)
SELECT *
FROM CustomerRevenue
ORDER BY Revenue DESC
LIMIT 5;
SELECT
    c.CustomerID,
    c.CustomerName,
    SUM(o.TotalAmount) AS Revenue,
    RANK() OVER
    (
        ORDER BY SUM(o.TotalAmount) DESC
    ) AS Customer_Rank
FROM FactOrders o
JOIN DimCustomer_Enterprise c
ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName;
SELECT
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS Total_Quantity,
    RANK() OVER
    (
        ORDER BY SUM(od.Quantity) DESC
    ) AS Product_Rank
FROM FactOrderDetails od
JOIN DimProduct_Enterprise p
ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName;

-- Advanced SQL Analytics -- 

SELECT
    OrderID,
    OrderDateKey,
    TotalAmount,
    ROW_NUMBER() OVER(ORDER BY OrderDateKey) AS Row_No
FROM FactOrders;
SELECT
    d.FullDate,
    SUM(o.TotalAmount) AS Daily_Revenue,
    SUM(SUM(o.TotalAmount))
        OVER(ORDER BY d.FullDate) AS Running_Revenue
FROM FactOrders o
JOIN DimDate d
ON o.OrderDateKey = d.DateKey
GROUP BY d.FullDate
ORDER BY d.FullDate;
SELECT
    OrderID,
    TotalAmount,
    LAG(TotalAmount)
        OVER(ORDER BY OrderDateKey) AS Previous_Order_Value
FROM FactOrders;
SELECT
    OrderID,
    TotalAmount,
    LEAD(TotalAmount)
        OVER(ORDER BY OrderDateKey) AS Next_Order_Value
FROM FactOrders;
SELECT *
FROM
(
    SELECT
        c.CategoryName,
        p.ProductName,
        SUM(od.Quantity) AS Qty_Sold,
        RANK() OVER
        (
            PARTITION BY c.CategoryName
            ORDER BY SUM(od.Quantity) DESC
        ) AS Product_Rank
    FROM FactOrderDetails od
    JOIN DimProduct_Enterprise p
        ON od.ProductID = p.ProductID
    JOIN DimCategory c
        ON p.CategoryID = c.CategoryID
    GROUP BY c.CategoryName,p.ProductName
) x
WHERE Product_Rank=1;
SELECT
    c.CustomerName,
    SUM(o.TotalAmount) AS Revenue,
    ROUND(
        SUM(o.TotalAmount)/
        (SELECT SUM(TotalAmount) FROM FactOrders)*100,
        2
    ) AS Revenue_Percentage
FROM FactOrders o
JOIN DimCustomer_Enterprise c
ON o.CustomerID=c.CustomerID
GROUP BY c.CustomerName
ORDER BY Revenue DESC;
SELECT *
FROM
(
    SELECT
        s.RegionName,
        st.StoreName,
        SUM(o.TotalAmount) AS Revenue,
        DENSE_RANK() OVER
        (
            PARTITION BY s.RegionName
            ORDER BY SUM(o.TotalAmount) DESC
        ) AS StoreRank
    FROM FactOrders o
    JOIN DimStore_Enterprise st
        ON o.StoreID=st.StoreID
    JOIN DimRegion s
        ON st.RegionID=s.RegionID
    GROUP BY s.RegionName,st.StoreName
) x
WHERE StoreRank<=3;
SELECT
    OrderID,
    StoreID,
    TotalAmount
FROM FactOrders o
WHERE TotalAmount >
(
SELECT AVG(TotalAmount)
FROM FactOrders
WHERE StoreID=o.StoreID
);
WITH MonthlyRevenue AS
(
SELECT
    d.Year,
    d.Month,
    SUM(o.TotalAmount) AS Revenue
FROM FactOrders o
JOIN DimDate d
ON o.OrderDateKey=d.DateKey
GROUP BY d.Year,d.Month
)
SELECT
    Year,
    Month,
    Revenue,
    Revenue-
    LAG(Revenue)
    OVER(ORDER BY Year,Month) AS Revenue_Growth
FROM MonthlyRevenue;
SELECT
ROUND(
COUNT(DISTINCT r.OrderID)*100.0/
COUNT(DISTINCT o.OrderID),
2
) AS Return_Percentage
FROM FactOrders o
LEFT JOIN FactReturns r
ON o.OrderID=r.OrderID;
SELECT
c.CustomerName,
COUNT(o.OrderID) AS TotalOrders
FROM FactOrders o
JOIN DimCustomer_Enterprise c
ON o.CustomerID=c.CustomerID
GROUP BY c.CustomerName
HAVING COUNT(o.OrderID)>1
ORDER BY TotalOrders DESC;
SELECT
c.CustomerID,
c.CustomerName
FROM DimCustomer_Enterprise c
LEFT JOIN FactOrders o
ON c.CustomerID=o.CustomerID
WHERE o.OrderID IS NULL;
SELECT
d.FullDate,
SUM(o.TotalAmount) AS Revenue
FROM FactOrders o
JOIN DimDate d
ON o.OrderDateKey=d.DateKey
GROUP BY d.FullDate
ORDER BY Revenue DESC
LIMIT 1;
SELECT
s.StoreName,
ROUND(AVG(o.TotalAmount),2) AS Avg_Order_Value
FROM FactOrders o
JOIN DimStore_Enterprise s
ON o.StoreID=s.StoreID
GROUP BY s.StoreName
ORDER BY Avg_Order_Value DESC;
SELECT
c.CustomerName,
SUM(o.TotalAmount) AS Customer_Lifetime_Value
FROM FactOrders o
JOIN DimCustomer_Enterprise c
ON o.CustomerID=c.CustomerID
GROUP BY c.CustomerName
ORDER BY Customer_Lifetime_Value DESC;
SELECT
p.ProductName,
SUM(
(od.UnitPrice-p.CostPrice)
*
od.Quantity
) AS Profit
FROM FactOrderDetails od
JOIN DimProduct_Enterprise p
ON od.ProductID=p.ProductID
GROUP BY p.ProductName
ORDER BY Profit DESC
LIMIT 10;
SELECT
c.CategoryName,
SUM(
(od.UnitPrice-p.CostPrice)
*
od.Quantity
) AS Profit
FROM FactOrderDetails od
JOIN DimProduct_Enterprise p
ON od.ProductID=p.ProductID
JOIN DimCategory c
ON p.CategoryID=c.CategoryID
GROUP BY c.CategoryName
ORDER BY Profit DESC;
SELECT
s.StoreName,
SUM(
(od.UnitPrice-p.CostPrice)
*
od.Quantity
) AS Profit,
RANK() OVER
(
ORDER BY SUM(
(od.UnitPrice-p.CostPrice)
*
od.Quantity
) DESC
) AS StoreRank
FROM FactOrders o
JOIN FactOrderDetails od
ON o.OrderID=od.OrderID
JOIN DimProduct_Enterprise p
ON od.ProductID=p.ProductID
JOIN DimStore_Enterprise s
ON o.StoreID=s.StoreID
GROUP BY s.StoreName;
SELECT
c.CustomerName,
SUM(o.TotalAmount) AS CLV,
RANK() OVER
(
ORDER BY SUM(o.TotalAmount) DESC
) AS CustomerRank
FROM FactOrders o
JOIN DimCustomer_Enterprise c
ON o.CustomerID=c.CustomerID
GROUP BY c.CustomerName;
SELECT
s.StoreName,
ROUND(
SUM(i.StockAvailable*p.CostPrice),
2
) AS Inventory_Value
FROM FactInventory i
JOIN DimProduct_Enterprise p
ON i.ProductID=p.ProductID
JOIN DimStore_Enterprise s
ON i.StoreID=s.StoreID
GROUP BY s.StoreName
ORDER BY Inventory_Value DESC;

-- Executive Business KPI Analysis --

SELECT
    s.StoreName,
    p.ProductName,
    i.StockAvailable,
    i.ReorderLevel
FROM FactInventory i
JOIN DimProduct_Enterprise p
    ON i.ProductID = p.ProductID
JOIN DimStore_Enterprise s
    ON i.StoreID = s.StoreID
WHERE i.StockAvailable <= i.ReorderLevel
ORDER BY i.StockAvailable;
SELECT
    sp.SupplierName,
    SUM(od.Quantity) AS Units_Sold
FROM FactOrderDetails od
JOIN DimProduct_Enterprise p
    ON od.ProductID = p.ProductID
JOIN DimSupplier_Enterprise sp
    ON p.SupplierID = sp.SupplierID
GROUP BY sp.SupplierName
ORDER BY Units_Sold DESC;
SELECT
    p.ProductName,
    COUNT(r.ReturnID) AS Total_Returns,
    SUM(od.Quantity) AS Units_Sold,
    ROUND(
        COUNT(r.ReturnID) * 100.0 /
        SUM(od.Quantity),2
    ) AS Return_Rate
FROM FactReturns r
JOIN FactOrderDetails od
    ON r.OrderID = od.OrderID
   AND r.ProductID = od.ProductID
JOIN DimProduct_Enterprise p
    ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY Return_Rate DESC;
SELECT
    c.CategoryName,
    COUNT(r.ReturnID) AS Total_Returns
FROM FactReturns r
JOIN DimProduct_Enterprise p
    ON r.ProductID = p.ProductID
JOIN DimCategory c
    ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY Total_Returns DESC;
SELECT
ROUND(
AVG(DATEDIFF(DeliveryDate, DispatchDate)),2
) AS Average_Delivery_Days
FROM FactShipments;
SELECT
ShipmentID,
Courier,
DispatchDate,
DeliveryDate,
DATEDIFF(DeliveryDate,DispatchDate) AS Delivery_Days
FROM FactShipments
WHERE DATEDIFF(DeliveryDate,DispatchDate)>7
ORDER BY Delivery_Days DESC;
SELECT
    dp.CampaignName,
    SUM(o.TotalAmount) AS Revenue,
    SUM(fm.Cost) AS Marketing_Cost,
    ROUND(
        (SUM(o.TotalAmount)-SUM(fm.Cost))
        /SUM(fm.Cost)*100,
        2
    ) AS ROI_Percentage
FROM FactMarketing fm
JOIN DimPromotion dp
    ON fm.PromotionID=dp.PromotionID
JOIN FactOrders o
    ON dp.PromotionID=o.PromotionID
GROUP BY dp.CampaignName;
SELECT
CampaignName,
SUM(o.TotalAmount) AS Revenue,
RANK() OVER
(
ORDER BY SUM(o.TotalAmount) DESC
) AS CampaignRank
FROM FactOrders o
JOIN DimPromotion d
ON o.PromotionID=d.PromotionID
GROUP BY CampaignName;
SELECT
VisitDate,
COUNT(*) AS Total_Visits
FROM FactWebsiteTraffic
GROUP BY VisitDate
ORDER BY VisitDate;
SELECT
ROUND(
SUM(Conversions)*100.0/
SUM(Clicks),
2
) AS Conversion_Rate
FROM FactMarketing;
SELECT
r.RegionName,
SUM(o.TotalAmount) AS Revenue
FROM FactOrders o
JOIN DimStore_Enterprise s
ON o.StoreID=s.StoreID
JOIN DimRegion r
ON s.RegionID=r.RegionID
GROUP BY r.RegionName
ORDER BY Revenue DESC;
SELECT
    e.EmployeeName,
    s.StoreName,
    SUM(o.TotalAmount) AS StoreRevenue,
    RANK() OVER (
        ORDER BY SUM(o.TotalAmount) DESC
    ) AS EmployeeRank
FROM DimEmployee_Enterprise e
JOIN DimStore_Enterprise s
    ON e.StoreID = s.StoreID
JOIN FactOrders o
    ON s.StoreID = o.StoreID
GROUP BY e.EmployeeName, s.StoreName;
SELECT
PaymentMethod,
SUM(PaidAmount) AS Revenue
FROM FactPayments
GROUP BY PaymentMethod
ORDER BY Revenue DESC;
SELECT
c.CategoryName,
ROUND(AVG(od.Discount),2) AS Avg_Discount
FROM FactOrderDetails od
JOIN DimProduct_Enterprise p
ON od.ProductID=p.ProductID
JOIN DimCategory c
ON p.CategoryID=c.CategoryID
GROUP BY c.CategoryName
ORDER BY Avg_Discount DESC;
SELECT
d.Year,
d.Month,
SUM(
(od.UnitPrice-p.CostPrice)
*
od.Quantity
) AS Profit
FROM FactOrderDetails od
JOIN FactOrders o
ON od.OrderID=o.OrderID
JOIN DimDate d
ON o.OrderDateKey=d.DateKey
JOIN DimProduct_Enterprise p
ON od.ProductID=p.ProductID
GROUP BY d.Year,d.Month
ORDER BY d.Year,d.Month;
SELECT
c.CustomerName,
COUNT(o.OrderID) AS Purchase_Frequency
FROM FactOrders o
JOIN DimCustomer_Enterprise c
ON o.CustomerID=c.CustomerID
GROUP BY c.CustomerName
ORDER BY Purchase_Frequency DESC;
SELECT *
FROM
(
SELECT
r.RegionName,
s.StoreName,
SUM(o.TotalAmount) AS Revenue,
RANK() OVER
(
PARTITION BY r.RegionName
ORDER BY SUM(o.TotalAmount) DESC
) AS StoreRank
FROM FactOrders o
JOIN DimStore_Enterprise s
ON o.StoreID=s.StoreID
JOIN DimRegion r
ON s.RegionID=r.RegionID
GROUP BY r.RegionName,s.StoreName
)x
WHERE StoreRank=1;
SELECT
c.CustomerID,
c.CustomerName,
DATEDIFF(
MAX(d.FullDate),
MAX(d.FullDate)
) AS Recency,
COUNT(o.OrderID) AS Frequency,
SUM(o.TotalAmount) AS Monetary
FROM FactOrders o
JOIN DimCustomer_Enterprise c
ON o.CustomerID=c.CustomerID
JOIN DimDate d
ON o.OrderDateKey=d.DateKey
GROUP BY c.CustomerID,c.CustomerName
ORDER BY Monetary DESC;
SELECT
o.OrderID,
d.FullDate,
c.CustomerName,
s.StoreName,
r.RegionName,
p.ProductName,
cat.CategoryName,
od.Quantity,
od.LineTotal,
o.TotalAmount
FROM FactOrders o
JOIN FactOrderDetails od
ON o.OrderID=od.OrderID
JOIN DimCustomer_Enterprise c
ON o.CustomerID=c.CustomerID
JOIN DimStore_Enterprise s
ON o.StoreID=s.StoreID
JOIN DimRegion r
ON s.RegionID=r.RegionID
JOIN DimProduct_Enterprise p
ON od.ProductID=p.ProductID
JOIN DimCategory cat
ON p.CategoryID=cat.CategoryID
JOIN DimDate d
ON o.OrderDateKey=d.DateKey;
SELECT
(SELECT COUNT(*) FROM DimCustomer_Enterprise) AS Total_Customers,
(SELECT COUNT(*) FROM FactOrders) AS Total_Orders,
(SELECT ROUND(SUM(TotalAmount),2)
 FROM FactOrders) AS Total_Revenue,
(SELECT ROUND(AVG(TotalAmount),2)
 FROM FactOrders) AS Average_Order_Value,
(SELECT COUNT(*) FROM DimProduct_Enterprise)
 AS Total_Products,
(SELECT COUNT(*) FROM FactReturns)
 AS Total_Returns,
(SELECT ROUND(SUM(
(od.UnitPrice-p.CostPrice)
*
od.Quantity),2)
FROM FactOrderDetails od
JOIN DimProduct_Enterprise p
ON od.ProductID=p.ProductID)
AS Total_Profit,
(SELECT ROUND(
COUNT(DISTINCT r.OrderID)*100.0/
COUNT(DISTINCT o.OrderID),2)
FROM FactOrders o
LEFT JOIN FactReturns r
ON o.OrderID=r.OrderID)
AS Return_Rate,
(SELECT ROUND(
SUM(i.StockAvailable*p.CostPrice),2)
FROM FactInventory i
JOIN DimProduct_Enterprise p
ON i.ProductID=p.ProductID)
AS Inventory_Value,
(SELECT ROUND(
AVG(DATEDIFF(DeliveryDate,DispatchDate)),2)
FROM FactShipments)
AS Average_Delivery_Time;