CREATE TABLE [dbo].[customer]
(
	[customer_id] INT NOT NULL IDENTITY PRIMARY KEY, 
    [name] VARCHAR(50) NOT NULL, 
    [description] VARCHAR(150) NULL, 
    [billing_street_address] VARCHAR(50) NOT NULL, 
    [billing_city] VARCHAR(50) NOT NULL, 
    [billing_state] VARCHAR(50) NOT NULL, 
    [billing_zipcode] VARCHAR(50) NOT NULL, 
    [billing_country] VARCHAR(50) NOT NULL, 
    [username] NCHAR(10) NOT NULL,
	FOREIGN KEY (username) REFERENCES account(username)
)
