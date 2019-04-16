
--
-- Удалить данные из таблицы 'dbo.fact_activities'
--
TRUNCATE TABLE dbo.fact_activities
GO
--
-- Удалить данные из таблицы 'dbo.dim_bloggers'
--
DELETE dbo.dim_bloggers
GO
--
-- Удалить данные из таблицы 'dbo.dim_platforms'
--
DELETE dbo.dim_platforms
GO
--
-- Удалить данные из таблицы 'dbo.dim_contents'
--
DELETE dbo.dim_contents
GO
--
-- Удалить данные из таблицы 'dbo.dim_donations'
--
DELETE dbo.dim_donations
GO
--
-- Удалить данные из таблицы 'dbo.dim_date'
--
DELETE dbo.dim_date
GO
--
-- Удалить данные из таблицы 'dbo.dim_subscribers'
--
DELETE dbo.dim_subscribers
GO



--заполнение таблицы с датами +-7к

DECLARE @startday DATE = '2010-01-01' 
DECLARE @endday DATE = '2020-01-01' 
DECLARE @inc DATE 
SET @inc = @startday 

WHILE @inc <= @endday 
BEGIN 
INSERT INTO dim_date VALUES 
(CAST (CONVERT (VARCHAR(8), @inc, 112) AS INT), 
CONVERT(DATE, @inc, 104), 
year(@inc), 
datepart(qq, @inc), 
month(@inc), 
datepart(wk, @inc), 
day(@inc) 
) 

set @inc = dateadd(day, 1, @inc) 
end


--
-- Вставка данных в таблицу dbo.dim_subscribers
--
SET IDENTITY_INSERT dbo.dim_subscribers ON
GO
INSERT dbo.dim_subscribers(c_subscriber_id, ID_Key, c_nick_name, c_country, c_city, c_sex, c_phone, flag) VALUES (2, 2, 	N'Goetz1965', 		N'Russia', 		N'Moscow', 	    N'MALE', 	N'8975027338', N'96A0CED6HJ1Y5ZP94J8170ZA9K25FD')
INSERT dbo.dim_subscribers(c_subscriber_id, ID_Key, c_nick_name, c_country, c_city, c_sex, c_phone, flag) VALUES (1, 1, 	N'Ligon568', 		N'USA', 		N'New York', 	N'MALE', 	N'8975815110', N'K18TQ71R127Y')
INSERT dbo.dim_subscribers(c_subscriber_id, ID_Key, c_nick_name, c_country, c_city, c_sex, c_phone, flag) VALUES (3, 3, 	N'Lonna33', 		N'Canada', 		N'Monreal', 	N'MALE', 	N'8935045256', N'2356R3IKV7PC6AW')
INSERT dbo.dim_subscribers(c_subscriber_id, ID_Key, c_nick_name, c_country, c_city, c_sex, c_phone, flag) VALUES (4, 4, 	N'Florentina2022', 	N'Germany', 	N'Berlin',      N'MALE',    N'8945917174', N'4JTZ768')
INSERT dbo.dim_subscribers(c_subscriber_id, ID_Key, c_nick_name, c_country, c_city, c_sex, c_phone, flag) VALUES (5, 5, 	N'Overton2023', 	N'USA', 		N'Los Angeles', N'MALE',    N'8965825392', N'0V79DT3T6IDJVR6K5VITG9172L9')
INSERT dbo.dim_subscribers(c_subscriber_id, ID_Key, c_nick_name, c_country, c_city, c_sex, c_phone, flag) VALUES (6, 6, 	N'Alonso823', 		N'Englang', 	N'Englang',     N'MALE',    N'8925047210', N'0A1UZJ72')
INSERT dbo.dim_subscribers(c_subscriber_id, ID_Key, c_nick_name, c_country, c_city, c_sex, c_phone, flag) VALUES (7, 7, 	N'Blake1987', 		N'Russia', 		N'Moscow', 	    N'MALE', 	N'8925915138', N'54E9H52')
INSERT dbo.dim_subscribers(c_subscriber_id, ID_Key, c_nick_name, c_country, c_city, c_sex, c_phone, flag) VALUES (8, 8, 	N'Eugenie1979', 	N'Russia', 		N'Saratov', 	N'MALE', 	N'8935027356', N'83S4PV2MVB167A02184EMA9C75QXIS11E')
INSERT dbo.dim_subscribers(c_subscriber_id, ID_Key, c_nick_name, c_country, c_city, c_sex, c_phone, flag) VALUES (9, 9, 	N'Crouse646', 		N'Belgium', 	N'Hamburg',     N'MALE',    N'8925045274', N'C81O79')
INSERT dbo.dim_subscribers(c_subscriber_id, ID_Key, c_nick_name, c_country, c_city, c_sex, c_phone, flag) VALUES (10, 10,	N'Sachiko27', 		N'Finland', 	N'Helsinky',    N'MALE',    N'8970027192', N'JF0KGA99LZ24N17TH683')
GO
SET IDENTITY_INSERT dbo.dim_subscribers OFF
GO



