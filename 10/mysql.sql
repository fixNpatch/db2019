USE streamlab
GO
IF EXISTS (SELECT * FROM sys.databases WHERE name='streamlab')
BEGIN
DROP DATABASE streamlab
END

--файл данных и файл журнала транзакций
CREATE DATABASE streamlab
ON PRIMARY
(NAME = N'streamlab', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\streamlab.mdf',
SIZE = 51200KB, FILEGROWTH = 10240KB)
LOG ON
(NAME = N'streamlab_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\streamlab_log.mdf',
SIZE = 10240KB, FILEGROWTH = 10%)
COLLATE Cyrillic_General_100_CI_AI
GO
ALTER DATABASE streamlab SET RECOVERY SIMPLE WITH NO_WAIT
GO
ALTER DATABASE streamlab SET AUTO_SHRINK OFF
GO
USE streamlab
GO

--быстроменяющиеся
ALTER DATABASE streamlab ADD FILEGROUP Fast_Growing
ALTER DATABASE streamlab ADD FILE
(NAME = N'streamlab_Fast_Growing', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\streamlab_Fast_Growing.ndf',
SIZE = 158400KB, FILEGROWTH = 21200KB) TO FILEGROUP Fast_Growing

--часто запрашиваемые
ALTER DATABASE streamlab ADD FILEGROUP Frequently_requested
ALTER DATABASE streamlab ADD FILE
(NAME = N'streamlab_Frequently_requested', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\streamlab_Frequently_requested.ndf',
SIZE = 158400KB, FILEGROWTH = 51200KB) TO FILEGROUP Frequently_requested

--медленно меняющиеся
ALTER DATABASE streamlab ADD FILEGROUP Slow_Growing
ALTER DATABASE streamlab ADD FILE
(NAME = N'streamlab_Slow_Growing', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\streamlab_Slow_Growing.ndf',
SIZE = 158400KB, FILEGROWTH = 20000KB) TO FILEGROUP Slow_Growing

--только для считывания
ALTER DATABASE streamlab ADD FILEGROUP Only_for_reading
ALTER DATABASE streamlab ADD FILE
(NAME = N'streamlab_Only_for_reading', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\streamlab_Only_for_reading.ndf',
SIZE = 100400KB, FILEGROWTH = 20000KB) TO FILEGROUP Only_for_reading

--секционирование
ALTER DATABASE streamlab ADD FILEGROUP Indices
ALTER DATABASE streamlab ADD FILE
(NAME = N'streamlab_Indices', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\streamlab_Indices.ndf',
SIZE = 100400KB, FILEGROWTH = 20000KB) TO FILEGROUP Indices


ALTER DATABASE streamlab ADD FILEGROUP My_Default
ALTER DATABASE streamlab ADD FILE
(NAME = N'streamlab_My_Default', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\streamlab_My_Default.ndf',
SIZE = 100400KB, FILEGROWTH = 20000KB) TO FILEGROUP My_Default


DROP PARTITION SCHEME PartFunction_fact_activities
DROP PARTITION FUNCTION PartFunction_fact_activities
DROP PARTITION SCHEME PartFunctionArchival
DROP PARTITION FUNCTION PartFunctionArchival

CREATE PARTITION FUNCTION PartFunction_fact_activities(bigint)
AS RANGE RIGHT FOR VALUES(20160101, 20170101, 20180101, 20190101)

CREATE PARTITION SCHEME PartFunction_fact_activities
AS PARTITION PartFunction_fact_activities TO
(Fast_Growing, Fast_Growing, Frequently_requested, Frequently_requested, Frequently_requested)


CREATE PARTITION FUNCTION PartFunctionArchival(bigint)
AS RANGE RIGHT FOR VALUES(20160101, 20170101, 20180101, 20190101)


CREATE PARTITION SCHEME PartFunctionArchival
AS PARTITION PartFunctionArchival TO
(Fast_Growing, Fast_Growing, Frequently_requested, Frequently_requested, Frequently_requested)


SELECT * FROM Sys.Partitions
WHERE OBJECT_ID = (SELECT OBJECT_ID FROM Sys.Tables WHERE name = 'Fact_Order')

