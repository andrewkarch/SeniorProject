CREATE TABLE [dbo].[inventory]
(
	[inventory_id] INT NOT NULL IDENTITY PRIMARY KEY, 
    [product_id] INT NOT NULL, 
    [row] NCHAR(10) NOT NULL, 
    [quantity] INT NOT NULL DEFAULT 0, 
    [box] NCHAR(10) NOT NULL,
	FOREIGN KEY (product_id) REFERENCES product(product_id)
)