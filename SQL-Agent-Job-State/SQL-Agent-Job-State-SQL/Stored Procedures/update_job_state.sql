/*

	Update the job state for a SQL Agent job. The @p_job_state_id parameter
	should come from the SSIS environment with the same name as the SQL Agent
	job.

*/
CREATE PROCEDURE [dbo].[update_job_state]
	@p_job_state_id	INT
,	@p_custom_state	NVARCHAR(4000)
AS
BEGIN
	DECLARE
		@last_modified	DATETIME = GETDATE();

	UPDATE [dbo].[job_state]
	SET 
		[state] = @p_custom_state
	,	[last_modified] = @last_modified
	WHERE [id] = @p_job_state_id
	AND [server_name] = @@SERVERNAME;

	IF @@ROWCOUNT = 0
	BEGIN
		DECLARE @error_msg NVARCHAR(MAX) =
			CONCAT(
				N'There is no state for the job with the Id = '
			,	TRY_CONVERT(NVARCHAR(10), @p_job_state_id)
			);
		THROW 2147483647, @error_msg, 1; 
	END
END