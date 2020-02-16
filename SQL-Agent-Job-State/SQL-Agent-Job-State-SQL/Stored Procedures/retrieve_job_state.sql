/*

	Retrieve the job state for a SQL Agent job. The @p_job_state_id parameter
	should come from the SSIS environment with the same name as the SQL Agent
	job.

*/
CREATE PROCEDURE [dbo].[retrieve_job_state]
	@p_job_state_id	INT
AS
BEGIN
	SELECT
		[id] AS JOB_STATE_ID
	,	[server_name] AS SERVER_NAME
	,	CONVERT(NVARCHAR(50), job_id) AS JOB_ID
	,	COALESCE([state], '')	AS [CUSTOM_STATE]		
	FROM [dbo].[job_state]
	WHERE [id] = @p_job_state_id;
END