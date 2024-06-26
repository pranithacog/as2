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
