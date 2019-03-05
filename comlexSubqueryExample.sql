--1- ���������� �������� ��� ����������� (UNION, UNION ALL, EXCEPT, INTERSECT)
-- ��� ������ � ������� ��������, ��������� ��� ������, �� ���������� �� 5000 �� 20 000 ��� ����������� ����� 2017-09-10 , ����� ���, � ������� ����� "������"

SELECT Ordering.ID_order, The_client.Surname, Ordering.Date_of_order, Ordering.The_price, Ordering.ID_tariff FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
INNER JOIN The_tariff ON Ordering.ID_tariff = The_tariff.ID_tariff
WHERE Ordering.The_price BETWEEN 5000 AND 20000
UNION --���
SELECT Ordering.ID_order, The_client.Surname, Ordering.Date_of_order, Ordering.The_price, Ordering.ID_tariff FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
INNER JOIN The_tariff ON Ordering.ID_tariff = The_tariff.ID_tariff
WHERE Ordering.Date_of_order > '2017-09-10'
EXCEPT --�����
SELECT Ordering.ID_order, The_client.Surname, Ordering.Date_of_order, Ordering.The_price, Ordering.ID_tariff FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
INNER JOIN The_tariff ON Ordering.ID_tariff = The_tariff.ID_tariff
WHERE The_tariff.Name_tariff='������'

-- ��� ������ � ������� ��������, ��������� ��� ������, �� ���������� �� 5000 �� 20 000 � ����������� ����� 2017-09-10 , ����� ���, � ������� ����� "������"

SELECT Ordering.ID_order, The_client.Surname, Ordering.Date_of_order, Ordering.The_price, Ordering.ID_tariff FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
INNER JOIN The_tariff ON Ordering.ID_tariff = The_tariff.ID_tariff
WHERE Ordering.The_price BETWEEN 5000 AND 20000
INTERSECT --�
SELECT Ordering.ID_order, The_client.Surname, Ordering.Date_of_order, Ordering.The_price, Ordering.ID_tariff FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
INNER JOIN The_tariff ON Ordering.ID_tariff = The_tariff.ID_tariff
WHERE Ordering.Date_of_order > '2017-09-10'
EXCEPT --�����
SELECT Ordering.ID_order, The_client.Surname, Ordering.Date_of_order, Ordering.The_price, Ordering.ID_tariff FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
INNER JOIN The_tariff ON Ordering.ID_tariff = The_tariff.ID_tariff
WHERE The_tariff.Name_tariff='������'


--2- ������ � �������������� ���������� �����������
--����� ���� �������, �������� ���������� ������� ��������� �������

SELECT Ordering.ID_order, The_client.Surname, Ordering.Prepayment, Ordering.ID_tariff FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
WHERE Ordering.Prepayment > (SELECT AVG(Prepayment) FROM Ordering)

--3- �������� ������� � �������������� ��������������� ����������� � ����������� SELECT � WHERE
--����� ������� ��������� � ������� ��������� ��������� ������� ��� ����������� ����������

SELECT Ord.ID_orderieng_of_material, Ord.The_price, Supplier.Name_supplier FROM Ordering_of_matarial Ord
INNER JOIN  Supplier ON Ord.ID_supplier=Supplier.ID_supplier
WHERE Ord.The_price > (SELECT AVG(The_price) FROM Ordering_of_matarial WHERE ID_supplier=Ord.ID_supplier )


--4- ����� � �������������� ��������� ������.
-- ����� ��������� ������ �� ������� ���������� ������ ������� � ����� ���������� ����������� ������������� � ��������������

SELECT ID_seamstress, Surname, The_phone_number
INTO #New_table  FROM Seamstress
SELECT * FROM #New_table
DROP TABLE #New_table

--5- ������ � �������������� ���������� ��������� ��������� (CTE((����� ��������� ���������) ��������� � ������ ������� ������ �������, �� ������� ����� ����������� ���������)).
-- ����� VIP ��������, ������� ��������� ����� �� ����� ����� 3000 � ����� �������

WITH OrderingVIP AS ( 
	SELECT Ordering.ID_order, The_client.Surname, Ordering.The_price, Ordering.ID_tariff FROM Ordering
	INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
	WHERE Ordering.ID_tariff = 3 AND Ordering.The_price >= 3000 )
SELECT * FROM OrderingVIP

--6- ������� ������ (INSERT, UPDATE) c ������� ���������� MERGE.
-- �������� �������������� ������� �����������, � � ������� � �������� ��������, ���� ��� ��� ����� ���������.

