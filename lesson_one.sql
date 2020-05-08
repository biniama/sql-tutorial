CREATE DATABASE fredatabase

-- This line is commented out. That means, it will not be executed.
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