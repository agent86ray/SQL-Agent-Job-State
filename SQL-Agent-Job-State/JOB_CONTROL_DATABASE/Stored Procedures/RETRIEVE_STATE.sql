﻿CREATE PROCEDURE [dbo].[RETRIEVE_STATE]
	@STATE_ID		BIGINT
AS
BEGIN
	SELECT
		COALESCE([CUSTOM_STATE], N'') AS [CUSTOM_STATE]
	,	[LAST_MODIFIED]
	FROM [dbo].[STATE];
END
