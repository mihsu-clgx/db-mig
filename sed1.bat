@SET DB=%1
@SET TBL=%2
@echo %date%-%time% start sed
@tr -cd '\11\12\15\36\37\40-\176' < %TBL%.csv | sed "s/^/\\N/;s/\\/\\\\/g;s//\\N/g;s//\\N/g;s/$/\\N/;" > %DB%\%TBL%.tmp
@echo %date%-%time% end sed

