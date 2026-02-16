@echo off
title 🌍 BIG BANG FONT RESTORE
color 0A

:: Phase 1: Sebelum Big Bang (Belum ada apa-apa)
echo 🕳️  Sebelum Big Bang: Font registry kosong...
timeout /t 1 /nobreak >nul

:: Phase 2: Big Bang (Ledakan)
echo 💥 BIG BANG: Menciptakan ruang dan waktu...
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /va /f >nul 2>&1
timeout /t 1 /nobreak >nul

:: Phase 3: Pembentukan Galaxy
echo 🌌 Membentuk galaxy font...
for %%f in ("%SystemRoot%\Fonts\*.ttf") do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (TrueType)" /t REG_SZ /d "%%~nxf" /f >nul
)

:: Phase 4: Kehidupan muncul
echo 🦠 Evolusi dimulai...
for %%f in ("%SystemRoot%\Fonts\*.otf") do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (OpenType)" /t REG_SZ /d "%%~nxf" /f >nul
)

:: Phase 5: Manusia modern (explorer)
echo 🧠 Kesadaran muncul... merestart explorer...
taskkill /f /im explorer.exe >nul
start explorer.exe

:: Phase 6: Selesai
echo.
echo ✅ Alam semesta font telah diciptakan dalam 6 hari!
echo    (Hari ke-7 explorer istirahat, jangan distop)
pause