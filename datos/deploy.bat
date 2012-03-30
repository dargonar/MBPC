@echo off

SET /P NEWVER=Version to install:

echo Stoping IIS..
iisreset /STOP

FOR /F "tokens=2 delims==" %%a in ('type C:\Inetpub\wwwroot\mbpc\Controllers\HomeController.cs ^| FIND "VERSION ="') do set _VER=%%a
set _VER=%_VER:"=%
set _VER=%_VER:;=%
set _VER=%_VER: =%

echo Backing up version %_VER%...

xcopy /E /Q /Y /I C:\Inetpub\wwwroot\mbpc "C:\Inetpub\wwwroot\mbpc-%_VER%"

echo Downloading new version...
xcopy /Y "\\tsclient\C\borrar\mbpc-%NEWVER%.zip" .

echo Unziping ...
unzip -o -q "mbpc-%NEWVER%.zip" -d C:\Inetpub\wwwroot\mbpc

echo Fixing permisions...
CACLS C:\Inetpub\wwwroot\mbpc /G todos:f /T

echo Starting IIS...
iisreset /START