-- TASK 1.1
SELECT
  individual.CustomerID CustomerId,
  contact.Firstname FirstName,
  contact.Lastname LastName,
  CONCAT(contact.Firstname, ' ', contact.Lastname) FullName,
  CASE
    WHEN contact.Title IS NULL THEN CONCAT('Dear',' ',contact.Lastname)
    ELSE CONCAT(contact.Title,' ',contact.Lastname)
END
  AS addressing_title,
  contact.Emailaddress Email,
  contact.Phone Phone,
  customer.AccountNumber AccountNumber,
  customer.CustomerType CustomerType,
  address.City City,
  address.AddressLine1,
  CASE
    WHEN address.AddressLine2 IS NULL THEN ''
    ELSE address.AddressLine2
END
  AS AddressLine2,
  state.Name State,
  country.Name Country,
  COUNT(salesorder.SalesOrderID) number_orders,
  ROUND(SUM(salesorder.TotalDue),3) total_amount,
  MAX(salesorder.OrderDate) date_last_order
FROM
  `adwentureworks_db.individual` individual
LEFT JOIN
  `adwentureworks_db.contact` contact
ON
  individual.ContactID = contact.ContactID
LEFT JOIN
  `adwentureworks_db.customer` customer
ON
  individual.CustomerID = customer.CustomerID
LEFT JOIN
  `adwentureworks_db.customeraddress` customeraddress
ON
  customer.CustomerID = customeraddress.CustomerID
LEFT JOIN
  `adwentureworks_db.address` address
ON
  customeraddress.AddressID = address.AddressID
LEFT JOIN
  `adwentureworks_db.stateprovince` state
ON
  state.StateProvinceID = address.StateProvinceID
LEFT JOIN
  `adwentureworks_db.countryregion` country
ON
  state.CountryRegionCode = country.CountryRegionCode
LEFT JOIN
  `adwentureworks_db.salesorderheader` salesorder
ON
  contact.ContactId = salesorder.ContactID
WHERE
  customeraddress.AddressID = (
  SELECT
    MAX(customeraddress2.AddressID)
  FROM
    `adwentureworks_db.customeraddress` customeraddress2
  WHERE
    customeraddress2.CustomerID = customer.CustomerID )
  AND customer.CustomerType = 'I'
GROUP BY
  CustomerId,
  FirstName,
  LastName,
  FullName,
  addressing_title,
  Email,
  Phone,
  AccountNumber,
  CustomerType,
  City,
  AddressLine1,
  AddressLine2,
  State,
  Country
ORDER BY
  SUM(salesorder.TotalDue) DESC
LIMIT
  200;

