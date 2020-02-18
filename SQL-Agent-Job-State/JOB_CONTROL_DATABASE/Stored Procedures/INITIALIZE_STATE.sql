/*

	This procedure should be called as the first step in a SQL Agent job.
	The purpose is to set the CUSTOM_STATE based on the needs of the job
	and overwrite any statethat exists from a previous execution of the 
	SQL Agent job.

*/
CREATE PROCEDURE [dbo].[INITIALIZE_STATE]
	@STATE_ID		BIGINT
,	@CUSTOM_STATE	NVARCHAR(4000) = NULL
AS
BEGIN
	UPDATE [dbo].[STATE]
	SET
		CUSTOM_STATE = @CUSTOM_STATE
	WHERE [STATE_ID] = @STATE_ID;

	IF @@ROWCOUNT = 0
		INSERT [dbo].[STATE] (
			[STATE_ID]
		,	[NAME]
		,	[CUSTOM_STATE]
		)
		VALUES (
			@STATE_ID
		,	CONCAT(
				N'STATE FOR STATE_ID = '
			,	CONVERT(NVARCHAR(20), @STATE_ID)
			)
		,	@CUSTOM_STATE
		);
END

