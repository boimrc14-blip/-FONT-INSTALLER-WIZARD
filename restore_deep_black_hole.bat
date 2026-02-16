@echo off
title ⚫ INTERSTELLAR - Melewati Lubang Hitam Font
color 08

echo.
echo "Masuk ke lubang hitam... space-time curvature detected..."
timeout /t 2 /nobreak >nul

:: Masuk ke dimensi ke-5 (tesseract)
echo 📦 Memasuki tesseract dimension...
set TESSERACT=%temp%\tesseract_font_%random%
mkdir "%TESSERACT%" 2>nul

:: Download font dari dimensi lain (pake curl kalo ada)
echo 📡 Menerima sinyal dari planet Miller...
echo     "Jangan goblok, font lo ada di C:\Windows\Fonts"
timeout /t 1 /nobreak >nul

:: Keluar dari lubang hitam
echo ⏱️  Time dilation: 1 jam di luar = 7 tahun di Bumi
echo     "Sekarang lo udah tua 7 tahun, tapi font balik!"
timeout /t 2 /nobreak >nul

:: Restore font pake cara kuantum
echo 🌀 Quantum entanglement activated...
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /va /f >nul 2>&1
for %%f in ("%SystemRoot%\Fonts\*.ttf") do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (TrueType)" /t REG_SZ /d "%%~nxf" /f >nul
)

echo.
echo ✅ "MURPH! MURPH! FONT NYA BALIK, MURPH!"
echo     - Cooper, mungkin
pause