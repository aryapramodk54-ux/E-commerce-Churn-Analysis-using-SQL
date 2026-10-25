SELECT * FROM ecomm.customer_churn;
SELECT AVG(WarehouseToHome) AS Mean_WarehouseToHome
FROM ecomm.customer_churn;
SET SQL_SAFE_UPDATES = 0;
UPDATE ecomm.customer_churn
SET WarehouseToHome = 16
WHERE WarehouseToHome IS NULL;
SELECT COUNT(*) AS Remaining_NULLs
FROM ecomm.customer_churn
WHERE WarehouseToHome IS NULL;
SELECT AVG(HourSpendOnApp) AS Mean_HourSpendOnApp
FROM ecomm.customer_churn;
UPDATE ecomm.customer_churn
SET HourSpendOnApp = 3
WHERE HourSpendOnApp IS NULL;
SELECT COUNT(*) AS Remaining_NULLs
FROM ecomm.customer_churn
WHERE HourSpendOnApp IS NULL;
SELECT AVG(OrderAmountHikeFromlastYear) AS Mean_OrderAmountHike
FROM ecomm.customer_churn;
UPDATE ecomm.customer_churn
SET OrderAmountHikeFromlastYear = 16
WHERE OrderAmountHikeFromlastYear IS NULL;
SELECT COUNT(*) AS Remaining_NULLs
FROM ecomm.customer_churn
WHERE OrderAmountHikeFromlastYear IS NULL;
SELECT AVG(DaySinceLastOrder) AS Mean_DaySinceLastOrder
FROM ecomm.customer_churn;
UPDATE ecomm.customer_churn
SET DaySinceLastOrder = 5
WHERE DaySinceLastOrder IS NULL;
SELECT COUNT(*) AS Remaining_NULLs
FROM ecomm.customer_churn
WHERE DaySinceLastOrder IS NULL;
SELECT Tenure, COUNT(*) AS Frequency
FROM ecomm.customer_churn
WHERE Tenure IS NOT NULL
GROUP BY Tenure
ORDER BY Frequency DESC
LIMIT 1;
UPDATE ecomm.customer_churn
SET Tenure = 1
WHERE Tenure IS NULL;
SELECT COUNT(*) AS Remaining_NULLs
FROM ecomm.customer_churn
WHERE Tenure IS NULL;
SELECT CouponUsed, COUNT(*) AS Frequency
FROM ecomm.customer_churn
WHERE CouponUsed IS NOT NULL
GROUP BY CouponUsed
ORDER BY Frequency DESC
LIMIT 1;
UPDATE ecomm.customer_churn
SET CouponUsed = 1
WHERE CouponUsed IS NULL;
SELECT COUNT(*) AS Remaining_NULLs
FROM ecomm.customer_churn
WHERE CouponUsed IS NULL;
SELECT OrderCount, COUNT(*) AS Frequency
FROM ecomm.customer_churn
WHERE OrderCount IS NOT NULL
GROUP BY OrderCount
ORDER BY Frequency DESC
LIMIT 1;
UPDATE ecomm.customer_churn
SET OrderCount = 2
WHERE OrderCount IS NULL;
SELECT COUNT(*) AS Remaining_NULLs
FROM ecomm.customer_churn
WHERE OrderCount IS NULL;
SELECT COUNT(*) AS Outlier_Count
FROM ecomm.customer_churn
WHERE WarehouseToHome > 100;
SELECT *
FROM ecomm.customer_churn
WHERE WarehouseToHome > 100;
DELETE FROM ecomm.customer_churn
WHERE WarehouseToHome > 100;
SELECT COUNT(*) AS Remaining_Outliers
FROM ecomm.customer_churn
WHERE WarehouseToHome > 100;
SELECT PreferredLoginDevice, COUNT(*) AS Frequency
FROM ecomm.customer_churn
GROUP BY PreferredLoginDevice
ORDER BY Frequency DESC;
UPDATE ecomm.customer_churn
SET PreferredLoginDevice = 'Mobile Phone'
WHERE PreferredLoginDevice = 'Phone';
SELECT PreferredLoginDevice, COUNT(*) AS frequency
FROM ecomm.customer_churn
GROUP BY PreferredLoginDevice;
SELECT COUNT(*) AS Phone_Count
FROM ecomm.customer_churn
WHERE PreferredLoginDevice = 'Phone';
SELECT *
FROM ecomm.customer_churn
WHERE PreferredLoginDevice = 'Mobile Phone';
SHOW COLUMNS FROM ecomm.customer_churn;
SELECT *
FROM ecomm.customer_churn
LIMIT 1;
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'ecomm'
  AND TABLE_NAME = 'customer_churn';
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'ecomm'
  AND TABLE_NAME = 'customer_churn'
  AND COLUMN_NAME LIKE '%Order%';
 SELECT PreferedOrderCat, COUNT(*) AS Frequency
