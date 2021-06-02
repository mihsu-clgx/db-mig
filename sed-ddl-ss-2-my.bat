cat %1 | sed "s/`//g;s/CHARACTER SET 'utf8mb4'//;s/money/decimal(10,4)/;s/nvarchar/varchar/;s/smalldatetime/datetime/;s/datetime2(7)/datetime/;s/datetime(6)/datetime/;s/DATETIME(6)/datetime/;s/ntext/longtext/;s/COLLATE SQL_Latin1_General_CP1_CI_AS//;" > %1.tmp
cat %1.tmp
echo ... %1.tmp
