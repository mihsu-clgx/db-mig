@CALL setenv.bat
@SET DB=%1
@SET TBL=%2
@echo %date%-%time% start sed
@tr -cd '\11\12\15\36\37\40-\176' < %FPATH%\dump_%DB%\%TBL%.csv | sed "s/^/\\N/;s/\\/\\\\/g;s//\\N/g;s//\\N/g;s/$/\\N/;" > %FPATH%\dump_%DB%\%TBL%.tmp
@mysql.exe --login-path=%MYLP% -s %DB% -sNe "SET SESSION UNIQUE_CHECKS=0;SET SESSION FOREIGN_KEY_CHECKS=0; truncate table %TBL%; " 
@echo %date%-%time% start load
@mysql.exe --login-path=%MYLP% -s %DB% -e "SET SESSION UNIQUE_CHECKS=0;SET SESSION FOREIGN_KEY_CHECKS=0; LOAD DATA LOCAL INFILE '%FPATH%\\dump_%DB%\\%TBL%.tmp' INTO TABLE %TBL% FIELDS TERMINATED BY "0x1F" ENCLOSED BY ''  LINES TERMINATED BY '\n\r|||';" 
@echo %date%-%time% end load
@mysql.exe --login-path=%MYLP% -s %DB% -sNe "select 'ROWCNT %TBL% = ',count(1) from %TBL%;"
@rm %FPATH%\dump_%DB%\%TBL%.tmp