-- TASK 1.2
WITH
  IndividualCustomers AS (
  SELECT
    individual.CustomerID CustomerId,
    contact.Firstname FirstName,
    contact.Lastname LastName,
    CONCAT(contact.Firstname, ' ', contact.Lastname) FullName,
    CASE
      WHEN contact.Title IS NULL THEN CONCAT('Dear',' ',contact.Lastname)
      ELSE CONCAT(contact.Title,' ',contact.Lastname)
  END
    AS addressing_title,
    contact.Emailaddress Email,
    contact.Phone Phone,
    customer.AccountNumber AccountNumber,
    customer.CustomerType CustomerType,
    address.City City,
    address.AddressLine1,
    CASE
      WHEN address.AddressLine2 IS NULL THEN ''
      ELSE address.AddressLine2
  END
    AS AddressLine2,
    state.Name State,
    country.Name Country,
    COUNT(salesorder.SalesOrderID) number_orders,
    ROUND(SUM(salesorder.TotalDue),3) total_amount,
    MAX(salesorder.OrderDate) date_last_order
  FROM
    `adwentureworks_db.individual` individual
  LEFT JOIN
    `adwentureworks_db.contact` contact
  ON
    individual.ContactID = contact.ContactID
  LEFT JOIN
    `adwentureworks_db.customer` customer
  ON
    individual.CustomerID = customer.CustomerID
  LEFT JOIN
    `adwentureworks_db.customeraddress` customeraddress
  ON
    customer.CustomerID = customeraddress.CustomerID
  LEFT JOIN
    `adwentureworks_db.address` address
  ON
    customeraddress.AddressID = address.AddressID
  LEFT JOIN
    `adwentureworks_db.stateprovince` state
  ON
    state.StateProvinceID = address.StateProvinceID
  LEFT JOIN
    `adwentureworks_db.countryregion` country
  ON
    state.CountryRegionCode = country.CountryRegionCode
  LEFT JOIN
    `adwentureworks_db.salesorderheader` salesorder
  ON
    contact.ContactId = salesorder.ContactID
  WHERE
    customeraddress.AddressID = (
    SELECT
      MAX(customeraddress2.AddressID)
    FROM
      `adwentureworks_db.customeraddress` customeraddress2
    WHERE
      customeraddress2.CustomerID = customer.CustomerID )
    AND customer.CustomerType = 'I'
  GROUP BY
    CustomerId,
    FirstName,
    LastName,
    FullName,
    addressing_title,
    Email,
    Phone,
    AccountNumber,
    CustomerType,
    City,
    AddressLine1,
    AddressLine2,
    State,
    Country
  ORDER BY
    SUM(salesorder.TotalDue) DESC),


  recent_order AS (
  SELECT
    MAX(OrderDate) max_order_date
  FROM
    `adwentureworks_db.salesorderheader`)

    
SELECT
  CustomerId,
  FirstName,
  LastName,
  FullName,
  addressing_title,
  Email,
  Phone,
  AccountNumber,
  CustomerType,
  City,
  AddressLine1,
  AddressLine2,
  State,
  Country,
  number_orders,
  total_amount,
  date_last_order
FROM
  IndividualCustomers
WHERE
  date_last_order < DATE_SUB((
    SELECT
      max_order_date
    FROM
      recent_order),INTERVAL 365 DAY)
LIMIT
  200;

-- TASK 1.3
SELECT
  individual.CustomerID CustomerId,
  contact.Firstname FirstName,
  contact.Lastname LastName,
  CONCAT(contact.Firstname, ' ', contact.Lastname) FullName,
  CASE
    WHEN contact.Title IS NULL THEN CONCAT('Dear',' ',contact.Lastname)
    ELSE CONCAT(contact.Title,' ',contact.Lastname)
END
  AS addressing_title,
  contact.Emailaddress Email,
  contact.Phone Phone,
  customer.AccountNumber AccountNumber,
  customer.CustomerType CustomerType,
  address.City City,
  address.AddressLine1,
  CASE
    WHEN address.AddressLine2 IS NULL THEN ''
    ELSE address.AddressLine2
END
  AS AddressLine2,
  state.Name State,
  country.Name Country,
  COUNT(salesorder.SalesOrderID) number_orders,
  ROUND(SUM(salesorder.TotalDue),3) total_amount,
  MAX(salesorder.OrderDate) date_last_order,
  CASE
    WHEN MAX(salesorder.OrderDate) < DATE_SUB(( SELECT MAX(OrderDate) FROM `adwentureworks_db.salesorderheader`),INTERVAL 365 DAY) THEN 'Inactive'
    ELSE 'Active'
END
  AS status
FROM
  `adwentureworks_db.individual` individual
LEFT JOIN
  `adwentureworks_db.contact` contact
ON
  individual.ContactID = contact.ContactID
LEFT JOIN
  `adwentureworks_db.customer` customer
ON
  individual.CustomerID = customer.CustomerID
LEFT JOIN
  `adwentureworks_db.customeraddress` customeraddress
ON
  customer.CustomerID = customeraddress.CustomerID
LEFT JOIN
  `adwentureworks_db.address` address
ON
  customeraddress.AddressID = address.AddressID
LEFT JOIN
  `adwentureworks_db.stateprovince` state
