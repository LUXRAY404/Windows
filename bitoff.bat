@echo off
title BitLocker Full Disable Tool
color 0A

:: ===== Check Administrator =====
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting Administrator Privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit
)

cls
echo ==========================================
echo        BitLocker Full Disable Tool
echo ==========================================
echo.

:: ===== Show Current Status =====
echo Current BitLocker Status:
manage-bde -status C:
echo.

echo Clearing stored auto-unlock keys...
manage-bde -autounlock -ClearAllKeys C:
echo.

echo Turning OFF BitLocker on C: ...
manage-bde -off C:
echo.

echo ==========================================
echo Decryption Started.
echo Monitoring progress...
echo Press CTRL + C to stop monitoring.
echo ==========================================
echo.

:loop
timeout /t 10 >nul
cls
manage-bde -status C:
goto loop