FROM ecomm.customer_churn
GROUP BY PreferedOrderCat
ORDER BY Frequency DESC;
SET SQL_SAFE_UPDATES = 0;
UPDATE ecomm.customer_churn
SET PreferedOrderCat = 'Mobile Phone'
WHERE PreferedOrderCat = 'Mobile';
SELECT PreferedOrderCat, COUNT(*) AS Frequency
FROM ecomm.customer_churn
GROUP BY PreferedOrderCat
ORDER BY Frequency DESC;
SELECT COUNT(*) AS Remaining_Mobile
FROM ecomm.customer_churn
WHERE PreferedOrderCat = 'Mobile';
SELECT PreferredPaymentMode, COUNT(*) AS Frequency
FROM ecomm.customer_churn
GROUP BY PreferredPaymentMode
ORDER BY Frequency DESC;
UPDATE ecomm.customer_churn
SET PreferredPaymentMode = 'Cash on Delivery'
WHERE PreferredPaymentMode = 'COD';
UPDATE ecomm.customer_churn
SET PreferredPaymentMode = 'Credit Card'
WHERE PreferredPaymentMode = 'CC';
SELECT COUNT(*) AS Remaining_COD
FROM ecomm.customer_churn
WHERE PreferredPaymentMode = 'COD';
SELECT COUNT(*) AS Remaining_CC
FROM ecomm.customer_churn
WHERE PreferredPaymentMode = 'CC';
SHOW COLUMNS FROM ecomm.customer_churn;
ALTER TABLE ecomm.customer_churn
RENAME COLUMN PreferedOrderCat TO PreferredOrderCat;
ALTER TABLE ecomm.customer_churn
RENAME COLUMN HourSpendOnApp TO HoursSpentOnApp;
ALTER TABLE ecomm.customer_churn
ADD COLUMN ComplaintReceived VARCHAR(3);
 SET SQL_SAFE_UPDATES = 0;
 UPDATE ecomm.customer_churn
SET ComplaintReceived = CASE
    WHEN Complain = 1 THEN 'Yes'
    ELSE 'No'
END;
SELECT ComplaintReceived, COUNT(*) AS Frequency
FROM ecomm.customer_churn
GROUP BY ComplaintReceived;
ALTER TABLE ecomm.customer_churn
ADD COLUMN ChurnStatus VARCHAR(7);
UPDATE ecomm.customer_churn
SET ChurnStatus = CASE
    WHEN Churn = 1 THEN 'Churned'
    ELSE 'Active'
END;
SELECT ChurnStatus, COUNT(*) AS Frequency
FROM ecomm.customer_churn
GROUP BY ChurnStatus;
ALTER TABLE ecomm.customer_churn
DROP COLUMN Churn;
ALTER TABLE ecomm.customer_churn
DROP COLUMN Complain;
SHOW COLUMNS FROM ecomm.customer_churn;
SELECT ChurnStatus, COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
GROUP BY ChurnStatus;
SELECT 
    AVG(Tenure) AS AverageTenure,
    SUM(CashbackAmount) AS TotalCashbackAmount
