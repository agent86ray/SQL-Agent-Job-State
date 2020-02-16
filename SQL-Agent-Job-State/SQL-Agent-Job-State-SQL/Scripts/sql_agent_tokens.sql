-- copy/paste this script in a SQL Agent job step
-- to see the tokens and their values
INSERT [dbo].[sql_agent_token_value] (
	[token]	
,	[value]	
)
SELECT
	N'JOBID-STRING'
,	CONVERT(NVARCHAR(50), CONVERT(uniqueidentifier, $(ESCAPE_NONE(JOBID))))

UNION ALL

SELECT
	N'STEPID'
,	CONVERT(NVARCHAR(50), $(ESCAPE_SQUOTE(STEPID)))

UNION ALL

SELECT
	N'STRTDT'
,	CONVERT(NVARCHAR(50), $(ESCAPE_SQUOTE(STRTDT)))

UNION ALL

SELECT
	N'STRTTM'
,	CONVERT(NVARCHAR(50), $(ESCAPE_SQUOTE(STRTTM)))

