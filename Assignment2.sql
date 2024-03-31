--Creating REstraunts table 
CREATE  TABLE Restraunts 
(Id INT PRIMARY KEY IDENTITY, 
Name VARCHAR(50), 
City VARCHAR(50), 
Rating INT, 
Cuisine VARCHAR(50), 
); 

--Inserting values in Restraunt tables 
INSERT INTO Restraunts (Name, City, Rating, Cuisine)
VALUES('Tadka Dhabha', 'Jaipur', 4, 'Punjabi'),
('Kanha', 'Jaipur', 4, 'North Indian'), 
('LMB', 'Jaipur', 3.5, 'Rajasthani'),
('Cafe Lazy Mojo', 'Jaipur', 3, 'Continental'), 
('Gopi Dhabha', 'Jaipur', 5, 'Punjabi');
--
SELECT * FROM Restraunts;

-- Menu Table 
CREATE TABLE FoodItems(
Id INT PRIMARY KEY IDENTITY, 
Restraunt_id  INT FOREIGN KEY REFERENCES Restraunts(Id), 
Item_Name VARCHAR(50), 
Price INT); 

ALTER TABLE FoodItems
ADD  Category VARCHAR(50);


INSERT INTO FoodItems(
Restraunt_id, Item_Name, Price, Category )
VALUES (1, 'Dal Makhni', 250, 'Indian'), 
(6, 'Dal Tadka', 250, 'Indian'), 
(6, 'Sarso Da Saag', 350, 'Indian'), 
(6, 'Dal Makhni', 250, 'Indian'), 
(7, 'Paav Bhaji', 250, 'Quick Bites'), 
(7, 'Chole Bhature', 150, 'Quick Bites'), 
(7, 'Chole Achari', 250, 'Fast Food'), 
(8, 'Saangri', 650, 'North Indian'), 
(8, 'Gwar Patha', 450, 'Quick Bites'), 
(8, 'Bejar ki Roti', 50, 'Quick Bites'), 
(9, 'Quarto Formaggio Pizza', 250, 'Quick Bites'), 
(9, 'Aleo Oleo Pasta', 150, 'Quick Bites'), 
(9, 'Brownie Shake', 250, 'Quick Bites'), 
(10, 'Sushi', 500, 'Quick Bites'), 
(10, 'Garlic Naan', 75, 'Quick Bites'), 
(10, 'Pasta', 690, 'Quick Bites');

SELECT * From FoodItems;

-- Just to check, the below line should not work as expected. 
INSERT INTO FoodItems (Restraunt_id, Item_Name, Price,Category) VALUES 
(6, 'GolGappe', 20, 'Street');
--

--CREATE TABLE RATING(
--Rating FLOAT, RatingStatus VARCHAR(50));

----
--1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick
--Chicken Bites’.
--User defined functions cannot be used to insert data directly into the tables. For this we will have to create a procedure first. 

--1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick
--Chicken Bites’.
CREATE FUNCTION StuffChicken()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        Id,
        Restraunt_id,
        CASE 
            WHEN Category = 'Quick Bites' THEN STUFF(Category, CHARINDEX('Bites', Category), 0, 'Chicken ')
            ELSE Category 
        END AS Category,
        Price
    FROM FoodItems
);

select * from dbo.StuffChicken();


-----
CREATE FUNCTION restrauntDetailsWithMaxRating ()
RETURNS TABLE 
AS RETURN 
(
SELECT name, Cuisine, Rating FROM Restraunts
WHERE Rating =(SELECT MAX(Rating) from Restraunts)
);

SELECT *  FROM dbo.restrauntDetailsWithMaxRating();


-----------
-- 3. Create a rating status column  to display the rating as 'Excellent' if it has more than 4 
--star rating, 'Good' if it has above 3.5 and below 4 star rating, 'Average ' if it has above 3 and below 3.5 
-- and bad if it's below 3 . 
SELECT  * FROM Restraunts;
SELECT *, 
CASE 
WHEN 
	Rating >4 THEN 'Excellant'
WHEN 
	Rating BETWEEN 3.5 AND 4 THEN 'Good'
WHEN 
	Rating BETWEEN 3 AND 3.5 THEN 'Average'
WHEN 
	Rating <3 THEN 'Bad'
END AS RatingStatus
FROM Restraunts;


----
--4. Find the Ceil, floor, and absolute values of the rating column and display the current date and separately 
--display the year, month, month_name and day. 

SELECT 
	CEILING(Rating) AS CEILING,
	FLOOR(Rating) AS FloorRating,
	ABS(Rating) AS ABSRating
FROM Restraunts; 
-- to see the effect of these functions use below query. Ceiling gives you next int number, floor gives you previous int number and absolute gives you exact number
SELECT 
	CEILING(3.756) AS CEILING,
	FLOOR(3.756) AS FloorRating,
	ABS(3.756) AS ABSRating;
----
-- Current date functions 
Select GETDATE() as CurrentDateAndTime, 
CURRENT_TIMESTAMP AS CurrentTimeStamp, 
 DAY(GETDATE()) AS CurrentDay, 
  MONTH(GETDATE()) AS CurrentMonth, 
   YEAR(GETDATE()) AS CurrentYear


   SELECT * FROM FoodItems;

--5. Display the restraunt type and total average cost using rollup. 
-- I am not sure on this one. Please can you verify and leave a feedback for this one? 

SELECT Category, AVG(Price) FROM FoodItems 
GROUP BY ROLLUP (Category);

