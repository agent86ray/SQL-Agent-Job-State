/*
	This procedure should be called in each SQL Agent job step where there 
	are changes to the state that need to be persisted. The thought is that 
	ths procedure would be called when the SSIS package is done (either successfully
	or has failed).

*/
CREATE PROCEDURE [dbo].[UPDATE_STATE]
	@STATE_ID		BIGINT
,	@CUSTOM_STATE	NVARCHAR(4000) = NULL
AS
BEGIN
	UPDATE [dbo].[STATE]
	SET
		CUSTOM_STATE = @CUSTOM_STATE
	WHERE [STATE_ID] = @STATE_ID;
END