ON
  state.StateProvinceID = address.StateProvinceID
LEFT JOIN
  `adwentureworks_db.countryregion` country
ON
  state.CountryRegionCode = country.CountryRegionCode
LEFT JOIN
  `adwentureworks_db.salesorderheader` salesorder
ON
  contact.ContactId = salesorder.ContactID
WHERE
  customeraddress.AddressID = (
  SELECT
    MAX(customeraddress2.AddressID)
  FROM
    `adwentureworks_db.customeraddress` customeraddress2
  WHERE
    customeraddress2.CustomerID = customer.CustomerID )
  AND customer.CustomerType = 'I'
GROUP BY
  CustomerId,
  FirstName,
  LastName,
  FullName,
  addressing_title,
  Email,
  Phone,
  AccountNumber,
  CustomerType,
  City,
  AddressLine1,
  AddressLine2,
  State,
  Country
ORDER BY
  CustomerID DESC
LIMIT
  500;

-- TASK 1.4 
WITH IndividualCustomers as (SELECT
  individual.CustomerID CustomerId,
  contact.Firstname FirstName,
  contact.Lastname LastName,
  CONCAT(contact.Firstname, ' ', contact.Lastname) FullName,
  CASE
    WHEN contact.Title IS NULL THEN CONCAT('Dear',' ',contact.Lastname)
    ELSE CONCAT(contact.Title,' ',contact.Lastname)
END
  AS addressing_title,
  contact.Emailaddress Email,
  contact.Phone Phone,
  customer.AccountNumber AccountNumber,
  customer.CustomerType CustomerType,
  address.City City,
  address.AddressLine1,
  SUBSTR(AddressLine1, 1, STRPOS(AddressLine1, ' ') - 1) AS address_no,
  SUBSTR(AddressLine1, STRPOS(AddressLine1, ' ') + 1) AS Address_st,
  CASE
    WHEN address.AddressLine2 IS NULL THEN ''
    ELSE address.AddressLine2
END
  AS AddressLine2,
  state.Name State,
  country.Name Country,
  territory.Group Region,
  COUNT(salesorder.SalesOrderID) number_orders,
  ROUND(SUM(salesorder.TotalDue),3) total_amount,
  MAX(salesorder.OrderDate) date_last_order,
  CASE
    WHEN MAX(salesorder.OrderDate) < DATE_SUB(( SELECT MAX(OrderDate) FROM `adwentureworks_db.salesorderheader`),INTERVAL 365 DAY) THEN 'Inactive'
    ELSE 'Active'
END
  AS status
FROM
  `adwentureworks_db.individual` individual
LEFT JOIN
  `adwentureworks_db.contact` contact
ON
  individual.ContactID = contact.ContactID
LEFT JOIN
  `adwentureworks_db.customer` customer
ON
  individual.CustomerID = customer.CustomerID
LEFT JOIN
  `adwentureworks_db.customeraddress` customeraddress
ON
  customer.CustomerID = customeraddress.CustomerID
LEFT JOIN
  `adwentureworks_db.address` address
ON
  customeraddress.AddressID = address.AddressID
LEFT JOIN
  `adwentureworks_db.stateprovince` state
ON
  state.StateProvinceID = address.StateProvinceID
LEFT JOIN
  `adwentureworks_db.countryregion` country
ON
  state.CountryRegionCode = country.CountryRegionCode
LEFT JOIN
  `adwentureworks_db.salesorderheader` salesorder
ON
  contact.ContactId = salesorder.ContactID
LEFT JOIN 
   `adwentureworks_db.salesterritory` territory
ON
  state.TerritoryID = territory.TerritoryID
WHERE
  customeraddress.AddressID = (
  SELECT
    MAX(customeraddress2.AddressID)
  FROM
    `adwentureworks_db.customeraddress` customeraddress2
  WHERE
    customeraddress2.CustomerID = customer.CustomerID )
  AND customer.CustomerType = 'I'
GROUP BY
  CustomerId,
  FirstName,
  LastName,
  FullName,
  addressing_title,
  Email,
  Phone,
  AccountNumber,
  CustomerType,
  City,
  AddressLine1,
  address_no,
  Address_st,
  AddressLine2,
  State,
  Country,
  Region)

