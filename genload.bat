@IF "%1" == "" GOTO ERR
@SET db=%1
@echo echo job start %%date%%-%%time%% > load-%db%.bat
@dir *.csv|grep -v " 0 "|grep -v "File(s)"|awk "{print $5}"|grep ".csv"|sed "s/^/call load1tbl.bat %db% /;s/.csv//" >> load-%db%.bat
@echo echo job   end %%date%%-%%time%% >> load-%db%.bat
@TYPE load-%db%.bat
@echo ... load-%db%.bat
@GOTO EOF
:ERR 
@echo input db name required
:EOF
