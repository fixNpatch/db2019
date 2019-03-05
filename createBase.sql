-- Generated by DBDesigner.net

CREATE TABLE [toc_order_menu] (
	c_id float NOT NULL UNIQUE,
	fk_order_id float NOT NULL,
	fk_menu_id float NOT NULL,
	c_amount float NOT NULL,
  CONSTRAINT [PK_TOC_ORDER_MENU] PRIMARY KEY CLUSTERED
  (
  [c_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [t_menu] (
	c_id float NOT NULL,
	c_dish_name varchar(40) NOT NULL,
	c_dish_cost float NOT NULL,
	c_dish_type integer NOT NULL,
  CONSTRAINT [PK_T_MENU] PRIMARY KEY CLUSTERED
  (
  [c_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [toc_menu_products] (
	c_id float NOT NULL,
	fk_menu_id float NOT NULL,
	fk_products_id float NOT NULL,
	c_amount float NOT NULL,
  CONSTRAINT [PK_TOC_MENU_PRODUCTS] PRIMARY KEY CLUSTERED
  (
  [c_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [t_order] (
	c_id float NOT NULL,
	fk_employee_id float NOT NULL,
	c_date timestamp NOT NULL,
	c_cost float NOT NULL,
  CONSTRAINT [PK_T_ORDER] PRIMARY KEY CLUSTERED
  (
  [c_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [t_employees] (
	c_id float NOT NULL,
	c_first_name varchar(40) NOT NULL,
	c_second_name varchar(40) NOT NULL,
	c_middle_name varchar(40) NOT NULL,
	c_passport float NOT NULL UNIQUE,
	c_hired timestamp NOT NULL,
	c_experience time NOT NULL,
	fk_employee_rank float NOT NULL,
  CONSTRAINT [PK_T_EMPLOYEES] PRIMARY KEY CLUSTERED
  (
  [c_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [t_employee_rank] (
	c_id float NOT NULL,
	c_name varchar(40) NOT NULL,
	c_salary float NOT NULL,
  CONSTRAINT [PK_T_EMPLOYEE_RANK] PRIMARY KEY CLUSTERED
  (
  [c_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [t_products] (
	c_id float NOT NULL,
	c_name varchar(40) NOT NULL,
	c_amount float NOT NULL,
  CONSTRAINT [PK_T_PRODUCTS] PRIMARY KEY CLUSTERED
  (
  [c_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [t_invoice] (
	c_id float NOT NULL,
	fk_providers_id float NOT NULL,
	c_date timestamp NOT NULL,
	c_cost float NOT NULL,
  CONSTRAINT [PK_T_INVOICE] PRIMARY KEY CLUSTERED
  (
  [c_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [t_providers] (
	c_id float NOT NULL,
	c_name varchar(40) NOT NULL,
	c_address varchar(40) NOT NULL,
  CONSTRAINT [PK_T_PROVIDERS] PRIMARY KEY CLUSTERED
  (
  [c_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [toc_invoice_products] (
	c_id float NOT NULL,
	fk_products_id float NOT NULL,
	fk_invoice_id float NOT NULL,
	c_amount float NOT NULL,
  CONSTRAINT [PK_TOC_INVOICE_PRODUCTS] PRIMARY KEY CLUSTERED
  (
  [c_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
ALTER TABLE [toc_order_menu] WITH CHECK ADD CONSTRAINT [toc_order_menu_fk0] FOREIGN KEY ([fk_order_id]) REFERENCES [t_order]([c_id])
ON UPDATE CASCADE
GO
ALTER TABLE [toc_order_menu] CHECK CONSTRAINT [toc_order_menu_fk0]
GO
ALTER TABLE [toc_order_menu] WITH CHECK ADD CONSTRAINT [toc_order_menu_fk1] FOREIGN KEY ([fk_menu_id]) REFERENCES [t_menu]([c_id])
ON UPDATE CASCADE
GO
ALTER TABLE [toc_order_menu] CHECK CONSTRAINT [toc_order_menu_fk1]
GO


ALTER TABLE [toc_menu_products] WITH CHECK ADD CONSTRAINT [toc_menu_products_fk0] FOREIGN KEY ([fk_menu_id]) REFERENCES [t_menu]([c_id])
ON UPDATE CASCADE
GO
ALTER TABLE [toc_menu_products] CHECK CONSTRAINT [toc_menu_products_fk0]
GO
ALTER TABLE [toc_menu_products] WITH CHECK ADD CONSTRAINT [toc_menu_products_fk1] FOREIGN KEY ([fk_products_id]) REFERENCES [t_products]([c_id])
ON UPDATE CASCADE
GO
ALTER TABLE [toc_menu_products] CHECK CONSTRAINT [toc_menu_products_fk1]
GO

ALTER TABLE [t_order] WITH CHECK ADD CONSTRAINT [t_order_fk0] FOREIGN KEY ([fk_employee_id]) REFERENCES [t_employees]([c_id])
ON UPDATE CASCADE
GO
ALTER TABLE [t_order] CHECK CONSTRAINT [t_order_fk0]
GO

ALTER TABLE [t_employees] WITH CHECK ADD CONSTRAINT [t_employees_fk0] FOREIGN KEY ([fk_employee_rank]) REFERENCES [t_employee_rank]([c_id])
ON UPDATE CASCADE
GO
ALTER TABLE [t_employees] CHECK CONSTRAINT [t_employees_fk0]
GO



ALTER TABLE [t_invoice] WITH CHECK ADD CONSTRAINT [t_invoice_fk0] FOREIGN KEY ([fk_providers_id]) REFERENCES [t_providers]([c_id])
ON UPDATE CASCADE
GO
ALTER TABLE [t_invoice] CHECK CONSTRAINT [t_invoice_fk0]
GO


ALTER TABLE [toc_invoice_products] WITH CHECK ADD CONSTRAINT [toc_invoice_products_fk0] FOREIGN KEY ([fk_products_id]) REFERENCES [t_products]([c_id])
ON UPDATE CASCADE
GO
ALTER TABLE [toc_invoice_products] CHECK CONSTRAINT [toc_invoice_products_fk0]
GO
ALTER TABLE [toc_invoice_products] WITH CHECK ADD CONSTRAINT [toc_invoice_products_fk1] FOREIGN KEY ([fk_invoice_id]) REFERENCES [t_invoice]([c_id])
ON UPDATE CASCADE
GO
ALTER TABLE [toc_invoice_products] CHECK CONSTRAINT [toc_invoice_products_fk1]
GO