SELECT * FROM Sys.Partitions
WHERE OBJECT_ID = (SELECT OBJECT_ID FROM Sys.Tables WHERE name = 'Archive')


--need to add FK's
CREATE TABLE [fact_activities] (
	c_activity_id bigint NOT NULL,
	fk_subscriber_id bigint NOT NULL,
	fk_bloger_id bigint NOT NULL,
	fk_donate_id bigint NOT NULL,
	fk_date_id bigint NOT NULL,
	fk_platform_id bigint NOT NULL,
	fk_content_id bigint NOT NULL,
	CONSTRAINT [PK_FACT_ACTIVITIES] PRIMARY KEY (c_activity_id, fk_date_id)
)ON PartFunction_fact_activities(fk_date_id)
GO

--drop  TABLE [fact_activities]


CREATE TABLE [Archive] (
	c_activity_id bigint IDENTITY(1,1) NOT NULL,
	fk_subscriber_id bigint NOT NULL,
	fk_bloger_id bigint NOT NULL,
	fk_donate_id bigint NOT NULL,
	fk_date_id bigint NOT NULL,
	fk_platform_id bigint NOT NULL,
	fk_content_id bigint NOT NULL,
	CONSTRAINT [PK_FACT_ACTIVITIES1] PRIMARY KEY (c_activity_id, fk_date_id)
)ON PartFunction_fact_activities(fk_date_id)
GO

CREATE TABLE [dim_date] (
	Data_Key bigint NOT NULL,
	Date date NOT NULL,
	Year int NOT NULL,
	Quarter int NOT NULL,
	Month int NOT NULL,
	Week int NOT NULL,
	Day int NOT NULL,
	CONSTRAINT [PK_DIMDATE] PRIMARY KEY (Data_Key)
)ON Fast_Growing
GO

CREATE TABLE [dim_bloggers] (
	c_blogger_id bigint IDENTITY(1,1) NOT NULL,
	c_first_name nvarchar(50) NOT NULL,
	c_second_name nvarchar(50) NOT NULL,
	s_middle_name nvarchar(50) NOT NULL,
	c_nick_name nvarchar(50) NOT NULL,
	c_phone nvarchar(13) NOT NULL,
	c_country nvarchar(50) NOT NULL,
	c_city nvarchar(50) NOT NULL,
	c_address nvarchar(50) NOT NULL,
	Experience int,
	flag nvarchar(50),
	CONSTRAINT [PK_DIM_BLOGGERS] PRIMARY KEY (c_blogger_id)
)ON Slow_Growing
GO


-- ID_key ????
CREATE TABLE [dim_subscribers] (
	ID_Key int NOT NULL,
	c_subscriber_id bigint IDENTITY(1,1) NOT NULL,
	c_nick_name nvarchar(50) NOT NULL,
	c_country nvarchar(50) NOT NULL,
	c_city nvarchar(50) NOT NULL,
	c_sex nvarchar(50) NOT NULL,
	c_phone nvarchar(10) NOT NULL,
	flag nvarchar(50) NOT NULL,
  CONSTRAINT [PK_DIM_SUBSCRIBERS] PRIMARY KEY (c_subscriber_id)
)ON Slow_Growing

CREATE TABLE [dim_platforms] (
	c_platform_id bigint IDENTITY(1,1) NOT NULL,
	Type nvarchar(100),
	c_platform_name float,
	CONSTRAINT [PK_DIM_PLATFORMS] PRIMARY KEY (c_platform_id)
)ON Frequently_requested
GO

CREATE TABLE [dim_donations] (
	c_donation_id bigint IDENTITY(1,1) NOT NULL,
	Type nvarchar(100),
	c_sum int NOT NULL,
  CONSTRAINT [PK_DIM_DONATIONS] PRIMARY KEY (c_donation_id)
)ON Only_for_reading
GO

CREATE TABLE [dim_contents] (
	c_content_id bigint IDENTITY(1,1) NOT NULL,
	Type nvarchar(50),
	Size nvarchar(100),
	c_name nvarchar(100),
	c_tags nvarchar(100),
	flag nvarchar(50) NOT NULL,
	CONSTRAINT [PK_DIM_CONTENTS] PRIMARY KEY (c_content_id)
)ON Fast_Growing
GO

