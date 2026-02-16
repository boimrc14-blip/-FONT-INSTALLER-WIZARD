@echo off
title Install Fonts Batch Script
echo Sedang menginstal fonts, harap tunggu...
copy "%~dp0*.ttf" "%SystemRoot%\Fonts"
copy "%~dp0*.otf" "%SystemRoot%\Fonts"
echo.
echo Installasi selesai!
pause