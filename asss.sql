CREATE TABLE products ( product_id int , product_name varchar(30), category_id int, price int); 
CREATE TABLE categories(category_id int, category_name varchar(30));
create table orders(order_id int, product_id int, quantity int, order_date date);
 
SELECT c.category_id, SUM(p.price * o.quantity) AS total_revenue
FROM categories c
INNER JOIN products p ON c.category_id = p.category_id
INNER JOIN orders o ON p.product_id = o.product_id
WHERE o.order_date >= '2024-6-2'
GROUP BY c.category_id;