--
-- Вставка данных в таблицу dbo.dim_donations
--
SET IDENTITY_INSERT dbo.dim_donations ON
GO
INSERT dbo.dim_donations(c_donation_id, Type, c_sum) VALUES (1, N'81K27080VOK80VQ9IPA1WHF157T6ZI', 46)
INSERT dbo.dim_donations(c_donation_id, Type, c_sum) VALUES (2, N'IV08UG26', 6)
INSERT dbo.dim_donations(c_donation_id, Type, c_sum) VALUES (3, N'Y9KX98K98T12XYJ2Z4W71W7F1W9U2TK65Z', 25)
INSERT dbo.dim_donations(c_donation_id, Type, c_sum) VALUES (4, N'33DMMTDCRO535B', 2)
INSERT dbo.dim_donations(c_donation_id, Type, c_sum) VALUES (5, N'870L23MMDTARZO04786V830XRE8641P8D30968RT33NCC7R1O3X1144MGPKWG0J8L1B2HRDMZ92I6MI1726U273Y65RLN9P12P94', 91)
INSERT dbo.dim_donations(c_donation_id, Type, c_sum) VALUES (6, N'JP0SG414OSKF22KQJNZS3A7I918B820KX6', 17)
INSERT dbo.dim_donations(c_donation_id, Type, c_sum) VALUES (7, N'FET93HEZX5EJUSX548ZXV', 86)
INSERT dbo.dim_donations(c_donation_id, Type, c_sum) VALUES (8, N'4UFF', 57)
INSERT dbo.dim_donations(c_donation_id, Type, c_sum) VALUES (9, N'U3SO4BX4B37781MEZ', 13)
GO
SET IDENTITY_INSERT dbo.dim_donations OFF
GO

--
-- Вставка данных в таблицу dbo.dim_contents
--
SET IDENTITY_INSERT dbo.dim_contents ON
GO
INSERT dbo.dim_contents(c_content_id, Type, Size, c_name, c_tags, flag) VALUES (1, 		N'7UF5D851DK746KN', N'GD5', N'00:00:01', N'tag1', N'flag1')
INSERT dbo.dim_contents(c_content_id, Type, Size, c_name, c_tags, flag) VALUES (2, 		N'4QRYFRML83Y83QH', N'TW2', N'00:20:02', N'tag2', N'flag2')
INSERT dbo.dim_contents(c_content_id, Type, Size, c_name, c_tags, flag) VALUES (3, 		N'R6VW907GW25QAYT', N'1C5', N'00:34:01', N'tag3', N'flag3')
INSERT dbo.dim_contents(c_content_id, Type, Size, c_name, c_tags, flag) VALUES (4, 		N'877', 			N'314', N'00:45:01', N'tag4', N'flag4')
INSERT dbo.dim_contents(c_content_id, Type, Size, c_name, c_tags, flag) VALUES (5, 		N'KU305P75M2U732', 	N'TY6', N'00:10:01', N'tag5', N'flag5')
INSERT dbo.dim_contents(c_content_id, Type, Size, c_name, c_tags, flag) VALUES (6, 		N'XJ8QD002EK770',	N'46C', N'00:00:01', N'tag6', N'flag6')
INSERT dbo.dim_contents(c_content_id, Type, Size, c_name, c_tags, flag) VALUES (7, 		N'S4WO4RQESL1VCJ2', N'RKW', N'01:00:01', N'tag7', N'flag7')
INSERT dbo.dim_contents(c_content_id, Type, Size, c_name, c_tags, flag) VALUES (8, 		N'CR', 				N'253', N'00:45:01', N'tag8', N'flag8')
INSERT dbo.dim_contents(c_content_id, Type, Size, c_name, c_tags, flag) VALUES (9, 		N'TKK7E3950TZPV6U', N'2SN', N'01:20:01', N'tag9', N'flag9')
INSERT dbo.dim_contents(c_content_id, Type, Size, c_name, c_tags, flag) VALUES (10, 	N'09B4O855W1G478',	N'6A7', N'00:00:02', N'1tag', N'1flag')
INSERT dbo.dim_contents(c_content_id, Type, Size, c_name, c_tags, flag) VALUES (11, 	N'Y1', 				N'97C', N'00:09:01', N'2tag', N'2flag')
INSERT dbo.dim_contents(c_content_id, Type, Size, c_name, c_tags, flag) VALUES (12, 	N'QE', 				N'G6S', N'00:06:01', N'3tag', N'3flag')
INSERT dbo.dim_contents(c_content_id, Type, Size, c_name, c_tags, flag) VALUES (13, 	N'11L19X1C97X59B', 	N'704', N'00:00:01', N'4tag', N'4flag')
GO
SET IDENTITY_INSERT dbo.dim_contents OFF
GO

