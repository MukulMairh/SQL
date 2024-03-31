CREATE PROCEDURE RESTRODETAILS 
AS 
BEGIN
SELECT RestaurantName, RestaurantType, CuisinesType, TableBooking FROM Jomato
WHERE TableBooking !=0
END


EXEC RESTRODETAILS;
---------------------
--Create a transaction and update the cuisine type 'Cafe' to 'Cafeteria'. 
--Check the result and rollback it. 


BEGIN TRANSACTION 
	UPDATE Jomato 
	SET CuisinesType= 'Cafeteria'
	WHERE CuisinesType='Cafe'

PRINT 'TRANSACTION COMPLETED';
SELECT * FROM Jomato WHERE CuisinesType='Cafe';
ROLLBACK TRANSACTION
SELECT * FROM Jomato WHERE CuisinesType='Cafe';


---------
--3. Generate a row number column and find the top5 areas with the highest rating of restraunts 
SELECT  TOP 5
ROW_NUMBER()OVER(ORDER By Area) AS ROW, 
 Area, Rating  FROM Jomato ORDER BY Rating DESC ;
 ----------
 ---4.  USE the while loop to display the 1 to 50. 
 DECLARE @COUNTER  INT 
 SET @COUNTER=1
 WHILE( @COUNTER <=50)
 BEGIN 
	PRINT 'COUNTER = '+ CONVERT (VARCHAR,@COUNTER)
	SET @COUNTER =@COUNTER+1
 END

 ----

 --5. Write a query to create a top rating view store the generated top5 highest rating of restraunts. 

 CREATE VIEW HotelsRating 
 AS 
 SELECT TOP 5 * FROM Jomato
 ORDER BY Rating Desc; 

 ---6. Create a trigger that give an message whenever a new record is inserted.
SELECT * FROM Jomato; 
  

  CREATE TRIGGER zomatoOrderAfterInsertion
ON Jomato 
AFTER INSERT 
AS
BEGIN
    INSERT INTO Jomato (
		OrderId, 
        RestaurantName,
        RestaurantType,
        Rating,
        No_of_Rating,
        AverageCost,
        OnlineOrder,
        TableBooking,
        CuisinesType,
        Area,
        LocalAddress,
        Delivery_time
    ) 
    SELECT 
		OrderId, 
        RestaurantName,
        RestaurantType,
        Rating,
        No_of_Rating,
        AverageCost,
        OnlineOrder,
        TableBooking,
        CuisinesType,
        Area,
        LocalAddress,
        Delivery_time
    FROM inserted;
END;
INSERT INTO JOMATO VALUES (7015, 'Kanha', 'NorthIndian', 5, 1000, 250, 1,1 , 'Fast Food, Beverages', 'Malviya Nagar', 'Opposite To GT', 30 ); 
