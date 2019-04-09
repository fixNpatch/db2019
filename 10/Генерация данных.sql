﻿
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
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (1, N'Montgomery', N'Abreu2022', N'Marino', N'6P4674GS4', N'237 Edgewood Court, Madison, Wisconsin, 54493', N'Purcell', N'86838', -463293378, N'8641HE7Z62S7Q57545C016K2XM872K192H26S3U', 3, N'J7O4SDQ909KH24A9SH2N7OMS8T173')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (2, N'Still', N'Cathey1980', N'Juarez', N'O14QNJU79495BXI4V2Z1672S6OE7IG4XIEMCD6BPH61I4', N'2352 Sharp Hill Ct, Judge Building, Augusta, Maine, 78895', N'Kingfisher', N'72982', -1501329100, N'4EN144098348C0ME7R96LGHWTQ1UP2XZ92II0A3A030A', -2090539160, N'7MHVQG4229L3Z8B')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (3, N'Dayton', N'Aleta1980', N'Abbott', N'8NR1P1MP9W37Q9IY3', N'608 Town Ave, Calyon Bldg, Salem, Oregon, 09662', N'Aberdeen', N'32630', 67, N'TP8602GR5KX64W6J7O80OJPP36V', -1298511159, N'WM29QV')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (4, N'Gagnon', N'Melba2', N'Marion', N'RH5K55Z5D861DY8H048E62QA3443KH2G4', N'1941 East Riverview Ln, Nashville, Tennessee, 07929', N'Astoria', N'93075', -940489305, N'7I7Z2Y4FOT1233R960M0X9XGE7KWKYSUW6D3BNFSQS08TF', -730023638, N'2Q4WO93RVU5')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (5, N'Christie', N'Vanessa1985', N'Corcoran', N'PRXW1M1X', N'3084 Bayview Street, 3rd Floor, Sacramento, California, 49564', N'Shawnee', N'75928', -1163814149, N'83E36V5YVY4U5D4K5W99L', -598152306, N'Q1G7355TEP3B6XC3D6PA844LPCUQMX5RC')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (6, N'Kinsey', N'Wolf35', N'Judd', N'K77W33P49FMFL5A9Q4XCG73UC0U682V96FPJO', N'567 E Woodcock Avenue, Sacramento, California, 90452', N'New Castle', N'57080', -865590283, N'410F6WIXY390', -497829609, N'5MW0Q016KLEJ35JWSI308U0')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (7, N'Wimberly', N'Gala2015', N'Staggs', N'6498X140JH0R4Z807FJD008U94', N'31 W Town St, Victor Executive Bldg, Providence, Rhode Island, 30494', N'Cincinnati', N'96491', -8, N'9IQ2UYBZ', -1272245938, N'R7ZI3P16857QFMK422XV0K9GC')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (8, N'Deal', N'Buster45', N'Mark', N'I03D35ME51NKLF', N'3457 North Beachwood Ave, Suite 6481, Harrisburg, Pennsylvania, 97502', N'Jonesborough', N'81993', -1541817106, N'CGCKYS3B1V21ZEWW5YZO76BI', 56, N'2640Y1C9S73628WGH2')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (9, N'Mcclain', N'Aiko86', N'Jude', N'2QX27A3ERN7ITWHPJ80I8Q0GN844D', N'1102 Riverview Highway, Boston, MA, 41081', N'Long Beach', N'94696', -2036831691, N'CI9M4BE4B6GC7JIFK7', 84, N'98')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (10, N'Beyer', N'Abel614', N'Fellows', N'I5I34NU8FIV294JWVE', N'867 SW Beachwood Ln, Comcast Bldg, Concord, NH, 69430', N'Chittenango', N'36058', -361358126, N'961890D699HF0RT', -1979878984, N'6IY6L13PZI7UHK403VB')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (11, N'Kirby', N'Alayna2019', N'Cordell', N'DOI20VC199BA07W633725IO', N'406 Woodfort Blvd, Lincoln, NE, 92904', N'Kingsport', N'56450', -1764359293, NULL, NULL, N'NNFPN')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (12, N'Christman', N'Kidd798', N'Bourque', N'4', N'1159 Burwood Cir, STE 99, Madison, Wisconsin, 72167', N'Abilene', N'88167', 9, N'AIO1482CUYA3C1', 627, N'F')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (13, N'Mcclanahan', N'Gilliam1978', N'Whitney', N'R99Z471S', N'132 Prospect Hill Hwy, Salem, OR, 69173', N'Bedford', N'95246', -298, N'54M34XD9550KY9ZO5714P0ABJ6K79I6Q9XPY4MJIX9', -353753083, N'OG4JIK63S4Y3LYWP0238ZNG803PBP3H')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (14, N'Stillwell', N'Adam2004', N'Markham', N'X6J', N'3831 New Meadowview Avenue, Richmond, VA, 03111', N'Harrisburg', N'49164', -1309034076, NULL, NULL, N'234K3JG86')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (15, N'Bible', N'Allan7', N'Stahl', N'4KW5D2RD', N'1712 East Sharp Hill Way, 3rd Floor, Santa Fe, New Mexico, 06403', N'Bernalillo', N'04311', -1406400249, N'X0544NF0796IK0JIB4', -1171149210, N'89XAESUZ1DT0F65TV5')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (16, N'Gaines', N'Chadwick1985', N'Whitson', N'2', N'3949 Chapel Hill Parkway, MidAmerican Building, Atlanta, GA, 60847', N'Conneaut', N'53107', -1937522438, N'09', -281018203, NULL)
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (17, N'Kirchner', N'Ronna2017', N'Felton', N'Q', N'216 West Mountain Road, Suite 5, Juneau, AK, 61262', N'East Liverpool', N'16787', -788164678, N'844H3WK342U49S319H1408V3Y935060UG51809LI64A9Z0CIT1C89TVN2AV125HM7K5NYT860W913MZDV159G25Y4K', -1162466197, N'U49RMV2535')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (18, N'Christopher', N'Abernathy67', N'Cordero', N'TMD', N'816 Ironwood Way, Enquirer Bldg, Lansing, Michigan, 89684', N'McKinney', N'22307', -1806017762, NULL, NULL, N'OD08N473G4')
INSERT dbo.dim_bloggers(ID, Surname, Name, Lastname, Passport, Address, City, Phone_number, Experience, Specialty, Wage, flag) VALUES (19, N'Mcclellan', N'Delma524', N'Abel', N'C37SV8', N'2820 Mountain Lane, Nashville, TN, 44334', N'Aberdeen', N'24269', 61, N'FG103I66LK62NS465', 1055, N'K3B091V2V28Y16H5Q1Q6UFPSO78VQ0CU3103K7027ZC4P4026M')
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