--
-- Вставка данных в таблицу dbo.dim_platforms
--
SET IDENTITY_INSERT dbo.dim_platforms ON
GO
INSERT dbo.dim_platforms(c_platform_id, Type, c_platform_name) VALUES (1, N'H', 34165171277.62)
INSERT dbo.dim_platforms(c_platform_id, Type, c_platform_name) VALUES (2, N'7I2K14', 22490075501.93)
INSERT dbo.dim_platforms(c_platform_id, Type, c_platform_name) VALUES (3, N'26I1441C2S70RN', -25075325353.89)
INSERT dbo.dim_platforms(c_platform_id, Type, c_platform_name) VALUES (4, NULL, NULL)
INSERT dbo.dim_platforms(c_platform_id, Type, c_platform_name) VALUES (5, N'MPUAK48H11EH', 32093263300.77)
INSERT dbo.dim_platforms(c_platform_id, Type, c_platform_name) VALUES (6, N'EQ2UL9X936XD7P8H73T57ES66XPX3RD27VCH57HYOF9V66AX4HF49Q5DX5HB4YW9B3O3628QPE2DT87W7ME7PH18SDZ0N234QT2F', 4995561012.06)
INSERT dbo.dim_platforms(c_platform_id, Type, c_platform_name) VALUES (7, N'PLQ5QL34CZS673IKFZ8N1JK104D32E7V550', -51114829517.43)
INSERT dbo.dim_platforms(c_platform_id, Type, c_platform_name) VALUES (8, N'9VP02SR251I5A1W23CTN03597411CX4R8', -89688160115.22)
INSERT dbo.dim_platforms(c_platform_id, Type, c_platform_name) VALUES (9, N'12W34FU9WT4J17W1W4V5V20LGO185HGJ4L8J317JKBWM17YHIQ86077T2DJ41IL8V73CUT8E321YIS71T2D4SWF37EQ962WGP535', 79.61)
INSERT dbo.dim_platforms(c_platform_id, Type, c_platform_name) VALUES (10, N'C42922UZ2I2J4517VTX0A5O54L', 87.69)
INSERT dbo.dim_platforms(c_platform_id, Type, c_platform_name) VALUES (11, N'7C8IX3', -15540962061.94)
INSERT dbo.dim_platforms(c_platform_id, Type, c_platform_name) VALUES (12, N'S92PU69VZ8A5H5X85Q307P35D594F0QKWG3SPAIWE0U0M590E34C9N7U', -98.82)
INSERT dbo.dim_platforms(c_platform_id, Type, c_platform_name) VALUES (13, N'O28104I67NM849YG649WO5355A2N4GOU4V9463T7688932999DI9QUR80A100JC55OQ372ZN', -8177.53)
GO
SET IDENTITY_INSERT dbo.dim_platforms OFF
GO

