@CALL setenv.bat
@SET db=%1
@SET host=%SRCHOST%
@REM SET host=EDGQN1VPSQLKP01
@REM SET db=WebHarvesting_Control
@REM SET host=EDGQN1VPLAFST03
@REM SET db=TaxServices

@REM echo "start count %db% "
@echo SET NOCOUNT ON; > %db%-tbl-cnt-ss.tmp
@sqlcmd -S %host% -d %db% -h -1 -Q "SET NOCOUNT ON; select concat('select ''',lower(table_name),''',count(1) from ',table_name,' (nolock);') from INFORMATION_SCHEMA.TABLES where table_catalog='%db%' and table_schema='dbo' and table_type='BASE TABLE' order by 1" >> %db%-tbl-cnt-ss.tmp
@REM type %db%-tbl-cnt-ss.tmp
@sqlcmd -S %host% -d %db% -h -1 -i %db%-tbl-cnt-ss.tmp | awk "{print $1 \",\" $2}" | sort > %db%-tbl-cnt-ss.lst
@type %db%-tbl-cnt-ss.lst
