@echo off
:: Última modificación: 30/Mar/2015
title mpv-player for Dummies v0.61-RC2
color 0a
cls
pushd "%~dp0"
if /i "%1" EQU "-runas" goto a1
if /i "%1" EQU "-uac" goto a2
set cpu=
if "%PROCESSOR_ARCHITECTURE%"=="x86" set cpu=i686
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set cpu=x86_64
if not defined cpu set dmn=Arquitectura de procesador no soportada.& goto wtf
for /f "tokens=*" %%a in ('ver') do set wv=%%a
set wv=%wv:~-9,1%
if %wv% GEQ 6 goto p1
if not defined APPDATA set APPDATA=%USERPROFILE%\Datos de programa
set LOCALAPPDATA=%USERPROFILE%\Configuraci¢n local\Datos de programa
if exist "%LOCALAPPDATA%" goto p1
set APPDATA=%USERPROFILE%\Application Data
set LOCALAPPDATA=%USERPROFILE%\Local Settings\Application Data
:p1
if not exist "%APPDATA%" goto p2
if not exist "%LOCALAPPDATA%\Microsoft\Windows\UsrClass.dat" goto p2
if not exist "%windir%" goto uk
echo %LOCALAPPDATA% | find /i "%windir%">nul
if %errorlevel% EQU 0 goto p2
echo %USERPROFILE% | find /i "Service">nul
if %errorlevel% EQU 0 goto p2
echo %USERPROFILE% | find /i "%windir%">nul
if %errorlevel% EQU 0 goto p2
echo %TEMP% | find /i "%windir%">nul
if %errorlevel% EQU 0 (
:p2
set dmn=No ejecute este script desde acceso remoto.
goto wtf
)
set apd=%LOCALAPPDATA%
for /f "tokens=*" %%a in ('echo %apd%') do set apd=%%~sa
set E7=%ProgramFiles%\7-Zip
"%E7%\7z">nul 2>&1
if %errorlevel% NEQ 0 goto p3
"%E7%\7z" 2>&1 | find "7-Zip" >nul
if %errorlevel% NEQ 0 (
:p3
set dmn=7-Zip no est  instalado o est  instalado en una ruta poco habitual...
goto wtf
)
if not defined PATHEXT goto uk
if not defined USERNAME goto uk
if not exist "%ComSpec%" goto uk
set SN=0
set E1=0
set E2=m2c
set dst=%ProgramFiles%\mpv-player
if defined SESSIONNAME set SN=1
set mg1=rem
:m0
set mg2=rem
set mg3=Instalar
set E3=%mg3%
set m7z=
for /f "tokens=*" %%a in ('dir mpv-%cpu%*.7z /on /b 2^>^&1') do set m7z=%%a>nul
if not exist "%m7z%" set dmn=Ops, mpv-%cpu%*.7z no est  presente.& goto wtf
set yx=exe
:p4
set ydl=
for /f "tokens=*" %%a in ('dir youtube-dl*.%yx% /on /b 2^>^&1') do set ydl=%%a>nul
if exist "%ydl%" set mg2=echo& goto p5
if /i %yx%==py goto p5
echo %PATHEXT% | find /i ".py">nul
if %errorlevel% EQU 0 set yx=py& goto p4
:p5
if exist "%dst%\mpv.exe" set mg3=Actualizar
if exist "%apd%\mpv-player\mpv.exe" set E3=Actualizar
cls
set VA=
%mg1%
echo.
echo Se usar : %m7z%
%mg2% Se a¤adir : %ydl%
echo.
echo 1. %mg3% para todos los usuarios
echo 2. %E3% solo para %USERNAME%
echo 3. Crear variable de entorno para %USERNAME%
echo 4. Desinstalaci¢n forzada...
echo 5. Asociar extensiones de archivo...
echo 6. Salir
echo.
set /p VA= ^ Opci¢n: 
if "%VA%"=="1" goto m1
if "%VA%"=="2" goto m2
if "%VA%"=="3" goto m3
if "%VA%"=="4" goto m4
if "%VA%"=="5" goto m3
if "%VA%"=="6" exit
set mg1=echo Opci¢n invalida...
goto m0
:m1
reg query HKU\S-1-5-19>nul 2>&1
if %errorlevel% NEQ 0 set mg1=echo Error, se requiere ejecutar este script como administrador& goto m0
if %VA%==5 goto m5
cls
reg add HKCR\Directory\shell\CommandPrompt /ve /d "Abrir con S¡mbolo del sistema" /f>nul 2>&1
reg add HKCR\Directory\shell\CommandPrompt\command /ve /d "%ComSpec% /k pushd \"%%1\" && title S¡mbolo del sistema" /f>nul 2>&1
reg add HKCR\Drive\shell\CommandPrompt /ve /d "Abrir con S¡mbolo del sistema" /f>nul 2>&1
reg add HKCR\Drive\shell\CommandPrompt\command /ve /d "%ComSpec% /k pushd \"%%1\" && title S¡mbolo del sistema" /f>nul 2>&1
if %wv% LEQ 5 goto m1a
reg add HKCR\Directory\shell\CommandPrompt /v Icon /t REG_EXPAND_SZ /d "%%ComSpec%%,0" /f>nul 2>&1
reg add HKCR\Drive\shell\CommandPrompt /v Icon /t REG_EXPAND_SZ /d "%%ComSpec%%,0" /f>nul 2>&1
reg add HKCR\Directory\Background\shell\CommandPrompt /ve /d "Abrir S¡mbolo del sistema aqu¡" /f>nul 2>&1
reg add HKCR\Directory\Background\shell\CommandPrompt /v Icon /t REG_EXPAND_SZ /d "%%ComSpec%%,0" /f>nul 2>&1
reg add HKCR\Directory\Background\shell\CommandPrompt\command /ve /d "%ComSpec% /k title S¡mbolo del sistema" /f>nul 2>&1
reg add HKCR\DesktopBackground\shell\CommandPrompt /ve /d "Abrir S¡mbolo del sistema aqu¡" /f>nul 2>&1
reg add HKCR\DesktopBackground\shell\CommandPrompt /v Icon /t REG_EXPAND_SZ /d "%%ComSpec%%,0" /f>nul 2>&1
reg add HKCR\DesktopBackground\shell\CommandPrompt\command /ve /d "%ComSpec% /k title S¡mbolo del sistema" /f>nul 2>&1
goto m1a
:m2
set dst=%apd%\mpv-player
:m1a
cls
taskkill /im mpv.exe /f>nul 2>&1
taskkill /im youtube-dl.exe /f>nul 2>&1
"%E7%\7z" x -y "%m7z%" -o"%dst%" >nul
if %errorlevel% NEQ 0 goto err
if defined ydl copy "%ydl%" "%dst%\youtube-dl.%yx%" /y>nul
if %errorlevel% NEQ 0 goto err
:m2a
cls
color 0e
reg query HKCU\Environment /v Path>nul 2>&1
if %errorlevel% NEQ 0 goto m2b
reg query HKCU\Environment /v Path 2>&1 | find /i "%dst%" >nul
if %errorlevel% EQU 0 (
if %VA% NEQ 4 set SN=0
goto %E2%)
if %VA%==4 goto m2b
:m4b
reg query HKCU\Environment /v Path>>path_backup.txt
reg delete HKCU\Environment /v Path /f>nul 2>&1
if %VA%==4 goto m2c
:m2b
if %VA%==4 set SN=0& goto m2d
reg add HKCU\Environment /v Path /d "%E7%;%dst%" /f>nul 2>&1
:m2c
if %SN%==0 goto m2d
echo.
echo POR CIERTAS RAZONES TCNICAS, SE REQUIERE CERRAR SESIàN.
:m2d
title ATENCIàN
echo.
echo My job is done!
echo.
echo PD: Dependiendo de la configuraci¢n de su sistema, es posible que tenga que cerrar sesi¢n usted mismo...
echo.
pause
if %SN%==1 shutdown -l & exit
if %E1%==1 start explorer
exit
:m3
if not exist "%dst%\mpv.exe" set mg1=echo Error, se requiere instalaci¢n para todos los usuarios& goto m0
if %VA%==5 goto m1
if %SN%==1 goto war
:m3a
goto m2a
:m4
if %SN%==1 goto war
:m4a
if %SN%==1 taskkill /im explorer.exe /f>nul 2>&1
set E1=%SN%
taskkill /im mpv.exe /f>nul 2>&1
taskkill /im youtube-dl.exe /f>nul 2>&1
reg delete HKCR\Directory\shell\CommandPrompt /f>nul 2>&1
reg delete HKCR\Directory\Background\shell\CommandPrompt /f>nul 2>&1
reg delete HKCR\DesktopBackground\shell\CommandPrompt /f>nul 2>&1
reg delete HKCR\Drive\shell\CommandPrompt /f>nul 2>&1
if exist "%dst%\un_extmpv.bat" call "%dst%\un_extmpv.bat"
rd "%APPDATA%\mpv" /s /q>nul 2>&1
rd "%apd%\mpv-player" /s /q>nul 2>&1
rd "%dst%" /s /q>nul 2>&1
set dst=mpv-player
set E2=m4b
goto m2a
:m5
set VV=2
set CC=:
:p6
for /f "usebackq tokens=1* delims=%CC%" %%a in (`"find "" "testing" 2>&1"`) do set E1=%%b
if "%E1:~1,4%"=="TEST" goto p7
if %CC%==: set CC=-& goto p6
set dmn=Error en el comportamiento de FIND...
goto wtf
:p7
title Asociar extensiones de archivo para mpv-player
set mg1=rem
:m5a
cls
%mg1%
echo.
echo Dejar la extensi¢n vacia para terminar...
echo.
set E1=
set /p E1=^Extensi¢n: 
if not defined E1 exit
set mg1=echo Extensi¢n invalida
set E2=
for /f "tokens=1" %%a in ('echo %E1:~0,5%') do set E2=%%a
find "" %E2%>nul 2>&1
if %errorlevel% EQU 2 goto m5a
set E2=
for /f "usebackq tokens=1* delims=%CC%" %%a in (`"find "" "%E1%" 2>&1"`) do set E2=%%b
for /f "tokens=1" %%a in ('echo %E2:~1,5%') do set E2=%%a
if /i "%E2%"=="%E1%" (set E1=%E2%) else goto m5a
set E3=
reg query HKLM\SOFTWARE\Classes\.%E1% /ve>nul 2>&1
if %errorlevel% NEQ 0 goto m5c
:m5b
for /f "tokens=%VV%*" %%a in ('reg query HKLM\SOFTWARE\Classes\.%E1% /ve') do set E3=%%b
if /i "%E3:~0,4%"=="REG_" set VV=3& goto m5b
if /i "%E3%"=="mpv-player.%E1%" set mg1=echo Extensi¢n duplicada...& goto m5a
:m5c
echo %PATHEXT% | find /i ".%E1%">nul
if %errorlevel% EQU 0 goto m5a
echo.
reg add HKLM\SOFTWARE\Classes\.%E1% /ve /d "mpv-player.%E1%" /f
reg add HKLM\SOFTWARE\Classes\mpv-player.%E1% /ve /d "%E1%" /f
reg add HKLM\SOFTWARE\Classes\mpv-player.%E1%\DefaultIcon /ve /d "%dst%\mpv.exe,0" /f
reg add HKLM\SOFTWARE\Classes\mpv-player.%E1%\shell\open\command /ve /d "\"%dst%\mpv.exe\" \"%%1\"" /f
echo.
echo reg delete HKLM\SOFTWARE\Classes\mpv-player.%E1% /f>>"%dst%\un_extmpv.bat"
if defined E3 (
echo reg add HKLM\SOFTWARE\Classes\.%E1% /ve /d "%E3%" /f>>"%dst%\un_extmpv.bat") else (
echo reg delete HKLM\SOFTWARE\Classes\.%E1% /f>>"%dst%\un_extmpv.bat")
pause
set mg1=rem
goto m5a
:war
title WARNING!
color 0c
cls
echo.
echo ADVERTENCIA: Cierre y guarde todo lo que este haciendo.
echo Al finalizar, el script podr¡a forzara el cierre de sesi¢n en la mayor¡a de los casos.
echo.
pause
cls
goto m%VA%a
:err
set dmn=ERROR: Algo a salido mal y este script no a podido completar todas o alguna de las funciones que deber¡a.^& echo Si no esta ejecutando este script con los permisos adecuados, esa podr¡a ser la causa...
goto wtf
:uk
set dmn=Error?
:wtf
title ERROR!
color 4f
cls
echo.
echo %dmn%
echo.
pause
exit
:a1
cls
set /p US=^Usuario: 
runas /user:"%US%" "%~f0"
if %errorlevel% NEQ 0 goto a1
exit
:a2
echo Set UAC = CreateObject("Shell.Application")>uac.vbs
echo UAC.ShellExecute WScript.Arguments.Item(0), "", "", "runas", ^1>>uac.vbs
cscript //nologo uac.vbs "%~f0"
ping 127.0.0.1 -n 3 >nul
del /f /q uac.vbs
exit