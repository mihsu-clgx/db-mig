grep -i error bcp-%db%.log |egrep -v "ODBC Driver 17|NativeError = 0"
egrep "job start|job end" bcp-%db%.log 
