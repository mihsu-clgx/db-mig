@CALL setenv.bat
@SET db=%1


@REM SET host=%1
@REM SET db=%2
@REM to sbx in GCP
@REM SET TOHOST=10.39.40.183
@REM DEV 
@REM SET TOHOST=10.46.184.249
@REM SBX
@REM SET TOHOST=10.39.41.215
@REM SET db=taxservices
@REM SET ADMIN=tsadmin
@REM SET MYPW=Greatwatercak3g

@mysql --login-path=%MYLP%  information_schema  -sNe "select concat('select \"',lower(table_name), '\", count(1) from %DB%.',table_name,';') from information_schema.tables where table_schema='%DB%' and table_name NOT IN (select table_name from information_schema.views where table_schema='%db%') order by 1;" > %db%-cnt-my.tmp
@REM cat %db%-cnt-my.tmp
@mysql --login-path=%MYLP%  information_schema  -sN < %db%-cnt-my.tmp |awk "{print $1 \",\" $2}" | sort > %db%-tbl-cnt-my.lst

@type %db%-tbl-cnt-my.lst
