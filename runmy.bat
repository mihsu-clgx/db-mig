@CALL setenv.bat
mysql --login-path=%MYLP% -s information_schema < %1 > %1.log 2>&1
grep -i error %1.log
cat %1.log