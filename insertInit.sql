INSERT t_employee_rank (c_id, c_name, c_salary) 
VALUES
(0,'rookie',10),
(1,'junior',22),
(2,'middle',333),
(3,'senior',4444),
(4,'cheaf',7777777);
GO

ALTER TABLE t_employees 
DROP COLUMN c_hired;
GO

ALTER TABLE t_employees 
ADD c_hired date NOT NULL;
GO

--ALTER TABLE t_employees 
--DROP COLUMN c_experience;
--GO


--ALTER TABLE t_employees 
--ADD c_experience date NOT NULL;
--GO

INSERT t_employees
(c_id, c_first_name, c_second_name,
c_middle_name, c_passport, c_hired, fk_employee_rank) 
VALUES
(0,'John',		'Smith',	'Marlo',		7890632874, CURRENT_TIMESTAMP, 0),
(1,'Voun',		'Landlord', 'Bumble',		7096321341, CURRENT_TIMESTAMP, 0),
(2,'Albert',	'Einstain', 'Rubert',		1190532374, CURRENT_TIMESTAMP, 0),
(3,'Enrich',	'Smith',	'Marlo',		5890532374, CURRENT_TIMESTAMP, 0),
(4,'Arnold',	'Smith',	'Jsad',			2693532374, CURRENT_TIMESTAMP, 0),
(5,'Ivan',		'Smith',	'Marasdlo',		4698532874, CURRENT_TIMESTAMP, 0),
(6,'Anthony',	'Smith',	'Loufda',		3290632874, CURRENT_TIMESTAMP, 0),
(7,'Samanta',	'Smith',	'Issak',		0994532274, CURRENT_TIMESTAMP, 0),
(8,'Lidia',		'Smith',	'Borrow',		8712632274, CURRENT_TIMESTAMP, 0),
(9,'Vicky',		'Smith',	'Venture',		2390632274, CURRENT_TIMESTAMP, 0);
GO