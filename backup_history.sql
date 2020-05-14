/*  Backup history, previous 60 days.  */
select
cast (SERVERPROPERTY('Servername') AS varchar(100)) as sql_server_name,
bs.[database_name],
bs.backup_start_date,
bs.backup_finish_date,
case bs.[type]
     WHEN 'D' THEN 'Database'
     WHEN 'L' THEN 'Log'
     When 'I' THEN 'Differential database'
end as backup_type,
bs.backup_size,
bmf.physical_device_name
from msdb.dbo.backupmediafamily  as bmf
inner join msdb.dbo.backupset as bs ON bmf.media_set_id = bs.media_set_id
WHERE (CONVERT(datetime, bs.backup_start_date, 102) >= GETDATE()-60 )
ORDER BY bs.backup_finish_date desc;
go