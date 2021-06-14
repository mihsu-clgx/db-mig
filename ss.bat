@CALL setenv.bat
@CALL setdb.bat
sqlcmd -S %SRCHOST% -d %db% -y90 -Y90
