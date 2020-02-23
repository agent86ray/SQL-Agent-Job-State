CREATE TABLE [dbo].[JOB_HISTORY]
(
    [instance_id] int,
    [job_id] uniqueidentifier,
    [step_id] int,
    [step_name] nvarchar(128),
    [sql_message_id] int,
    [sql_severity] int,
    [message] nvarchar(4000),
    [run_status] int,
    [run_date] int,
    [run_time] int,
    [run_duration] int,
    [operator_id_emailed] int,
    [operator_id_netsent] int,
    [operator_id_paged] int,
    [retries_attempted] int,
    [server] nvarchar(128)
)
