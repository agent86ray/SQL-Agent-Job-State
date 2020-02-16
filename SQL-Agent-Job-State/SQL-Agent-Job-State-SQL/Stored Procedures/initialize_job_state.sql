CREATE PROCEDURE [dbo].[initialize_job_state]
	@p_job_id	NVARCHAR(50)
,	@p_state	NVARCHAR(4000)
AS
BEGIN
	DECLARE 
		@job_id			UNIQUEIDENTIFIER = TRY_CONVERT(UNIQUEIDENTIFIER, @p_job_id)
	,	@error_msg		NVARCHAR(MAX)
	,	@last_modified	DATETIME = GETDATE();

	IF @job_id IS NULL
	BEGIN
		SET @error_msg = CONCAT(
		 	@p_job_id
		,	N' is not a valid Job ID.'
		);
		THROW 2147483647, @error_msg, 1; 
	END

	UPDATE [dbo].[job_state]
	SET 
		[state] = @p_state
	,	[last_modified] = @last_modified
	WHERE job_id = @job_id
	AND [server_name] = @@SERVERNAME;

	IF @@ROWCOUNT = 0
	BEGIN
		INSERT [dbo].[job_state] (
			[job_id]
		,	[server_name]
		,	[state]
		,	[last_modified]
		)
		VALUES (
			@job_id
		,	@@SERVERNAME
		,	@p_state
		,	@last_modified
		)
	END
END