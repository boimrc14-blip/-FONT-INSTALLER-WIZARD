@echo off
title Font Registry NUKLIR
color 0C
echo ========================================
echo   PERINGATAN: RESET FONT REGISTRY
echo ========================================
echo.
echo Ini akan menghapus SEMUA entri registry font
echo dan mendaftarkan ulang dari file fisik!
echo.
echo Backup dulu? (Y/N)
set /p backup=

if /i "%backup%"=="Y" (
    echo Membackup registry lama...
    reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" "%userprofile%\Desktop\fonts_backup_SEBELUM_NUKLIR.reg" /y
)

echo.
echo Menghapus semua entri font registry...
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /va /f >nul 2>&1

echo Mendaftarkan ulang dari folder fonts...
set count=0
for %%f in ("%SystemRoot%\Fonts\*.ttf") do (
    set /a count+=1
    set /a mod=count %% 100
    if !mod!==0 echo Progress: !count! font...
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (TrueType)" /t REG_SZ /d "%%~nxf" /f >nul 2>&1
)

for %%f in ("%SystemRoot%\Fonts\*.otf") do (
    set /a count+=1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (OpenType)" /t REG_SZ /d "%%~nxf" /f >nul 2>&1
)

echo.
echo Selesai! Total %count% font telah didaftarkan ulang.
echo.
echo Restart komputer untuk efek maksimal.
pause
shutdown /r /t 10