--1- Реализация операций над множествами (UNION, UNION ALL, EXCEPT, INTERSECT)
-- все Заказы и фамилии клиентов, сделавших эти заказы, со стоимостью от 5000 до 20 000 ИЛИ оформленных после 2017-09-10 , кроме тех, в которых тариф "Эконом"

SELECT Ordering.ID_order, The_client.Surname, Ordering.Date_of_order, Ordering.The_price, Ordering.ID_tariff FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
INNER JOIN The_tariff ON Ordering.ID_tariff = The_tariff.ID_tariff
WHERE Ordering.The_price BETWEEN 5000 AND 20000
UNION --ИЛИ
SELECT Ordering.ID_order, The_client.Surname, Ordering.Date_of_order, Ordering.The_price, Ordering.ID_tariff FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
INNER JOIN The_tariff ON Ordering.ID_tariff = The_tariff.ID_tariff
WHERE Ordering.Date_of_order > '2017-09-10'
EXCEPT --КРОМЕ
SELECT Ordering.ID_order, The_client.Surname, Ordering.Date_of_order, Ordering.The_price, Ordering.ID_tariff FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
INNER JOIN The_tariff ON Ordering.ID_tariff = The_tariff.ID_tariff
WHERE The_tariff.Name_tariff='Эконом'

-- все Заказы и фамилии клиентов, сделавших эти заказы, со стоимостью от 5000 до 20 000 И оформленных после 2017-09-10 , кроме тех, в которых тариф "Эконом"

SELECT Ordering.ID_order, The_client.Surname, Ordering.Date_of_order, Ordering.The_price, Ordering.ID_tariff FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
INNER JOIN The_tariff ON Ordering.ID_tariff = The_tariff.ID_tariff
WHERE Ordering.The_price BETWEEN 5000 AND 20000
INTERSECT --И
SELECT Ordering.ID_order, The_client.Surname, Ordering.Date_of_order, Ordering.The_price, Ordering.ID_tariff FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
INNER JOIN The_tariff ON Ordering.ID_tariff = The_tariff.ID_tariff
WHERE Ordering.Date_of_order > '2017-09-10'
EXCEPT --КРОМЕ
SELECT Ordering.ID_order, The_client.Surname, Ordering.Date_of_order, Ordering.The_price, Ordering.ID_tariff FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
INNER JOIN The_tariff ON Ordering.ID_tariff = The_tariff.ID_tariff
WHERE The_tariff.Name_tariff='Эконом'


--2- Запрос с использованием автономных подзапросов
--Вывод всех заказов, внесённая предоплата которых превышает среднюю

SELECT Ordering.ID_order, The_client.Surname, Ordering.Prepayment, Ordering.ID_tariff FROM Ordering
INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
WHERE Ordering.Prepayment > (SELECT AVG(Prepayment) FROM Ordering)

--3- Сщздание запроса с использованием коррелированных подзапросов в предложении SELECT и WHERE
--Вывод заказов материала у которых стоимость превышает среднюю ддя конкретного поставщика

SELECT Ord.ID_orderieng_of_material, Ord.The_price, Supplier.Name_supplier FROM Ordering_of_matarial Ord
INNER JOIN  Supplier ON Ord.ID_supplier=Supplier.ID_supplier
WHERE Ord.The_price > (SELECT AVG(The_price) FROM Ordering_of_matarial WHERE ID_supplier=Ord.ID_supplier )


--4- Зпрос с использованием временных таблиц.
-- Вывод некоторых данных из таблици работников вновую таблицу с целью возможного дальнейшего использования и преобразования

SELECT ID_seamstress, Surname, The_phone_number
INTO #New_table  FROM Seamstress
SELECT * FROM #New_table
DROP TABLE #New_table

--5- Запрос с использованием обобщенных табличных выражений (CTE((общее табличное выражение) позволяет в рамках запроса задать таблицу, на которую можно многократно ссылаться)).
-- Вывод VIP клиентов, которые совершили заказ на сумму более 3000 в новую таблицу

WITH OrderingVIP AS ( 
	SELECT Ordering.ID_order, The_client.Surname, Ordering.The_price, Ordering.ID_tariff FROM Ordering
	INNER JOIN  The_client ON Ordering.ID_client = The_client.ID_client
	WHERE Ordering.ID_tariff = 3 AND Ordering.The_price >= 3000 )
