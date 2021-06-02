SET DB=%1
echo echo job start %%date%%-%%time%% > bcp-%DB%.bat
echo call setenv.bat >> bcp-%DB%.bat
cat %DB%_bulk_copy_tables.cmd | grep bcp | sed "s/\" queryout/(nolock)\" queryout/;s/-c -t.*$/-c -t\"0x1F\" -r\"\\n\\r\" -T -S %%SRCHOST%% /" |sed "s/\\n\\r/\\n\\r|||/" >> bcp-%DB%.bat
echo echo job end   %%date%%-%%time%% >> bcp-%DB%.bat
type bcp-%DB%.bat
echo ... bcp-%DB%.bat
