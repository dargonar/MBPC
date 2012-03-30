@echo off

SET /P NEWVER=Version to install:

echo Stoping IIS..
iisreset /STOP

FOR /F "tokens=2 delims==" %%a in ('type C:\Inetpub\wwwroot\mbpcadmin\Controllers\MyController.cs ^| FIND "VERSION ="') do set _VER=%%a
set _VER=%_VER:"=%
set _VER=%_VER:;=%
set _VER=%_VER: =%

echo Backing up version %_VER%...

xcopy /E /Q /Y /I C:\Inetpub\wwwroot\mbpcadmin "C:\Inetpub\wwwroot\mbpcadmin-%_VER%"

echo Downloading new version...
xcopy /Y "\\tsclient\C\borrar\mbpcadmin-%NEWVER%.zip" .

echo Unziping ...
unzip -o -q "mbpcadmin-%NEWVER%.zip" -d C:\Inetpub\wwwroot\mbpcadmin

echo Fixing permisions...
CACLS C:\Inetpub\wwwroot\mbpcadmin /G todos:f /T

echo Starting IIS...
iisreset /START