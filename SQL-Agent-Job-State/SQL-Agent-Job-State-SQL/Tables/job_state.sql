CREATE TABLE [dbo].[job_state]
(
	[id]			INT IDENTITY		NOT NULL 
,	[server_name]	NVARCHAR(128)		NOT NULL
,	[job_id]		UNIQUEIDENTIFIER	NOT NULL
,	[state]			NVARCHAR(4000)		NULL
,	CONSTRAINT pkc_job_state PRIMARY KEY CLUSTERED
		([job_id], [server_name])
,	[last_modified] DATETIME			NOT NULL
)
