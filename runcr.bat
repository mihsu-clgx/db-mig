@IF "%2" == "" GOTO Error
@SET db=%1
@CALL setenv.bat
mysql --login-path=%MYLP% -s %db% < %2 > %2.log 2>&1
grep -i error %2.log
cat %2.log
@GOTO TheEnd
:Error
@ECHO Error - need db and sql file
:TheEnd
