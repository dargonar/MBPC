@echo off

SET /P NEWVER=Version to install:

echo Downloading new version...
xcopy /Y "\\tsclient\C\borrar\mbpc_wsreport-%NEWVER%.zip" .
echo Stoping IIS..
iisreset /STOP

FOR /F "tokens=2 delims==" %%a in ('type C:\Inetpub\wwwroot\mbpc_wsreport\reports.asmx.cs ^| FIND "VERSION ="') do set _VER=%%a
set _VER=%_VER:"=%
set _VER=%_VER:;=%
set _VER=%_VER: =%

echo Backing up version %_VER%...

xcopy /E /Q /Y /I C:\Inetpub\wwwroot\mbpc_wsreport "C:\Inetpub\wwwroot\mbpc_wsreport-%_VER%"

echo Unziping ...
unzip -o -q "mbpc_wsreport-%NEWVER%.zip" -d C:\Inetpub\wwwroot\mbpc_wsreport

echo Fixing permisions...
CACLS C:\Inetpub\wwwroot\mbpc_wsreport /G todos:f /T

echo Starting IIS...
iisreset /START