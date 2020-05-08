# SQL (T-SQL) Tutorial

T-SQL, also known as Transact-SQL, is Microsoft’s implementation of the Structured Query Language (SQL) for SQL Server. T-SQL is the language that is most often used to extract or modify data stored in an SQL Server database, regardless of which application or tool you use.

### What Is SQL Server?
SQL Server is Microsoft’s relational database management system (RDBMS). An RDBMS stores data in tables according to the relational model.
 
### Other Database Technologies:
The following are FOSS - Free and Open Source Software
- MySQL
- Postgresql
		 	 	 		
### Relational database management system (RDBMS).
- has tables that have rows and columns

### Other alternatives: Document-based DBMS
- has no table and store everything as a file

### Downloading Links
[Microsoft® SQL Server® 2017 Express](https://www.microsoft.com/en-us/download/details.aspx?id=55994)
[SQL Server Management Studio (SSMS)](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15)
			
		
## Lesson 1
```sql
CREATE DATABASE fredatabase
 
-- DROP TABLE Customer
 
-- specify table name, column name and data type
CREATE TABLE Customer (
   id INT,
   firstName VARCHAR(20),
   lastName VARCHAR(20),
   phoneNumber VARCHAR(12),
   gender VARCHAR(6)
)
 
-- add or insert to a table
INSERT INTO Customer
VALUES (1, 'Frehiwot', 'Asnake', '720000000', 'FEMALE')
 
INSERT INTO Customer
VALUES (2, 'Biniam', 'Asnake', '017621003292', 'MALE')
 
-- INSERT INTO Customer
-- VALUES (1, 'Frehiwot', 'Asnake', '720000000', 'FEMALE'),
--        (2, 'Biniam', 'Asnake', '017621003292', 'MALE')
 
-- to list every data in the table
SELECT *    -- * indicates all columns
FROM Customer

-- List the first name and phone number of all female customers who has last name is not Kefale. -- This is a comment.
-- WHAT YOU WANT TO SEE
SELECT firstName, phoneNumber
-- WHERE TO GET THE DATA FROM
FROM Customer
-- FILTERING(s)
WHERE gender = 'FEMALE' AND lastName != 'Kefale'
 
-- List the id and first name of the first (only one) customers who are either male or has last name is Asnake. -- This is a comment.
SELECT TOP(1) id, firstName
FROM Customer
WHERE gender = 'MALE' OR lastName = 'Asnake'
 
-- by default, it sorts (orders) by the first column. In this case, it is ID
-- order the customers by first name
SELECT *
FROM Customer
ORDER BY gender
 
-- Count the female customers
SELECT COUNT(*) -- optionally SELECT COUNT(id)
FROM Customer
WHERE gender = 'FEMALE'
 
-- Alias - giving another name to a column or a table
SELECT COUNT(*) AS 'Count of all female customers'    -- (optionally) SELECT COUNT(*) AS Count
FROM Customer
WHERE gender = 'FEMALE'
 
-- grouping
SELECT COUNT(*) AS 'Count of family by last name', lastName
FROM Customer
WHERE lastName = 'Asnake'
GROUP BY lastName
 
-- having => important to do extra filtering
-- list the count and the firstName of customers who are children of Asnake and grouped by first name and
-- have first name that starts with 'Fre' or ends with 'ot'
-- and orders the last result by first name
SELECT COUNT(*) AS 'Count', firstName
FROM Customer
WHERE lastName LIKE 'Asnake'
GROUP BY firstName
HAVING firstName LIKE 'Fre%' OR firstName LIKE '%ot'
ORDER BY firstName
```

## Lesson 2
Tables to Join: Orders and Orderdetail  
What column to join? id and order+id  
 
Tables to Join? Orders and Customer  
What column to join? Customer_id and id  
 
```sql
Select item
From dbo.orders 
	join orderdetail on orders.id = orderdetail.order_id
	join dbo.customer on orders.customer_id = customer.id
where gender = 'female'
```
 
### Primary Key
Primary Key is something that identifies the entity and it should be unique and not null/blank. The best example is Social Security Number.

### Foreign Key
Foreign Key is a key on table2 that refers to a primary key in table1.

### Business Rule
One customer can make multiple orders. So, we put the customer_id in the Orders table instead of putting the order_id in the Customer table.  
Customer table has no information about which order a customer made.  
An order can have multiple Order details. So, we put the order_id in the OrderDetail table instead of putting the order_detail_id in the Orders table.  
Order table has no information about what order details it has.  
 
```sql
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
```
 
### Home Work
1. SHOW THE ITEMS THAT ARE ORDERED BY WOMAN
2. WHAT ITEMS DID ASNAKE'S FAMILY ORDER SINCE MARCH 1ST?

## Lesson 3: SQL JOINS - Deep Dive
Formula for Joining Tables:
```sql
Select *
FROM firstTableName
	JOIN secondTableName ON firstTableName.columnName = secondTableName.columnName
	JOIN thirdTableName ON firstTableName.columnName = thirdTableName.columnName
```

```sql
Select *
FROM orders
	JOIN customer ON orders.customer_id = customer.id
	JOIN orderdetail ON orders.id = orderdetail.order_id
```

## Exercise
Design Database Tables, and their relationship (no script required).

Think of designing a hotel management/reservation database.  
You have a Hotel, Room and Bed concepts.  
Use your imagination to design the relationship.  
Try to avoid this (having multiple rooms in the same row).  

| Hotel Id |Name|Address|NumberOfRooms|Rooms|  
|---|---|---|---|---|
|1|Asnake Hotel|Gondar|5|1,2,3,4,5|
and do this (reference the hotel from the room table)  

| Room Id |number|hasTv|hotel_id|  
|---|---|---|---|  
|1|A1|true|1|  
|2|B5|false|2|  


## Exercise
Create tables for Hotel, Room and Bed.  
Insert 2 hotels  
Each hotel should have 1 room with TV and another room with no tv.  
Each room should have 1 bed (queen, king, single, double)  
Total = 2 hotels, 4 rooms, 4 beds  
Show the room number for those rooms that have TV.  
Which hotel (name) has a king bed?  
Which room (number) has TV and queen bed?  
Which hotel and room has no TV but a double bed?  

## LESSON 4: Answers
```sql
--Create Table for Hotels
Create Table Hotels (
Id		int,
Name		VarChar (20),
Address	VarChar (20),
);

-- Insert 2 Hotels

Insert Into Hotels (Id, Name, Address)
Values		(1, 'Ghion', '123 Flanders Way')

Insert Into Hotels (Id, Name, Address)
Values	(2, 'Hilton', '234 same Way');

			
Select * From Hotels


-- Create Table for room

Create table Room (
Id		int,
Number	VarChar (20),
HasTV		Char (5),
Hotel_Id	int,
);

-- Each Hotel should have 1 room with TV and another one with No TV.

Insert Into Room (Id, Number, HasTV, Hotel_Id)
Values	(1, 111, 'True', 1),
		(2, 112, 'False',2),
		(3, 113, 'True', 2),
		(4, 114, 'False',1);

Select * From Room

-- Create table bed

Create table Bed (
Id		int,
Number	VarChar (20),
size		Char (10),
room_Id	int,
);

-- Each room should have 1 bed (King, Queen, Double, Single)

Insert Into Bed (Id, Number, size, room_Id)
Values	(1, 211, 'King', 1),
		(2, 212, 'Queen',2),
		(3, 213, 'Double',3),
		(4, 213, 'Single',4);
	
Select * From Bed


--  Show the Room numbers for those rooms that have TV

Select	Room.Number
From	Room
Where	HasTV = 'True';

-- Which Hotel has a King bed?

Select Hotels.Name 
From	Hotels
Join	Room on Hotels.Id = Room.Hotel_Id
Join	Bed on  Hotels.Id = Bed.room_Id
Where	size = 'King';

-- Which Room Number have TV or has Queen bed?

Select Room.Number
From	Room
Join	Bed on room_Id = Bed.room_Id
Where	HasTV= 'true' or size = 'Queen'

 -- Which Hotel and Room has No TV but a double bed?

Select	Hotels.Name, Room.Number
From		Hotels
Join		Room on Hotels.Id = Room.Hotel_Id
Join		Bed on  Hotels.Id = Bed.room_Id
Where		HasTV = 'true'  and size = 'Double'
```

## LESSON 5: TYPE OF SQL JOINS
Credit Card Table  
 
|CreditCardNUmber|CCV|EXP Date|  
|---|---|---| 
|123|1|2|
|999|1|2|  

Address Table

|Street|City|CreditCard#|
|---|---|---|  
|flandersway|denver|123|  
|steegerstr|berlin|null|  

```sql
CREATE DATABASE hotel_management;
 
-- all columns are null by default
CREATE TABLE hotel (
   id int NOT NULL IDENTITY PRIMARY KEY,
   name varchar(20) NOT NULL,
   address nvarchar(30)
);
 
CREATE TABLE room (
   id int NOT NULL IDENTITY PRIMARY KEY,
   hotel_id int,
   number int NOT NULL,
   type varchar(10)
   -- hotel_id int FOREIGN KEY REFERENCES hotel(id)
   CONSTRAINT FK_hotel_room FOREIGN KEY(hotel_id) REFERENCES hotel(id)
);
 
UPDATE room
SET hotel_id = 0
WHERE hotel_id IS NULL
 
ALTER TABLE room
ALTER COLUMN hotel_id int NOT NULL;
 
INSERT INTO hotel(name, address)
VALUES ('Ghion', 'Stadium'),
      ('Wabi Shebelle', 'Nazret'),
      ('Intercontinental', 'Kassanchis'),
      ('Sheraton', '4 kilo');
 
SELECT * FROM hotel;
 
-- order of columns in the table doesn't matter as long as you use the same order in the INSERT INTO and VALUES
INSERT INTO room(type, number, hotel_id)
VALUES ('king', 123, 1),
      ('queen', 456, 1),
      ('double', 789, 1),
      ('king', 321, 2),
      ('queen', 872, 2),
      ('double', 271, 2),
      ('king', 232, 3),
      ('queen', 333, 3),
      ('double', 983, 3);
 
SELECT * FROM room;
 
-- JOINS
-- 1. INNER JOIN or JOIN - returns the common/intersection of both tables
SELECT hotel.name, room.type
FROM hotel
INNER JOIN room ON hotel.id = room.hotel_id
 
-- 2. LEFT JOIN - hotel is on the left and room is on the right
SELECT hotel.name, room.type
FROM hotel
LEFT JOIN room ON hotel.id = room.hotel_id
-- output
-- name        type
-- Sheraton    NULL
 
-- SWAPPING THE LEFT TABLE
-- WE NEED TO FAKE THE HOTEL_ID AS NULL
ALTER TABLE room
ALTER COLUMN hotel_id int NULL;
 
-- INSERT ROOM WITH NO HOTEL
INSERT INTO room(type, number, hotel_id)
VALUES ('no hotel', 999, null)
 
SELECT hotel.name, room.type
FROM room
LEFT JOIN hotel ON hotel.id = room.hotel_id
 
-- output
-- name        type
-- NULL         no hotel
 
-- 3. RIGHT JOIN - hotel is on the left and room is on the right
SELECT hotel.name, room.type
FROM hotel
RIGHT JOIN room ON hotel.id = room.hotel_id
-- 4. LEFT OUTER JOIN - records that exist in the left table ONLY and not on the right table
SELECT hotel.name, room.id, room.type
FROM hotel
LEFT JOIN room ON hotel.id = room.hotel_id
WHERE room.id IS NULL
 
-- 5. RIGHT OUTER JOIN - rooms that doesn't have hotel. records that exists on the right table ONLY.
SELECT hotel.id, hotel.name, room.id, room.type
FROM hotel
RIGHT JOIN room ON hotel.id = room.hotel_id
WHERE hotel.id IS NULL
 
-- 6. FULL OUTER JOIN - everything! -> all hotels and all rooms
SELECT hotel.id, hotel.name, room.id, room.type
FROM hotel
FULL OUTER JOIN room ON hotel.id = room.hotel_id
 
-- 7. FULL OUTER JOIN 2 (name to be discovered) - hotels with no room and rooms with no hotel
SELECT hotel.id, hotel.name, room.id, room.type
FROM hotel
FULL OUTER JOIN room ON hotel.id = room.hotel_id
WHERE hotel.id IS NULL OR room.id IS NULL 
```

### AND LOGIC - both sides should be true  
T & T = T  
T & F = F  
F & T = F  
F & F = F  
 
### OR LOGIC - at least one side should be true  
T or T = T  
T or F = T  
F or T = T  
F or F = F  

## HOME WORK

You have Order(s) and OrderItem tables.  
They have relationship through the Order.id  

##### Tasks:
Create database  
Create tables  
Insert data  
Orders with orderItem (2)  
orders with no orderItem  
OrderItem with no order  
Write query for ALL (7) Join Types  

```sql
Create database Joining_Orders

Create table orders (
id		int,
name	Varchar (20),
type	Varchar (20),
Order_Date	Date,
);


INSERT INTO orders (id, name, type, order_date)
Values	(1, 'Phone', 'Electronics', '05/12/2008'),
		(2, 'Laptop', 'Electronics', '07/12/2004');

INSERT INTO orders (name, type, order_date)
Values	('Charger', 'Electronics', '11/06/2019');

Create table	orderitem (
id			int,
quantity	int,
order_id	int,
item_name	VarChar (20),
)

INSERT INTO orderitem (id, quantity,order_id, item_name)
Values	(100, 4, 1, 'Phone'),
		(101, 5, 2, 'Laptop');
		
INSERT INTO orderitem (id, quantity, item_name)
Values (4, 8, 'mouse')

--Inner Join

Select orders.name
From	orders
Inner Join	orderitem on order_id = order_id

--Right Join

Select 	orders.type
From		orders
Right Join	orderitem on order_id= order_id

-- left join

Select	orders.name
From		orders
Left Join	orderitem on order_id= order_id

-- left excluding join 

Select		orders.name
From		orders
Right Join	orderitem on order_id= order_id
Where	orderitem.id = Null

-- Right Exclusive

Select				orderitem.id
From				orders
Left outer Join		orderitem on order_id= order_id
Where			orders.id = null

-- Full outer Inclusive

Select			orders.name
From			orders
Full outer join	orderitem on order_id = order_id

-- Full outer exclusive

Select			orders.type
From			orders
Full outer join	orderitem on order_id = order_id
Where 		orders.type is null or orderitem.id is null
```
