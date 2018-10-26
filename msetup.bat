@echo off
chcp 65001 >nul

SETLOCAL ENABLEDELAYEDEXPANSION
pushd "%~sdp0" >nul

mymklink.bat >nul 2>nul || (
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
if exist "%~dp0settings\settings-keyboard.bat" call "%~dp0settings\settings-keyboard.bat"


:: - Windows Explorer options
:: - ==============================
if exist "%~dp0settings\settings-explorer.bat" call "%~dp0settings\settings-explorer.bat"


:: - Console settings
::  Meanings of keys: https://blogs.msdn.microsoft.com/commandline/2017/06/20/understanding-windows-console-host-settings/
:: - ==============================
if exist "%~dp0settings\settings-cmd.bat" call "%~dp0settings\settings-cmd.bat"


:: - other settings
:: - ==============================
:: -- Don't replace Command Prompt with Windows PowerShell in the menu when I right-click the start button or press Windows key+X.
call admrun reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DontUsePowerShellOnWinX" /t REG_DWORD /d 1 /f

:: -- Disable UAC
::  Range   Default value
::  0 | 1   1
call admrun reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f

:: -- Turn On or Off Windows SmartScreen
::  Range   Default value
::  0 | 1   1
call admrun reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f

:: -- Turn On or Off SmartScreen for Apps and Files
::  Range   REG_SZ  Default value
::  Block   REG_SZ  Blocks any unrecognized app from running
::  Warn    REG_SZ  Warn before running an unrecognized app
::  Off     REG_SZ  Don't do anything
call admrun reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f

:: -- Turn On or Off SmartScreen for MicrosoftEdge
::  Range   Default value
::  0 | 1   1
call admrun reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d 0 /f

:: -- Turn On or Off SmartScreen for Internet Explorer
::  Range   Default value
::  0 | 1   1
call admrun reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d 0 /f

:: -- Turn On or Off Fast Startup
::  Range   Default value
::  0 | 1   1
::  0 = Turn off fast startup
::  1 = Turn on fast startup
call admrun reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f


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
