CREATE PROCEDURE [dbo].[parse_sql_agent_jobid_token]
	@p_sql_agent_jobid_token	NVARCHAR(50)
AS
BEGIN
	DECLARE 
		@sql	NVARCHAR(100) = CONCAT(
					'SELECT @job_id_out = CONVERT(UNIQUEIDENTIFIER, '
				,	@p_sql_agent_jobid_token
				,	N')')
	,	@job_id UNIQUEIDENTIFIER;

	EXEC sp_executesql @sql, N'@job_id_out UNIQUEIDENTIFIER OUTPUT', @job_id_out = @job_id OUTPUT;

	SELECT CONVERT(NVARCHAR(50), @job_id);
END
