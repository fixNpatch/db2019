SELECT partition_number, rows FROM Sys.partitions
WHERE OBJECT_ID = (SELECT OBJECT_ID FROM Sys.tables WHERE name = 'Fact_Order')
ORDER BY partition_number

SELECT partition_number, rows FROM Sys.partitions
WHERE OBJECT_ID = (SELECT OBJECT_ID FROM Sys.tables WHERE name = 'Archive')
ORDER BY partition_number


EXEC Pr_SlidingWindow

DROP Procedure Pr_SlidingWindow

/*

select * from Orders
select * from ArchiveOrders

insert into Orders Values(2, 2, 2, 2, 2, 2, 2, 2, 567,  20170101, 20170103)

insert into Orders Values(2, 2, 2, 2, 2, 2, 2, 2, 567,  20160101, 20170101)

insert into Orders Values(2, 2, 2, 2, 2, 2, 2, 2, 567, 20150101, 20170101)

insert into Orders Values(2, 2, 2, 2, 2, 2, 2, 2, 567, 20140101, 20170101)


insert into Orders Values(2, 2, 2, 2, 2, 2, 2, 2, 567, 20050101, 20170101)

*/