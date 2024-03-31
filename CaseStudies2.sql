CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');

 CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);
INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

	   CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);


INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)


---------------------------------
--Case Studies 2 Solutions-
---Simple Queries
--1. List all the employee details.
SELECT * FROM EMPLOYEE;
--2. List all the department details.
SELECT * FROM DEPARTMENT;
--3. List all job details.
SELECT * FROM JOB;
--4. List all the locations.
SELECT * FROM LOCATION;
--5. List out the First Name, Last Name, Salary, Commission for all Employees.
SELECT FIRST_NAME, LAST_NAME,SALARY, Comm FROM EMPLOYEE;
--6. List out the Employee ID, Last Name, Department ID for all employees and alias
--Employee ID as "ID of the Employee", Last Name as "Name of the
--Employee", Department ID as "Dep_id".

SELECT EMPLOYEE_ID AS 'ID of the Employee',LAST_NAME AS 'Last Name of the Employee',
DEPARTMENT_ID AS 'Dep_id' FROM EMPLOYEE;
--7. List out the annual salary of the employees with their names only.SELECT CONCAT (FIRST_NAME,' ',  MIDDLE_NAME,' ', LAST_NAME  ) AS Name, SALARY  FROM EMPLOYEE;-----------------------------------------------------------START of WHERE Condition----------------------------------------------------------1. List the details about "Smith".
SELECT * FROM EMPLOYEE WHERE LAST_NAME='SMITH';
--2. List out the employees who are working in department 20.
SELECT CONCAT( FIRST_NAME,' ',LAST_NAME) FROM EMPLOYEE WHERE DEPARTMENT_ID=20;
--3. List out the employees who are earning salary between 2000 and 3000.
SELECT  CONCAT( FIRST_NAME,' ',LAST_NAME) FROM EMPLOYEE WHERE SALARY BETWEEN 2000 AND 3000;
--4. List out the employees who are working in department 10 or 20.
SELECT  CONCAT( FIRST_NAME,' ',LAST_NAME), DEPARTMENT_ID FROM EMPLOYEE WHERE DEPARTMENT_ID = 10 OR DEPARTMENT_ID=20;
--5. Find out the employees who are not working in department 10 or 30.
SELECT  CONCAT( FIRST_NAME,' ',LAST_NAME), DEPARTMENT_ID FROM EMPLOYEE WHERE DEPARTMENT_ID != 10 AND DEPARTMENT_ID!=30;
--6. List out the employees whose name starts with 'L'.
SELECT CONCAT( FIRST_NAME,' ',LAST_NAME) FROM EMPLOYEE WHERE FIRST_NAME LIKE 'L%';
--7. List out the employees whose name starts with 'L' and ends with 'E'.
SELECT CONCAT( FIRST_NAME,' ',LAST_NAME) FROM EMPLOYEE WHERE FIRST_NAME LIKE 'L%' AND FIRST_NAME LIKE '%E';
--8. List out the employees whose name length is 4 and start with 'J'.
SELECT CONCAT( FIRST_NAME,' ',LAST_NAME) FROM EMPLOYEE WHERE LEN(FIRST_NAME)=4;
--9. List out the employees who are working in department 30 and draw the salaries more than 2500.
SELECT CONCAT( FIRST_NAME,' ',LAST_NAME) FROM EMPLOYEE WHERE DEPARTMENT_ID=30 AND SALARY> 2500;
--10. List out the employees who are not receiving commissionSELECT CONCAT( FIRST_NAME,' ',LAST_NAME), COMM FROM EMPLOYEE WHERE COMM IS NULL;----------------------------------------------------------------------------------------------------END of WHERE Clause-------------------------------------------------------------------------------------------------------------Starting ORDER BY Clause-------------
------------------------------------------------------------------------------------------
--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.
SELECT EMPLOYEE_ID, LAST_NAME FROM EMPLOYEE ORDER BY EMPLOYEE_ID asc;
--2. List out the Employee ID and Name in descending order based on salary.
SELECT EMPLOYEE_ID, CONCAT( FIRST_NAME,' ',LAST_NAME)AS Name , SALARY FROM EMPLOYEE ORDER BY SALARY asc;
--3. List out the employee details according to their Last Name in ascending-order.
SELECT * FROM EMPLOYEE ORDER BY LAST_NAME asc;
--4. List out the employee details according to their Last Name in ascending order and then --Department ID in descending order.SELECT * FROM EMPLOYEE ORDER BY LAST_NAME asc, DEPARTMENT_ID desc;----------------------------------------------------------------------------------------------------End of ORDER BY Clause-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------Starting GROUP BY and HAVING Clause-------------------------------------------------------------------------------------------------------SELECT * FROM EMPLOYEE;--1. List out the department wise maximum salary, minimum salary and average salary of the employees.
SELECT MIN(SALARY) AS MinSalary, Max(Salary) AS MaxSalary , AVG(SALARY)  As AvgSalary, DEPARTMENT_ID FROM Employee 
GROUP BY DEPARTMENT_ID;
--2. List out the job wise maximum salary, minimum salary and average salary of the employees.
 SELECT MIN(SALARY) AS MinSalary, Max(Salary) AS MaxSalary , AVG(SALARY)  As AvgSalary, JOB_ID FROM Employee 
