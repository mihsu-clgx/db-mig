@CALL setenv.bat
@SET db=%1
@SET host=%SRCHOST%
@REM SET host=
@REM SET db=
@REM SET host=
@REM SET db=

@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'table',lower(table_name) from information_schema.tables where table_schema='dbo' and table_type='BASE TABLE' order by 2" | awk "{print $1 \",\" $2}" | sort > %db%-tbl-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'view',lower(table_name) from information_schema.views where table_schema='dbo'  order by 2"  | awk "{print $1 \",\" $2}"  | sort > %db%-view-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'column',concat(lower(c.table_name),'.',lower(c.column_name)) column_name from information_schema.columns c,information_schema.tables t  where c.TABLE_SCHEMA='dbo' and t.TABLE_SCHEMA='dbo' and c.table_name=t.TABLE_NAME and t.table_type='BASE TABLE' order by 2; " | awk "{print $1 \",\" $2}" | sort > %db%-column-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'pk_constraint', lower(constraint_name) pk_constraint from information_schema.table_constraints where constraint_type='PRIMARY KEY' AND CONSTRAINT_SCHEMA='dbo' order by 2"  | awk "{print $1 \",\" $2}" | sort > %db%-pk-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'fk_constraint',lower(constraint_name) fk_name from information_schema.table_constraints where constraint_type='FOREIGN KEY' AND CONSTRAINT_SCHEMA='dbo'  order by 2"  | awk "{print $1 \",\" $2}" | sort > %db%-fk-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'index', lower(I.name) FROM sys.indexes I, sys.tables T WHERE I.[object_id] = T.[object_id] AND I.type_desc <> N'HEAP' AND SCHEMA_NAME(T.[schema_id])='dbo'  order by 2" | awk "{print $1 \",\" $2}"  | sort > %db%-index-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'routine', lower(routine_name) from information_schema.routines where routine_schema='dbo'  order by 2"  | awk "{print $1 \",\" $2}" | sort > %db%-routine-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'trigger', lower(name) FROM sys.triggers t , sys.objects o WHERE t.type = 'TR' and t.object_id=o.object_id AND SCHEMA_NAME(o.[schema_id])='dbo'  order by 2 " | awk "{print $1 \",\" $2}" | sort > %db%-trigger-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'identity_column', concat(lower(T.name), lower(C.name)) table_column FROM sys.columns C, sys.tables T WHERE C.[object_id] = T.[object_id] AND SCHEMA_NAME(T.[schema_id])='dbo' AND C.is_identity=1  order by 2" | awk "{print $1 \",\" $2}" | sort > %db%-identity-ss.lst

@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'object_type,count' " | awk "{print $1 \",\" $2}" > %db%-obj-cnt-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'table',count(1) cnt from information_schema.tables where table_schema='dbo' and table_type='BASE TABLE' " | awk "{print $1 \",\" $2}" >> %db%-obj-cnt-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'view',count(1) cnt from information_schema.views where table_schema='dbo' "  | awk "{print $1 \",\" $2}" >> %db%-obj-cnt-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'column',count(1) from information_schema.columns c,information_schema.tables t  where c.TABLE_SCHEMA='dbo' and t.TABLE_SCHEMA='dbo' and c.table_name=t.TABLE_NAME and t.table_type='BASE TABLE' "  | awk "{print $1 \",\" $2}" >> %db%-obj-cnt-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'pk_constraint',count(1) cnt from information_schema.table_constraints where constraint_type='PRIMARY KEY' AND CONSTRAINT_SCHEMA='dbo' "  | awk "{print $1 \",\" $2}" >> %db%-obj-cnt-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'fk_constraint',count(1) cnt from information_schema.table_constraints where constraint_type='FOREIGN KEY' AND CONSTRAINT_SCHEMA='dbo' "  | awk "{print $1 \",\" $2}" >> %db%-obj-cnt-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'index', count(1) FROM sys.indexes I, sys.tables T WHERE I.[object_id] = T.[object_id] AND I.type_desc <> N'HEAP' AND SCHEMA_NAME(T.[schema_id])='dbo' " | awk "{print $1 \",\" $2}" >> %db%-obj-cnt-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'routine',count(1) cnt from information_schema.routines where routine_schema='dbo' "  | awk "{print $1 \",\" $2}" >> %db%-obj-cnt-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'trigger',count(1) cnt FROM sys.triggers t , sys.objects o WHERE t.type = 'TR' and t.object_id=o.object_id AND SCHEMA_NAME(o.[schema_id])='dbo' " | awk "{print $1 \",\" $2}" >> %db%-obj-cnt-ss.lst
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select 'identity_column', count(1) cnt FROM sys.columns C, sys.tables T WHERE C.[object_id] = T.[object_id] AND SCHEMA_NAME(T.[schema_id])='dbo' AND C.is_identity=1 " | awk "{print $1 \",\" $2}" >> %db%-obj-cnt-ss.lst

@type %db%-obj-cnt-ss.lst


