
-- Find books that are out of stock.
SELECT  title FROM books
where stock =0;

--  Retrieve the most expensive book in the store.

SELECT  * FROM books 
Order BY  price DESC LIMIT 1;


-- Find the total number of orders placed by each customer.
SELECT customers.name, count(orders.customer_id) As total_orders  FROM orders
JOIN customers On orders.customer_id = customers.id
GROUP by "customers"."name"


--  Calculate the total revenue generated from book sales.
-- for found revenue need to multiply the price of each book by the quantity sold and sum up the results

SELECT SUM(books.price * orders.quantity) AS total_revenue FROM orders
JOIN books ON orders.book_id = books.id;


--List all customers who have placed more than one order.
SELECT customers.name, count(orders.customer_id) As orders_count  FROM orders
JOIN customers On orders.customer_id = customers.id
GROUP by customers.id
HAVING count(orders.customer_id) >1

--Find the average price of books in the store.
SELECT AVG(price) AS avg_book_price FROM books;

-- Delete customers who haven't placed any orders.
DELETE FROM customers
WHERE id NOT IN (SELECT DISTINCT customer_id FROM orders);