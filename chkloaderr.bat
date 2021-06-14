@call setdb.bat
@egrep -i "ROWCNT|ERROR" load-%db%.log |grep -v "call load1tbl.bat" | sed "s/^.*from//;s/;\"//"
@echo num files to load:
@dir *.csv|grep -v " 0 "|grep -v "File(s)"  | grep ".csv" | wc -l
@echo num files loaded:
@grep "ROWCNT" load-%db%.log | wc -l
@grep -i "ERROR" load-%db%.log |grep -v "call load1tbl.bat" | sed "s/^.*from//;s/;\"//"
@egrep "^job start|^job end" load-%db%.log 
