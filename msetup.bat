@echo off
chcp 65001 >nul

SETLOCAL ENABLEDELAYEDEXPANSION
pushd "%~sdp0" >nul

which mymklink.bat >nul 2>nul || (
    if exist "D:\data\github\batch\EnvSetter.bat\EnvSetter.bat" (
        pushd "D:\data\github\batch\EnvSetter.bat" 2>nul
        EnvSetter.bat && shutdown -r -t 10
        popd 2>nul
        exit/b
    )
    echo/
    echo/--------------------------------------------------
    echo/Environments required.
    exit/b
)

if not exist "%userprofile%\_vimrc" if exist "%ghb%\dotfiles_mantislin" (
    pushd "%ghb%\dotfiles_mantislin" >nul
    call admrun setup.bat
    popd >nul
)

if exist "%ghb%\batch\StartupJudgeByConnect.bat\StartupJudgeByConnect.bat" (
    call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v 0000 /t REG_SZ /d "%ghb%\batch\StartupJudgeByConnect.bat\StartupJudgeByConnect.bat" /f
)
if exist "%userprofile%\_cmdrc.bat" (
    call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v "AutoRun" /t REG_SZ /d "%userprofile%\_cmdrc.bat" /f
)

:: -- ==========================================================================
:: -- symbol links of special points

call admrun mymklink /j /f "%userprofile%\Desktop" "D:\udata\Desktop"
call admrun mymklink /j /f "%userprofile%\Documents" "D:\uData\documents"
call admrun mymklink /j /f "%userprofile%\Downloads" "D:\tdd\Downloads"
call admrun mymklink /j /f "%userprofile%\Music" "D:\music"
call admrun mymklink /j /f "%userprofile%\Pictures" "D:\udata\Pictures"
call admrun mymklink /j /f "%userprofile%\Videos" "D:\udata\Videos"

call mymklink /j /f /s "%appdata%" "D:\uData\AppData\Roaming"
call mymklink /j /f /s "%appdata%\..\Locallow" "D:\uData\AppData\Locallow"
call mymklink /j /f /s "%appdata%\..\Local" "D:\uData\AppData\Local"

if exist "%program%" (
    call mymklink /j /f "%systemdrive%\ProgramFiles" "%program%"
    if exist "%programfiles%" call mymklink /j /f /s "%programfiles%" "%program%"
)
if exist "%program86% (
    call mymklink /j /f "%systemdrive%\ProgramFiles86" "%program86%"
    if exist "%programfiles86%" call mymklink /j /f /s "%programfiles86%" "%program86%"
)

:: -- ==========================================================================
:: -- symbol links of normal points

call mymklink /j /f "%appdata%\PotPlayerMini\Capture" "%pics%\Capture_PotPlayerMini"
call mymklink /j /f "%appdata%\弹弹play\Screenshots" "D:\uData\pictures\Captures"
call mymklink /j /f "%systemdrive%\CloudMusic" "D:\music\CloudMusic"
call mymklink /j /f /r "%appdata%\SPlayer\SVPSub" "D:\tdd\subs"
call mymklink /j /f /r "%appdata%\XMusic\XMusicCache\lrc" "D:\music\lyrics"
call mymklink /j /f /r "%docus%\XMusic" "D:\music\xiami"
call mymklink /j /f /r "%systemdrive%\BiZhi" "D:\tdd\soft\win\upupoo\dynamic-wallpapers"
call mymklink /j /f /r "D:\tdd\Downloads\Complete Youtube Saver\rensai" "U:\tdd\ani\rensai"
call mymklink /j /f /s "%lab%\batch" "%github%\batch"

:: -- ==========================================================================
:: -- settings

