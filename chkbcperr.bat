@CALL setdb.bat
@egrep "bcp|rows copied|Error|error" bcp-%db%.log |egrep -v "SQLState|ODBC Driver"|sed "s/.*\[dbo\].//;s/(nolock.*//"
@egrep "job start|job end" bcp-%db%.log | grep -v "echo"
@echo current   %date%-%time%
@grep bcp bcp-%db%.bat |wc -l
@grep "rows copied" bcp-%db%.log | wc -l
