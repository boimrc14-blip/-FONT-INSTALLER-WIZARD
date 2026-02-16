@echo off
title 📋 FONT INSTALLER - PILIH SENDIRI
color 1F
mode con: cols=90 lines=40

:: =============================================
:: INISIALISASI
:: =============================================
setlocal enabledelayedexpansion
set "TEMP_FILE=%temp%\font_list_%random%.txt"
set "SELECTED_FILE=%temp%\selected_fonts_%random%.txt"

:: Header
cls
echo ╔══════════════════════════════════════════════════════════════════════╗
echo ║                   📋 FONT INSTALLER INTERAKTIF                       ║
echo ║                  "Pilih sendiri, centang sendiri"                    ║
echo ╚══════════════════════════════════════════════════════════════════════╝
echo.

:: =============================================
:: FASE 1: CARI SEMUA FILE FONT
:: =============================================
echo 🔍 [1/4] Mencari file font di semua drive...
echo ----------------------------------------
echo Mencakup drive: C D E F G H (yang ada aja)
echo.

set FONT_COUNT=0
> "%TEMP_FILE%" (
    for %%d in (C D E F G H) do (
        if exist "%%d:\" (
            echo     Scanning drive %%d:... 
            dir /s /b "%%d:\*.ttf" "%%d:\*.otf" 2>nul
        )
    )
)

:: Hitung jumlah font
for /f %%a in ('type "%TEMP_FILE%" ^| find /c /v ""') do set FONT_COUNT=%%a
echo.
echo ✅ Ditemukan %FONT_COUNT% file font di seluruh drive!
echo.
pause
cls

:: =============================================
:: FASE 2: TAMPILKAN DENGAN NOMOR (PILIHAN)
:: =============================================
:show_menu
cls
echo ╔══════════════════════════════════════════════════════════════════════╗
echo ║                      📋 DAFTAR FONT DITEMUKAN                        ║
echo ║                   (Ketik nomor untuk centang/batal)                  ║
echo ╚══════════════════════════════════════════════════════════════════════╝
echo.
echo Total font: %FONT_COUNT%  |  Terpilih: !SELECTED_COUNT!  |  Halaman: !PAGE!/!TOTAL_PAGES!
echo ------------------------------------------------------------------------
echo.

:: Baca file per halaman (20 font per halaman)
set /a PAGE_SIZE=20
set /a START=0
if not defined PAGE set PAGE=1
set /a START=(PAGE-1)*PAGE_SIZE
set /a END=PAGE*PAGE_SIZE
set /a COUNT=0
set /a DISPLAY_NUM=0

:: Baca file dan tampilkan
for /f "usebackq delims=" %%f in ("%TEMP_FILE%") do (
    set /a COUNT+=1
    if !COUNT! gtr !START! if !COUNT! leq !END! (
        set /a DISPLAY_NUM+=1
        set "FILE[!DISPLAY_NUM!]=%%f"
        
        :: Dapatkan nama file aja
        for %%g in ("%%f") do set "FNAME=%%~nxg"
        set "FNAME=!FNAME!                                        "
        
        :: Cek apakah sudah dipilih
        set "CEK="
        if exist "%SELECTED_FILE%" (
            findstr /i /c:"%%f" "%SELECTED_FILE%" >nul && set "CEK=✅" || set "CEK=⬜"
        ) else (
            set "CEK=⬜"
        )
        
        :: Tampilkan dengan nomor
        set "DISPLAY_NUM2=!DISPLAY_NUM! "
        if !DISPLAY_NUM! lss 10 set "DISPLAY_NUM2=!DISPLAY_NUM!  "
        echo    !DISPLAY_NUM2! !CEK! !FNAME:~0,60!
    )
)

:: Hitung total halaman
set /a TOTAL_PAGES=(FONT_COUNT+PAGE_SIZE-1)/PAGE_SIZE

echo.
echo ------------------------------------------------------------------------
echo.
echo Perintah: [nomor] Centang/Batal  |  [N] Halaman berikut  |  [P] Halaman sebelumnya
echo           [I] Install terpilih    |  [A] Pilih semua       |  [C] Hapus semua pilihan
echo           [Q] Keluar
echo.

:: =============================================
:: FASE 3: INPUT PERINTAH
:: =============================================
set /p CMD="➤ Masukkan perintah: "

:: Handle input
if /i "!CMD!"=="N" (
    set /a PAGE+=1
    if !PAGE! gtr !TOTAL_PAGES! set PAGE=!TOTAL_PAGES!
    goto show_menu
)

if /i "!CMD!"=="P" (
    set /a PAGE-=1
    if !PAGE! lss 1 set PAGE=1
    goto show_menu
)

