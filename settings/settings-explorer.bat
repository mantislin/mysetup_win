@echo off
chcp 65001 >nul

SETLOCAL ENABLEDELAYEDEXPANSION

:: - Get windows version number and store in variable
:: - ==============================
ver | find /i "xp" && (
    for /f "tokens=5-6 delims=. " %%i in ('ver') do set VERSION=%%i%%j
) || (
    for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i%%j
)

:: - Windows Explorer options
:: - ==============================
:: -- Always show all icons and notifications on the taskbar
call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "EnableAutoTray" /t REG_DWORD /d 0 /f
:: -- uncheck "Show desktop icons"
call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideIcons" /t REG_DWORD /d 1 /f
:: -- uncheck "Use Sharing Wizard (Recommanded)"
call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SharingWizardOn" /t REG_DWORD /d 0 /f
:: -- check Show hidden files, folders, and drivers
call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f
:: -- uncheck "Hide protected operating system files (Recommanded)"
call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 1 /f
:: -- check "Show encrypted or compressed NTFS files in color"
call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowEncryptCompressedColor" /t REG_DWORD /d 1 /f
:: -- Uncheck "Hide extensions for known file types"
::  Range   Default value
::  0 | 1   1
call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f
:: -- Restore last opened folders
::  Range   Default value
::  0 | 1   0
call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "PersistBrowsers" /t REG_DWORD /d 1 /f
:: -- check "Launch folder windows in a separate process"
call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f
:: -- Windows 10 File Explorer open "This PC" by default
::  Range   Default value
::  1 | 2   2
::  1 = This PC
::  2 = Quick access
call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f
:: -- Stop appending " - Shortcut" to Shortcut file names
call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d 0 /f
:::: -- Removes Shut Down from the Start menu and disabvles the Shut Down button in the Windows Security dialog box.
::::  Range   Default value
::::  0 | 1   0
::call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoClose" /t REG_DWORD /d 0 /f
:: -- Do not display the lock screen
::  Range   Default value
::  0 | 1   0
call admrun reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreen" /t REG_DWORD /d 0 /f
:: -- Allow system to be shut down without having to log on
::  Range   Default value
::  0 | 1   1
call admrun reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "shutdownwithoutlogon" /t REG_DWORD /d 1 /f
:: -- Disable Navigation Pane
::  win7off     PageSpaceControlSizer    REG_BINARY    c80000000000000000000000d7030000
::  win7on      PageSpaceControlSizer    REG_BINARY    c80000000100000000000000d7030000
::  win10off    PageSpaceControlSizer    REG_BINARY    A000000000000000000000003A030000
::  win10on     PageSpaceControlSizer    REG_BINARY    A000000001000000000000003A030000
for /f "usebackq tokens=* delims=" %%a in (`reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer" /v "PageSpaceControlSizer"`) do (
    for /f "usebackq tokens=3 delims= " %%b in ('%%~a') do (
        if not "%%~b" == "" (
            set "value=%%~b"
            set "valueHead=!value:~0,9!"
            set "valueMiddle=!value:~9,1!"
            set "valueTail=!value:~10!"
            rem
            if %VERSION% geq 62 ( :: Windows 8 and later
                if "%valueHead%" == "" set "valueHead=A00000000"
                if "%valueTail%" == "" set "valueTail=000000000000003A030000"
            ) else ( :: Windows 7 and earlier
                if "%valueHead%" == "" set "valueHead=c80000000"
                if "%valueTail%" == "" set "valueTail=00000000000000d7030000"
            )
            rem
            rem -- Show or Hide Windows Explorer Navigation Pane
            rem  Range   Default value
            rem  0 | 1   1
            set "valueMiddle=0"
            call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer" /v "PageSpaceControlSizer" /t REG_BINARY /d !valueHead!!valueMiddle!!valueTail! /f
        )
    )
)

ENDLOCAL
