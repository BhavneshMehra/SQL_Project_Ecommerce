-- Creating the database
CREATE DATABASE customer_transaction_analysis;

-- Connecting to the database
\c customer_transaction_analysis;

-- Creating customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE
);

-- Creating products table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Creating transactions table
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    transaction_date DATE,
    quantity INT,
    total_amount DECIMAL(10, 2)
);

-- Insert sample data into customers
INSERT INTO customers (name, email, join_date) VALUES
('Alice', 'alice@example.com', '2023-01-15'),
('Bob', 'bob@example.com', '2023-02-20'),
('Charlie', 'charlie@example.com', '2023-03-05');

-- Insert sample data into products
INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 750.00),
('Headphones', 'Electronics', 50.00),
('Coffee Maker', 'Home Appliances', 120.00);

-- Insert sample data into transactions
INSERT INTO transactions (customer_id, product_id, transaction_date, quantity, total_amount) VALUES
(1, 1, '2023-04-10', 1, 750.00),
(2, 2, '2023-04-15', 2, 100.00),
(3, 3, '2023-05-01', 1, 120.00);

-- Top 5 products by revenue
SELECT 
    p.product_name, 
    SUM(t.total_amount) AS revenue
FROM 
    transactions t
JOIN 
    products p ON t.product_id = p.product_id
GROUP BY 
    p.product_name
ORDER BY 
    revenue DESC
LIMIT 5;

-- Monthly revenue trend
SELECT 
    DATE_TRUNC('month', transaction_date) AS month, 
    SUM(total_amount) AS monthly_revenue
FROM 
    transactions
GROUP BY 
    month
ORDER BY 
    month;

-- Most active customers
SELECT 
    c.name, 
    COUNT(t.transaction_id) AS transaction_count
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
GROUP BY 
    c.name
ORDER BY 
    transaction_count DESC;