SELECT   
 CustomerId,
  FirstName,
  LastName,
  FullName,
  addressing_title,
  Email,
  Phone,
  AccountNumber,
  CustomerType,
  City,
  AddressLine1,
  address_no,
  Address_st,
  AddressLine2,
  State,
  Country,
  Region,
  number_orders,
  total_amount,
  date_last_order,
  status
FROM IndividualCustomers
WHERE status= 'Active' AND Region = 'North America' AND (total_amount >= 2500 OR number_orders >= 5)
ORDER BY Country,State,date_last_order;


-- TASK 2.1

SELECT 
  LAST_DAY(DATETIME(salesorder.OrderDate), MONTH) order_month,
  salesterritory.CountryRegionCode,
  salesterritory.Name Region,
  COUNT(DISTINCT(salesorder.SalesOrderID)) number_orders,
  COUNT(DISTINCT(salesorder.CustomerID)) number_customers,
  COUNT(DISTINCT(salesorder.SalesPersonID)) no_salesPersons,
  CAST(SUM(salesorder.TotalDue) AS INTEGER) total_w_tax

FROM `adwentureworks_db.salesorderheader` salesorder
LEFT JOIN `adwentureworks_db.salesterritory` salesterritory
ON salesorder.TerritoryID = salesterritory.TerritoryID
GROUP BY order_month,CountryRegionCode, Region;

-- TASK 2.2 
WITH
  monthly_sales_order AS (
  SELECT
    LAST_DAY(DATETIME(salesorder.OrderDate), MONTH) order_month,
    salesterritory.CountryRegionCode,
    salesterritory.Name Region,
    COUNT(DISTINCT(salesorder.SalesOrderID)) number_orders,
    COUNT(DISTINCT(salesorder.CustomerID)) number_customers,
    COUNT(DISTINCT(salesorder.SalesPersonID)) no_salesPersons,
    CAST(SUM(salesorder.TotalDue) AS INTEGER) total_w_tax
  FROM
    `adwentureworks_db.salesorderheader` salesorder
  LEFT JOIN
    `adwentureworks_db.salesterritory` salesterritory
  ON
    salesorder.TerritoryID = salesterritory.TerritoryID
  GROUP BY
    order_month,
    CountryRegionCode,
    Region)
  
SELECT
    order_month,
    CountryRegionCode,
    Region,
    number_orders,
    number_customers,
    no_salesPersons,
    total_w_tax,
  SUM(monthly_sales_order.total_w_tax) OVER (PARTITION BY CountryRegionCode, Region ORDER BY order_month) AS cumulative_sum
FROM
  monthly_sales_order

-- TASK 2.3
WITH
    monthly_sales_order AS (
    SELECT
      LAST_DAY(DATETIME(salesorder.OrderDate), MONTH) order_month,
      salesterritory.CountryRegionCode,
      salesterritory.Name Region,
      COUNT(DISTINCT(salesorder.SalesOrderID)) number_orders,
      COUNT(DISTINCT(salesorder.CustomerID)) number_customers,
      COUNT(DISTINCT(salesorder.SalesPersonID)) no_salesPersons,
      CAST(SUM(salesorder.TotalDue) AS INTEGER) total_w_tax
    FROM
      `adwentureworks_db.salesorderheader` salesorder
    LEFT JOIN
      `adwentureworks_db.salesterritory` salesterritory
    ON
      salesorder.TerritoryID = salesterritory.TerritoryID
    GROUP BY
      order_month,
      CountryRegionCode,
      Region),


