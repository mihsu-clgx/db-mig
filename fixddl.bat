@CALL setenv.bat
set db=%1
cat %db%_migration_script.sql | sed "/DROP SCHEMA IF EXISTS/d;s/VARCHAR(0)/LONGTEXT/;s/CHARACTER SET 'utf8mb4' //" > %db%_migration_script.fixed.sql