-- fk_subscriber_id
-- fk_bloger_id
-- fk_donate_id
-- fk_date_id
-- fk_platform_id
-- fk_content_id

ALTER TABLE [fact_activities] ADD CONSTRAINT [FK_fact_activities_subs_id] FOREIGN KEY ([fk_subscriber_id]) REFERENCES [dim_subscribers]([c_subscriber_id])
ALTER TABLE [fact_activities] ADD CONSTRAINT [FK_fact_activities_blog_id] FOREIGN KEY ([fk_bloger_id]) REFERENCES [dim_bloggers]([c_blogger_id])
ALTER TABLE [fact_activities] ADD CONSTRAINT [FK_fact_activities_plat_id] FOREIGN KEY ([fk_platform_id]) REFERENCES [dim_platforms]([c_platform_id])
ALTER TABLE [fact_activities] ADD CONSTRAINT [FK_fact_activities_donate_id] FOREIGN KEY ([fk_donate_id]) REFERENCES [dim_donations]([c_donation_id])
ALTER TABLE [fact_activities] ADD CONSTRAINT [FK_fact_activities_date_id] FOREIGN KEY ([fk_date_id]) REFERENCES [dim_date]([Data_Key])
ALTER TABLE [fact_activities] ADD CONSTRAINT [FK_fact_activities_content_id] FOREIGN KEY ([fk_content_id]) REFERENCES [dim_contents]([c_content_id])


Select * from fact_activities
Select * from dim_subscribers
Select * from dim_bloggers
Select * from dim_platforms
Select * from dim_donations
Select * from dim_date
Select * from dim_contents

--Скользящее окно--
SELECT
	prt.partition_number,
	prt.rows,
	flg.name name_filegroung
FROM sys.partitions prt
	JOIN sys.indexes idx ON prt.object_id = idx.object_id
	JOIN sys.data_spaces dts ON dts.data_space_id = idx.data_space_id
	LEFT JOIN sys.partition_schemes prs ON prs.data_space_id = dts.data_space_id
	LEFT JOIN sys.partition_range_values prv ON prv.function_id = prs.function_id AND prv.boundary_id = prt.partition_number - 1
	LEFT JOIN sys.destination_data_spaces dds ON dds.partition_scheme_id = prs.data_space_id AND dds.destination_id = prt.partition_number
	LEFT JOIN sys.filegroups flg ON flg.data_space_id = dds.data_space_id
WHERE prt.object_id = (SELECT object_id FROM Sys.Tables WHERE name = 'Archive')

--fact_activities Archive

SELECT * from fact_activities

DROP Procedure Pr_SlidingWindow

CREATE PROCEDURE Pr_SlidingWindow
AS
DECLARE @DayForMaxPartFactSales VARCHAR(8)
DECLARE @DayForMaxPartArchival VARCHAR(8)
DECLARE @DayForMinPartFactSales VARCHAR(8)
DECLARE @DayForMinPartArchival VARCHAR(8)

SET @DayForMaxPartFactSales = CAST((SELECT TOP 1 [value] FROM
sys.partition_range_values
 WHERE function_id = (SELECT function_id
 FROM sys.partition_functions
 WHERE name = 'PartFunction_Fact_Order')
 ORDER BY boundary_id DESC) AS VARCHAR(8))
SET @DayForMaxPartArchival = CAST((SELECT TOP 1 [value] FROM
sys.partition_range_values
 WHERE function_id = (SELECT function_id
 FROM sys.partition_functions
 WHERE name = 'PartFunctionArchival')
 ORDER BY boundary_id DESC) AS VARCHAR(8))

 DECLARE @Day_DT DATE
SET @Day_DT = DATEADD(YEAR, 1, CAST(@DayForMaxPartFactSales AS DATE))
DECLARE @DayArchival_DT DATE
SET @DayArchival_DT = DATEADD(YEAR, 1, CAST(@DayForMaxPartArchival AS
DATE))

ALTER PARTITION SCHEME PartFunction_Fact_Order
NEXT USED [Frequently_Requested];
ALTER PARTITION SCHEME PartFunctionArchival
NEXT USED [Frequently_Requested]

