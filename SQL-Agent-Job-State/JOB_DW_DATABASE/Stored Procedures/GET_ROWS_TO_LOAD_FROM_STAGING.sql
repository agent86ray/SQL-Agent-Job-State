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
