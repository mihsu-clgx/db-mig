@CALL setenv.bat
@IF "%1" == "" GOTO Error
@SET db=%1
@ECHO ... diff bcp and load results
@CALL %FPATH%\mig-diff-bcp-load.bat %db%
@ECHO 
@ECHO ... may need to run fix load scripts
@ECHO 
@ECHO ... analyze table mysql
@CALL %FPATH%\analyze-tbl.bat %db%
@ECHO ... count objects mysql
@CALL %FPATH%\mig-obj-cnt-my.bat %db%
@ECHO ... count objects sql server
@CALL %FPATH%\mig-obj-cnt-ss.bat %db%
@ECHO ... count tables mysql
@CALL %FPATH%\mig-tbl-cnt-my.bat %db%
@ECHO ... count tables sql server
@CALL %FPATH%\mig-tbl-cnt-ss.bat %db%
@ECHO ... diff
@CALL %FPATH%\mig-diff.bat %db%
@GOTO TheEnd
:Error
@ECHO Error - no db specified
:TheEnd
