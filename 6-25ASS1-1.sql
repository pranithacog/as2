===========================================================1=============================================================================
CREATE FUNCTION RES(
 @I VARCHAR(255)
 )
 RETURNS VARCHAR(255)
 AS 
 BEGIN
 DECLARE @IDX INT =Patindex('%[^0-9]%',@I)
 BEGIN
 WHILE @IDX>0
 BEGIN 
 SET @I=STUFF(@I,@IDX,1,'')
 SET @IDX=Patindex('%[^0-9]%',@I)
 END
 END
 RETURN isnull(@I,0)
 END

 CREATE TABLE NUM(A VARCHAR(20))
INSERT INTO NUM VALUES('DUG3186');
INSERT INTO NUM VALUES('DUGS872128XHZ838');
SELECT [dbo].[RES](A) AS extracted_numerics
FROM NUM;
 
SELECT * FROM NUM
==================================================================2================================================================
CREATE TABLE qn2 (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    RestrictedColumn AS (1 / 0) 
);

INSERT INTO qn2 (ID, NAME) VALUES (1, 'Jack'),(2,'rose');

SELECT * FROM qn2;

SELECT ID, NAME FROM qn2;


================================================================3=============================================================

DECLARE @Date DATE='2017-5-1'
DECLARE @TEMP VARCHAR(30);

SET @TEMP=
  CASE WHEN @Date = CAST(YEAR(@Date) AS varchar(4)) + '-01-01' THEN 1  
       ELSE DATEDIFF(day, CAST(YEAR(@Date) AS varchar(4)) + '-01-01', @Date) + 1  
  END
  
================================================================4==================================================================
create table cal(CALENDAR VARCHAR(30),DATA VARCHAR(30));
 

INSERT INTO cal VALUES ('DayofYear',NULL),('Week',NULL),('DayofWeek',NULL),('Month','-12'),('DayofMonth','-30/31');
 
DECLARE @Date DATE='2017-12-1'
DECLARE @TEMP VARCHAR(30);

SET @TEMP=
  CASE WHEN @Date = CAST(YEAR(@Date) AS varchar(4)) + '-01-01' THEN 1  
       ELSE DATEDIFF(day, CAST(YEAR(@Date) AS varchar(4)) + '-01-01', @Date) + 1  
  END
 

DECLARE @N INT= CAST(@TEMP AS INT)
DECLARE @N2 INT= CAST(@TEMP AS INT)
SET @N=CEILING(@N/7)

UPDATE cal SET DATA=CONCAT(@TEMP,'-365/366') WHERE(CALENDAR='DayofYear')
DECLARE @TEMP2 VARCHAR(30)=CAST(@N AS varchar(30))

UPDATE cal SET DATA=@TEMP2+'-52/53' WHERE (CALENDAR='Week')

SET @N2 =@N2%7
SET @TEMP2=CAST(@N2 AS VARCHAR(30))
UPDATE cal SET DATA=@TEMP2+'-7' WHERE (CALENDAR='DayofWeek');

UPDATE cal SET DATA = CAST(MONTH(@Date) AS VARCHAR(2)) + '-12' WHERE CALENDAR = 'Month';
UPDATE cal SET DATA = CAST(DAY(@Date) AS VARCHAR(2)) + '-30/31' WHERE CALENDAR = 'DayOfMonth';
SELECT * FROM cal

=================================================================5============================================================