ALTER PARTITION FUNCTION PartFunction_Fact_Order()
SPLIT RANGE (CAST(CONVERT (VARCHAR(8),@Day_DT, 112) AS BIGINT))
ALTER PARTITION FUNCTION PartFunctionArchival()
SPLIT RANGE (CAST(CONVERT (VARCHAR(8),@DayArchival_DT, 112) AS BIGINT))

ALTER TABLE Fact_Order
SWITCH PARTITION 2
TO Archive PARTITION 2

SET @DayForMinPartFactSales = CAST((SELECT TOP 1 [value] FROM
sys.partition_range_values
 WHERE function_id = (SELECT function_id
 FROM sys.partition_functions
 WHERE name = 'PartFunction_Fact_Order')
 ORDER BY boundary_id) AS VARCHAR(8))
SET @DayForMinPartArchival = CAST((SELECT TOP 1 [value] FROM
sys.partition_range_values
 WHERE function_id = (SELECT function_id
 FROM sys.partition_functions
 WHERE name = 'PartFunctionArchival')
 ORDER BY boundary_id) AS VARCHAR(8))
ALTER PARTITION FUNCTION PartFunction_Fact_Order()
MERGE RANGE (CAST(@DayForMinPartFactSales AS BIGINT));
ALTER PARTITION FUNCTION PartFunctionArchival()
MERGE RANGE (CAST(@DayForMinPartArchival AS BIGINT));

EXECUTE Pr_SlidingWindow

--индексы

SET STATISTICS IO ON
SET STATISTICS TIME ON
SELECT [Week], [Year] FROM [dim_date] WHERE [Year] > 2000 AND [Week] >= -2147483648
SET STATISTICS TIME OFF
SET STATISTICS IO OFF

--удаление первичный ключ
ALTER TABLE [Archive]
DROP CONSTRAINT PK_FACT_ACTIVITIES1;
GO
--возвращение ключей
ALTER TABLE [Archive]
ADD CONSTRAINT PK_FACT_ACTIVITIES1 PRIMARY KEY (c_activity_id, fk_date_id);
GO

SELECT fk_bloger_id from Archive WHERE fk_bloger_id = 1

DROP INDEX ind_1 ON [Archive]
CREATE CLUSTERED COLUMNSTORE INDEX ind_1 ON Archive
SELECT * FROM [Archive] WHERE fk_bloger_id = 1

DROP INDEX col_2 ON [Archive]
CREATE NONCLUSTERED COLUMNSTORE INDEX col_2 ON Archive (fk_bloger_id)
SELECT * FROM [Archive] WHERE fk_bloger_id = 1

DROP INDEX ind2 ON [Archive]
CREATE NONCLUSTERED INDEX ind2 ON [Archive] (fk_bloger_id, fk_platform_id) ON Indices
SELECT c_activity_id FROM Archive WHERE fk_bloger_id = 1 OR fk_platform_id = 2;

DROP INDEX col_3 ON [dim_subscribers]
CREATE NONCLUSTERED INDEX col_3 ON [dim_subscribers] (flag) ON Indices
SELECT * FROM [dim_subscribers] WHERE flag = '2'

DROP INDEX col_4 ON [dim_date]
CREATE NONCLUSTERED INDEX col_4 ON [dim_date](Month,Day)
SELECT [Day] from [dim_date] WHERE Month = 10

DROP INDEX col_5 ON [dim_contents]
CREATE NONCLUSTERED INDEX col_5 ON [dim_contents] (flag) ON Indices
SELECT * FROM [dim_contents] WHERE flag = '927197Z280E77DK'

DROP INDEX col_6 ON [dim_bloggers]
CREATE NONCLUSTERED INDEX col_6 ON dim_bloggers (c_blogger_id, c_city) ON Indices
SELECT * FROM [dim_bloggers] WHERE c_blogger_id > 20 AND c_city = 'Ashland'




DELETE FROM dim_date
Delete From fact_activities
Delete From Archive
Delete From dim_subscribers
Delete From dim_bloggers
Delete From dim_platforms
Delete From dim_contents
Delete From dim_donations

Select * from fact_activities