FROM ecomm.customer_churn
WHERE ChurnStatus = 'Churned';
SELECT 
    ROUND(
        100.0 * SUM(CASE WHEN ComplaintReceived = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS ChurnedCustomersWhoComplained_Percentage
FROM ecomm.customer_churn
WHERE ChurnStatus = 'Churned';
SELECT 
    CityTier,
    COUNT(*) AS ChurnedCustomerCount
FROM ecomm.customer_churn
WHERE ChurnStatus = 'Churned'
  AND PreferredOrderCat = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY ChurnedCustomerCount DESC
LIMIT 1;
SELECT 
    PreferredPaymentMode,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE ChurnStatus = 'Active'
GROUP BY PreferredPaymentMode
ORDER BY CustomerCount DESC
LIMIT 1;
SELECT 
    PreferredLoginDevice,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE ChurnStatus = 'Churned'
GROUP BY PreferredLoginDevice
ORDER BY CustomerCount DESC
LIMIT 1;
SELECT 
    PreferredOrderCat,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE ChurnStatus = 'Churned'
GROUP BY PreferredOrderCat
ORDER BY CustomerCount DESC
LIMIT 1;
 SELECT 
    PreferredLoginDevice,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE ChurnStatus = 'Active'
GROUP BY PreferredLoginDevice
ORDER BY CustomerCount DESC
LIMIT 1;
SELECT 
    PreferredPaymentMode,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE ChurnStatus = 'Churned'
GROUP BY PreferredPaymentMode
ORDER BY CustomerCount DESC
LIMIT 1;
SELECT 
    Gender,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE ChurnStatus = 'Churned'
GROUP BY Gender
ORDER BY CustomerCount DESC
LIMIT 1;
SELECT 
    CityTier,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE ChurnStatus = 'Active'
GROUP BY CityTier
ORDER BY CustomerCount DESC
LIMIT 1;
SELECT 
    Gender,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE ChurnStatus = 'Active'
GROUP BY Gender
ORDER BY CustomerCount DESC
LIMIT 1;
SELECT 
    PreferredOrderCat,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE ChurnStatus = 'Active'
GROUP BY PreferredOrderCat
ORDER BY CustomerCount DESC
LIMIT 1;
SELECT 
    PreferredPaymentMode,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE ChurnStatus = 'Active'
GROUP BY PreferredPaymentMode
ORDER BY CustomerCount DESC
LIMIT 1;
SELECT 
    PreferredOrderCat,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE ChurnStatus = 'Active'
GROUP BY PreferredOrderCat
ORDER BY CustomerCount DESC
LIMIT 1;
SELECT PreferredOrderCat, COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE CouponUsed > 5
GROUP BY PreferredOrderCat
ORDER BY CustomerCount DESC;
SELECT 
    PreferredPaymentMode,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE CouponUsed > 5
GROUP BY PreferredPaymentMode
ORDER BY CustomerCount DESC;
SELECT 
    PreferredLoginDevice,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE CouponUsed > 5
GROUP BY PreferredLoginDevice
ORDER BY CustomerCount DESC;
SHOW COLUMNS FROM ecomm.customer_churn;
SELECT 
    SUM(OrderAmountHikeFromlastYear) AS TotalOrderAmountHike
FROM ecomm.customer_churn
WHERE MaritalStatus = 'Single'
  AND PreferredLoginDevice = 'Mobile Phone';
  SELECT 
    AVG(NumberOfDeviceRegistered) AS AverageDevicesRegistered
FROM ecomm.customer_churn
WHERE PreferredPaymentMode = 'UPI';
SELECT 
    CityTier,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
GROUP BY CityTier
ORDER BY CustomerCount DESC
LIMIT 1;
SELECT 
    Gender,
    SUM(CouponUsed) AS TotalCouponsUsed
FROM ecomm.customer_churn
GROUP BY Gender
ORDER BY TotalCouponsUsed DESC
LIMIT 1;
SELECT 
    PreferredOrderCat,
    COUNT(*) AS CustomerCount,
    MAX(HoursSpentOnApp) AS MaxHoursSpentOnApp
FROM ecomm.customer_churn
GROUP BY PreferredOrderCat;
SELECT 
    SUM(OrderCount) AS TotalOrderCount
FROM ecomm.customer_churn
WHERE PreferredPaymentMode = 'Credit Card'
  AND SatisfactionScore = (
      SELECT MAX(SatisfactionScore)
      FROM ecomm.customer_churn
  );
 SELECT 
    AVG(SatisfactionScore) AS AverageSatisfactionScore
FROM ecomm.customer_churn
WHERE ComplaintReceived = 'Yes'; 
SELECT PreferredOrderCat, COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
WHERE CouponUsed > 5
GROUP BY PreferredOrderCat
ORDER BY CustomerCount DESC;
SELECT 
    PreferredOrderCat,
    AVG(CashbackAmount) AS AverageCashbackAmount
FROM ecomm.customer_churn
GROUP BY PreferredOrderCat
ORDER BY AverageCashbackAmount DESC
LIMIT 3;
 SELECT 
    MAX(OrderCount) AS MaximumOrderCount,
    AVG(Tenure) AS OverallAverageTenure
FROM ecomm.customer_churn;
SELECT 
    PreferredPaymentMode,
    ROUND(AVG(Tenure), 0) AS AverageTenure,
    SUM(OrderCount) AS TotalOrderCount
FROM ecomm.customer_churn
GROUP BY PreferredPaymentMode
HAVING ROUND(AVG(Tenure), 0) = 10
   AND SUM(OrderCount) > 500;
 SELECT
    CASE
        WHEN WarehouseToHome <= 5 THEN 'Very Close Distance'
        WHEN WarehouseToHome <= 10 THEN 'Close Distance'
        WHEN WarehouseToHome <= 15 THEN 'Moderate Distance'
        ELSE 'Far Distance'
    END AS DistanceCategory,
    ChurnStatus,
    COUNT(*) AS CustomerCount
FROM ecomm.customer_churn
GROUP BY DistanceCategory, ChurnStatus
ORDER BY
    CASE DistanceCategory
        WHEN 'Very Close Distance' THEN 1
        WHEN 'Close Distance' THEN 2
        WHEN 'Moderate Distance' THEN 3
        WHEN 'Far Distance' THEN 4
    END,
    ChurnStatus;
 SELECT *
FROM ecomm.customer_churn
WHERE MaritalStatus = 'Married'
  AND CityTier = 1
  AND OrderCount > (
      SELECT AVG(OrderCount)
      FROM ecomm.customer_churn
  );
CREATE TABLE ecomm.customer_returns (
    ReturnID INT PRIMARY KEY,
    CustomerID INT,
    ReturnDate DATE,
    RefundAmount INT
);  
SELECT *
FROM ecomm.customer_returns;
SELECT
    cr.ReturnID,
    cr.CustomerID,
    cr.ReturnDate,
    cr.RefundAmount,
    cc.ChurnStatus,
    cc.ComplaintReceived,
    cc.PreferredOrderCat,
    cc.PreferredPaymentMode,
    cc.Gender,
    cc.Tenure,
    cc.SatisfactionScore
FROM ecomm.customer_returns AS cr
INNER JOIN ecomm.customer_churn AS cc
    ON cr.CustomerID = cc.CustomerID
WHERE cc.ChurnStatus = 'Churned'
  AND cc.ComplaintReceived = 'Yes';
  

   

  
  
