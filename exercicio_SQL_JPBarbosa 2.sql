USE classicmodels;
#1--
SELECT
products.productName As productName,
products.productLine As productLine,
products.MSRP As MSRP,
products.buyPrice As buyPrice
FROM
products
WHERE
buyPrice > 50
AND
MSRP > buyPrice * 2;

#2--
SELECT
orders.orderNumber As orderNumber,
orders.customerNumber As customerNumber,
orders.orderDate As orderDate,
orders.shippedDate As shippedDate
FROM
orders
WHERE
Month(orderDate) <> Month(shippedDate);

#3--
SELECT
orders.customerNumber As customerNumber,
orders.status As status
FROM
orders
WHERE
status = 'Shipped'
GROUP BY
customerNumber
HAVING COUNT(*) >= 5;

#4--
SELECT
orderdetails.productCode As productCode, 
products.productName As productName,
sum(orderdetails.quantityOrdered) As sumQuantityOrdered
FROM
orderdetails
JOIN
products ON orderdetails.productCode = products.productCode
GROUP BY
orderdetails.productCode,
products.productCode
ORDER BY
sumQuantityOrdered DESC
LIMIT 10;
	
#5--
SELECT DISTINCT
status
FROM
orders;

SELECT
customers.customerNumber As customerNumber,
customers.customerName As customerName,
customers.phone As phone,
COUNT(CASE WHEN status NOT IN ('Shipped', 'In Process') THEN 1 END) / COUNT(CASE WHEN status = 'Shipped' THEN 1 END) AS unsuccessRate
FROM 
orders
JOIN
customers ON customers.customerNumber = orders.customerNumber
WHERE
orders.status <> 'In Process'
GROUP BY
customers.customerNumber,
customers.customerName,
customers.phone
HAVING
unsuccessRate > 0.3
ORDER BY
unsuccessRate DESC;













