CREATE DATABASE fredatabase

-- specify table name, column name and data type
CREATE TABLE Customer (
   id INT,
   firstName VARCHAR(20),
   lastName VARCHAR(20),
   phoneNumber VARCHAR(12),
   gender VARCHAR(6)
   -- order_id INT -- one customer can make only one order
)

CREATE TABLE Orders (
   id INT,
   number INT,
   order_date DATE,
   customer_id INT -- one order can be made by only one customer
   -- order_detail_id INT, -- one order can have only one order detail
)

CREATE TABLE OrderDetail (
   id INT,
   item VARCHAR(30),
   quantity INT,
   order_id INT, -- one order detail belongs to one order
)

-- add or insert to a table
INSERT INTO Customer
VALUES (1, 'Frehiwot', 'Asnake', '720000000', 'FEMALE')

INSERT INTO Customer
VALUES (2, 'Biniam', 'Asnake', '017621003292', 'MALE')

INSERT INTO Orders
VALUES (1, 123, '2020-01-01', 1),
      (2, 456, '2020-02-02', 2),
      (3, 789, '2020-03-03', 1)

INSERT INTO OrderDetail
VALUES (1, 'Laoptop', 1, 1),
      (2, 'Mouse', 2, 1),
      (3, 'iPhone', 1, 2),
      (4, 'Eye Glass', 4, 3),
      (5, 'Charger', 2, 3)

SELECT * FROM Customer

SELECT * FROM Orders

SELECT * FROM OrderDetail

-- UPDATE STATEMENT
UPDATE OrderDetail
SET item = 'Laptop'
WHERE id = 1

-- SHOW THE ITEMS THAT FRE ORDERED WITH HER FIRST NAME, DATE, ITEM, AND QUANTITY
SELECT Customer.firstName, Orders.order_date, OrderDetail.item, OrderDetail.quantity
FROM Customer
JOIN Orders ON Customer.id = Orders.customer_id
JOIN OrderDetail ON Orders.id = OrderDetail.order_id
WHERE firstName = 'Frehiwot'

-- SHOW ORDER NUMBERS AND DATE WITH QUANTITY MORETHAN 2
SELECT Orders.number, Orders.order_date, OrderDetail.item
FROM Orders
JOIN OrderDetail ON Orders.id = OrderDetail.order_id
WHERE quantity > 2

-- WHO ordered the previous item with quantity morethan 2
SELECT Orders.number, Orders.order_date, OrderDetail.item, Customer.firstName, Customer.lastName
FROM Orders
JOIN OrderDetail ON Orders.id = OrderDetail.order_id
JOIN Customer ON Orders.customer_id = Customer.id
WHERE quantity > 2