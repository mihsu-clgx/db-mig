@CALL setdb.bat
@if not exist "%db%" mkdir %db%
@echo echo job start %%date%%-%%time%% > sed-%db%.bat
@dir *.csv|grep -v " 0 "|grep -v "File(s)"|awk "{print $5}"|grep ".csv"|sed "s/^/call sed1.bat %db% /;s/.csv//" >> sed-%db%.bat
@echo echo job end   %%date%%-%%time%% >> sed-%db%.bat
@TYPE sed-%db%.bat
@echo ... sed-%db%.bat
