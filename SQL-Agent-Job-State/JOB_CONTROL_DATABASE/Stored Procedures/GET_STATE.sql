﻿CREATE PROCEDURE [dbo].[GET_STATE]
	@P_STATE_ID		BIGINT
,	@P_CUSTOM_STATE	NVARCHAR(4000) OUTPUT
AS
BEGIN
	DECLARE @CUSTOM_STATE	NVARCHAR(4000);

	SELECT
		@CUSTOM_STATE = [CUSTOM_STATE]
	FROM [dbo].[STATE]
	WHERE [STATE_ID] = @P_STATE_ID;

	SET @P_CUSTOM_STATE = COALESCE(@CUSTOM_STATE, N'');
END
