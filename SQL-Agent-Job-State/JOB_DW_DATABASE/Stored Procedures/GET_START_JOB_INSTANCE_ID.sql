﻿CREATE PROCEDURE [dbo].[GET_START_JOB_INSTANCE_ID]
AS
BEGIN
	DECLARE @MAX_JOB_INSTANCE_ID INT = NULL;

	SELECT
		@MAX_JOB_INSTANCE_ID = MAX([instance_id])
	FROM [dbo].[JOB_HISTORY];
	
	SELECT COALESCE(@MAX_JOB_INSTANCE_ID, 1);
END