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