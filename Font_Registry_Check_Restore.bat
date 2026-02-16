@echo off
title Font Registry Check & Restore
color 4F
echo ========================================
echo   CEK FONT REGISTRY
echo ========================================
echo.

:: Cek jumlah entri font di registry
setlocal enabledelayedexpansion
set count=0
for /f "tokens=*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" 2^>nul ^| find /c "REG_"') do set count=%%a

echo Jumlah font terdaftar: %count%
echo.

if %count% lss 100 (
    echo [WARNING] Font registry kemungkinan berkurang!
    echo.
    echo Apakah Anda punya file backup font? (Y/N)
    set /p choice=
    
    if /i "!choice!"=="Y" (
        echo.
        echo Cari file backup .reg di desktop...
        
        if exist "%userprofile%\Desktop\*Font*.reg" (
            for %%f in ("%userprofile%\Desktop\*Font*.reg") do (
                echo Menemukan: %%~nxf
                echo Mengapply backup...
                reg import "%%f" >nul
                echo Selesai!
            )
        ) else (
            echo File backup tidak ditemukan!
            echo.
            echo Mencoba repair otomatis dari file fisik...
            
            for %%f in ("%SystemRoot%\Fonts\*.ttf") do (
                reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (TrueType)" /t REG_SZ /d "%%~nxf" /f >nul 2>&1
            )
            echo Repair otomatis selesai.
        )
    ) else (
        echo Tidak melakukan restore.
    )
) else (
    echo [OK] Font registry masih aman!
)

echo.
echo Restart explorer untuk melihat perubahan...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

pause