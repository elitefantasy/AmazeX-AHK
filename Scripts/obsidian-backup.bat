@echo off
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "datestamp=%YYYY%-%MM%-%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
@REM echo datestamp: "%datestamp%"

set "source=E:\2 PcloudSync\Obsidian"
set "dest=E:\1 Megasync\Backup-Obsidian\obsidian%datestamp%
echo "making backup of Obsidian Source...."
timeout /t 2 /nobreak
xcopy /s/e /q /I /y "%source%" "%dest%"
timeout /t 1 /nobreak
echo "Backup is Done!.. and windows will be closed in 5 seconds"
timeout /t 5 /nobreak
start %windir%\explorer.exe "E:\1 Megasync\Backup-Obsidian\"