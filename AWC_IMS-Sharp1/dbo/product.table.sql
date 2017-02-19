CREATE TABLE [dbo].[product]
(
	[product_id] INT NOT NULL IDENTITY PRIMARY KEY, 
    [name] VARCHAR(50) NOT NULL, 
    [description] VARCHAR(50) NULL, 
    [price] DECIMAL(18, 2) NOT NULL, 
    [active] TINYINT NOT NULL DEFAULT 1
)
