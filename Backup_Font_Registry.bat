@echo off
title Backup Font Registry
color 1F
echo ========================================
echo   BACKUP FONT REGISTRY
echo ========================================
echo.
echo Membackup semua entri font ke desktop...

:: Export semua font registry
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" "%userprofile%\Desktop\Font_Registry_Backup_%date:~-4,4%%date:~-7,2%%date:~-10,2%.reg" /y

echo.
echo Backup selesai!
echo File: Font_Registry_Backup_%date:~-4,4%%date:~-7,2%%date:~-10,2%.reg
echo Lokasi: Desktop
echo.
echo Simpan file ini untuk berjaga-jaga!
pause