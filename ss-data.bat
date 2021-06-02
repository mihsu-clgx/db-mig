@CALL setenv.bat
sed "s/from /from dbo./" %1 | sqlcmd -S %SRCHOST% -d %db% -h -1 |sed "s/^ *//;s/ *//g" > %1.ss.dat
head %1.ss.dat