GROUP BY JOB_ID;
--3. List out the number of employees who joined each month in ascending order.
SELECT DATEPART(MONTH,HIRE_DATE) As MONTH ,COUNT(*) as NumberOfEmployees FROM EMPLOYEE 
GROUP BY DATEPART(MONTH,HIRE_DATE) 
ORDER BY DATEPART(MONTH,HIRE_DATE) ASC;
--4. List out the number of employees for each month and year in ascending order based on the year and month.
SELECT DATEPART(YEAR,HIRE_DATE) As YEAR , DATEPART(MONTH,HIRE_DATE) As MONTH ,COUNT(*) as NumberOfEmployees FROM EMPLOYEE 
GROUP BY DATEPART(YEAR,HIRE_DATE), DATEPART(MONTH,HIRE_DATE) 
ORDER BY DATEPART(YEAR,HIRE_DATE)ASC , DATEPART(MONTH,HIRE_DATE) ASC;
--5. List out the Department ID hav1ing at least four employees.
SELECT DEPARTMENT_ID FROM EMPLOYEE GROUP BY DEPARTMENT_ID 
HAVING COUNT(*)>=4
--6. How many employees joined in February month.
SELECT COUNT(*) AS NumberOfPeopleJoinedInFEb FROM EMPLOYEE 
WHERE  DATEPART(MONTH, HIRE_DATE) =2
--7. How many employees joined in May or June month.
SELECT COUNT(*)  AS NumberOfPeopleJoinedInFEb FROM EMPLOYEE 
WHERE  DATEPART(MONTH, HIRE_DATE) =5 OR DATEPART(MONTH, HIRE_DATE) =6
--8. How many employees joined in 1985?
SELECT COUNT(*)  AS NumberOfPeopleJoinedIn1985 FROM EMPLOYEE 
GROUP BY  DATEPART(YEAR, HIRE_DATE) 
HAVING DATEPART(YEAR, HIRE_DATE) =1985 ;
--9. How many employees joined each month in 1985?
SELECT COUNT(*)AS NumberOfPeopleJoinedIn1985, DATEPART(YEAR, HIRE_DATE) as year ,  DATEPART(MONTH, HIRE_DATE) 
as month
FROM EMPLOYEE 
 GROUP BY ROLLUP( DATEPART(YEAR, HIRE_DATE)  ,  DATEPART(MONTH, HIRE_DATE) )
HAVING DATEPART(YEAR, HIRE_DATE) =1985 ;
--10. How many employees were joined in April 1985?
SELECT COUNT(*) as EmployeJoinedIn1985April FROM EMPLOYEE
WHERE DATEPART(YEAR,HIRE_DATE)=1985 AND DATEPART(MONTH,HIRE_DATE)=4; 
--11. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
SELECT DEPARTMENT_ID
FROM EMPLOYEE 
GROUP BY DEPARTMENT_ID, DATEPART(YEAR, HIRE_DATE),DATEPART(MONTH, HIRE_DATE)
HAVING COUNT(*)>=4 AND DATEPART(YEAR, HIRE_DATE)= 1985 AND DATEPART(MONTH, HIRE_DATE)=4;

----------------------------------------------------------------------------------------------------End of GROUP BY and HAVING Clause-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------Starting JOINS ---------------------------------------------------------------------------------------------------------1. List out employees with their department names.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EmployeeName,Name AS DepartmentName FROM EMPLOYEE E 
JOIN DEPARTMENT D ON E.DEPARTMENT_ID= D.Department_Id; 
--2. Display employees with their designations.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EmployeeName, Designation  FROM EMPLOYEE E 
JOIN JOB J ON E.JOB_ID=J.Job_ID ; 
--3. Display the employees with their department names and city.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EmployeeName,Name AS DepartmentName, City FROM EMPLOYEE E 
JOIN DEPARTMENT D ON E.DEPARTMENT_ID= D.Department_Id
JOIN LOCATION L ON D.Location_Id= L.Location_ID; 
--4. How many employees are working in different departments? Display with department names.
SELECT COUNT(*) AS NoOfEmployees, Name As DepartmentName from EMPLOYEE  E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY Name
--5. How many employees are working in the sales department?
SELECT COUNT(*) NoOFEmplouyewe FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE Name='Sales'
--6. Which is the department having greater than or equal to 3 employees and display the department names in
--ascending order.
SELECT COUNT(*) countOfEmployee, Name FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY Name
HAVING  count(*)>= 3
ORDER BY Name Asc; 

