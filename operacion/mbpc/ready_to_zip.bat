@echo off

FOR /F "tokens=2 delims==" %%a in ('type Controllers\HomeController.cs ^| FIND "VERSION ="') do set _VER=%%a
set _VER=%_VER:"=%
set _VER=%_VER:;=%
set _VER=%_VER: =%

echo Packing for version %_VER%

del /f /q *.config > nul
rmdir /Q /S obj

echo mbpc-%_VER%.zip

"c:\Program Files\7-Zip\7z.exe" a "..\mbpc-%_VER%.zip" * > nul