if /i "!CMD!"=="Q" goto end
if /i "!CMD!"=="I" goto install_selected
if /i "!CMD!"=="A" goto select_all
if /i "!CMD!"=="C" goto clear_all

:: Cek apakah input adalah angka (pilih font)
set "IS_NUMBER="
echo !CMD!| findstr /r /x "[0-9]*" >nul && set IS_NUMBER=1

if defined IS_NUMBER (
    if !CMD! geq 1 if !CMD! leq !DISPLAY_NUM! (
        set "SELECTED_FILE_PATH=!FILE[%CMD%]!"
        
        :: Toggle pilihan
        if exist "%SELECTED_FILE%" (
            findstr /i /v /c:"!SELECTED_FILE_PATH!" "%SELECTED_FILE%" > "%TEMP_FILE2%" 2>nul
            move /y "%TEMP_FILE2%" "%SELECTED_FILE%" >nul 2>&1
            echo !SELECTED_FILE_PATH! >> "%SELECTED_FILE%" 2>nul
        ) else (
            echo !SELECTED_FILE_PATH! >> "%SELECTED_FILE%"
        )
    )
    goto show_menu
)

goto show_menu

:: =============================================
:: FASE 4: SELECT ALL / CLEAR ALL
:: =============================================
:select_all
echo Membuat semua font terpilih...
type "%TEMP_FILE%" > "%SELECTED_FILE%"
goto show_menu

:clear_all
echo Menghapus semua pilihan...
del "%SELECTED_FILE%" 2>nul
goto show_menu

:: =============================================
:: FASE 5: INSTALL FONT TERPILIH
:: =============================================
:install_selected
cls
echo ╔══════════════════════════════════════════════════════════════════════╗
echo ║                      🔧 MENGINSTALL FONT TERPILIH                    ║
echo ╚══════════════════════════════════════════════════════════════════════╝
echo.

:: Cek admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ❌ ERROR: Harus Run as Administrator!
    echo    Klik kanan → Run as administrator
    echo.
    pause
    goto end
)

:: Cek file pilihan
if not exist "%SELECTED_FILE%" (
    echo ❌ Belum ada font yang dipilih!
    pause
    goto show_menu
)

:: Hitung yang akan diinstall
for /f %%a in ('type "%SELECTED_FILE%" ^| find /c /v ""') do set TO_INSTALL=%%a
echo 📊 Akan menginstall %TO_INSTALL% font...
echo.

:: Mulai install
set INSTALLED=0
set FAILED=0

for /f "usebackq delims=" %%f in ("%SELECTED_FILE%") do (
    set /a INSTALLED+=1
    set PERCENT=!INSTALLED! * 100 / !TO_INSTALL!
    
    :: Dapatkan nama file
    for %%g in ("%%f") do set "FNAME=%%~nxg"
    
    :: Progress bar
    set "PROGRESS="
    set /a BARS=!PERCENT! / 2
    for /l %%b in (1,1,!BARS!) do set "PROGRESS=!PROGRESS!█"
    for /l %%b in (!BARS!,1,50) do set "PROGRESS=!PROGRESS!░"
    
    echo [!PROGRESS!] !PERCENT!%% - Menginstall: !FNAME!
    
    :: Copy ke folder fonts
    copy "%%f" "%SystemRoot%\Fonts\" >nul 2>&1
    if !errorlevel! equ 0 (
        :: Daftarkan di registry
        if /i "%%~xf"==".ttf" (
            reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (TrueType)" /t REG_SZ /d "%%~nxf" /f >nul 2>&1
        ) else if /i "%%~xf"==".otf" (
            reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (OpenType)" /t REG_SZ /d "%%~nxf" /f >nul 2>&1
        )
    ) else (
        set /a FAILED+=1
        echo     ❌ Gagal mengcopy file!
    )
)

echo.
echo ========================================
echo ✅ INSTALASI SELESAI!
echo ========================================
echo    Berhasil : %INSTALLED%
echo    Gagal    : %FAILED%
echo ========================================
echo.
echo 🔄 Merestart explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
pause
goto end

:: =============================================
:: SELESAI
:: =============================================
:end
:: Bersihkan file temporary
del "%TEMP_FILE%" 2>nul
del "%SELECTED_FILE%" 2>nul
del "%TEMP_FILE2%" 2>nul

cls
echo ╔══════════════════════════════════════════════════════════════════════╗
echo ║                    🌠 SAMPAI JUMPA DI ALAM SEMESTA LAIN! 🌠          ║
echo ╚══════════════════════════════════════════════════════════════════════╝
echo.
timeout /t 2 /nobreak >nul
exit /b