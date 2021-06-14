@set db=%1
@egrep "dbo|rows copied" dump_%db%\bcp-%db%.log|sed "s/.*queryout//;s/.csv .*$//"|sed "N;s/\n/ /"|sed "/ 0 rows copied/d"|sed "s/ rows copied.*$//;s/ *//g"|sort > bcp-%db%-row-cnt.lst
@grep "ROWCNT" load-%db%.log|sed "s/ROWCNT//;s/\t//;s/= //;s/ *//g"|sort > load-%db%-row-cnt.lst
@echo diff -y bcp-%db%-row-cnt.lst load-%db%-row-cnt.lst
@echo ----------------------------------------------------------------------
@diff -y bcp-%db%-row-cnt.lst load-%db%-row-cnt.lst | sed -n "/|/p;/>/p;/</p"
@echo ----------------------------------------------------------------------
