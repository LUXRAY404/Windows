@echo off
:: Check for Admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting Administrator Privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit
)

cls
echo ==============================
echo      BitLocker Disable Tool
echo ==============================
echo.

set /p drive=Enter drive letter (Example: C): 

if "%drive%"=="" (
    echo No drive entered. Exiting...
    pause
    exit
)

echo.
echo Checking BitLocker status on %drive%:
manage-bde -status %drive%:
echo.

echo Turning off BitLocker on %drive%:
manage-bde -off %drive%:
echo.

echo Decryption process started.
echo You can monitor progress using:
echo manage-bde -status %drive%:
echo.
pause
