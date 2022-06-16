; link for script :
; original author :
; Date of Creation :
; Last updated :
; Modified By : Anil
; Last Modified : 29 May 2022
; Description : This scripts let's you select which Folder to Sort according to their file type.
;---------------------------------------------------------------------------------------------------------------------------------------;
; Initialization 
;---------------------------------------------------------------------------------------------------------------------------------------;
	#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
	SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
	SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
	#SingleInstance Force
	#Persistent
	; #NoTrayIcon
	;Custom Icon
   	 	I_Icon = %A_ScriptDir%\..\..\Resources\Icons\AmazeX-sorter.ico
		IfExist, %I_Icon%
   	 	Menu, Tray, Icon, %I_Icon%


; creating ini file if not already exists by AKM
	sorter_ini_file := A_ScriptDir . "\sorter_ini_file.ini"
	if not (FileExist(sorter_ini_file)) { ; creates the ini file if it does not exist
	FileAppend,
	(
	[mySection]
	myPermanentVar=
	), % sorter_ini_file, utf-16 ; save your ini file asUTF-16LE
	}
	; reading ini file to get path
		IniRead, Select_Monitored, sorter_ini_file.ini, mySection, myPermanentVar





;---------------------------------------------------------------------------------------------------------------------------------------;
; User Variables
;---------------------------------------------------------------------------------------------------------------------------------------;
	icon_path = %A_ScriptDir%\..\..\Resources\Icons
	;Behaviour
		; 
		MonitoredFolder = %Select_Monitored%
		UnzipTo = %Select_Monitored%\Compressed ;Default= \compressed
		UnzipToggle = False ;Toggle Unzip functionality by AKM
		HowOftenToScanInSeconds = 60 ; Default=60 , How long we wait before re-scanning the folder for any changes.
		ToolTips = 1 ;Show helper popups showing what the program is doing.
		OverWrite = 1 ;default= 1,Overwrite duplicate files?
		RemoveEmptyFolders = 0 ;default= 1, Delete any folders in the monitored folder that are now empty. (recursive)

	;Zip files
		7ZipLocation = C:\Program Files\7-Zip\7z.exe ;Needed to provide unzipping functionality.
		OpenExtractedZip = False ;Open the folder up after extraction has finished?
		DeleteZipFileAfterExtract = 1 ;default=1, Recycle the zip file after a successful extract.
		UnzipSuccessSound = 1 ;Play a jingle when unzipped something.

	;What filetypes belong to what group, and what their folder name should be sorted into.
		FiletypeObjectArray := [] ;Array needs to be initiated first to work.
		PushFiletypeToArray(FiletypeObjectArray,["zip","7z","rar","r00","001"], "Compressed") ;default= compressed
		PushFiletypeToArray(FiletypeObjectArray,["jpg","bmp","gif","gifv","webm","png","jpeg","swf","tga","tiff","exr","psd"], "Images")
		PushFiletypeToArray(FiletypeObjectArray,["txt","nfo","rtf","pptx","docx","doc"], "Documents")
		PushFiletypeToArray(FiletypeObjectArray,["mp3","flac","wav"], "Audio")
		PushFiletypeToArray(FiletypeObjectArray,["avi","mpg","mpeg","mov","mp4","mkv","wmv"], "Videos")
		PushFiletypeToArray(FiletypeObjectArray,["exe","msi","jar","cmd","bat","ahk", "iso"], "Programs")
		PushFiletypeToArray(FiletypeObjectArray,["pdf"], "Pdf")



;---------------------------------------------------------------------------------------------------------------------------------------;
; Main
;---------------------------------------------------------------------------------------------------------------------------------------;
;Start the folder monitor
	WaitTimeBetweenScans := HowOftenToScanInSeconds * 1000
	SetTimer, SearchFiles, %WaitTimeBetweenScans%
	GoSub,SearchFiles ; Immediately do a scan
	

;_________________________________________________
; Context Menu
;_________________________________________________
	Menu, Tray, NoStandard
	Menu, Tray, Add, Open Folder, open_folder
	Menu, Tray, Icon,Open Folder, %icon_path%\folder.ico
	Menu, Tray, Default, Open Folder
	Menu, Tray, Click, 1

	Menu, Tray, Add, Select Folder To Monitor,select_folder
	Menu, Tray, Icon,Select Folder To Monitor, %icon_path%\folder.ico
	
	Menu, Tray, Add, Monitored Folder?,monitored_folder
	Menu, Tray, Icon,Monitored Folder?, %icon_path%\help.ico

	
	Menu, Tray, Add, Pause/Resume, Pause
	Menu, Tray, Icon,Pause/Resume, %icon_path%\pause.ico

	Menu, Tray, Add, Exit, Exit
	Menu, Tray, Icon,Exit, %icon_path%\cross.ico
	return

	;_________________________________________________
	;Menu Labels by AKM
	;_________________________________________________
		open_folder:
			Run, %Select_Monitored%
			Return
		pause:
			pause
			Return
		select_folder:
			FileSelectFolder, Select_Monitored, , 3
			if Select_Monitored =
				MsgBox, You didn't select any folder.
			else
				MsgBox, Your selected folder is "%Select_Monitored%".
    			IniWrite, %Select_Monitored%, sorter_ini_file.ini, mySection, myPermanentVar
				IniRead, Select_Monitored, sorter_ini_file.ini, mySection, myPermanentVar
				Reload
				Return
		monitored_folder:
			msgbox, "Your selected path is " %Select_Monitored%
			Return
		Exit:
			ExitApp
			Return


