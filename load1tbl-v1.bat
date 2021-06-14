
SET DB=%1
SET TBL=%2
@REM to sbx in GCP
SET TOHOST=10.39.40.183
SET MYADM=kofaxadmin
SET MYPW=Desktreel00k
SET FPATH=C:\\mig
sed "/^$/d;/^$/d;s/^/\\N/;s//\\N/g;s//\\N/g;s/$/\\N/;" %FPATH%\dump_%DB%\%TBL%.csv > %FPATH%\dump_%DB%\%TBL%.tmp
mysql.exe -h%TOHOST% -u%MYADM% -p%MYPW% %DB% -e "SET SESSION UNIQUE_CHECKS=0;SET SESSION FOREIGN_KEY_CHECKS=0; truncate table %TBL%; " 
mysql.exe -h%TOHOST% -u%MYADM% -p%MYPW% %DB% -e "SET SESSION UNIQUE_CHECKS=0;SET SESSION FOREIGN_KEY_CHECKS=0; LOAD DATA LOCAL INFILE '%FPATH%\\dump_%DB%\\%TBL%.tmp' INTO TABLE %TBL% FIELDS TERMINATED BY "0x1F" ENCLOSED BY ''  LINES TERMINATED BY '\n\r';" 
@REM del %FPATH%\dump_%DB%\%TBL%.tmp
mysql.exe -h%TOHOST% -u%MYADM% -p%MYPW% %DB% -e "select count(1) from %TBL%;"

