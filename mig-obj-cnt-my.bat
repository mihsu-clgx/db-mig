@CALL setenv.bat
@SET db=%1

@REM SET host=%1
@REM SET db=%2



@mysql --login-path=%MYLP%  information_schema  -sNe "select 'table',lower(table_name) from information_schema.tables where table_schema='%db%' and table_type='BASE TABLE' order by 2" | awk "{print $1 \",\" $2}" | sort > %db%-tbl-my.lst

@mysql --login-path=%MYLP%  information_schema  -sNe "select 'view',lower(table_name) from information_schema.views where table_schema='%db%'  order by 2"  | awk "{print $1 \",\" $2}" | sort > %db%-view-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'column',concat(lower(table_name),'.',lower(column_name)) column_name from information_schema.columns where TABLE_SCHEMA='%db%' and table_name  NOT IN (select table_name from information_schema.views where table_schema='%db%') order by 2"  | awk "{print $1 \",\" $2}" | sort > %db%-column-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'pk_constraint', lower(constraint_name) pk_constraint from information_schema.table_constraints where constraint_type='PRIMARY KEY' AND CONSTRAINT_SCHEMA='%db%' order by 2"  | awk "{print $1 \",\" $2}" | sort > %db%-pk-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'fk_constraint', lower(constraint_name) fk_name from information_schema.table_constraints where constraint_type='FOREIGN KEY' AND CONSTRAINT_SCHEMA='%db%'  order by 2"  | awk "{print $1 \",\" $2}" | sort > %db%-fk-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'uk_constraint', lower(constraint_name) fk_name from information_schema.table_constraints where constraint_type='UNIQUE' AND CONSTRAINT_SCHEMA='%db%'  order by 2"  | awk "{print $1 \",\" $2}" | sort > %db%-fk-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'index', lower(index_name) FROM information_schema.STATISTICS WHERE table_schema='%db%'  order by 2" | awk "{print $1 \",\" $2}" | sort > %db%-index-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'routine', lower(routine_name) from information_schema.routines where routine_schema='%db%'  order by 2"  | awk "{print $1 \",\" $2}" | sort > %db%-routine-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'trigger', lower(trigger_name) FROM information_schema.triggers WHERE trigger_schema='%db%'  order by 2 " | awk "{print $1 \",\" $2}" | sort > %db%-trigger-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'auto_incr', concat(lower(table_name),'.',lower(column_name)) FROM information_schema.columns WHERE table_schema='%db%' AND extra = 'auto_increment' order by 2 " | awk "{print $1 \",\" $2}" | sort > %db%-autoincr-my.lst


@echo object_type,count > %db%-obj-cnt-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'table',count(1) cnt from information_schema.tables where table_schema='%db%' and table_type='BASE TABLE' ;" | awk "{print $1 \",\" $2}" >> %db%-obj-cnt-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'view',count(1) cnt from information_schema.views where table_schema='%db%' ;" | awk "{print $1 \",\" $2}">> %db%-obj-cnt-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'column',count(1) from information_schema.columns where TABLE_SCHEMA='%db%' and table_name NOT IN (select table_name from information_schema.views where table_schema='%db%');" | awk "{print $1 \",\" $2}">> %db%-obj-cnt-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'pk_constraint',count(1) cnt from information_schema.TABLE_CONSTRAINTS where CONSTRAINT_SCHEMA='%db%' AND CONSTRAINT_TYPE='PRIMARY KEY';" | awk "{print $1 \",\" $2}">> %db%-obj-cnt-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'uk_constraint',count(1) cnt from information_schema.TABLE_CONSTRAINTS where CONSTRAINT_SCHEMA='%db%' AND CONSTRAINT_TYPE='UNIQUE KEY';" | awk "{print $1 \",\" $2}">> %db%-obj-cnt-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'fk_constraint',count(1) cnt from information_schema.TABLE_CONSTRAINTS where CONSTRAINT_SCHEMA='%db%' AND CONSTRAINT_TYPE='FOREIGN KEY';" | awk "{print $1 \",\" $2}">> %db%-obj-cnt-my.lst
@REM mysql --login-path=%MYLP%  information_schema  -sNe "select 'rf_constraint',count(1) cnt from information_schema.REFERENTIAL_CONSTRAINTS where CONSTRAINT_SCHEMA='%db%' ;" | awk "{print $1 \",\" $2}">> %db%-obj-cnt-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'index',count(1) cnt from information_schema.STATISTICS where table_schema='%db%' ;" | awk "{print $1 \",\" $2}">> %db%-obj-cnt-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'routine',count(1) cnt from information_schema.routines where routine_schema='%db%' ;" | awk "{print $1 \",\" $2}">> %db%-obj-cnt-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'trigger',count(1) cnt from information_schema.triggers where trigger_schema='%db%' ;" | awk "{print $1 \",\" $2}">> %db%-obj-cnt-my.lst
@REM mysql --login-path=%MYLP%  information_schema  -sNe "select 'event',count(1) cnt from information_schema.events where event_schema='%db%' ;" | awk "{print $1 \",\" $2}">> %db%-obj-cnt-my.lst
@mysql --login-path=%MYLP%  information_schema  -sNe "select 'auto_incr', count(1) cnt FROM information_schema.columns WHERE table_schema='%db%' AND extra = 'auto_increment' " | awk "{print $1 \",\" $2}" >> %db%-obj-cnt-my.lst
@type %db%-obj-cnt-my.lst
