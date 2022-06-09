#NoEnv
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#NoTrayIcon

;-------------------------------------------------
; Utility
;-------------------------------------------------
    ; GUI
    Gui, Color, black 
    Gui, Font, cwhite s14 , Calibri ; this changes gui property
    Gui, Add, Text, x2 y-1 w100 h30 , Install ; has to be 27 in between | |
    Gui, Font, cwhite s10 ;this resets gui
    Gui, Add, Button, x2 y29 w100 h30 gchoco, choco essential
    Gui, Add, Button, x2 y59 w100 h30 gwinget, winget essential
    Gui, Add, Button, x2 y89 w100 h30 gselective, selective install
    Gui, Add, Button, x2 y119 w100 h30 gtitus, titus utility
    Gui, Add, Button, x2 y329 w100 h30 gobsidian, Obsidian-Backup
    ;===================================================
    ; Gui, Add, Text, x102 y-1 w100 h30 , |         menu2
    ; Gui, Add, Button, x102 y29 w100 h30 , Button
    ; Gui, Add, Button, x102 y329 w100 h30 , Button
    ;===================================================
    ; Gui, Add, Text, x202 y-1 w100 h30 , |menu3
    ; Gui, Add, Button, x202 y29 w100 h30 , Button
    ; Gui, Add, Button, x202 y329 w100 h30 , Button
    ;==================================================
    ; Gui, Add, Text, x302 y-1 w100 h30 , menu4
    ; Gui, Add, Button, x302 y29 w100 h30 , Button
    ; Gui, Add, Button, x302 y329 w100 h30 , Button
    ;=================================================
    Gui, Font, s14  , Calibri 
    Gui, Add, Text, x402 y-1 w100 h30 , Quick Access
    Gui, Font, 
    Gui, Add, Button, x402 y29 w100 h30 gstartupapp, Startup Apps-loc
    Gui, Add, Button, x402 y59 w100 h30 gapplication, Application-loc
    Gui, Add, Button, x402 y89 w100 h30 gutilityconfig, scriptConfig-loc

    Gui +Resize ;-MaximizeBox 
    Menu, Tray, Icon, %A_ScriptDir%\..\Resources\Icons\AmazeX.ico
    Gui, Show, x407 y214 h366 w509, AKM's Utility
    
    ; Gui Menus
        Menu,Menu,Add,Help,Function
        Menu,Help,Add,readme,Function
        Menu,Help,Add,website,Function
        Menu,Menu,Add,Help,:Help
        GuiControl, Font, cRed 
        Gui,Menu,Menu
        return
        Function(Item,Index,Menu)
        {
            %Item%: ;readme
            Run, https://github.com/elitefantasy/AmazeX-Utility/blob/main/Readme.md
            return
        }
        return

    GuiClose:
    ExitApp
        ; Gui Menu Labels Used here
            Help:
            Run, https://github.com/elitefantasy/AmazeX-Utility/blob/main/Readme.md
            return
        ; GUI Labels used here
            ;reference=>^0::RunWait, powershell.exe -NoExit -Command "choco install vlc"
            choco:
            RunWait, *runas %A_ScriptDir%\Install-scripts\Choco-install.cmd
            return

            winget:
            Runwait, *runas %A_ScriptDir%\Install-scripts\winget-install.cmd
            return

            selective:
            Run, %A_ScriptDir%\Install-scripts\select-install-gui.ahk
            return

            titus:
            RunWait, *runas powershell.exe -Command "iwr -useb https://christitus.com/win | iex"
            return

            obsidian:
            Run, %A_ScriptDir%\obsidian-backup.bat
            Return

            startupapp:
            Run, C:\Users\%A_UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
            Return

            application:
            send, #r
            sleep, 50
            send, shell:appsfolder
            sleep, 500
            send, {Enter}
            return

            utilityconfig:
            Run, Edit %A_ScriptDir%\utility-gui.ahk
            Return