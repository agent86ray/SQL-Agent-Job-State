/*

	The T-SQL below returns the error:  
	
	Incorrect syntax near ''. [SQLSTATE 42000] (Error 102).  The step failed.

*/
DECLARE 
   @t_token TABLE (
         [token_value]     NVARCHAR(50)
    );

INSERT @t_token ([token_value])
EXEC [dbo].[parse_sql_agent_jobid_token]
   @p_sql_agent_jobid_token = $(ESCAPE_NONE(JOBID));

INSERT [dbo].[sql_agent_token_value] (
	[token]	
,	[value]	
)
SELECT
	N'JOBID-STRING'
,	[token_value]
FROM @t_token;
