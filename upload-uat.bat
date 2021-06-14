@REM in GCP SDK, set to UAT tf account
gsutil -m cp C:\mig\dump_TaxServices\*.tmp gs://clgx-edg-mysql-uat-dba/mig/taxservices/
gsutil -m cp C:\mig\dump_TaxServices\*.sql gs://clgx-edg-mysql-uat-dba/mig/taxservices/
gsutil cp C:\mig\dump_TaxServices\cr-TaxServices.bat gs://clgx-edg-mysql-uat-dba/mig/taxservices/
gsutil cp C:\mig\dump_TaxServices\load-TaxServices.bat gs://clgx-edg-mysql-uat-dba/mig/taxservices/
gsutil cp C:\mig\dump_TaxServices\bcp-TaxServices.log gs://clgx-edg-mysql-uat-dba/mig/taxservices/
