@echo off
title Register Fonts from Existing Files
echo Mendaftarkan ulang fonts dari folder sistem...
echo.

:: Loop untuk semua file TTF di folder fonts
for %%f in ("%SystemRoot%\Fonts\*.ttf") do (
    echo Mendaftarkan: %%~nxf
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (TrueType)" /t REG_SZ /d "%%~nxf" /f >nul
)

:: Loop untuk file OTF
for %%f in ("%SystemRoot%\Fonts\*.otf") do (
    echo Mendaftarkan: %%~nxf
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (OpenType)" /t REG_SZ /d "%%~nxf" /f >nul
)

echo.
echo Selesai! Silakan restart komputer Anda.
pause