SELECT * FROM OrderingVIP

--6- Слияние данных (INSERT, UPDATE) c помощью инструкции MERGE.
-- Создание дополнительной таблицы поставщиков, и её слияние с основной таблицей, если там нет этого постащика.

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
 ('Шелковый путь', '+7-9122040310', 'г. Екатеринбург'),
 ('ООО Красота', '+7-3333335555', 'г. Самара'),
 ('ООО "Капитал Текс"', '+7-8889997744', 'г. Иваново'),
 ('ООО  "СТАЙЛ ОФ САЙЛ"', '+7-1012023344', 'г. Москва'),
 ('ООО "ЛентаБел"', '+7-1012023344', 'г. Москва')

 
 MERGE INTO Supplier AS A
 USING Supplier02 AS B ON (A.Name_supplier = B.Name_supplier)
 WHEN MATCHED THEN UPDATE SET  Name_supplier=B.Name_supplier, The_phone_number=B.The_phone_number, The_city=B.The_city
 WHEN NOT MATCHED THEN INSERT (ID_supplier, Name_supplier, The_phone_number, The_city)
 VALUES (B.ID_supplier+7, B.Name_supplier, B.The_phone_number, B.The_city);
SET IDENTITY_INSERT Supplier ON

SELECT * FROM Supplier
SELECT * FROM Supplier02


--7- Запрос с использованием оператора PIVOT.
--8- Запрос с использованием оператора UNPIVOT.
-- Создаёт временную таблицу1 заказов: Клиент/Стоимость_заказа/Тариф; 
-- Выводит временную таблицу2 клиентов: Клиент/Сумма_стоимостей_заказов_по_всем_тарифам (PIVOT/сворачивает таблицу1) ;
-- Выводит таблицу клиентов: Клиент/Тариф/Сумма_стоимостей_заказов_по_заданному_тарифу (UNPIVOT/разворачивает таблицу2).

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

--9- Запрос с использованием GROUP BY с операторами ROLLUP, CUBE и GROUPING SETS.
--Групировка по швеям, выполняемым заказы за оперделённый год и итог

SELECT Ordering.ID_order, Ordering.ID_seamstress, Seamstress.Surname, Seamstress.The_percentage_of_the_price,  Ordering.The_price, Ordering.Date_of_order,  (DATEDIFF(year, 0000-00-00, Ordering.Date_of_order) + 1900) AS Year_of_order INTO #Tb_3 FROM Ordering
INNER JOIN  Seamstress ON Ordering.ID_seamstress = Seamstress.ID_seamstress
SELECT * FROM #Tb_3

SELECT  Surname, Year_of_order , SUM(The_price * The_percentage_of_the_price /100) AS Pay FROM #Tb_3
GROUP BY 
ROLLUP ( Surname,  Year_of_order) -- формирует промежуточные итоги для каждого указанного элемента и общий итог

SELECT  Surname, Year_of_order , SUM(The_price * The_percentage_of_the_price /100) AS Pay FROM #Tb_3
GROUP BY 
CUBE ( Surname,  Year_of_order) --  формирует результаты для всех возможных перекрестных вычислений

SELECT  Surname, Year_of_order , SUM(The_price * The_percentage_of_the_price /100) AS Pay FROM #Tb_3
GROUP BY 
GROUPING SETS ( Surname,  Year_of_order) -- формирует результаты нескольких группировок в один набор данных

DROP TABLE #Tb_3

--10- Секционирование с использованием OFFSET FETCH. (предоставляет возможность выбирать из результирующего набора только такой объем данных, который требуется для заполнения)
--Сортировка клиентов по фамилии и вывести только 3-их, пропустив первых 5

SELECT * FROM The_client
ORDER BY Surname
OFFSET 5 ROW
FETCH FIRST 3 ROWS ONLY

SELECT * FROM The_client
ORDER BY Surname

--11- Запросы с использованием ранжирующих оконных функций.  ROW_NUMBER() нумерация строк. Использовать для нумерации внутри групп. RANK(), DENSE_RANK(), NTILE ().
-- Возвращение значения для каждой строки группы в результирующем наборе данных в таблице заказов материала
SELECT Ordering_of_matarial.ID_orderieng_of_material, Ordering_of_matarial.ID_order, Ordering_of_matarial.ID_supplier, Supplier.Name_supplier, Ordering_of_matarial.The_price INTO #Tb_4 FROM Ordering_of_matarial
INNER JOIN  Supplier ON Ordering_of_matarial.ID_supplier = Supplier.ID_supplier
SELECT * FROM #Tb_4