--7. How many employees are working in 'Dallas'?
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EmployeeName,Name AS DepartmentName, City FROM EMPLOYEE E 
JOIN DEPARTMENT D ON E.DEPARTMENT_ID= D.Department_Id
JOIN LOCATION L ON D.Location_Id= L.Location_ID
WHERE City='Dallas'; --can use count 
--8. Display all employees in sales or operation departments.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EmployeeName, Name FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE Name ='Sales' OR Name='Operations';

----------------------------------------------------------------------------------------------------End of JOINS-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------Starting CONDITIONAL STATTEMENT ---------------------------------------------------------------------------------------------------------1. Display the employee details with salary grades. Use conditional statement to
--create a grade column.
SELECT *, 
CASE 
	WHEN 
	SALARY BETWEEN 0 AND 1000 THEN 'A'
	WHEN SALARY BETWEEN 1001 AND 2000 THEN 'B'
	WHEN SALARY BETWEEN 2001 AND 3000 THEN 'C'
	END Grade 
FROM EMPLOYEE ;

--2. List out the number of employees grade wise. Use conditional statement to
--create a grade column.
SELECT COUNT(*), 
CASE 
	WHEN  COUNT(*) BETWEEN 1 AND 5 THEN 'A'
	WHEN  COUNT(*) BETWEEN 6 AND 10 THEN 'B'
	END 
	 Grade 
FROM EMPLOYEE ;

--3. Display the employee salary grades and the number of employees between
--2000 to 5000 range of salary
SELECT  
CASE 
	WHEN 
	SALARY BETWEEN 0 AND 1000 THEN 'A'
	WHEN SALARY BETWEEN 1001 AND 2000 THEN 'B'
	WHEN SALARY BETWEEN 2001 AND 3000 THEN 'C'
	END Grade , COUNT(*) As COUNT
FROM EMPLOYEE 
WHERE SALARY BETWEEN 2001 AND 5000
GROUP BY 
CASE 
	WHEN 
	SALARY BETWEEN 0 AND 1000 THEN 'A'
	WHEN SALARY BETWEEN 1001 AND 2000 THEN 'B'
	WHEN SALARY BETWEEN 2001 AND 3000 THEN 'C'
END ;

----------------------------------------------------------------------------------------------------End of CONDITIONAL STATEMENT-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------Starting Subqueries---------------------------------------------------------------------------------------------------------1. Display the employees list who got the maximum salary.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EmployeeName, SALARY FROM  EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);
--2. Display the employees who are working in the sales department.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EmployeeName FROM EMPLOYEE
WHERE DEPARTMENT_ID= (SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE Name='Sales');
--3. Display the employees who are working as 'Clerk'.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EmployeeName FROM EMPLOYEE
WHERE JOB_ID= (SELECT Job_ID FROM JOB WHERE Designation='Clerk');
--4. Display the list of employees who are living in 'Boston'.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EmployeeName FROM EMPLOYEE
WHERE DEPARTMENT_ID = (SELECT 
					DEPARTMENT_ID FROM DEPARTMENT WHERE Location_Id= (SELECT 
					Location_ID FROM LOCATION WHERE City='Boston'));
--5. Find out the number of employees working in the sales department.
SELECT COUNT(*) as numberOfEmployee From EMPLOYEE WHERE 
DEPARTMENT_ID= (SELECT DEPARTMENT_ID FROM DEPARTMENT WHERE Name='Sales');
--6. Update the salaries of employees who are working as clerks on the basis of 10%.
UPDATE EMPLOYEE
SET SALARY = SALARY *1.1 
WHERE JOB_ID= 
(SELECT JOB_ID FROM JOB WHERE Designation='Clerk'); 
--7. Display the second highest salary drawing employee details.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EmployeeName, MAX(salary) AS salary
FROM employee
WHERE salary = (
    SELECT MAX(salary) 
    FROM employee 
    WHERE SALARY < (SELECT MAX(SALARY) FROM EMPLOYEE)
)
GROUP BY FIRST_NAME, LAST_NAME;
--8. List out the employees who earn more than every employee in department 30.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EmployeeName, SALARY FROM EMPLOYEE
WHERE SALARY > (
	SELECT MAX(SALARY) FROM EMPLOYEE WHERE DEPARTMENT_ID =30
	)
--9. Find out which department has no employees.
SELECT Name, Department_Id from DEPARTMENT 
WHERE DEPARTMENT_ID NOT IN 
(SELECT Department_Id FROM EMPLOYEE);
--10. Find out the employees who earn greater than the average salary for their department.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EmployeeName, SALARY FROM EMPLOYEE
WHERE SALARY > (
	SELECT AVG(SALARY) FROM EMPLOYEE );
