# Visualizing Data Using Power BI
![Dashboard](https://github.com/iamkarim/Data-Analysis-Projects/blob/main/Dashboard%20Works/images/AdventureWorks%20Dashboard.png)
This file contains visualizations of key performance metrics for Adventure Works Company. The dashboard presents several insights through various visual elements, including:

- Revenue Analysis
  ![Revenue](https://github.com/iamkarim/Data-Analysis-Projects/blob/main/Dashboard%20Works/images/Revenue%20Analysis.png)
- Sales Volume Analysis
  ![Sales Volume](https://github.com/iamkarim/Data-Analysis-Projects/blob/main/Dashboard%20Works/images/Sales%20Volume%20Analysis.png)
- Profit Analysis
  ![Profit](https://github.com/iamkarim/Data-Analysis-Projects/blob/main/Dashboard%20Works/images/Profit%20Analysis.png)
- Customer Analysis
  ![Customer](https://github.com/iamkarim/Data-Analysis-Projects/blob/main/Dashboard%20Works/images/Customer%20Analysis.png)
- Product Analysis
  ![Product](https://github.com/iamkarim/Data-Analysis-Projects/blob/main/Dashboard%20Works/images/Product%20Analysis.png)

These reports provide a comprehensive overview of the company's performance, highlighting areas of strength and identifying opportunities for improvement.

On PowerBI, Several tables were added to create the visuals. These tables include:

- ## Sales Reason
  WITH sales_per_reason AS (SELECT DATE_TRUNC(OrderDate, MONTH) AS year_month,
                                    sales_reason.SalesReasonID,
                                    SUM(sales.TotalDue) AS sales_amount,
                                    COUNT(sales.SalesOrderID) AS reasons_count
                             FROM  `tc-da-1.adwentureworks_db.salesorderheader` AS sales
                             INNER JOIN#(lf)   `tc-da-1.adwentureworks_db.salesorderheadersalesreason` AS sales_reason
                               ON sales.SalesOrderID = sales_reason.salesOrderID
                             GROUP BY 1,2
  SELECT  sales_per_reason.year_month,reason.Name AS sales_reason,
          sales_per_reason.sales_amount,
          sales_per_reason.reasons_count
  FROM sales_per_reason
  LEFT JOIN `tc-da-1.adwentureworks_db.salesreason`AS reason
     ON sales_per_reason.SalesReasonID = reason.SalesReasonID
- ## Shipping Address
`SELECT salesorderheader.*,
 province.stateprovincecode as ship_province,
 province.CountryRegionCode as country_code,
       province.name as country_state_name#(lf)
FROM tc-da-1.adwentureworks_db.salesorderheader as salesorderheader
INNER JOIN tc-da-1.adwentureworks_db.address as address#(lf)    
  ON salesorderheader.ShipToAddressID = address.AddressID
INNER JOIN tc-da-1.adwentureworks_db.stateprovince as province#(lf)   
  ON address.stateprovinceid = province.stateprovinceid`
- ## Profit
SELECT salesorderdetail.SalesOrderID, 
       SUM(salesorderdetail.OrderQty * product.StandardCost) SalesCost FROM  `adwentureworks_db.salesorderdetail` salesorderdetail JOIN  `adwentureworks_db.product` product ON  salesorderdetail.ProductID = product.ProductID GROUP BY  salesorderdetail.SalesOrderID
- ## Customer
  SELECT   customer.CustomerID,  customer.CustomerType,    CONCAT(contact.FirstName,    IFNULL(CONCAT(' ', contact.MiddleName), ''),      ' ',          contact.LastName) AS FullName FROM    `adwentureworks_db.customer` customer LEFT JOIN     `adwentureworks_db.individual` individual ON individual.CustomerID = customer.CustomerID LEFT JOIN  `adwentureworks_db.contact` contact ON contact.ContactId = individual.ContactID
- ## Product
  SELECT product.ProductID,    product.Name Product,     subcategory.Name subcategory,    category.Name category,      SUM(salesorderdetail.OrderQty) OrderCount,      SUM(salesorderdetail.LineTotal) Revenue FROM `adwentureworks_db.product` product LEFT JOIN `adwentureworks_db.productsubcategory` subcategory ON product.ProductSubcategoryID = subcategory.ProductSubcategoryID LEFT JOIN `adwentureworks_db.productcategory` category ON subcategory.ProductCategoryID = category.ProductCategoryID LEFT JOIN `adwentureworks_db.salesorderdetail` salesorderdetail ON product.ProductID = salesorderdetail.ProductID GROUP BY 1,2,3,4

  The rest were generated directly from google bigQuery.
  
