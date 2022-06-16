#NoEnv
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;===========================================First menu
Gui, Add, Text, x2 y-1 w100 h30 , |           Image            ; has to be 27 in between | |
Gui, Add, Button, x2 y29 w100 h30 gcanva, Canva
Gui, Add, Button, x2 y59 w100 h30 gsharex, ShareX
; Gui, Add, Button, x2 y89 w100 h30 , Button
; Gui, Add, Button, x2 y119 w100 h30 , Button
; Gui, Add, Button, x2 y149 w100 h30 , Button
; Gui, Add, Button, x2 y179 w100 h30 , Button
; Gui, Add, Button, x2 y209 w100 h30 , Button
; Gui, Add, Button, x2 y239 w100 h30 , Button
; Gui, Add, Button, x2 y269 w100 h30 , Button
; Gui, Add, Button, x2 y299 w100 h30 , Button
; Gui, Add, Button, x2 y329 w100 h30 , Button
; Gui, Add, Button, x2 y359 w100 h30 , Button
; Gui, Add, Button, x2 y389 w100 h30 , Button

;===========================================Second menu
Gui, Add, Text, x102 y-1 w100 h30 , |          Tools          
Gui, Add, Button, x102 y29 w100 h30 g7zip, 7zip
Gui, Add, Button, x102 y59 w100 h30 gnotepads, Notepads
Gui, Add, Button, x102 y89 w100 h30 gventoy, Ventoy
Gui, Add, Button, x102 y119 w100 h30 geverything, Everything
Gui, Add, Button, x102 y149 w100 h30 gpandoc, Pandoc
Gui, Add, Button, x102 y179 w100 h30 gautohotkey, Autohotkey
Gui, Add, Button, x102 y209 w100 h30 gccleaner, CCleaner
Gui, Add, Button, x102 y239 w100 h30 gpowertoys, Powertoys
Gui, Add, Button, x102 y269 w100 h30 grevo, RevoUninstaller
Gui, Add, Button, x102 y299 w100 h30 gwinaerotweaker, Winaerotweaker
; Gui, Add, Button, x102 y329 w100 h30 , Button
; Gui, Add, Button, x102 y359 w100 h30 , Button
; Gui, Add, Button, x102 y389 w100 h30 , Button
;===========================================Third Menu
Gui, Add, Text, x202 y-1 w100 h30 , |  Win Customization  
Gui, Add, Button, x202 y29 w100 h30 gtaskbarx, TaskbarX
Gui, Add, Button, x202 y59 w100 h30 gqttabbar, qttabbar
;===========================================Fourth Menu
Gui, Add, Text, x302 y-1 w100 h30 , |         Internet         
Gui, Add, Button, x302 y29 w100 h30 gchrome, Chrome
Gui, Add, Button, x302 y59 w100 h30 gfdm, FDM
Gui, Add, Button, x302 y89 w100 h30 gmega, Mega
;===========================================Fifth menu
Gui, Add, Text, x402 y-1 w100 h30 , |         Other
Gui, Add, Button, x402 y29 w100 h30 gobsidian, Obsidian
Gui, Add, Button, x402 y59 w100 h30 gdrawboard, Drawboard
Gui, Add, Button, x402 y89 w100 h30 gxodo, Xodo
;===========================================Sixth menu
; Gui, Add, Text, x502 y-1 w100 h30 , sixth menu
; Gui, Add, Button, x502 y29 w100 h30 , Button
; Generated using SmartGUI Creator 4.0
Gui, Show, x332 y123 h300 w504, Selective Install
Return

GuiClose:
ExitApp

;=========================Labels Used Here=========================
/*
run, *runas cmd.exe /k echo installing program please wait... && choco install powertoys && pause && exit
Return
*/

canva:
run, *runas cmd.exe /k echo installing program please wait && winget install Canva.Canva && pause && exit
Return
sharex:
run, *runas cmd.exe /k echo installing program please wait... && choco install sharex && pause && exit
Return
7zip:
run, *runas cmd.exe /k echo installing program please wait... && choco install 7zip && pause && exit
Return
notepads:
run, *runas cmd.exe /k echo installing program please wait... && winget install JackieLiu.NotepadsApp && pause && exit
Return
ventoy:
run, *runas cmd.exe /k echo installing program please wait... && choco install ventoy && pause && exit
Return
everything:
run, *runas cmd.exe /k echo installing program please wait... && choco install everything && pause && exit
Return
pandoc:
run, *runas cmd.exe /k echo installing program please wait... && choco install pandoc && pause && exit
Return
autohotkey:
run, *runas cmd.exe /k echo installing program please wait... && choco install autohotkey && pause && exit
Return
ccleaner:
run, *runas cmd.exe /k echo installing program please wait... && choco install ccleaner && pause && exit
Return
powertoys:
run, *runas cmd.exe /k echo installing program please wait... && choco install powertoys && pause && exit
Return
revo:
run, *runas cmd.exe /k echo installing program please wait... && choco install revo-uninstaller && pause && exit
Return
winaerotweaker:
run, *runas cmd.exe /k echo installing program please wait... && choco install winaero-tweaker && pause && exit
Return
taskbarx:
run, *runas cmd.exe /k echo installing program please wait... && winget install 9PCMZ6BXK8GH && pause && exit
Return
qttabbar:
run, *runas cmd.exe /k echo installing program please wait... && choco install qttabbar && pause && exit
Return
chrome:
run, *runas cmd.exe /k echo installing program please wait... && choco install googlechrome && pause && exit
Return
fdm:
run, *runas cmd.exe /k echo installing program please wait... && choco install freedownloadmanager && pause && exit
Return
mega:
run, *runas cmd.exe /k echo installing program please wait... && choco install megasync && pause && exit
Return
obsidian:
run, *runas cmd.exe /k echo installing program please wait... && choco install obsidian && pause && exit
Return
drawboard:
run, *runas cmd.exe /k echo installing program please wait... && choco install 9WZDNCRFHWQT && pause && exit
Return
xodo:
run, *runas cmd.exe /k echo installing program please wait... && choco install 9WZDNCRDJXP4 && pause && exit
Return
