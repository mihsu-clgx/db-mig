@CALL setenv.bat
@CALL setdb.bat
mysql --login-path=%MYLP% %db%
