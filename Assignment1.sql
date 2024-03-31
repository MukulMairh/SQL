select * from Orders;
select * from Salesman;
SELECT * FROM Customer;

--1. Insert a new record in your Orders table.
INSERT INTO Orders VALUES(5005,3747,102,'2024-03-09', 10000);

--2. Add Primary key constraint for SalesmanId column in Salesman table. Add default
--constraint for City column in Salesman table. Add Foreign key constraint for SalesmanId
--column in Customer table. Add not null constraint in Customer_name column for the
--Customer table.--removing allowed null from the salesmanALTER TABLE Salesman ALTER COLUMN SalesmanID INT NOT NULL;--adding the primary key constraintALTER TABLE SalesmanADD CONSTRAINT PK_Salesman PRIMARY KEY (SAlesmanId);--add constraing for city columnALTER TABLE Salesman ADD CONSTRAINT DF_Salesman_City DEFAULT 'Jaipur' FOR City;--add foreign key constraint for salesman column in customer table ,--for this making FK as not null ALTER TABLE CustomerALTER COLUMN SalesmanId INT NOT NULL;--thenALTER TABLE Customer ADD CONSTRAINT FKSalesmanIdFOREIGN KEY (SalesmanId) REFERENCES Salesman(SalesmanId);--add not null constraint in the Customer_name column for the customer tableALTER TABLE CustomerALTER COLUMNCustomerName VARCHAR(50) NOT NULL ;--3. Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase
--amount value greater than 500.SELECT * FROM Customer where CustomerName LIKE '%N' AND PurchaseAmount>500;--4.  Using SET operators, retrieve the first result with unique SalesmanId values from two
--tables, and the other result containing SalesmanId with duplicates from two tables.SELECT SalesmanId FROM SalesmanUNION SELECT SalesmanId FROM Customer; ---SELECT SalesmanId FROM SalesmanUNION ALLSELECT SalesmanId FROM CUstomer;--5:Display the below columns which has the matching data.
--Orderdate, Salesman Name, Customer Name, Commission, and City which has the
--range of Purchase Amount between 500 to 1500

SELECT Orderdate, Name AS SalesmanName,CustomerName,Commission, City  from ORders o 
JOIN Customer C on O.CustomerId=C.CustomerId 
JOIN Salesman S on O.SalesmanId=S.SalesmanId;

---6. Using right join fetch all the results from Salesman and Orders table.SELECT * FROM Salesman S RIGHT JOIN Orders O On S.SalesmanId=O.SalesmanId ;