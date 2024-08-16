/* 1. Select all departments in all locations where the Total Salary of a Department is Greater than twice the Average Salary for the department.
And max basic for the department is at least thrice the Min basic for the department */

CREATE TABLE DEPARTMENTS(ID INT,DEPT VARCHAR(30),SALARY INT);
INSERT INTO DEPARTMENTS VALUES(271,'SOFTWARE ENGINEER ASSOCIATE',30000);
INSERT INTO DEPARTMENTS VALUES(272,'SOFTWARE ENGINEER ASSOCIATE',28000);
INSERT INTO DEPARTMENTS VALUES(275,'SOFTWARE ENGINEER ASSOCIATE',35000);
INSERT INTO DEPARTMENTS VALUES(269,'SOFTWARE ENGINEER ASSOCIATE',42000);
INSERT INTO DEPARTMENTS VALUES(270,'SOFTWARE ENGINEER ASSOCIATE',42000);
INSERT INTO DEPARTMENTS VALUES(273,'INTERN',45000);
INSERT INTO DEPARTMENTS VALUES(274,'INTERN',45000);
INSERT INTO DEPARTMENTS VALUES(249,'HR',600000);
INSERT INTO DEPARTMENTS VALUES(241,'HR ASSOCIATE',10000);
INSERT INTO DEPARTMENTS VALUES(242,'SOFTWARE ENGINEER',100000);
INSERT INTO DEPARTMENTS VALUES(243,'SOFTWARE ENGINEER',100000);
INSERT INTO DEPARTMENTS VALUES(246,'SOFTWARE ENGINEER',10000);
INSERT INTO DEPARTMENTS VALUES(245,'SOFTWARE ENGINEER',500000);
 
SELECT D.DEPT,D.SALARY
FROM DEPARTMENTS D
WHERE SALARY >= (SELECT MIN(SALARY)*3 FROM DEPARTMENTS )AND SALARY>(SELECT AVG(SALARY)*2 FROM DEPARTMENTS)
GROUP BY DEPT,SALARY;


/* 2. As per the companies rule if an employee has put up service of 1 Year 3 Months and 15 days in office, Then She/he would be eligible for a Bonus.
the Bonus would be Paid on the first of the Next month after which a person has attained eligibility. Find out the eligibility date for all the employees. 
And also find out the age of the Employee On the date of Payment of the First bonus. Display the Age in Years, Months, and Days.
Also Display the weekday Name, week of the year, Day of the year and week of the month of the date on which the person has attained the eligibility*/

CREATE TABLE EmployeeBonus (
EmployeeID INT PRIMARY KEY,
Names VARCHAR(30),
JoiningDate DATE,
BirthDate DATE
);
INSERT INTO EmployeeBonus 
VALUES
(4,'RAM', '2020-01-15', '1985-07-23'),
(5,'VIJAY', '2021-03-28', '1992-11-12'),
(6,'BHASKAR', '2019-09-05', '1988-04-04'),
(7, 'PRANAV','2022-11-18', '1995-02-17'),
(8,'PRADEEP', '2018-06-22', '1990-09-08'),
(9, 'MANIDEEP','2023-04-03', '1997-01-31'),
(10,'RAVI', '2017-12-10', '1989-06-15'),
(11,'KIRAN', '2021-07-25', '1993-03-28'),
(12,'KISHORE', '2019-02-18', '1987-10-11'),
(13,'VIVEK', '2022-09-05', '1994-05-04');


--Solution

WITH EmployeeData AS (
SELECT
EmployeeID,
Names,
JoiningDate,
BirthDate,
DATEADD(day, 365 + 90 + 15, JoiningDate) AS EligibilityDate,
DATEADD(day, 365 + 120 + 15, JoiningDate) AS BonusPaymentDate
FROM
EmployeeBonus
)


SELECT * ,
DATENAME(WEEKDAY, BonusPaymentDate) AS WeekdayName,
DATEPART(WEEK, BonusPaymentDate) AS WeekOfYear,
DATEPART(DAYOFYEAR, BonusPaymentDate) AS DayOfYear,
(DATEPART(DAY, BonusPaymentDate) - 1) / 7 + 1 AS WeekOfMonth
from EmployeeData
;



/*3}
1. Service Type 1. Employee Type 1. Minimum service is 10. Minimum service left should be 15 Years. Retirement age will be 60
Years
2. Service Type 1. Employee Type 2. Minimum service is 12. Minimum service left should be 14 Years . Retirement age will be 55
Years
3. Service Type 1. Employee Type 3. Minimum service is 12. Minimum service left should be 12 Years . Retirement age will be 55
Years
3. for Service Type 2,3,4 Minimum Service should Be 15 and Minimum service left should be 20 Years . Retirement age will be 65
Years
Write a query to find out the employees who are eligible for the bonus.
*/

