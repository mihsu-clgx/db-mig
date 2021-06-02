SET db=%1
@echo ... object count
@diff -y %db%-obj-cnt-ss.lst  %db%-obj-cnt-my.lst    
@echo ... table list
@diff -y %db%-tbl-ss.lst      %db%-tbl-my.lst        | sed -n "/|/p;/>/p;/</p"
@echo ... column list
@diff -y %db%-column-ss.lst   %db%-column-my.lst     | sed -n "/|/p;/>/p;/</p"
@REM diff -y %db%-pk-ss.lst       %db%-pk-my.lst         | sed -n "/|/p;/>/p;/</p"
@REM diff -y %db%-fk-ss.lst       %db%-fk-my.lst         | sed -n "/|/p;/>/p;/</p"
@REM diff -y %db%-index-ss.lst    %db%-index-my.lst      | sed -n "/|/p;/>/p;/</p"
@REM diff -y %db%-routine-ss.lst  %db%-routine-my.lst    | sed -n "/|/p;/>/p;/</p"
@REM diff -y %db%-trigger-ss.lst  %db%-trigger-my.lst    | sed -n "/|/p;/>/p;/</p"
@echo ... view list
@diff -y %db%-view-ss.lst     %db%-view-my.lst       | sed -n "/|/p;/>/p;/</p"
@echo ... bcp vs load row count
@diff -y bcp-%db%-row-cnt.lst load-%db%-row-cnt.lst   | sed -n "/|/p;/>/p;/</p"
@ECHO ... realtime row count
@diff -y %db%-tbl-cnt-ss.lst      %db%-tbl-cnt-my.lst        | sed -n "/|/p;/>/p;/</p"


