CREATE TABLE [dbo].[department]
(
	[department_id] INT NOT NULL IDENTITY PRIMARY KEY, 
    [name] VARCHAR(50) NOT NULL, 
    [description] VARCHAR(50) NULL
)