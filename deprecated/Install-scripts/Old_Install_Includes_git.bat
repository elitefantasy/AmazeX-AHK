@echo off
goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...
    
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
    ) else (
        echo Failure: Current permissions inadequate Run as Administrator to continue...... && pause >nul
    )
    
:continue_Choco
    echo "Chocolatey is required for script to work properly, say y if not already on your system."
    set /p Choco="Want to install Chocolatey, y or n: "
    if %Choco%==y (
        goto installChoco
    )
    if %Choco%==n (
        goto continue_git
    ) else echo "press y or n in small, No valid argument wer passed" && goto continue_Choco

:installChoco
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
call RefreshEnv.cmd
cls
goto continue_git
pause

:continue_git
    echo "Git is required to download script. say y if git is not installed on system already"
    set /p git="Want to install Git, y or n: "
    if %git%==y (
        goto install_git
    )
    if %git%==n (
        goto continue_script
    ) else echo "press y or n in small, No valid argument wer passed" && goto continue_git

:install_git
winget install -e --id --interactive Git.Git
call RefreshEnv.cmd
cls

:continue_script
echo "installing autohotkey, 7zip, Pls wait.... may take time depending on internet speed!!"
choco install autohotkey 7zip --yes >> C:\Users\%UserName%\Desktop\TemporaryAmazeX_deleteMe.log && echo "autohotkey, 7zip installed"
echo.
echo.
echo.
echo "removing script if already exists"
rmdir /s /q "C:\Users\%UserName%\Documents\AmazeX-Utility"
echo .
echo .
echo .
echo "Cloning script now"

git clone https://github.com/elitefantasy/AmazeX-Utility.git %USERPROFILE%\Documents\Temp\AmazeX-Utility\
move /Y %USERPROFILE%\Documents\Temp\Amazex-Utility %USERPROFILE%\Documents\AmazeX-Utility
rmdir /s /q "%USERPROFILE%\Documents\Temp"
echo "making shortcut to startup"
echo .
echo .
echo .
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "C:\Users\%UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\AmazeX-main.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "C:\Users\%UserName%\Documents\AmazeX-Utility\Scripts\AmazeX-main.ahk" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript CreateShortcut.vbs
del CreateShortcut.vbs

echo "for help Do Read, Readme.md file from Github=>https://github.com/elitefantasy/Akm-s-Utility"
echo "Script is now located in =>Documents\AmazeX-Utility\"
echo "  ___                         __   __  _   _ _   _ _ _ _         "
echo " / _ \                        \ \ / / | | | | | (_) (_) |        "
echo "/ /_\ \_ __ ___   __ _ _______ \ V /  | | | | |_ _| |_| |_ _   _ "
echo "|  _  | '_ \` _ \ / _\` |_  / _ \/   \  | | | | __| | | | __| | |"
echo "| | | | | | | | | (_| |/ /  __/ /^\ \ | |_| | |_| | | | |_| |_| |"
echo "\_| |_/_| |_| |_|\__,_/___\___\/   \/  \___/ \__|_|_|_|\__|\__, |"
echo "                                                            __/ |"
echo "                                                           |___/ "
%SystemRoot%\explorer.exe "%USERPROFILE%\Documents\AmazeX-Utility\"
"C:\Users\%UserName%\Documents\AmazeX-Utility\Scripts\AmazeX-main.ahk"
pause