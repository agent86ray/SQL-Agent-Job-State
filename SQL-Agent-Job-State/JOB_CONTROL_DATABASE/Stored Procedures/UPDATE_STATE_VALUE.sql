﻿CREATE PROCEDURE [dbo].[UPDATE_STATE_VALUE]
	@STATE_ID		BIGINT
,	@PATH			NVARCHAR(50)
,	@INT_VALUE		INT	= NULL
AS
BEGIN
	UPDATE [dbo].[STATE]
	SET
		CUSTOM_STATE = JSON_MODIFY(CUSTOM_STATE, @PATH, @INT_VALUE)
	WHERE [STATE_ID] = @STATE_ID;
END
