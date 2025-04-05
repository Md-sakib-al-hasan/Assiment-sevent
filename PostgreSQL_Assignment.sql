--  create books table 
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(200) NOT NULL,
    price NUMERIC(10, 2) CHECK (price >= 0) NOT NULL,
    stock INT CHECK (stock >= 0) NOT NULL,
    published_year INT CHECK (published_year > 0) NOT NULL
);

-- create customers table
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    "name" VARCHAR(200) NOT NULL,
    email VARCHAR(200) UNIQUE NOT NULL,
    joined_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

 --create orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
    book_id INT REFERENCES books(id) ON DELETE CASCADE,
    quantity INT CHECK (quantity > 0) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- Find books that are out of stock.
SELECT  title FROM books
where stock =0;

--  Retrieve the most expensive book in the store.

SELECT  * FROM books 
Order BY  price DESC LIMIT 1;


-- Find the total number of orders placed by each customer.
SELECT customers.name, count(orders.customer_id) As total_orders  FROM orders
JOIN customers On orders.customer_id = customers.id
GROUP by customers."name"


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