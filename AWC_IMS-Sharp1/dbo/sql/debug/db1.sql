/*
Deployment script for db1
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "db1"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
USE [master]

GO
:on error exit
GO
IF (DB_ID(N'$(DatabaseName)') IS NOT NULL
    AND DATABASEPROPERTYEX(N'$(DatabaseName)','Status') <> N'ONLINE')
BEGIN
    RAISERROR(N'The state of the target database, %s, is not set to ONLINE. To deploy to this database, its state must be set to ONLINE.', 16, 127,N'$(DatabaseName)') WITH NOWAIT
    RETURN
END

GO
IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)] COLLATE SQL_Latin1_General_CP1_CI_AS
GO
EXECUTE sp_dbcmptlevel [$(DatabaseName)], 100;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
USE [$(DatabaseName)]

GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

GO
PRINT N'Creating [dbo].[account]...';


GO
CREATE TABLE [dbo].[account] (
    [username]         NCHAR (10)   NOT NULL,
    [password]         VARCHAR (50) NOT NULL,
    [authorization_id] INT          NOT NULL,
    [create_date]      DATETIME     NOT NULL,
    PRIMARY KEY CLUSTERED ([username] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
PRINT N'Creating [dbo].[authorization_level]...';


GO
CREATE TABLE [dbo].[authorization_level] (
    [authorization_id] INT           IDENTITY (1, 1) NOT NULL,
    [name]             VARCHAR (50)  NOT NULL,
    [description]      VARCHAR (150) NOT NULL,
    PRIMARY KEY CLUSTERED ([authorization_id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
PRINT N'Creating [dbo].[customer]...';


GO
CREATE TABLE [dbo].[customer] (
    [customer_id]            INT           IDENTITY (1, 1) NOT NULL,
    [name]                   VARCHAR (50)  NOT NULL,
    [description]            VARCHAR (150) NULL,
    [billing_street_address] VARCHAR (50)  NOT NULL,
    [billing_city]           VARCHAR (50)  NOT NULL,
    [billing_state]          VARCHAR (50)  NOT NULL,
    [billing_zipcode]        VARCHAR (50)  NOT NULL,
    [billing_country]        VARCHAR (50)  NOT NULL,
    [username]               NCHAR (10)    NOT NULL,
    PRIMARY KEY CLUSTERED ([customer_id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
PRINT N'Creating [dbo].[customer_shipping_address]...';


GO
CREATE TABLE [dbo].[customer_shipping_address] (
    [csa_id]                  INT          IDENTITY (1, 1) NOT NULL,
    [customer_id]             INT          NOT NULL,
    [shipping_street_address] VARCHAR (50) NOT NULL,
    [shipping_city]           VARCHAR (50) NOT NULL,
    [shipping_state]          VARCHAR (50) NOT NULL,
    [shipping_zipcode]        VARCHAR (50) NOT NULL,
    [shipping_country]        VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([csa_id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
PRINT N'Creating [dbo].[department]...';


GO
CREATE TABLE [dbo].[department] (
    [department_id] INT          IDENTITY (1, 1) NOT NULL,
    [name]          VARCHAR (50) NOT NULL,
    [description]   VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([department_id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
PRINT N'Creating [dbo].[employee]...';


GO
CREATE TABLE [dbo].[employee] (
    [employee_id]    INT          IDENTITY (1, 1) NOT NULL,
    [first_name]     VARCHAR (50) NOT NULL,
    [middle_name]    VARCHAR (50) NOT NULL,
    [last_name]      VARCHAR (50) NOT NULL,
    [username]       NCHAR (10)   NOT NULL,
    [date_of_birth]  DATETIME     NOT NULL,
    [start_date]     DATETIME     NOT NULL,
    [position_id]    INT          NULL,
    [street_address] VARCHAR (50) NOT NULL,
    [city]           VARCHAR (50) NOT NULL,
    [state]          VARCHAR (50) NOT NULL,
    [zipcode]        VARCHAR (15) NOT NULL,
    [country]        VARCHAR (30) NOT NULL,
    [home_phone]     VARCHAR (20) NULL,
    [mobile_phone]   VARCHAR (20) NULL,
    [work_phone]     VARCHAR (20) NOT NULL,
    [active]         TINYINT      NOT NULL,
    PRIMARY KEY CLUSTERED ([employee_id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
PRINT N'Creating [dbo].[inventory]...';


GO
CREATE TABLE [dbo].[inventory] (
    [inventory_id] INT        IDENTITY (1, 1) NOT NULL,
    [product_id]   INT        NOT NULL,
    [row]          NCHAR (10) NOT NULL,
    [quantity]     INT        NOT NULL,
    [box]          NCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([inventory_id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
PRINT N'Creating [dbo].[position]...';


GO
CREATE TABLE [dbo].[position] (
    [position_id]   INT          IDENTITY (1, 1) NOT NULL,
    [title]         VARCHAR (50) NOT NULL,
    [department_id] INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([position_id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
PRINT N'Creating [dbo].[product]...';


GO
CREATE TABLE [dbo].[product] (
    [product_id]  INT             IDENTITY (1, 1) NOT NULL,
    [name]        VARCHAR (50)    NOT NULL,
    [description] VARCHAR (50)    NULL,
    [price]       DECIMAL (18, 2) NOT NULL,
    [active]      TINYINT         NOT NULL,
    PRIMARY KEY CLUSTERED ([product_id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
PRINT N'Creating [dbo].[purchase_order]...';


GO
CREATE TABLE [dbo].[purchase_order] (
    [po_id]       INT      IDENTITY (1, 1) NOT NULL,
    [customer_id] INT      NOT NULL,
    [date_placed] DATETIME NOT NULL,
    [date_filled] DATETIME NULL,
    [employee_id] INT      NULL,
    [csa_id]      INT      NOT NULL,
    PRIMARY KEY CLUSTERED ([po_id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
PRINT N'Creating [dbo].[purchase_order_product]...';


GO
CREATE TABLE [dbo].[purchase_order_product] (
    [pop_id]     INT IDENTITY (1, 1) NOT NULL,
    [po_id]      INT NOT NULL,
    [product_id] INT NOT NULL,
    [quantity]   INT NOT NULL,
    PRIMARY KEY CLUSTERED ([pop_id] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF)
);


GO
PRINT N'Creating On column: active...';


GO
ALTER TABLE [dbo].[employee]
    ADD DEFAULT 1 FOR [active];


GO
PRINT N'Creating On column: quantity...';


GO
ALTER TABLE [dbo].[inventory]
    ADD DEFAULT 0 FOR [quantity];


GO
PRINT N'Creating On column: active...';


GO
ALTER TABLE [dbo].[product]
    ADD DEFAULT 1 FOR [active];


GO
PRINT N'Creating On table: account...';


GO
ALTER TABLE [dbo].[account] WITH NOCHECK
    ADD FOREIGN KEY ([authorization_id]) REFERENCES [dbo].[authorization_level] ([authorization_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating On table: customer...';


GO
ALTER TABLE [dbo].[customer] WITH NOCHECK
    ADD FOREIGN KEY ([username]) REFERENCES [dbo].[account] ([username]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating On table: customer_shipping_address...';


GO
ALTER TABLE [dbo].[customer_shipping_address] WITH NOCHECK
    ADD FOREIGN KEY ([customer_id]) REFERENCES [dbo].[customer] ([customer_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating On table: employee...';


GO
ALTER TABLE [dbo].[employee] WITH NOCHECK
    ADD FOREIGN KEY ([position_id]) REFERENCES [dbo].[position] ([position_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating On table: employee...';


GO
ALTER TABLE [dbo].[employee] WITH NOCHECK
    ADD FOREIGN KEY ([username]) REFERENCES [dbo].[account] ([username]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating On table: inventory...';


GO
ALTER TABLE [dbo].[inventory] WITH NOCHECK
    ADD FOREIGN KEY ([product_id]) REFERENCES [dbo].[product] ([product_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating On table: position...';


GO
ALTER TABLE [dbo].[position] WITH NOCHECK
    ADD FOREIGN KEY ([department_id]) REFERENCES [dbo].[department] ([department_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating On table: purchase_order...';


GO
ALTER TABLE [dbo].[purchase_order] WITH NOCHECK
    ADD FOREIGN KEY ([customer_id]) REFERENCES [dbo].[customer] ([customer_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating On table: purchase_order...';


GO
ALTER TABLE [dbo].[purchase_order] WITH NOCHECK
    ADD FOREIGN KEY ([employee_id]) REFERENCES [dbo].[employee] ([employee_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating On table: purchase_order...';


GO
ALTER TABLE [dbo].[purchase_order] WITH NOCHECK
    ADD FOREIGN KEY ([csa_id]) REFERENCES [dbo].[customer_shipping_address] ([csa_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating On table: purchase_order_product...';


GO
ALTER TABLE [dbo].[purchase_order_product] WITH NOCHECK
    ADD FOREIGN KEY ([po_id]) REFERENCES [dbo].[purchase_order] ([po_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating On table: purchase_order_product...';


GO
ALTER TABLE [dbo].[purchase_order_product] WITH NOCHECK
    ADD FOREIGN KEY ([product_id]) REFERENCES [dbo].[product] ([product_id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
-- Refactoring step to update target server with deployed transaction logs
CREATE TABLE  [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
GO
sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
GO

GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO

GO
CREATE TABLE [#__checkStatus] (
    [Table]      NVARCHAR (270),
    [Constraint] NVARCHAR (270),
    [Where]      NVARCHAR (MAX)
);

SET NOCOUNT ON;


GO
INSERT INTO [#__checkStatus]
EXECUTE (N'DBCC CHECKCONSTRAINTS (N''[dbo].[account]'')
    WITH NO_INFOMSGS');

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occured while verifying constraints on table [dbo].[account]', 16, 127);
    END


GO
INSERT INTO [#__checkStatus]
EXECUTE (N'DBCC CHECKCONSTRAINTS (N''[dbo].[customer]'')
    WITH NO_INFOMSGS');

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occured while verifying constraints on table [dbo].[customer]', 16, 127);
    END


GO
INSERT INTO [#__checkStatus]
EXECUTE (N'DBCC CHECKCONSTRAINTS (N''[dbo].[customer_shipping_address]'')
    WITH NO_INFOMSGS');

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occured while verifying constraints on table [dbo].[customer_shipping_address]', 16, 127);
    END


GO
INSERT INTO [#__checkStatus]
EXECUTE (N'DBCC CHECKCONSTRAINTS (N''[dbo].[employee]'')
    WITH NO_INFOMSGS');

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occured while verifying constraints on table [dbo].[employee]', 16, 127);
    END


GO
INSERT INTO [#__checkStatus]
EXECUTE (N'DBCC CHECKCONSTRAINTS (N''[dbo].[inventory]'')
    WITH NO_INFOMSGS');

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occured while verifying constraints on table [dbo].[inventory]', 16, 127);
    END


GO
INSERT INTO [#__checkStatus]
EXECUTE (N'DBCC CHECKCONSTRAINTS (N''[dbo].[position]'')
    WITH NO_INFOMSGS');

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occured while verifying constraints on table [dbo].[position]', 16, 127);
    END


GO
INSERT INTO [#__checkStatus]
EXECUTE (N'DBCC CHECKCONSTRAINTS (N''[dbo].[purchase_order]'')
    WITH NO_INFOMSGS');

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occured while verifying constraints on table [dbo].[purchase_order]', 16, 127);
    END


GO
INSERT INTO [#__checkStatus]
EXECUTE (N'DBCC CHECKCONSTRAINTS (N''[dbo].[purchase_order_product]'')
    WITH NO_INFOMSGS');

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occured while verifying constraints on table [dbo].[purchase_order_product]', 16, 127);
    END


GO
SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        DECLARE @VarDecimalSupported AS BIT;
        SELECT @VarDecimalSupported = 0;
        IF ((ServerProperty(N'EngineEdition') = 3)
            AND (((@@microsoftversion / power(2, 24) = 9)
                  AND (@@microsoftversion & 0xffff >= 3024))
                 OR ((@@microsoftversion / power(2, 24) = 10)
                     AND (@@microsoftversion & 0xffff >= 1600))))
            SELECT @VarDecimalSupported = 1;
        IF (@VarDecimalSupported > 0)
            BEGIN
                EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
            END
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET MULTI_USER 
    WITH ROLLBACK IMMEDIATE;


GO
