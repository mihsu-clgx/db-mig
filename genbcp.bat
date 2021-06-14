@CALL setdb.bat
echo echo job start %%date%%-%%time%% > bcp-%db%.bat
echo call setenv.bat >> bcp-%db%.bat
cat %db%_bulk_copy_tables.cmd | grep bcp | sed "s/\" queryout/(nolock)\" queryout/;s/-c -t.*$/-c -t\"0x1F\" -r\"\\n\\r\" -T -S %%SRCHOST%% /" |sed "s/\\n\\r/\\n\\r|||/" >> bcp-%db%.bat
echo echo job end   %%date%%-%%time%% >> bcp-%db%.bat
type bcp-%db%.bat
echo ... bcp-%db%.bat
