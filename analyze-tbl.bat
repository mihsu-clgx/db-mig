@CALL setenv.bat
@SET db=%1
@mysql --login-path=%MYLP%  information_schema  -sNe "select concat('analyze table ',lower(table_name), ' ;') from information_schema.tables where table_schema='%DB%' and table_type='BASE TABLE' order by 1;" > %db%-analyze-my.tmp
@REM cat %db%-analyzemy.tmp
@mysql --login-path=%MYLP%  %db% -sN < %db%-analyze-my.tmp 