cumulative_sales AS (
  SELECT
    order_month,
    CountryRegionCode,
    Region,
    number_orders,
    number_customers,
    no_salesPersons,
    total_w_tax,
    SUM(monthly_sales_order.total_w_tax) OVER (PARTITION BY CountryRegionCode, Region ORDER BY order_month) AS cumulative_sum
  FROM
    monthly_sales_order)


SELECT
  order_month,
  CountryRegionCode,
  Region,
  number_orders,
  number_customers,
  no_salesPersons,
  total_w_tax,
  RANK() OVER (PARTITION BY CountryRegionCode ORDER BY total_w_tax DESC) country_sales_rank,
  cumulative_sum
FROM
  cumulative_sales
ORDER BY
  CountryRegionCode,
  Region;

-- TASK 2.4
WITH
    monthly_sales_order AS (
      SELECT
        LAST_DAY(DATETIME(salesorder.OrderDate), MONTH) order_month,
        salesterritory.CountryRegionCode,
        salesterritory.Name Region,
        COUNT(DISTINCT(salesorder.SalesOrderID)) number_orders,
        COUNT(DISTINCT(salesorder.CustomerID)) number_customers,
        COUNT(DISTINCT(salesorder.SalesPersonID)) no_salesPersons,
        CAST(SUM(salesorder.TotalDue) AS INTEGER) total_w_tax
      FROM
        `adwentureworks_db.salesorderheader` salesorder
      LEFT JOIN
        `adwentureworks_db.salesterritory` salesterritory
      ON
        salesorder.TerritoryID = salesterritory.TerritoryID
      GROUP BY
        order_month,
        CountryRegionCode,
        Region),

cumulative_sales_rank AS (
  SELECT
    order_month,
    CountryRegionCode,
    Region,
    number_orders,
    number_customers,
    no_salesPersons,
    total_w_tax,
    RANK() OVER (PARTITION BY CountryRegionCode, Region ORDER BY total_w_tax DESC) country_sales_rank,
    SUM(monthly_sales_order.total_w_tax) OVER (PARTITION BY CountryRegionCode, Region ORDER BY order_month) AS cumulative_sum
  FROM monthly_sales_order
  ORDER BY
    CountryRegionCode,
    Region),


  highest_tax_rate_per_province AS (
  SELECT
    countryregion.CountryRegionCode,
    stateprovince.name StateProvince,
    MAX(salestaxrate.TaxRate) AS max_tax_rate
  FROM
    `adwentureworks_db.countryregion` countryregion
  JOIN
    `adwentureworks_db.stateprovince` stateprovince
  ON
    countryregion.CountryRegionCode = stateprovince.CountryRegionCode
  LEFT JOIN
    `adwentureworks_db.salestaxrate` salestaxrate
  ON
    salestaxrate.StateProvinceID = stateprovince.StateProvinceID
  GROUP BY
    CountryRegionCode,
    stateprovince ),


  tax_summary AS (
  SELECT
    CountryRegionCode,
    ROUND((SUM(CASE WHEN max_tax_rate IS NOT NULL THEN 1
                     ELSE 0 END)/COUNT(*)),2) as perc_provinces_w_tax,
    ROUND(AVG(max_tax_rate),1) avg_tax_rate
  FROM
    highest_tax_rate_per_province
  GROUP BY
    CountryRegionCode
)

SELECT
  cumulative_sales_rank.order_month,
  cumulative_sales_rank.CountryRegionCode,
  cumulative_sales_rank.Region,
  cumulative_sales_rank.number_orders,
  cumulative_sales_rank.number_customers,
  cumulative_sales_rank.no_salesPersons,
  cumulative_sales_rank.total_w_tax,
  cumulative_sales_rank.country_sales_rank,
  cumulative_sales_rank.cumulative_sum,
  tax_summary.avg_tax_rate AS mean_tax_rate,
  tax_summary.perc_provinces_w_tax
FROM
  cumulative_sales_rank
JOIN
  tax_summary
ON
  cumulative_sales_rank.CountryRegionCode = tax_summary.CountryRegionCode
ORDER BY
  tax_summary.avg_tax_rate;
