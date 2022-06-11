@echo off
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
Making shortcut
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "C:\Users\%UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\AmazeX-main.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "%currentpath%\AmazeX-main.exe" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript CreateShortcut.vbs >> %logpath%
del CreateShortcut.vbs

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
start "" "%currentpath%\AmazeX-main.ahk" >> %logpath%