/*
Deployment script for JOB_DW

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "JOB_DW"
:setvar DefaultFilePrefix "JOB_DW"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creating [dbo].[JOB_HISTORY]...';


GO
CREATE TABLE [dbo].[JOB_HISTORY] (
    [instance_id]         INT              NULL,
    [job_id]              UNIQUEIDENTIFIER NULL,
    [step_id]             INT              NULL,
    [step_name]           NVARCHAR (128)   NULL,
    [sql_message_id]      INT              NULL,
    [sql_severity]        INT              NULL,
    [message]             NVARCHAR (4000)  NULL,
    [run_status]          INT              NULL,
    [run_date]            INT              NULL,
    [run_time]            INT              NULL,
    [run_duration]        INT              NULL,
    [operator_id_emailed] INT              NULL,
    [operator_id_netsent] INT              NULL,
    [operator_id_paged]   INT              NULL,
    [retries_attempted]   INT              NULL,
    [server]              NVARCHAR (128)   NULL
);


GO
PRINT N'Creating [dbo].[JOB_HISTORY_STAGING]...';


GO
CREATE TABLE [dbo].[JOB_HISTORY_STAGING] (
    [instance_id]         INT              NULL,
    [job_id]              UNIQUEIDENTIFIER NULL,
    [step_id]             INT              NULL,
    [step_name]           NVARCHAR (128)   NULL,
    [sql_message_id]      INT              NULL,
    [sql_severity]        INT              NULL,
    [message]             NVARCHAR (4000)  NULL,
    [run_status]          INT              NULL,
    [run_date]            INT              NULL,
    [run_time]            INT              NULL,
    [run_duration]        INT              NULL,
    [operator_id_emailed] INT              NULL,
    [operator_id_netsent] INT              NULL,
    [operator_id_paged]   INT              NULL,
    [retries_attempted]   INT              NULL,
    [server]              NVARCHAR (128)   NULL
);


GO
PRINT N'Creating [dbo].[GET_ROWS_TO_LOAD_FROM_STAGING]...';


GO
CREATE PROCEDURE [dbo].[GET_ROWS_TO_LOAD_FROM_STAGING]
AS
BEGIN
	;WITH CTE_NEW_INSTANCE_IDS AS (
		SELECT
			s.[instance_id]
		FROM [dbo].[JOB_HISTORY_STAGING] s
		LEFT OUTER JOIN [dbo].[JOB_HISTORY] h
		ON h.[instance_id] = s.[instance_id]
		WHERE h.[instance_id] IS NULL
	)

	SELECT
		s.[instance_id]
	,	s.[job_id]
	,	s.[step_id]
	,	s.[step_name]
	,	s.[sql_message_id]
	,	s.[sql_severity]
	,	s.[message]
	,	s.[run_status]
	,	s.[run_date]
	,	s.[run_time]
	,	s.[run_duration]
	,	s.[operator_id_emailed]
	,	s.[operator_id_netsent]
	,	s.[operator_id_paged]
	,	s.[retries_attempted]
	,	s.[server]
	FROM [dbo].[JOB_HISTORY_STAGING] s
	JOIN CTE_NEW_INSTANCE_IDS n
	ON n.[instance_id] = s.[instance_id];
END
GO
PRINT N'Creating [dbo].[GET_ROWS_TO_LOAD_FROM_SYSJOBS]...';


GO
CREATE PROCEDURE [dbo].[GET_ROWS_TO_LOAD_FROM_SYSJOBS]
	@START_JOB_INSTANCE_ID	INT
,	@END_JOB_INSTANCE_ID	INT
AS
BEGIN
	SELECT
		[instance_id]
	,	[job_id]
	,	[step_id]
	,	[step_name]
	,	[sql_message_id]
	,	[sql_severity]
	,	[message]
	,	[run_status]
	,	[run_date]
	,	[run_time]
	,	[run_duration]
	,	[operator_id_emailed]
	,	[operator_id_netsent]
	,	[operator_id_paged]
	,	[retries_attempted]
	,	[server]
	FROM [msdb].[dbo].[sysjobhistory]
	WHERE [instance_id] 
		BETWEEN @START_JOB_INSTANCE_ID AND @END_JOB_INSTANCE_ID;
END
GO
PRINT N'Creating [dbo].[GET_START_JOB_INSTANCE_ID]...';


GO
CREATE PROCEDURE [dbo].[GET_START_JOB_INSTANCE_ID]
AS
BEGIN
	DECLARE @MAX_JOB_INSTANCE_ID INT = NULL;

	SELECT
		@MAX_JOB_INSTANCE_ID = MAX([instance_id]) + 1
	FROM [dbo].[JOB_HISTORY];
	
	SELECT COALESCE(@MAX_JOB_INSTANCE_ID, 1);
END
GO
PRINT N'Update complete.';


GO
