USE [master]
GO
/****** Object:  Database [TestDB]    Script Date: 16.08.2021 22:29:10 ******/
CREATE DATABASE [TestDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\TestDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TestDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\TestDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TestDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TestDB] SET  MULTI_USER 
GO
ALTER DATABASE [TestDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TestDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TestDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TestDB] SET QUERY_STORE = OFF
GO
USE [TestDB]
GO
/****** Object:  Table [dbo].[Company]    Script Date: 16.08.2021 22:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[OrganizationalLegalForm] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 16.08.2021 22:29:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[MiddleName] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[Position] [varchar](50) NOT NULL,
	[Company] [varchar](50) NULL,
	[EmploymentDate] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_Name]  DEFAULT ('Unknown') FOR [Name]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_Company]  DEFAULT ('Unknown') FOR [Company]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Companies] FOREIGN KEY([Company])
REFERENCES [dbo].[Company] ([Name])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Companies]
GO
/****** Object:  StoredProcedure [dbo].[spAddCompany]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAddCompany]
    @Name VARCHAR(50),           
    @OrganizationalLegalForm VARCHAR(50)
AS
BEGIN
    Insert into Company(Name, OrganizationalLegalForm)           
    Values (@Name, @OrganizationalLegalForm)       
END
GO
/****** Object:  StoredProcedure [dbo].[spAddEmployee]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAddEmployee]
    @FirstName VARCHAR(50),           
    @LastName VARCHAR(50), 
	@MiddleName VARCHAR(50),
    @Position VARCHAR(30),          
    @Company VARCHAR(20),  
    @Date Date   
AS
BEGIN
    Insert into Employee(FirstName, LastName, MiddleName, Position, Company, EmploymentDate)           
    Values (@FirstName, @LastName, @MiddleName, @Position, @Company, @Date)       
END
GO
/****** Object:  StoredProcedure [dbo].[spCountEmployee]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCountEmployee] 
	@CompanyName varchar(50)
AS
BEGIN
	SELECT COUNT(*) FROM Employee WHERE Company= @CompanyName
END
GO
/****** Object:  StoredProcedure [dbo].[spDeleteCompany]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteCompany]
	@Id int 
AS
BEGIN
	Delete from Company where Id=@Id     
END
GO
/****** Object:  StoredProcedure [dbo].[spDeleteEmployee]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteEmployee]
	@Id int 
AS
BEGIN
	Delete from Employee where Id=@Id     
END
GO
/****** Object:  StoredProcedure [dbo].[spGetCompanyId]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetCompanyId]
AS
BEGIN
    select *        
    from Company     
    order by Id
END
GO
/****** Object:  StoredProcedure [dbo].[spGetCompanyIdDesc]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetCompanyIdDesc]
AS
BEGIN
    select *        
    from Company     
    order by Id Desc
END
GO
/****** Object:  StoredProcedure [dbo].[spGetCompanyName]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetCompanyName]
AS
BEGIN
    select *        
    from Company     
    order by Name
END
GO
/****** Object:  StoredProcedure [dbo].[spGetCompanyNameDesc]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetCompanyNameDesc]
AS
BEGIN
    select *        
    from Company     
    order by Name Desc
END
GO
/****** Object:  StoredProcedure [dbo].[spGetCompanyOrganizationalLegalForm]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetCompanyOrganizationalLegalForm]
AS
BEGIN
    select *        
    from Company     
    order by OrganizationalLegalForm
END
GO
/****** Object:  StoredProcedure [dbo].[spGetCompanyOrganizationalLegalFormDesc]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetCompanyOrganizationalLegalFormDesc]
AS
BEGIN
    select *        
    from Company     
    order by OrganizationalLegalForm Desc
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeCompany]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeCompany]
AS
BEGIN
    select *        
    from Employee     
    order by Company
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeCompanyDesc]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeCompanyDesc]
AS
BEGIN
    select *        
    from Employee     
    order by Company Desc
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeEmploymentDate]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeEmploymentDate]
AS
BEGIN
    select *        
    from Employee     
    order by EmploymentDate
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeEmploymentDateDesc]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeEmploymentDateDesc]
AS
BEGIN
    select *        
    from Employee     
    order by EmploymentDate Desc
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeId]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeId]
AS
BEGIN
    select *        
    from Employee     
    order by Id
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeIdDesc]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeIdDesc]
AS
BEGIN
    select *        
    from Employee     
    order by Id DESC
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeLastName]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeLastName]
AS
BEGIN
    select *        
    from Employee     
    order by LastName
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeLastNameDesc]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeLastNameDesc]
AS
BEGIN
    select *        
    from Employee     
    order by LastName Desc
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeMiddleName]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeMiddleName]
AS
BEGIN
    select *        
    from Employee     
    order by MiddleName
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeMiddleNameDesc]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeMiddleNameDesc]
AS
BEGIN
    select *        
    from Employee     
    order by MiddleName Desc
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeName]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeName]
AS
BEGIN
    select *        
    from Employee     
    order by FirstName
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeNameDesc]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeNameDesc]
AS
BEGIN
    select *        
    from Employee     
    order by FirstName Desc
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeePosition]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeePosition]
AS
BEGIN
    select *        
    from Employee     
    order by Position
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeePositionDesc]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeePositionDesc]
AS
BEGIN
    select *        
    from Employee     
    order by Position Desc
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCompany]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateCompany] 
	@Id INTEGER ,
    @Name VARCHAR(50),           
    @OrganizationalLegalForm VARCHAR(50)
AS
BEGIN
   Update Company             
   set Name=@Name,            
   OrganizationalLegalForm=@OrganizationalLegalForm     
   where Id=@Id   
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateEmployee]    Script Date: 16.08.2021 22:29:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateEmployee]  
	@Id INTEGER ,
    @FirstName VARCHAR(50),           
    @LastName VARCHAR(50), 
	@MiddleName VARCHAR(50),
    @Position VARCHAR(30),          
    @Company VARCHAR(20),  
    @EmploymentDate Date  
AS
BEGIN
   Update Employee             
   set FirstName=@FirstName,            
   LastName=@LastName,            
   MiddleName=@MiddleName,          
   Position=@Position,
   Company=@Company,
   EmploymentDate=@EmploymentDate            
   where Id=@Id    
END
GO
USE [master]
GO
ALTER DATABASE [TestDB] SET  READ_WRITE 
GO
