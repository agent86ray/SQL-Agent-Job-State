-- SCRIPT: CREATE_JOB_STATE
-- this script creates a new row for job state for a SQL Agent job

INSERT [dbo].[job_state] (
	[server_name]
,	[job_id]
,	[state]	
,	[last_modified]
)
VALUES (
	@@SERVERNAME
,	'12D9E97B-C2F0-4FAD-801A-143E9B421F38'	-- SAMPLE DATA LOAD with JOB STATE
,	NULL
,	GETDATE()
)

SELECT SCOPE_IDENTITY()

