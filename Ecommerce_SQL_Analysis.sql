
-- TASK 3: SQL FOR DATA ANALYSIS
-- E-Commerce SQL Database
-- Database: SQLite

-- 1. SELECT and WHERE
SELECT product_name, category, price
FROM Products
WHERE price > 2000;

-- 2. ORDER BY
SELECT product_name, price
FROM Products
ORDER BY price DESC;

-- 3. GROUP BY
SELECT category, COUNT(*) AS total_products
FROM Products
GROUP BY category;

-- 4. SUM and AVG
SELECT
    SUM(total_amount) AS total_sales,
    AVG(total_amount) AS average_order_value
FROM Orders;

-- 5. INNER JOIN
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
ORDER BY o.order_id;

-- 6. MULTIPLE JOIN
SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    od.quantity,
    od.unit_price
FROM Orders o
INNER JOIN Customers c
ON o.customer_id = c.customer_id
INNER JOIN Order_Details od
ON o.order_id = od.order_id
INNER JOIN Products p
ON od.product_id = p.product_id
ORDER BY o.order_id;

-- 7. LEFT JOIN
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.total_amount
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- 8. RIGHT JOIN equivalent
SELECT
    c.customer_name,
    o.order_id,
    o.total_amount
FROM Orders o
LEFT JOIN Customers c
ON o.customer_id = c.customer_id
ORDER BY o.order_id;

-- 9. SUBQUERY
SELECT product_name, price
FROM Products
WHERE price > (
    SELECT AVG(price)
    FROM Products
)
ORDER BY price DESC;

-- 10. CUSTOMER ANALYSIS
SELECT
    c.customer_name,
    COUNT(o.order_id) AS number_of_orders,
    SUM(o.total_amount) AS total_spent
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

-- 11. BEST-SELLING PRODUCTS
SELECT
    p.product_name,
    SUM(od.quantity) AS total_quantity_sold
FROM Products p
INNER JOIN Order_Details od
ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC;

-- 12. VIEW
CREATE VIEW Customer_Sales_Summary AS
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    AVG(o.total_amount) AS average_order_value
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.city;

-- View output
SELECT *
FROM Customer_Sales_Summary
ORDER BY total_spent DESC;

-- 13. INDEX
CREATE INDEX idx_orders_customer_id
ON Orders(customer_id);

CREATE INDEX idx_orders_order_date
ON Orders(order_date);

CREATE INDEX idx_products_category
ON Products(category);

-- 14. FINAL ANALYSIS
SELECT
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_order_value,
    MIN(total_amount) AS minimum_order,
    MAX(total_amount) AS maximum_order
FROM Orders;
