set db=%1
egrep "dbo|rows copied" bcp-%db%.log|sed "s/.*queryout//;s/.csv .*$//"|sed "N;s/\n/ /"|sed "/ 0 rows copied/d"|sed "s/ rows copied.*$//"|sort > bcp-%db%-row-cnt.lst
grep "ROWCNT" load-%db%.log|sed "s/ROWCNT//;s/\t//;s/= //"|sort > load-%db%-row-cnt.lst
diff -y bcp-%db%-row-cnt.lst load-%db%-row-cnt.lst | sed -n "/|/p;/>/p;/</p"
