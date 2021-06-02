@echo %cd% |sed "s/^.*dump_//;s/ *//g">dbis.txt
@SET /p db= < dbis.txt
@ECHO %db%
