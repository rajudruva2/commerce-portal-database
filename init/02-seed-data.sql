INSERT INTO categories (name) VALUES
('Electronics'), ('Office'), ('Accessories')
ON CONFLICT (name) DO NOTHING;

INSERT INTO products (name, description, price, stock, category_id)
SELECT 'Wireless Headphones', 'Bluetooth over-ear headphones', 79.99, 25, id
FROM categories WHERE name = 'Electronics'
AND NOT EXISTS (SELECT 1 FROM products WHERE name = 'Wireless Headphones');

INSERT INTO products (name, description, price, stock, category_id)
SELECT 'Mechanical Keyboard', 'Compact mechanical keyboard', 89.50, 18, id
FROM categories WHERE name = 'Electronics'
AND NOT EXISTS (SELECT 1 FROM products WHERE name = 'Mechanical Keyboard');

INSERT INTO products (name, description, price, stock, category_id)
SELECT 'Laptop Stand', 'Adjustable aluminum laptop stand', 42.00, 30, id
FROM categories WHERE name = 'Office'
AND NOT EXISTS (SELECT 1 FROM products WHERE name = 'Laptop Stand');

INSERT INTO products (name, description, price, stock, category_id)
SELECT 'USB-C Hub', 'Multi-port USB-C adapter', 34.99, 8, id
FROM categories WHERE name = 'Accessories'
AND NOT EXISTS (SELECT 1 FROM products WHERE name = 'USB-C Hub');

INSERT INTO customers (name, email)
VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Carol Williams', 'carol@example.com')
ON CONFLICT (email) DO NOTHING;

INSERT INTO orders (customer_id, status, total_amount)
SELECT id, 'CONFIRMED', 169.49 FROM customers WHERE email = 'alice@example.com'
AND NOT EXISTS (SELECT 1 FROM orders o JOIN customers c ON c.id=o.customer_id WHERE c.email='alice@example.com');

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, p.price
FROM orders o JOIN customers c ON c.id=o.customer_id
JOIN products p ON p.name='Wireless Headphones'
WHERE c.email='alice@example.com'
AND NOT EXISTS (SELECT 1 FROM order_items oi WHERE oi.order_id=o.id);

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT o.id, p.id, 1, p.price
FROM orders o JOIN customers c ON c.id=o.customer_id
JOIN products p ON p.name='Mechanical Keyboard'
WHERE c.email='alice@example.com'
AND NOT EXISTS (SELECT 1 FROM order_items oi WHERE oi.order_id=o.id);
