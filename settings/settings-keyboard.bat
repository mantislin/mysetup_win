@echo off
chcp 65001 >nul

SETLOCAL ENABLEDELAYEDEXPANSION

:: - keyboard settings
:: - ==============================
:: -- Turn off NumLock by default. (0:turn off; 2:turn on;)
call admrun reg add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "0" /f
:: -- Set keyboard delay to 0.
call admrun reg add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f
:: -- Set keyboard speed to max
call admrun reg add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d "31" /f

ENDLOCAL
