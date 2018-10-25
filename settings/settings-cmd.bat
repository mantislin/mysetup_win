@echo off
chcp 65001 >nul

SETLOCAL ENABLEDELAYEDEXPANSION

:: - Console settings
::  Meanings of keys: https://blogs.msdn.microsoft.com/commandline/2017/06/20/understanding-windows-console-host-settings/
:: - ==============================
call admrun reg add "HKEY_CURRENT_USER\Console" /v "CtrlKeyShortcutsDisabled" /t REG_DWORD /d 0 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "ExtendedEditKey" /t REG_DWORD /d 1 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "FaceName" /t REG_SZ /d "__DefaultTTFont__" /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "FilterOnPaste" /t REG_DWORD /d 1 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "FontFamily" /t REG_DWORD /d 0 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "FontSize" /t REG_DWORD /d 1048576 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "FontWeight" /t REG_DWORD /d 0 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "ForceV2" /t REG_DWORD /d 1 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "HistoryBufferSize" /t REG_DWORD /d 999 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "HistoryNoDup" /t REG_DWORD /d 0 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "InsertMode" /t REG_DWORD /d 1 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "LineSelection" /t REG_DWORD /d 1 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "LineWrap" /t REG_DWORD /d 1 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "NumberOfHistoryBuffers" /t REG_DWORD /d 4 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "PopupColors" /t REG_DWORD /d 245 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "QuickEdit" /t REG_DWORD /d 1 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "QuickEdit" /t REG_DWORD /d 1 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "ScreenBufferSize" /t REG_DWORD /d 655294574 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "ScrollScale" /t REG_DWORD /d 1 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "TrimLeadingZeros" /t REG_DWORD /d 0 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "WindowAlpha" /t REG_DWORD /d 218 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "WindowSize" /t REG_DWORD /d 1966200 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "WordDelimiters" /t REG_DWORD /d 0 /f

ENDLOCAL
