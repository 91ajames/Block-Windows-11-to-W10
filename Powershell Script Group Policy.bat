@echo off
:: Batch script to enable PowerShell script execution and prompt for reboot
:: Run as Administrator!
 
:: Check for admin rights
NET FILE >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo This script requires administrator privileges.
    echo Please right-click and select "Run as administrator".
    pause
    exit /b
)
 
:: Set PowerShell execution policy via Group Policy
echo Configuring PowerShell execution policy...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "EnableScripts" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "RemoteSigned" /f >nul
 
echo PowerShell script execution has been enabled (RemoteSigned policy).
echo.
echo Your computer needs to reboot for changes to take effect.
echo.
 
:: Reboot countdown with cancel option
set /a countdown=10
:rebootloop
echo Rebooting in %countdown% seconds... Press Ctrl+C to cancel.
choice /n /c YN /d Y /t 1 >nul
if errorlevel 2 (
    echo Reboot cancelled.
    pause
    exit /b
)
set /a countdown-=1
if %countdown% gtr 0 goto rebootloop
 
:: Initiate reboot
echo Rebooting now...
shutdown /r /t 0