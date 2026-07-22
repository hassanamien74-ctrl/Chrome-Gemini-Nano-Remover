@echo off
:: Requesting Administrator privileges to ensure file locking and process closing works
set "params=%*"
cd /d "%~dp0" && fsutil dirty query %systemdrive% >nul 2>&1 || (
    echo Requesting administrative privileges...
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
)

set "CHROME_DIR=%LOCALAPPDATA%\Google\Chrome\User Data\OptGuideOnDeviceModel"

echo =======================================================
echo  [1/4] Closing Google Chrome Forcefully...
echo =======================================================
:: Force close the browser to release any file locks
taskkill /F /IM chrome.exe >nul 2>&1
:: Give the system 2 seconds to make sure all background tasks are closed
timeout /t 2 /nobreak >nul

echo =======================================================
echo  [2/4] Searching and Deleting Old weights.bin...
echo =======================================================
:: Verify if the folder exists and wipe it entirely
if exist "%CHROME_DIR%" (
    echo Found old Gemini Nano directory. Deleting files...
    rmdir /S /Q "%CHROME_DIR%"
    echo Old weights.bin and logs deleted successfully!
) else (
    echo Gemini Nano folder not found. Proceeding to prevention step.
)

echo =======================================================
echo  [3/4] Creating New Fake Blank weights.bin...
echo =======================================================
:: Re-create the folder cleanly
mkdir "%CHROME_DIR%" >nul 2>&1
:: Create an empty weights.bin file (0 bytes)
echo. > "%CHROME_DIR%\weights.bin"
echo Blank file created.

echo =======================================================
echo  [4/4] Locking File Attributes (Read-Only)...
echo =======================================================
:: Set file to Read-Only so Chrome can't overwrite it later
attrib +r "%CHROME_DIR%\weights.bin"
echo File attributes changed to Read-Only (+r).

echo =======================================================
echo  Operation Completed Successfully! Your RAM ^& Storage are safe.
echo =======================================================
pause