--Сортирует по номеру самого заказа, для которого нужен материал
SELECT *, 
ROW_NUMBER() OVER (ORDER BY ID_order DESC) AS [ROW_NUMBER], --возвращает просто номер строки
RANK() OVER (ORDER BY ID_order DESC) AS [RANK], --возвращает ранг каждой строки (анализ значений и в случае нахождения одинаковых возвращает одинаковый ранг с пропуском следующего)
DENSE_RANK () OVER (ORDER BY ID_order DESC) AS [DENSE_RANK], --возвращает ранг каждой строки (в случае нахождения одинаковых значений возвращает ранг без пропуска следующего)
NTILE(3) OVER (ORDER BY ID_order DESC) AS [NTILE] --делит результирующий набор на группы по определенному столбцу (количество групп указывается в качестве параметра)
FROM #Tb_4 

--Групирует по поставщику и сортирует по стоимости заказа 
SELECT *, 
ROW_NUMBER() OVER (PARTITION BY ID_supplier ORDER BY The_price DESC) AS [ROW_NUMBER], --возвращает просто номер строки
RANK() OVER (PARTITION BY ID_supplier ORDER BY The_price DESC) AS [RANK], --возвращает ранг каждой строки
DENSE_RANK () OVER (PARTITION BY ID_supplier ORDER BY The_price DESC) AS [DENSE_RANK], --возвращает ранг каждой строки
NTILE(3) OVER (PARTITION BY ID_supplier ORDER BY The_price DESC) AS [NTILE] --делит результирующий набор на группы по определенному столбцу
FROM #Tb_4 

DROP TABLE #Tb_4 

--12- Перенаправление ошибки в TRY/CATCH

 BEGIN TRY
 BEGIN TRANSACTION
 INSERT INTO Discont
 VALUES 
 ('2018-10-10', '2018-10-15', '40', 'День рождения пердприятия');
  COMMIT TRANSACTION
 PRINT 'Finish'
 END TRY
 BEGIN CATCH
 ROLLBACK
 PRINT 'Cancel'
 END CATCH

--13- Создание процедуры обработки ошибок в блоке CATCH с использованием функций ERROR

 BEGIN TRY
 BEGIN TRANSACTION
 INSERT INTO Discont
 VALUES
 ('2019-10-10', '2019-10-15', '40', 'День рождения пердприятия');
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

--14- Использование THROW, чтобы передать сообщение об ошибке клиенту

 BEGIN TRY
 BEGIN TRANSACTION
 INSERT INTO Discont
 VALUES
('2017-10-10', '2017-10-15', '40', 'День рождения пердприятия');
 COMMIT TRANSACTION
 PRINT 'Finish'
 END TRY
 BEGIN CATCH
 ROLLBACK
 PRINT 'Cancel';
 THROW;
 END CATCH;

--15- Контроль транзакций с BEGIN и COMMIT

BEGIN TRANSACTION;
DELETE FROM The_client WHERE ID_client = 176;
COMMIT;

SELECT * FROM The_client;

--16- Использование XACT_ABORT

SET XACT_ABORT OFF;
GO
BEGIN TRANSACTION;
INSERT INTO Discont VALUES ('2016-02-10', '2016-02-15', '30', 'Акция: выгодная неделя');
INSERT INTO Discont VALUES ('2016-07-10', '2016-07-15', '30', 'Акция: выгодная неделя');
COMMIT TRANSACTION;
GO 

SET XACT_ABORT ON;
GO
BEGIN TRANSACTION;
INSERT INTO Discont VALUES ('2016-05-10', '2016-05-15', '30', 'Акция: выгодная неделя');
COMMIT TRANSACTION;
GO 

--17- Добавление логики обработки транзакций в блоке CATCH.

BEGIN TRY
BEGIN TRANSACTION
INSERT INTO Discont
VALUES 
('2016-10-10', '2016-10-15', '40', 'День рождения пердприятия');
COMMIT TRANSACTION
PRINT 'Finish'
END TRY  
BEGIN CATCH  
    SELECT  
		ID_discont FROM Discont; 
END CATCH;  
GO 