--
-- Вставка данных в таблицу dbo.dim_bloggers
--
SET IDENTITY_INSERT dbo.dim_bloggers ON
GO
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (1,		N'Montgomery',		N'Ashe',  N'Sergeyevichs',  N'Dasha2244', N'USA',	N'1941 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9271262411', 1, N'flag1')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (2,		N'Stilliner',		N'Pash',  N'Dedyesavichs',  N'Masha2244', N'USA',	N'1942 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9282462532', 1, N'flag2')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (3,		N'Daytonoer',		N'Bash',  N'Reropyequchs',  N'Pasha2244', N'USA',	N'1943 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9253262423', 2, N'flag3')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (4,		N'Gagnonoer',		N'Vash',  N'Rodriguessac',  N'sadsad213', N'USA',	N'1944 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9284562614', 3, N'flag4')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (5,		N'Christie',		N'Nash',  N'Sawicksowich',  N'vxzvz2131', N'USA',	N'1945 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9255262435', 4, N'flag5')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (6,		N'KinseyDom',		N'Myas',  N'Hummelbummel',  N'boballb21', N'USA',	N'1946 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9279262726', 1, N'flag6')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (7,		N'Wimberly',		N'Kash',  N'Kashowicnich',  N'vajlblb93', N'USA',	N'1947 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9288662417', 2, N'flag7')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (8,		N'Dealwithit',		N'Dash',  N'Populartorue',  N'qbllbq215', N'USA',	N'1948 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9297262838', 4, N'flag8')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (9,		N'Mcclaim',			N'Rash',  N'Kamathutrass',  N'jbqljkba2', N'USA',	N'1949 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9276262419', 3, N'flag9')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (10,		N'Beyer',			N'Yash',  N'Yoboyadahoho',  N'nick_name', N'USA',	N'1940 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9275262910', 1, N'fla10')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (11,		N'Kirby',			N'Lash',  N'Loshoarrkass',  N'qnvqnjbsv', N'USA',	N'1911 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9271862431', 1, N'fla11')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (12,		N'Christman',		N'Koyh',  N'Nikolayevich',  N'Yohohama2', N'USA',	N'1921 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9272262122', 1, N'fla12')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (13,		N'McClanahan',		N'Reus',  N'Petrovoyvich',  N'Y0shumits', N'USA',	N'1931 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9273262413', 1, N'fla13')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (14,		N'Stillwell',		N'Deus',  N'Bogdaanovich',  N'N4g4ss4ki', N'USA',	N'1840 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9274862334', 2, N'fla14')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (15,		N'Bible',			N'Otto',  N'Vasiliyevich',  N'qwehjvqvj', N'USA',	N'1951 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9275262425', 1, N'fla15')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (16,		N'Gaines',			N'Yani',  N'Barmaleevich',  N'jhvacjyvq', N'USA',	N'1961 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9279262516', 1, N'fla16')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (17,		N'Kirchner',		N'Pepe',  N'Popugaevichs',  N'retuneec6', N'USA',	N'1971 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9277862437', 4, N'fla17')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (18,		N'Christopher',		N'Holu',  N'Adamoveaichs',  N'sodapopin', N'USA',	N'1981 East Riverview Ln, Nashville, Tennessee, 079', N'New York',  N'9275962728', 2, N'fla18')		
INSERT dbo.dim_bloggers(c_blogger_id, c_second_name, c_first_name, s_middle_name, c_nick_name, c_country, c_address, c_city, c_phone, Experience, flag) VALUES (19,		N'McClellan',		N'Dart',  N'Sergeyevichs',  N'colamasta', N'UK',	N'1991 East Riverview Ln, Nashville, Tennessee, 079', N'London',	N'9275262619', 3, N'fla19')		
GO
SET IDENTITY_INSERT dbo.dim_bloggers OFF
GO


DECLARE @startdate date = '2010-01-01'
DECLARE @counter int = 2000

while @counter > 0
begin
	
	DECLARE @bufdate date =  dateadd(year, CAST(RAND() * 10 as int), dateadd(month, CAST(RAND() * 11 as int), dateadd(day, CAST(RAND() * 27 as int), @startdate)))
	
	insert into [streamlab].[dbo].[fact_activities] values(
		CAST(RAND() * 10 + 1 as int),
		1,
		1,
		1,
		CAST(CONVERT(varchar(8), @bufdate, 112) as bigint),
		1,
		1
	)
	set @counter = @counter - 1
end

select* from [streamlab].[dbo].[fact_activities]
--drop table fact_activities

--
-- Вставка данных в таблицу dbo.fact_activities
--


--
-- Установить NOEXEC в состояние off
--

SET NOEXEC OFF
GO