CREATE TABLE [dbo].[job_state]
(
	[id]			INT IDENTITY		NOT NULL 
,	[server_name]	NVARCHAR(128)		NOT NULL
,	[job_id]		UNIQUEIDENTIFIER	NOT NULL
,	[state]			NVARCHAR(4000)		NULL
)
