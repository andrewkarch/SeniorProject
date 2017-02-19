CREATE TABLE [dbo].[authorization_level]
(
	[authorization_id] INT NOT NULL IDENTITY PRIMARY KEY, 
    [name] VARCHAR(50) NOT NULL, 
    [description] VARCHAR(150) NOT NULL
)

