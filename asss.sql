1}Employee Management System
create table employee( eid int , ename varchar(50), did int, hire_date date );
create table departments(did int , dname varchar(60));
create table salaries( eid int,salary int,sdate date);

select * from salaries;
SELECT e.ename, d.dname, MAX(s.sam)
FROM employee e
INNER JOIN departments d ON e.did = d.did
INNER JOIN salaries s ON e.eid = s.eid
GROUP BY e.eid, e.ename, d.dname;

 
==============================================2============================================================
2}Product Inventory:

CREATE TABLE products ( product_id int , product_name varchar(30), category_id int, price int); 
CREATE TABLE categories(category_id int, category_name varchar(30));
create table orders(order_id int, product_id int, quantity int, order_date date);
 
SELECT c.category_id, SUM(p.price * o.quantity) AS total_revenue
FROM categories c
INNER JOIN products p ON c.category_id = p.category_id
INNER JOIN orders o ON p.product_id = o.product_id
WHERE o.order_date >= '2024-6-2'
GROUP BY c.category_id;

===============================================3==========================================================
3}Library Managementt System


CREATE TABLE authors (
  author_id INT PRIMARY KEY,
  author_name VARCHAR(255) ,
  author_country VARCHAR(50)
);


INSERT INTO authors (author_id, author_name, author_country)
VALUES (1, 'Jane Austen', 'UK'),
       (2, 'Harper Lee', 'USA'),
       (3, 'J. R. R. Tolkien', 'UK'),
       (4, 'Douglas Adams', 'UK'),
       (5, 'Gabriel Garcia Marquez', 'Colombia');

CREATE TABLE books (
  book_id INT PRIMARY KEY,
  book_title VARCHAR(255) ,
  author_id INT ,
  publication_date DATE,
  FOREIGN KEY (author_id) REFERENCES authors(author_id)
);


INSERT INTO books (book_id, book_title, author_id, publication_date)
VALUES (1, 'Pride and Prejudice', 1, '1813-01-28'),
       (2, 'To Kill a Mockingbird', 2, '1960-07-11'),
       (3, 'The Lord of the Rings: The Fellowship of the Ring', 3, '1954-07-29'),
       (4, 'The Hitchhiker\s Guide to the Galaxy', 4, '1979-10-12'),
       (5, 'One Hundred Years of Solitude', 5, '1967-06-5');


CREATE TABLE borrowers (
  borrower_id INT PRIMARY KEY,
  book_id INT ,
  borrower_name VARCHAR(255) ,
  borrow_date DATE,
  return_date DATE,
  FOREIGN KEY (book_id) REFERENCES books(book_id)
);


INSERT INTO borrowers (borrower_id, book_id, borrower_name, borrow_date, return_date)
VALUES (1, 1, 'Alice Smith', '2024-06-20', '2024-06-25'),
       (2, 2, 'Bob Jones', '2024-06-18', '2024-06-23'),
       (3, 3, 'Charlie Brown', '2024-06-15', NULL), 
       (4, 4, 'David Lee', '2024-06-21', NULL), 
       (5, 5, 'Emily Watson', '2024-06-22', '2024-06-24');


SELECT b.book_title, a.author_name, br.borrower_name, br.borrow_date, br.return_date
FROM books b
INNER JOIN authors a ON b.author_id = a.author_id
LEFT JOIN borrowers br ON b.book_id = br.book_id
ORDER BY b.book_title;
=========================================================4=======================================================
	
4}University Enrollment:
	
create table students( student_id int, student_name varchar(30), student_major varchar(30));
create table courses( course_id int, course_name varchar(30), course_department varchar(30));
create table enrollments( enrollment_id int, student_id int, course_id int, enrollment_date date);
create table grades ( grade_id int, enrollment_id int, grade_value int);


INSERT INTO students (student_id, student_name, student_major)
VALUES (1, 'Alice Smith', 'CS'),
       (2, 'Bob Jones', 'Math'),
       (3, 'Charlie Brown', 'History'),
       (4, 'David Lee', 'Engineering'),
       (5, 'Emily Watson', 'Biology');


INSERT INTO courses (course_id, course_name, course_department)
VALUES (101, 'Intro to Programming', 'CS'),
       (102, 'Calculus I', 'Math'),
       (103, 'World History', 'History'),
       (104, 'Mechanics', 'Engineering'),
       (105, 'General Biology', 'Biology');

INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date)
VALUES (1, 1, 101, '2024-06-20'),
       (2, 2, 102, '2024-06-20'),
       (3, 3, 103, '2024-06-20'),
       (4, 4, 104, '2024-06-20'),
       (5, 1, 104, '2024-06-20');

INSERT INTO grades (grade_id, enrollment_id, grade_value)
VALUES (1, 1, 85),
       (2, 2, 90),
       (3, 3, 78),
       (4, 4, 82);


SELECT c.course_name, AVG(g.grade_value) AS average_grade
FROM courses c
INNER JOIN enrollments e ON c.course_id = e.course_id
INNER JOIN grades g ON e.enrollment_id = g.enrollment_id
GROUP BY c.course_name;

===============================================5==========================================================
5}E-commerce Analysis:
	
create table customer(customer_id int, customer_name varchar(30), customer_country varchar(30));
create table orders ( order_id int, customer_id int, product_id int, order_date date, order_quantity int);
create table products( product_id int, product_name varchar(30), product_price int);

INSERT INTO customer (customer_id, customer_name, customer_country)
VALUES (1, 'John Doe', 'USA'),
       (2, 'Jane Smith', 'UK'),
       (3, 'Chen Lin', 'CHINA'),
       (4, 'Maria Garcia', 'SPAIN'),
       (5, 'Pierre Dupont', 'GREECE');
INSERT INTO orders (order_id, customer_id, product_id, order_date, order_quantity)
VALUES (1, 1, 101, '2024-06-22', 2),
       (2, 2, 102, '2024-06-22', 1),
       (3, 3, 103, '2024-06-22', 3),
       (4, 1, 102, '2024-06-21', 4),  
       (5, 4, 101, '2024-06-21', 1);  

	   INSERT INTO products (product_id, product_name, product_price)
VALUES (101, 'Laptop', 1000),
       (102, 'Headphones', 50),
       (103, 'Mouse', 20),
       (201, 'Keyboard', 30),
       (202, 'Tablet', 500);
SELECT c.customer_country, SUM(p.product_price * o.order_quantity) AS total_revenue
FROM customer c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_country;







