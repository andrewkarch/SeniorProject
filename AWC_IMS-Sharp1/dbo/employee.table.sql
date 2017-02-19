CREATE TABLE [dbo].[employee]
(
	[employee_id] INT NOT NULL IDENTITY PRIMARY KEY, 
    [first_name] VARCHAR(50) NOT NULL, 
    [middle_name] VARCHAR(50) NOT NULL, 
    [last_name] VARCHAR(50) NOT NULL, 
    [username] NCHAR(10) NOT NULL, 
    [date_of_birth] DATETIME NOT NULL, 
    [start_date] DATETIME NOT NULL, 
    [position_id] INT NULL, 
    [street_address] VARCHAR(50) NOT NULL, 
    [city] VARCHAR(50) NOT NULL, 
    [state] VARCHAR(50) NOT NULL, 
    [zipcode] VARCHAR(15) NOT NULL, 
    [country] VARCHAR(30) NOT NULL, 
    [home_phone] VARCHAR(20) NULL, 
    [mobile_phone] VARCHAR(20) NULL, 
    [work_phone] VARCHAR(20) NOT NULL,
	[active] TINYINT NOT NULL DEFAULT 1, 
    FOREIGN KEY (position_id) REFERENCES position(position_id),
	FOREIGN KEY (username) REFERENCES account(username)
)