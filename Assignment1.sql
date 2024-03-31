select * from Orders;
select * from Salesman;
SELECT * FROM Customer;

--1. Insert a new record in your Orders table.
INSERT INTO Orders VALUES(5005,3747,102,'2024-03-09', 10000);

--2. Add Primary key constraint for SalesmanId column in Salesman table. Add default
--constraint for City column in Salesman table. Add Foreign key constraint for SalesmanId
--column in Customer table. Add not null constraint in Customer_name column for the
--Customer table.
--amount value greater than 500.
--tables, and the other result containing SalesmanId with duplicates from two tables.
--Orderdate, Salesman Name, Customer Name, Commission, and City which has the
--range of Purchase Amount between 500 to 1500

SELECT Orderdate, Name AS SalesmanName,CustomerName,Commission, City  from ORders o 
JOIN Customer C on O.CustomerId=C.CustomerId 
JOIN Salesman S on O.SalesmanId=S.SalesmanId;

---6. Using right join fetch all the results from Salesman and Orders table.