CREATE TABLE Supplier02
(
	ID_supplier int IDENTITY(1,1) NOT NULL primary key,
	Name_supplier varchar(50) NOT NULL,
	The_phone_number varchar(20),
	The_city varchar(50),
)
GO
INSERT Supplier02
 (Name_supplier, The_phone_number, The_city)
 values
 ('�������� ����', '+7-9122040310', '�. ������������'),
 ('��� �������', '+7-3333335555', '�. ������'),
 ('��� "������� ����"', '+7-8889997744', '�. �������'),
 ('���  "����� �� ����"', '+7-1012023344', '�. ������'),
 ('��� "��������"', '+7-1012023344', '�. ������')

 
 MERGE INTO Supplier AS A
 USING Supplier02 AS B ON (A.Name_supplier = B.Name_supplier)
 WHEN MATCHED THEN UPDATE SET  Name_supplier=B.Name_supplier, The_phone_number=B.The_phone_number, The_city=B.The_city
 WHEN NOT MATCHED THEN INSERT (ID_supplier, Name_supplier, The_phone_number, The_city)
 VALUES (B.ID_supplier+7, B.Name_supplier, B.The_phone_number, B.The_city);
SET IDENTITY_INSERT Supplier ON

SELECT * FROM Supplier
SELECT * FROM Supplier02


--7- ������ � �������������� ��������� PIVOT.
--8- ������ � �������������� ��������� UNPIVOT.
-- ������ ��������� �������1 �������: ������/���������_������/�����; 
-- ������� ��������� �������2 ��������: ������/�����_����������_�������_��_����_������� (PIVOT/����������� �������1) ;
-- ������� ������� ��������: ������/�����/�����_����������_�������_��_���������_������ (UNPIVOT/������������� �������2).

SELECT The_client.ID_client, The_client.Surname, Ordering.The_price, Ordering.ID_tariff INTO #Tb_1 FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
SELECT * FROM #Tb_1


SELECT ID_client, Surname, [1], [2], [3] INTO #Tb_2 FROM #Tb_1
PIVOT 
( SUM (The_price)
FOR ID_tariff IN ([1], [2], [3])) AS Test_pivot;
SELECT * FROM #Tb_2

SELECT ID_client, Surname, ID_tariff, Summ_the_price FROM  #Tb_2
UNPIVOT
( Summ_the_price FOR ID_tariff IN ( [1],[2],[3])) AS Test_unpivot;

DROP TABLE #Tb_1
DROP TABLE #Tb_2

--9- ������ � �������������� GROUP BY � ����������� ROLLUP, CUBE � GROUPING SETS.
--���������� �� �����, ����������� ������ �� ����������� ��� � ����

SELECT Ordering.ID_order, Ordering.ID_seamstress, Seamstress.Surname, Seamstress.The_percentage_of_the_price,  Ordering.The_price, Ordering.Date_of_order,  (DATEDIFF(year, 0000-00-00, Ordering.Date_of_order) + 1900) AS Year_of_order INTO #Tb_3 FROM Ordering
INNER JOIN  Seamstress ON Ordering.ID_seamstress = Seamstress.ID_seamstress
SELECT * FROM #Tb_3

SELECT  Surname, Year_of_order , SUM(The_price * The_percentage_of_the_price /100) AS Pay FROM #Tb_3
GROUP BY 
ROLLUP ( Surname,  Year_of_order) -- ��������� ������������� ����� ��� ������� ���������� �������� � ����� ����

SELECT  Surname, Year_of_order , SUM(The_price * The_percentage_of_the_price /100) AS Pay FROM #Tb_3
GROUP BY 
CUBE ( Surname,  Year_of_order) --  ��������� ���������� ��� ���� ��������� ������������ ����������

SELECT  Surname, Year_of_order , SUM(The_price * The_percentage_of_the_price /100) AS Pay FROM #Tb_3
GROUP BY 
GROUPING SETS ( Surname,  Year_of_order) -- ��������� ���������� ���������� ����������� � ���� ����� ������

DROP TABLE #Tb_3

--10- ��������������� � �������������� OFFSET FETCH. (������������� ����������� �������� �� ��������������� ������ ������ ����� ����� ������, ������� ��������� ��� ����������)
--���������� �������� �� ������� � ������� ������ 3-��, ��������� ������ 5

SELECT * FROM The_client
ORDER BY Surname
OFFSET 5 ROW
FETCH FIRST 3 ROWS ONLY

SELECT * FROM The_client
ORDER BY Surname