:: - keyboard settings
:: - ==============================
:: -- Turn off NumLock by default. (0:turn off; 2:turn on;)
call admrun reg add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "0" /f
call admrun reg add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f
call admrun reg add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d "31" /f

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
            set "valueBefore=!value:~0,9!"
            set "valueMiddle=!value:~9,1!"
            set "valueTail=!value:~10!"
            set "valueMiddle=0"
            rem  Range   Default value
            rem  0 | 1   1
            call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Modules\GlobalSettings\Sizer" /v "PageSpaceControlSizer" /t REG_BINARY /d !valueBefore!!valueMiddle!!valueTail! /f
        )
    )
)

:: - Console settings
::  Meanings of keys: https://blogs.msdn.microsoft.com/commandline/2017/06/20/understanding-windows-console-host-settings/
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
call admrun reg add "HKEY_CURRENT_USER\Console" /v "WindowSize" /t REG_DWORD /d 1966190 /f
call admrun reg add "HKEY_CURRENT_USER\Console" /v "WordDelimiters" /t REG_DWORD /d 0 /f

:: - other settings
:: -- Don't replace Command Prompt with Windows PowerShell in the menu when I right-click the start button or press Windows key+X.
call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DontUsePowerShellOnWinX" /t REG_DWORD /d 1 /f

:: -- ==========================================================================
:: -- GITHUB

:: - SSH Key generating and git global configs
:: - ==============================
call :mSetupGithubConfigs

popd >nul
ENDLOCAL
EXIT/B

:: -- ==========================================================================
:mSetupGithubConfigs -- Helping generate ssh key for github
::                   -- %~1: your_email@example.com
::                   -- %~2: your github account name
SETLOCAL
set "eMail=%~1"
set "uName=%~2"
if "%eMail%" equ "" (
    set/p eMail="Github E-Mail: "
)
if "%uName%" equ "" (
    set/p uName="Github Account name: "
)

git config --global push.default simple
if not "%uName%" equ "" git config --global user.name "%uName%"
if not "%eMail%" equ "" git config --global user.email "%eMail%"
git config --global http.postBuffer 524288000
git config --global core.autocrlf false
git config --global core.editor "gvim"
git config --global core.excludesfile ~/.gitignore_global

git config --global --replace-all diff.external gvimexternal

git config --global --replace-all difftool.gvimdiff2.cmd "gvim -f -d -c `"wincmd H`" `"\\`$REMOTE`" `"\\`$LOCAL`""
git config --global --replace-all mergetool.gvimdiff3.cmd "gvim -f -d -c `"wincmd J`" `"\\`$MERGED`" `"\\`$LOCAL`" `"\\`$BASE`" `"\\`$REMOTE`""
git config --global --replace-all mergetool.vimdiff3.cmd "vim -f -d -c `"wincmd J`" `"\\`$MERGED`" `"\\`$LOCAL`" `"\\`$BASE`" `"\\`$REMOTE`""
git config --global --replace-all diff.tool gvimdiff2
git config --global --replace-all merge.tool gvimdiff3
git config --global --replace-all merge.conflictstyle diff3

git config --global --replace-all credential.helper cache
git config --global --replace-all credential.helper "cache --timeout=3600"

call :mGenSSHKey "%eMail%"

:meoSetupGithubConfigs
ENDLOCAL
GOTO:EOF

:: -- ==========================================================================
:mGenSSHKey -- Helping generate ssh key for github
::          -- %~1: your_email@example.com
SETLOCAL
which "ssh-keygen" >nul 2>nul || (
    echo/
    echo/--------------------------------------------------
    echo/Cannot find ssh-keygen, mission failed.
    GOTO:meoGenSSHKey
)
set "eMail=%~1"
if "%eMail%" equ "" (
    set/p eMail="Github E-Mail: "
)
if "%eMail%" equ "" (
    echo/
    echo/--------------------------------------------------
    echo/Needs e-mail.
    GOTO:meoGenSSHKey
)
ssh-keygen -t rsa -b 4096 -C "%eMail%"
:meoGenSSHKey
ENDLOCAL
GOTO:EOF