CREATE TABLE EMPB(ID INT,SERVICETYPE INT,EMPTYPE INT,JOININGDATE DATE,SAL INT,RETIREMENT INT, MINIMUM_SERVICE INT,DOB DATE)
INSERT INTO EMPB (ID, SERVICETYPE, EMPTYPE, JOININGDATE, SAL, RETIREMENT, MINIMUM_SERVICE,DOB)
VALUES
  (1, 1, 1, '2015-01-01', 50000, 65, 30,'1995-01-10'),
  (2, 2, 2, '2010-02-14', 60000, 60, 20,'1995-01-10'),
  (3, 3, 2, '2012-03-15', 70000, 53, 30,'1995-01-10'),

  (4, 1, 2, '2010-12-25', 45000, 62, 30,'1995-01-10'),
  (5, 2, 3, '2009-11-01', 55000, 58, 30,'1995-01-10'),
  (6, 3, 1, '2001-10-09', 65000, 53, 20,'1995-01-10'),

  (7, 4, 2, '2002-04-20', 40000, 68, 50,'1995-01-10'),
  (8, 3, 3, '2003-05-23', 50000, 63, 8,'1995-01-10'),
  (9, 4, 2, '2004-06-12', 60000, 53, 50,'1995-01-10'),

  (10, 2, 2, '2004-07-04', 45000, 60, 8,'1995-01-10'),
  (11, 1, 3, '2003-08-17', 55000, 65, 8,'1995-01-10'),
  (12, 2, 1, '2003-09-08', 65000, 53, 9,'1995-01-10'),

  (13, 3, 1, '2003-01-01', 75000, 55, 20,'1995-01-10'),
  (14, 4, 2, '2004-12-24', 40000, 68, 15,'1995-01-10'),
  (15, 1, 1, '2009-11-19', 50000, 53, 80,'1995-01-10');
SELECT * FROM EMPB 


SELECT 
  CASE WHEN SERVICETYPE = 1 AND EMPTYPE = 1 AND DATEDIFF(YEAR, JOININGDATE, GETDATE()) >= 10 AND MINIMUM_SERVICE >= 15 THEN E.ID
    WHEN SERVICETYPE = 1 AND EMPTYPE = 2 AND DATEDIFF(YEAR,JOININGDATE, GETDATE() ) >= 12 AND MINIMUM_SERVICE >= 14 THEN E.ID
    WHEN SERVICETYPE = 1 AND EMPTYPE = 3 AND DATEDIFF(YEAR,JOININGDATE, GETDATE()) >= 12 AND MINIMUM_SERVICE >= 12 THEN E.ID
    WHEN SERVICETYPE IN (2, 3, 4) AND DATEDIFF(YEAR,JOININGDATE, GETDATE()) >= 15 AND MINIMUM_SERVICE >= 20 THEN E.ID
    ELSE NULL
	  END AS ID
FROM EMPB E;


/*4.write a query to Get Max, Min and Average age of employees, service of employees by service Type , Service Status for each Centre(display in years and Months)*/

SELECT
SERVICETYPE,
CENTER,
MAX(CAST(DATEDIFF(YEAR, DOB, GETDATE()) AS VARCHAR) + ' years ' + RIGHT('0' + CAST(DATEDIFF(MONTH, DATEADD(YEAR, DATEDIFF(YEAR, DOB, GETDATE()), DOB), GETDATE()) % 12 AS VARCHAR), 2) + ' months') AS max_age,
MIN(CAST(DATEDIFF(YEAR, DOB, GETDATE()) AS VARCHAR) + ' years ' + RIGHT('0' + CAST(DATEDIFF(MONTH, DATEADD(YEAR, DATEDIFF(YEAR, DOB, GETDATE()), DOB), GETDATE()) % 12 AS VARCHAR), 2) + ' months') AS min_age,
CAST(AVG(DATEDIFF(YEAR, DOB, GETDATE())) AS VARCHAR) + ' years ' + 
RIGHT('0' + CAST(AVG(DATEDIFF(MONTH, DATEADD(YEAR, DATEDIFF(YEAR, DOB, GETDATE()), DOB), GETDATE()) % 12) AS VARCHAR), 2) + ' months' AS avg_age,
MAX(CAST(DATEDIFF(YEAR, JOININGDATE, GETDATE()) AS VARCHAR) + ' years ' + RIGHT('0' + CAST(DATEDIFF(MONTH, DATEADD(YEAR, DATEDIFF(YEAR, JOININGDATE, GETDATE()), JOININGDATE), GETDATE()) % 12 AS VARCHAR), 2) + ' months') AS max_service,
MIN(CAST(DATEDIFF(YEAR, JOININGDATE, GETDATE()) AS VARCHAR) + ' years ' + RIGHT('0' + CAST(DATEDIFF(MONTH, DATEADD(YEAR, DATEDIFF(YEAR, JOININGDATE, GETDATE()), JOININGDATE), GETDATE()) % 12 AS VARCHAR), 2) + ' months') AS min_service,
CAST(AVG(DATEDIFF(YEAR, JOININGDATE, GETDATE())) AS VARCHAR) + ' years ' + 
RIGHT('0' + CAST(AVG(DATEDIFF(MONTH, DATEADD(YEAR, DATEDIFF(YEAR, JOININGDATE, GETDATE()), JOININGDATE), GETDATE()) % 12) AS VARCHAR), 2) + ' months' AS avg_service
FROM EMPC
GROUP BY SERVICETYPE, SERVICE_TYPE, CENTER;


/* 5. Write a query to list out all the employees where any of the words (Excluding Initials) in the Name starts and ends with the same
character. (Assume there are not more than 5 words in any name )    

EXCLUDED ALL INITIALS AND WORKED ONLY ON THE LAST WORD */
CREATE TABLE NAMES(ID INT, NAME VARCHAR(30));
INSERT INTO NAMES VALUES(1,'ALL PRA');
INSERT INTO NAMES VALUES(1,'APRA');
INSERT INTO NAMES VALUES(1,'PRAP');
INSERT INTO NAMES VALUES(1,'RRR');
INSERT INTO NAMES VALUES(1,'5PRA5');
INSERT INTO NAMES VALUES(1,'AHA HELLO YAAL BDID EEU');

SELECT *    
FROM NAMES
WHERE SUBSTRING(NAME, PATINDEX('% %', NAME)+1, 1 )  = RIGHT(NAME,1);

