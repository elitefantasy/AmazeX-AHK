::::::::::::::::::::::::::::::::::::::::::::
:: Elevate.cmd - Version 4
:: Automatically check & get admin rights
:: see "https://stackoverflow.com/a/12264592/1016343" for description
::::::::::::::::::::::::::::::::::::::::::::
 @echo off 
 CLS
 ECHO.
 ECHO =============================
 ECHO Running Admin shell
 ECHO =============================

:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~dpnx0"
 rem this works also from cmd shell, other than %~0
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO.
  ECHO **************************************
  ECHO Invoking UAC for Privilege Escalation
  ECHO **************************************

  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"
  
  if '%cmdInvoke%'=='1' goto InvokeCmd 

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B

:gotPrivileges
 setlocal & cd /d %~dp0
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

 ::::::::::::::::::::::::::::
 ::START
 ::::::::::::::::::::::::::::
@REM Checks Permission for administrator
:check_Permissions
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
    ) else (
        echo Failure: Current permissions inadequate Run as Administrator to continue...... && pause >nul
    )
@REM Createlogpath
set logpath=C:\Users\%UserName%\Desktop\TemporaryAmazeX_deleteMe.log

echo Installing Chocolatey on Your System if not already installed Pls wait.....Depends on Your internet speed
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" >> %logpath% && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"  >> %logpath%
call RefreshEnv.cmd >> %logpath%
echo.
echo.
echo.
echo "installing autohotkey, 7zip, Pls wait.... may take time depending on internet speed!!"
choco install autohotkey 7zip --yes >> %logpath%
echo.
echo.
echo.


set currentpath=%~dp0
@REM Making shortcut
@REM echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
@REM echo sLinkFile = "C:\Users\%UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\AmazeX-AHK.lnk" >> CreateShortcut.vbs
@REM echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
@REM echo oLink.TargetPath = "%currentpath%\AmazeX-main.exe" >> CreateShortcut.vbs
@REM echo oLink.Save >> CreateShortcut.vbs
@REM cscript CreateShortcut.vbs >> %logpath%
@REM del CreateShortcut.vbs

echo "for help Do Read, Readme.md file from Github=>https://github.com/elitefantasy/Akm-s-Utility"
echo "Script is now located in =>%currentpath%"
echo "  ___                         __   __  _   _ _   _ _ _ _         "
echo " / _ \                        \ \ / / | | | | | (_) (_) |        "
echo "/ /_\ \_ __ ___   __ _ _______ \ V /  | | | | |_ _| |_| |_ _   _ "
echo "|  _  | '_ \` _ \ / _\` |_  / _ \/   \  | | | | __| | | | __| | |"
echo "| | | | | | | | | (_| |/ /  __/ /^\ \ | |_| | |_| | | | |_| |_| |"
echo "\_| |_/_| |_| |_|\__,_/___\___\/   \/  \___/ \__|_|_|_|\__|\__, |"
echo "                                                            __/ |"
echo "                                                           |___/ "
@REM start "" "%currentpath%\AmazeX-main.ahk" >> %logpath%