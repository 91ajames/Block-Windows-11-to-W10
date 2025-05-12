@echo off
:: Check for Administrator rights
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO Please run this script as Administrator.
    PAUSE
    EXIT /B
)

:: Configure Cortana setting (Disable Allow Cortana)
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f

:: Configure Web Search setting (Enable "Do not allow web search")
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f

:: Refresh Group Policy
GPUPDATE /FORCE

ECHO Group Policy settings have been configured:
ECHO - Allow Cortana: Disabled
ECHO - Do not allow web search: Enabled
ECHO.
ECHO Note: Some changes might require a reboot to take full effect.
PAUSE