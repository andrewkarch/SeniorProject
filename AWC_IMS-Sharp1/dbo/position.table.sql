CREATE TABLE [dbo].[position]
(
	[position_id] INT NOT NULL IDENTITY PRIMARY KEY, 
    [title] VARCHAR(50) NOT NULL, 
    [department_id] INT NOT NULL,
	FOREIGN KEY (department_id) REFERENCES department(department_id)
)