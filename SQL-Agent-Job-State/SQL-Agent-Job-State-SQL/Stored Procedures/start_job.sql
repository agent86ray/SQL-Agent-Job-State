CREATE PROCEDURE [dbo].[start_job]
	@p_job_id					NVARCHAR(50)
,	@p_state					NVARCHAR(4000) = null
,	@p_ignore_previous_state	INT = 0
AS
BEGIN
	DECLARE 
		@job_id		UNIQUEIDENTIFIER = TRY_CONVERT(UNIQUEIDENTIFIER, @p_job_id)
	,	@error_msg	NVARCHAR(MAX);

	-- TO DO: THROW error if @p_job_id is not valid

	IF @p_ignore_previous_state = 0
	BEGIN
		IF EXISTS (
			SELECT TOP 1 
				* 
			FROM [dbo].[job_state]
			WHERE job_id = @job_id
		)
		BEGIN
			SET @error_msg = CONCAT(
				N'State exists for Job ID '
			,	@p_job_id
			,	N'; restart or ignore previous state'
			);
			THROW 2147483647, @error_msg, 1; 
		END

		INSERT [dbo].[job_state] (
			[job_id]
		,	[server_name]
		)
		VALUES (
			@job_id
		,	@@SERVERNAME
		)
	END
END

