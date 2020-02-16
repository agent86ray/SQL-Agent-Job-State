CREATE PROCEDURE [dbo].[update_job_state]
	@p_job_id	UNIQUEIDENTIFIER
,	@p_state	NVARCHAR(4000)
AS
BEGIN
	DECLARE
		@last_modified	DATETIME = GETDATE();

	UPDATE [dbo].[job_state]
	SET 
		[state] = @p_state
	,	[last_modified] = @last_modified
	WHERE job_id = @p_job_id
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
			@p_job_id
		,	@@SERVERNAME
		,	@p_state
		,	@last_modified
		)
	END
END