
DECLARE @job_id NVARCHAR(50) = TRY_CONVERT(NVARCHAR(50), NEWID());
SELECT @job_id

-- E80C9011-5DA0-46EE-B521-5EB17E9E1607

/*

	TRUNCATE TABLE [dbo].[job_state]

*/

DECLARE @state	NVARCHAR(4000) = N'{"record_count":0}';

EXEC [dbo].[initialize_job_state]
	@p_job_id = '1B6C102B-B5DE-46AF-A17F-FFE6CD9C7768'
,	@p_state = @state

SELECT * FROM [dbo].[job_state];


DECLARE @new_record_count INT = 666;
UPDATE [dbo].[job_state]
SET [state] = JSON_MODIFY([state], '$.record_count', @new_record_count)
WHERE job_id = CONVERT(UNIQUEIDENTIFIER, '1B6C102B-B5DE-46AF-A17F-FFE6CD9C7768');

SELECT * FROM [dbo].[job_state];


DECLARE @new_record_count INT = 777;
UPDATE [dbo].[job_state]
SET [state] = JSON_MODIFY([state], '$.record_count', @new_record_count)
WHERE job_id = CONVERT(UNIQUEIDENTIFIER, '1B6C102B-B5DE-46AF-A17F-FFE6CD9C7768');

SELECT * FROM [dbo].[job_state];



EXEC [dbo].[initialize_job_state]
  @p_job_id = '1B6C102B-B5DE-46AF-A17F-FFE6CD9C7768'
, @p_state = N'{"step_id":1}';

SELECT * FROM [dbo].[job_state];


SELECT NEWID()


DECLARE @CURRENT_TIME DATETIME = GETDATE();
DECLARE @JSON NVARCHAR(4000) = CONCAT(N'{"initialize_time":', CONVERT(NVARCHAR(20), @CURRENT_TIME), N'}');
EXEC [dbo].[initialize_job_state]
  @p_job_id = '09D20716-DC00-41C7-A6C7-9C244C8BE288'
, @p_state = @JSON;

SELECT * FROM [dbo].[job_state];






DECLARE @state	NVARCHAR(4000) = N'{"record_count":0}';
DECLARE @new_record_count INT = 50;
SET @state = JSON_MODIFY(@state, '$.record_count', @new_record_count);
SELECT @state

EXEC [dbo].[initialize_job_state]
	@p_job_id = '1B6C102B-B5DE-46AF-A17F-FFE6CD9C7768'
,	@p_state = @state

SELECT * FROM [dbo].[job_state];


SELECT CONVERT(UNIQUEIDENTIFIER, '1B6C102B-B5DE-46AF-A17F-FFE6CD9C7768')

UPDATE [dbo].[job_state]
SET [state] = JSON_MODIFY([state], '$.record_count', '666')
WHERE job_id = CONVERT(UNIQUEIDENTIFIER, '1B6C102B-B5DE-46AF-A17F-FFE6CD9C7768');

SELECT * FROM [dbo].[job_state];






DECLARE
	@p_job_id	NVARCHAR(50) = 'E80C9011-5DA0-46EE-B521-5EB17E9E1607';
DECLARE
	@job_id		UNIQUEIDENTIFIER = TRY_CONVERT(UNIQUEIDENTIFIER, @p_job_id)
,	@error_msg	NVARCHAR(MAX)	;

SELECT @job_id

			SET @error_msg = CONCAT(
				N'State exists for Job ID '
			,	@p_job_id
			,	N'; restart or ignore previous state'
			);

			SELECT @error_msg;

	DECLARE
		@p_job_id	NVARCHAR(50) = N'BLAH';
	DECLARE 
		@job_id		UNIQUEIDENTIFIER = TRY_CONVERT(UNIQUEIDENTIFIER, @p_job_id)
	,	@error_msg	NVARCHAR(MAX);

	IF @job_id IS NULL
	BEGIN
		SET @error_msg = CONCAT(
		 	@p_job_id
		,	N' is not a valid Job ID.'
		);
		THROW 2147483647, @error_msg, 1; 
	END

	SELECT 'should never get here'







