@echo off
rasdial Prefe fcalabrese tesam123
if "%errorlevel%" NEQ "0"; goto error

FOR /F "tokens=2 delims=:" %%a in ('IPCONFIG ^|FIND "IP" ^|FIND "192.168.41."') do set _IP=%%a
set IP=%_IP:~1%
echo Poniendo GW para IPs en %IP%
route add 192.168.10.0 mask 255.255.255.0 %IP%

ping -t 192.168.10.120
goto fin
:error
pause
:fin
