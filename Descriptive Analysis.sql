-- Descriptive Analysis --


-- Sales Performance Analysis --
-- Calculate total revenue over time. This tells management if the business is growing or shrinking.
-- Query: 

SELECT 
    SUM(od.quantityOrdered * od.priceEach) AS Total_Revenue,
    YEAR(o.orderDate) AS Sales_year
FROM
    orders o
        JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
WHERE
    o.status = 'Shipped'
GROUP BY YEAR(o.orderDate)
ORDER BY Sales_year DESC;

########################################################################

-- Customer Demographics (Market Distribution)
-- Understand where the customers are located. This helps marketing teams decide where to run campaigns.
-- Query: 

SELECT 
    country, COUNT(*) AS number_of_customers
FROM
    customers
GROUP BY country
ORDER BY number_of_customers DESC;

########################################################################

-- Product Popularity (Inventory Management)
-- Identify the "Bestsellers". This helps with inventory planning (knowing what to reorder)
-- Query: 

SELECT 
    p.productName,
    p.productLine,
    SUM(od.quantityOrdered) AS total_units_sold
FROM
    products p
        JOIN
    orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode , p.productName , p.productLine
ORDER BY total_units_sold DESC
LIMIT 10;
