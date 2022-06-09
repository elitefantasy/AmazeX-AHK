
;----------------------------------------------------------------------------------------------------
; Initialization
;----------------------------------------------------------------------------------------------------
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
    ;Custom Icon
   	 I_Icon = %A_ScriptDir%\..\Resources\Icons\AmazeX.ico
   	 IfExist, %I_Icon%
   	 Menu, Tray, Icon, %I_Icon%
    	;return
;----------------------------------------------------------------------------------------------------
; Autolaunch
;----------------------------------------------------------------------------------------------------
Run, %A_ScriptDir%\Tools\AmazeX-sorter.ahk
Run, %A_ScriptDir%\Tools\AmazeX-clipper.ahk

;_________________________________________________
; Context Menu
;_________________________________________________
	Menu, Tray, NoStandard


	Menu, Tray, add, Utility,Function
	Menu, Tray, Icon, Utility, %A_ScriptDir%\..\Resources\Icons\AmazeX.ico
	Menu, Utility, Add, Open, OpenGui


	Menu,Tray,Add,Launch,Function
	Menu,Tray,Icon,Launch,%A_ScriptDir%\..\Resources\Icons\menu.ico

	Menu,Launch,Add,Cloud Convert,OpenCloudConvert
	Menu,Launch,Icon,Cloud Convert,%A_ScriptDir%\..\Resources\Icons\cloudconvert.ico

	Menu,Launch,Add,Imgur,imgur
	Menu,Launch,Icon,Imgur,%A_ScriptDir%\..\Resources\Icons\imgur.ico

	Menu,Launch,Add,Win10 ConMen Cleaner,OpenConCleaner
	Menu,Launch,Add,Old Win10 ConMen,Win10ConMenu

	Menu,Tray,Add,Quick Access,Function
	Menu,Tray,Icon,Quick Access,%A_ScriptDir%\..\Resources\Icons\folder.ico

	Menu,Quick Access,Add,Downloads LOC,DownloadsLoc
	Menu,Quick Access,Icon,Downloads LOC,%A_ScriptDir%\..\Resources\Icons\folder.ico

	Menu,Quick Access,Add,Script LOC,ScriptLoc
	Menu,Quick Access,Icon,Script LOC,%A_ScriptDir%\..\Resources\Icons\folder.ico

	Menu,Quick Access,Add,Startup LOC,StartupLoc
	Menu,Quick Access,Icon,Startup LOC,%A_ScriptDir%\..\Resources\Icons\folder.ico

	Menu,Quick Access,Add,Dev LOC,DevLoc
	Menu,Quick Access,Icon,Dev LOC,%A_ScriptDir%\..\Resources\Icons\folder.ico

	Menu,Tray,Add,
	Menu,Tray,Add,Edit Script,EditScript
	Menu,Tray,Icon,Edit Script,%A_ScriptDir%\..\Resources\Icons\notepad.ico

	Menu, Tray, Add, Pause/Resume,Pause
	Menu, Tray, Icon, Pause/Resume,%A_ScriptDir%\..\Resources\Icons\pause.ico

	Menu, Tray, Add, Exit,
	Menu, Tray,Icon,Exit,%A_ScriptDir%\..\Resources\Icons\cross.ico


	Menu,Tray,Add,Utility,:Utility
	Menu,Tray,Add,Launch,:Launch
	Menu,Tray,Add,Quick Access,:Quick Access
	Function(Item,Index,Menu){
		MsgBox,You Clicked: %Item% Under: %Menu%
	}
#z::Menu,Tray,Show
; RButton::Menu, Tray, Close

;_________________________________________________
;Menu Labels Used here
;_________________________________________________
	OpenGui:
		Run, %A_ScriptDir%\New-Gui.ahk
		Return

	OpenCloudConvert:
		Run, https://cloudconvert.com/
		Return
	imgur:
		Run, https://imgur.com/upload
		Return
	OpenConCleaner:
		Return
	Win10ConMenu:
		Return

	DownloadsLoc:
		Run, "C:\Users\%A_UserName%\Downloads"
		Return
	ScriptLoc:
		Run, %A_ScriptDir%\..\
		return
	StartupLoc:
		Run, C:\Users\%A_UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
		Return
	DevLoc:
		Run, "C:\Users\anilm\Downloads\Autohotkey Tools"
		Return

	ObsidianL:
		Run, %A_ScriptDir%\obsidian-backup.bat
		Return
	EditScript:
		Run, Edit %A_ScriptDir%\AmazeX-main.ahk
		return
	Pause:
		Pause
		Return
	Exit:
		DetectHiddenWindows, On
		WinGet, AHKList, List, ahk_class AutoHotkey
		Loop, %AHKList%
		{
		    ID := AHKList%A_Index%
		    If (ID <> A_ScriptHwnd)
			   WinClose, ahk_id %ID%
		}
		Process, Close, ShareX.exe
		ExitApp
		Return

;----------------------------------------------------------------------------------------------------
; Custom Hotkeys
;----------------------------------------------------------------------------------------------------
	^r::Reload
	^`::Run, Edit %A_ScriptDir%\AmazeX-main.ahk
	^ESC::Run, %A_ScriptDir%\Tools\SysMeter.ahk
	^1::Run, %A_ScriptDir%\utility-gui.ahk
	^2::Run, %A_ScriptDir%
;----------------------------------------------------------------------------------------------------
; Program Hotkeys
;----------------------------------------------------------------------------------------------------
	^!n::Run, Notepads.exe
	^!t::RunWait, *runas wt.exe
	^!k::Run https://keep.google.com/u/1/#home
	^!s::Run, https://open.spotify.com/

