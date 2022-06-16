@echo off
cd /d %~dp0
taskkill /f /im ShareX.exe
taskkill /f /im AutoHotkey.exe
taskkill /f /im "AmazeX AHK.exe"