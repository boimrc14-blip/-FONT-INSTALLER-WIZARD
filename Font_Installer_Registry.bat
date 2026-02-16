@echo off
title Font Installer dengan Registry
color 3f
echo ========================================
echo   MENGINSTAL FONT KE SISTEM
echo ========================================
echo.

:: Meminta hak administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Script harus dijalankan sebagai Administrator!
    echo Klik kanan dan pilih "Run as administrator"
    pause
    exit /b
)

echo Mengcopy file font ke system folder...

:: Copy file TTF
for %%f in ("%~dp0*.ttf") do (
    echo Menginstal: %%~nxf
    copy "%%f" "%SystemRoot%\Fonts\" >nul
    
    :: Mendaftarkan di registry (Tanpa spasi di ekstensi)
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (TrueType)" /t REG_SZ /d "%%~nxf" /f >nul
)

:: Copy file OTF
for %%f in ("%~dp0*.otf") do (
    echo Menginstal: %%~nxf
    copy "%%f" "%SystemRoot%\Fonts\" >nul
    
    :: Untuk OTF, biasanya menggunakan "(OpenType)"
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (OpenType)" /t REG_SZ /d "%%~nxf" /f >nul
)

echo.
echo ========================================
echo INSTALASI SELESAI!
echo ========================================
echo.
pause