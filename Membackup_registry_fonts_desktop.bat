@echo off
echo Membackup registry fonts ke desktop...
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" "%userprofile%\Desktop\fonts_backup.reg"
echo Backup selesai! File disimpan di Desktop.
pause