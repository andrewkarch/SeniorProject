CREATE TABLE [dbo].[purchase_order]
(
	[po_id] INT NOT NULL IDENTITY PRIMARY KEY, 
    [customer_id] INT NOT NULL, 
    [date_placed] DATETIME NOT NULL, 
    [date_filled] DATETIME NULL, 
    [employee_id] INT NULL,
	[csa_id] INT NOT NULL, 
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
	FOREIGN KEY (csa_id) REFERENCES customer_shipping_address(csa_id)
)