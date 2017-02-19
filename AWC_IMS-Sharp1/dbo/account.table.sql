CREATE TABLE [dbo].[account]
(
	[username] NCHAR(10) NOT NULL PRIMARY KEY, 
    [password] VARCHAR(50) NOT NULL, 
    [authorization_id] INT NOT NULL, 
    [create_date] DATETIME NOT NULL,
	FOREIGN KEY (authorization_id) REFERENCES authorization_level(authorization_id)
)
