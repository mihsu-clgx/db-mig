@CALL setenv.bat
mysql --login-path=%MYLP%  -sN %db% < %1  |sed "s/ *//g" > %1.my.dat
head %1.my.dat