--11- ������� � �������������� ����������� ������� �������.  ROW_NUMBER() ��������� �����. ������������ ��� ��������� ������ �����. RANK(), DENSE_RANK(), NTILE ().
-- ����������� �������� ��� ������ ������ ������ � �������������� ������ ������ � ������� ������� ���������
SELECT Ordering_of_matarial.ID_orderieng_of_material, Ordering_of_matarial.ID_order, Ordering_of_matarial.ID_supplier, Supplier.Name_supplier, Ordering_of_matarial.The_price INTO #Tb_4 FROM Ordering_of_matarial
INNER JOIN  Supplier ON Ordering_of_matarial.ID_supplier = Supplier.ID_supplier
SELECT * FROM #Tb_4

--��������� �� ������ ������ ������, ��� �������� ����� ��������
SELECT *, 
ROW_NUMBER() OVER (ORDER BY ID_order DESC) AS [ROW_NUMBER], --���������� ������ ����� ������
RANK() OVER (ORDER BY ID_order DESC) AS [RANK], --���������� ���� ������ ������ (������ �������� � � ������ ���������� ���������� ���������� ���������� ���� � ��������� ����������)
DENSE_RANK () OVER (ORDER BY ID_order DESC) AS [DENSE_RANK], --���������� ���� ������ ������ (� ������ ���������� ���������� �������� ���������� ���� ��� �������� ����������)
NTILE(3) OVER (ORDER BY ID_order DESC) AS [NTILE] --����� �������������� ����� �� ������ �� ������������� ������� (���������� ����� ����������� � �������� ���������)
FROM #Tb_4 

--��������� �� ���������� � ��������� �� ��������� ������ 
SELECT *, 
ROW_NUMBER() OVER (PARTITION BY ID_supplier ORDER BY The_price DESC) AS [ROW_NUMBER], --���������� ������ ����� ������
RANK() OVER (PARTITION BY ID_supplier ORDER BY The_price DESC) AS [RANK], --���������� ���� ������ ������
DENSE_RANK () OVER (PARTITION BY ID_supplier ORDER BY The_price DESC) AS [DENSE_RANK], --���������� ���� ������ ������
NTILE(3) OVER (PARTITION BY ID_supplier ORDER BY The_price DESC) AS [NTILE] --����� �������������� ����� �� ������ �� ������������� �������
FROM #Tb_4 

DROP TABLE #Tb_4 

--12- ��������������� ������ � TRY/CATCH

 BEGIN TRY
 BEGIN TRANSACTION
 INSERT INTO Discont
 VALUES 
 ('2018-10-10', '2018-10-15', '40', '���� �������� �����������');
  COMMIT TRANSACTION
 PRINT 'Finish'
 END TRY
 BEGIN CATCH
 ROLLBACK
 PRINT 'Cancel'
 END CATCH

--13- �������� ��������� ��������� ������ � ����� CATCH � �������������� ������� ERROR

 BEGIN TRY
 BEGIN TRANSACTION
 INSERT INTO Discont
 VALUES
 ('2019-10-10', '2019-10-15', '40', '���� �������� �����������');
 COMMIT TRANSACTION
 PRINT 'Finish'
 END TRY  
 BEGIN CATCH  
 ROLLBACK
    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  
GO 

--14- ������������� THROW, ����� �������� ��������� �� ������ �������

 BEGIN TRY
 BEGIN TRANSACTION
 INSERT INTO Discont
 VALUES
('2017-10-10', '2017-10-15', '40', '���� �������� �����������');
 COMMIT TRANSACTION
 PRINT 'Finish'
 END TRY
 BEGIN CATCH
 ROLLBACK
 PRINT 'Cancel';
 THROW;
 END CATCH;

--15- �������� ���������� � BEGIN � COMMIT

BEGIN TRANSACTION;
DELETE FROM The_client WHERE ID_client = 176;
COMMIT;

SELECT * FROM The_client;

--16- ������������� XACT_ABORT

SET XACT_ABORT OFF;
GO
BEGIN TRANSACTION;
INSERT INTO Discont VALUES ('2016-02-10', '2016-02-15', '30', '�����: �������� ������');
INSERT INTO Discont VALUES ('2016-07-10', '2016-07-15', '30', '�����: �������� ������');
COMMIT TRANSACTION;
GO 

SET XACT_ABORT ON;
GO
BEGIN TRANSACTION;
INSERT INTO Discont VALUES ('2016-05-10', '2016-05-15', '30', '�����: �������� ������');
COMMIT TRANSACTION;
GO 

--17- ���������� ������ ��������� ���������� � ����� CATCH.

BEGIN TRY
BEGIN TRANSACTION
INSERT INTO Discont
VALUES 
('2016-10-10', '2016-10-15', '40', '���� �������� �����������');
COMMIT TRANSACTION
PRINT 'Finish'
END TRY  
BEGIN CATCH  
    SELECT  
		ID_discont FROM Discont; 
END CATCH;  
GO 
