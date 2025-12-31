-- Diagnostic Analysis --
#############################################

-- The Inventory Crunch Diagnostic --
-- identify products that are selling fast but have dangerously low stock. to decide what to restock immediately --
-- we compare quantityInStock against the total quantityOrdered from the history of sales. --
 
 SELECT p.productName, p.productLine, p.quantityInStock, SUM(od.quantityOrdered) AS total_lifetime_sales, p.quantityInStock - SUM(od.quantityOrdered) AS inventory_risk_level
 FROM products p
 JOIN orderdetails od ON p.productCode = od.productCode
	GROUP BY p.productCode, p.productName, p.productLine, p.quantityInStock
    ORDER BY p.quantityInStock ASC LIMIT 10;

#############################################
    
-- The "Process Bottleneck" Diagnostic (late shipments) --
-- Analyze supply chain efficiency by finding orders that missed their deadline. --
-- An order is late if the shippedDate is later than requiredDate. --

SELECT o.orderNumber, c.customerName, o.orderDate, o.requiredDate, o.shippedDate, DATEDIFF(o.shippedDate, o.requiredDate) AS days_late
FROM orders o 
JOIN customers c ON o.customerNumber = c.customerNumber
WHERE o.shippedDate > o.requiredDate
ORDER BY days_late DESC;

############################################

-- The "Dead Stock" Diagnostic --
-- To find capital tied up in inventory that isn't moving. This is crucial for financial health and warehouse optimization. --
-- We are looking for items in the products table that do not appear in the orderdetails table. --

SELECT p.productCode, p.productName, p.buyPrice, p.quantityInStock, (p.buyPrice * p.quantityInStock) AS tied_up_capital
FROM products p 
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.productCode IS NULL 
ORDER BY tied_up_capital DESC;