;---------------------------------------------------------------------------------------------------------------------------------------;
; Functions
;---------------------------------------------------------------------------------------------------------------------------------------;	
	;Utilities
		HasVal(haystack, needle)
		{
			for index, value in haystack
				if (value = needle)
					return index
			if !IsObject(haystack)
				throw Exception("Bad haystack!", -1, haystack)
			return 0
		}
		
		MakeFolderIfNotExist(TheFolderDir)
		{
			ifnotexist,%TheFolderDir%
				FileCreateDir,%TheFolderDir%
		}		
		
		RemoveEmptyFolders(Folder)
		{
			global Tooltips
			Loop, %Folder%\*, 2, 1
			{
			  FL := ((FL<>"") ? "`n" : "" ) A_LoopFileFullPath
				Sort, FL, R D`n ; Arrange folder-paths inside-out
				Loop, Parse, FL, `n
				{
				  FileRemoveDir, %A_LoopField% ; Do not remove the folder unless is  empty
				  If ! ErrorLevel
					{
					   Del := Del+1,  RFL := ((RFL<>"") ? "`n" : "" ) A_LoopField
						if Tooltips
						{
							Tooltip,Removing empty folder %FL%
							SetTimer, RemoveToolTip, 3000
						}
					}
				}
			}
		}
		return
		
		FindZipFiles(Folder,GoalObjectDestination)
		{
			global FiletypeObjectArray
			global MonitoredFolder
			global Tooltips
			i = 0
			
			loop % FiletypeObjectArray.Count() 
			{
				i ++
				;Get a ref to the object that holds the array of extensions we want.
					if FiletypeObjectArray[i].Destination != GoalObjectDestination						
						continue
					o := FiletypeObjectArray[i]
				
				;Unzip
					if o ;Without this it may end up unzipping to the root of C drive? i THINK "" defaults to C:\ when using Loop Files
					{
						Loop, Files, %MonitoredFolder%\*.*,R
						{
							if HasVal(o.Extensions,A_LoopFileExt)
								UnZip(A_LoopFileName,A_LoopFileDir,A_LoopFileFullPath)
						}
					}
			}
		}
		return
		
		UnZip(FileFullName,Dir,FullPath)
		{
			global 7ZipLocation ;Saves having to re-pass this dir each time you use this function.
			global DeleteZipFileAfterExtract
			global OpenExtractedZip
			global Tooltips
			global UnzipTo
			global UnzipSuccessSound
			
			;Get filename
				StringGetPos,ExtentPos,FileFullName,.,R
				FileName := SubStr(FileFullName,1,ExtentPos)
				if Tooltips
				{
					Tooltip,Unzipping %FileName% > %Dir%\%FileName%
					SetTimer, RemoveToolTip, 3000
				}
				MakeFolderIfNotExist(UnzipTo . "\" . FileName)
				Runwait, "%7ZipLocation%" x "%FullPath%" -o"%UnzipTo%\%FileName%"
			sleep,2000
			
			IfExist %UnzipTo%\%FileName%
			{
				if DeleteZipFileAfterExtract
					Filerecycle, %FullPath%
				if OpenExtractedZip
					run, %UnzipTo%\%FileName%
				if UnzipSuccessSound
					soundplay, *64
			}
			else
				msgbox,,Oh Noes!,Something went wrong and I couldn't unzip %FileName% to %UnzipTo%\%FileName%
		}

		
	;Objects
		PushFiletypeToArray(InputArray,FiletypesArray,Destination)
		{
			InputArray.Push(MakeFiletypeObject(FiletypesArray,Destination))
			return InputArray
		}

		MakeFiletypeObject(InputArray,Destination)
		{
			object := []
			object.Extensions := InputArray
			object.Destination := Destination
			return object
		}
		
		GetDestination(TheFile)
		{
			global FiletypeObjectArray
			for i in FiletypeObjectArray
			{
				if HasVal(FiletypeObjectArray[i].Extensions,A_LoopFileExt)
					Destination := FiletypeObjectArray[i].Destination
			}
		return Destination
}

;---------------------------------------------------------------------------------------------------------------------------------------;
; Subroutines
;---------------------------------------------------------------------------------------------------------------------------------------;
	;Main
		SearchFiles:
		global UnzipToggle ; added by AKM
		Loop, Files, %MonitoredFolder%\*
		{
			DestinationFolder := GetDestination(A_LoopFileFullPath)
			; if (DestinationFolder = "Compressed") ; commented by AKM

			if( UnzipToggle = True and DestinationFolder = "Compressed")
				UnZip(A_LoopFileName,A_LoopFileDir,A_LoopFileFullPath)
			else if DestinationFolder
			{
				DestinationFolder := MonitoredFolder . "\" . DestinationFolder
				MakeFolderIfNotExist(DestinationFolder)
				FileMove,%A_LoopFileFullPath%,%DestinationFolder%\*.*,%OverWrite% ; *.* is needed else it could be renamed to no extension! (If dest folder failed)
					if Tooltips
					{
						Tooltip,Moving %A_LoopFileName% > %DestinationFolder%
						SetTimer, RemoveToolTip, 3000
					}
			}
		}
		if RemoveEmptyFolders
			RemoveEmptyFolders(MonitoredFolder)
		; FindZipFiles(MonitoredFolder,"Compressed") ; commented by AKM
		if( UnzipToggle = True )
			FindZipFiles(MonitoredFolder,"Compressed")
	
		;Other
		RemoveToolTip:
			SetTimer, RemoveToolTip, Off
			ToolTip
		return