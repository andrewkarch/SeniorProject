CREATE TABLE [dbo].[customer_shipping_address]
(
	[csa_id] INT NOT NULL IDENTITY PRIMARY KEY, 
    [customer_id] INT NOT NULL, 
    [shipping_street_address] VARCHAR(50) NOT NULL, 
    [shipping_city] VARCHAR(50) NOT NULL, 
    [shipping_state] VARCHAR(50) NOT NULL, 
    [shipping_zipcode] VARCHAR(50) NOT NULL, 
    [shipping_country] VARCHAR(50) NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
)