@echo off
title ⚛️ SCRIPT ALAM SEMESTA - FONTIVERSE ⚛️
color F0
mode con: cols=100 lines=30

echo.
echo   ╔════════════════════════════════════════════════════════════╗
echo   ║           🌍 SCRIPT ALAM SEMESTA - FONT EDITION 🌍         ║
echo   ║                    "Dari Big Bang sampe font balik"        ║
echo   ╚════════════════════════════════════════════════════════════╝
echo.

:: =============================================
:: FASE 1: BIG BANG (Initialize Semesta)
:: =============================================
echo [1/7] 🌌 Big Bang: Menginisialisasi ruang-waktu font...
timeout /t 2 /nobreak >nul

:: Backup dulu sebelum kiamat
set BACKUP_DIR=%userprofile%\Desktop\ALAM_SEMESTA_BACKUP_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%%time:~6,2%
set BACKUP_DIR=%BACKUP_DIR: =_%
mkdir "%BACKUP_DIR%" 2>nul

echo     ├─ Membuat backup di: %BACKUP_DIR%

:: =============================================
:: FASE 2: BIG CRUNCH (Hapus Semua)
:: =============================================
echo [2/7] 💥 Big Crunch: Menghancurkan semua dimensi font...
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" "%BACKUP_DIR%\fonts_registry_before_nuklir.reg" /y >nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /va /f >nul 2>&1
echo     ├─ Registry font dihapus (tapi tenang, udah dibackup)

:: =============================================
:: FASE 3: DARK MATTER (Cari file di kegelapan)
:: =============================================
echo [3/7] ⚫ Dark Matter: Menjelajah kegelapan folder fonts...

:: Scan semua drive buat nyari font (sampe ke dimensi lain)
set FONT_COUNT=0
set UNIVERSE_FONTS=%BACKUP_DIR%\daftar_font_alam_semesta.txt
echo Mencari font di seluruh penjuru alam semesta... > "%UNIVERSE_FONTS%"

:: Loop semua drive dari A sampai Z (yang ada)
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\" (
        echo     ├─ Scanning drive %%d:...
        dir /s /b "%%d:\*.ttf" "%%d:\*.otf" 2>nul >> "%UNIVERSE_FONTS%"
    )
)

:: =============================================
:: FASE 4: GALAXY FORMATION (Kumpulin font)
:: =============================================
echo [4/7] 🌌 Galaxy Formation: Mengumpulkan font dari multiverse...

:: Copy semua font ke folder central (kayak black hole)
set CENTRAL_FONT_DIR=%BACKUP_DIR%\FONT_GALAXY
mkdir "%CENTRAL_FONT_DIR%" 2>nul

for /f "usebackq delims=" %%f in ("%UNIVERSE_FONTS%") do (
    copy "%%f" "%CENTRAL_FONT_DIR%\" >nul 2>&1
    set /a FONT_COUNT+=1
)

echo     ├─ Terkumpul %FONT_COUNT% font dari berbagai dimensi

:: =============================================
:: FASE 5: SOLAR SYSTEM (Install di sistem)
:: =============================================
echo [5/7] ☀️ Solar System: Mendistribusikan font ke tata surya Windows...

set INSTALLED=0
for %%f in ("%CENTRAL_FONT_DIR%\*.ttf") do (
    copy "%%f" "%SystemRoot%\Fonts\" >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (TrueType)" /t REG_SZ /d "%%~nxf" /f >nul 2>&1
    set /a INSTALLED+=1
)

for %%f in ("%CENTRAL_FONT_DIR%\*.otf") do (
    copy "%%f" "%SystemRoot%\Fonts\" >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (OpenType)" /t REG_SZ /d "%%~nxf" /f >nul 2>&1
    set /a INSTALLED+=1
)

echo     ├─ Berhasil menginstall %INSTALLED% font

:: =============================================
:: FASE 6: LIFE FORMS (Bikin hidup lagi)
:: =============================================
echo [6/7] 🧬 Life Forms: Menghidupkan kembali explorer...

taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

:: =============================================
:: FASE 7: THE END OF THE UNIVERSE (Selesai)
:: =============================================
echo [7/7] ✨ The End of The Universe (for now)...

echo.
echo   ╔════════════════════════════════════════════════════════════╗
echo   ║     🌠 ALAM SEMESTA TELAH TERBENTUK KEMBALI! 🌠            ║
echo   ╠════════════════════════════════════════════════════════════╣
echo   ║  Font ditemukan    : %FONT_COUNT%                             ║
echo   ║  Font terinstall   : %INSTALLED%                             ║
echo   ║  Lokasi backup     : %BACKUP_DIR%  ║
echo   ╚════════════════════════════════════════════════════════════╝
echo.

:: Bonus: The Big Question
echo.
echo   ┌─────────────────────────────────────────────┐
echo   │  🧐 PERTANYAAN ALAM SEMESTA:                │
echo   │  "Apakah font Comic Sans termasuk            │
echo   │   kesalahan tata letak alam semesta?"       │
echo   └─────────────────────────────────────────────┘
echo.

pause
cls