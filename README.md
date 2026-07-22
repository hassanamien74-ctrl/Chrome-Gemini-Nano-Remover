# Chrome Gemini Nano Remover 🚀

A lightweight Windows Batch script (`.bat`) that forcefully blocks Google Chrome from silently downloading the massive 4GB `weights.bin` (Gemini Nano AI model) in the background. It saves your local storage, limits background RAM consumption, and stops unexpected CPU/GPU throttling.

## How to run it without downloading the file (Safest Way)
If Windows SmartScreen or your browser flags the `.bat` file download as a false positive, you can easily create the file manually:

1. Copy the code from the box below.
2. Open **Notepad** (المفكرة) on your Windows PC.
3. Paste the code into Notepad.
4. Click **File** > **Save As**.
5. Set **Save as type** to `All Files (*.*)`.
6. Name the file `Remove_Gemini.bat` and click **Save**.
7. Right-click the saved file and choose **Run as administrator**.

### The Script Code:

```batch
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
taskkill /F /IM chrome.exe >nul 2>&1
timeout /t 2 /nobreak >nul

echo =======================================================
echo  [2/4] Searching and Deleting Old weights.bin...
echo =======================================================
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
mkdir "%CHROME_DIR%" >nul 2>&1
echo. > "%CHROME_DIR%\weights.bin"
echo Blank file created.

echo =======================================================
echo  [4/4] Locking File Attributes (Read-Only)...
echo =======================================================
attrib +r "%CHROME_DIR%\weights.bin"
echo File attributes changed to Read-Only (+r).

echo =======================================================
echo  Operation Completed Successfully! Your RAM ^& Storage are safe.
echo =======================================================
pause
```

## What This Script Does:
1. **Force Closes Google Chrome**: Safely releases any file locks on Chrome directories.
2. **Deletes the Hidden AI Directory**: Completely wipes out the `OptGuideOnDeviceModel` folder and the heavy `weights.bin` file.
3. **Creates a Dummy File**: Places an empty, 0-byte fake `weights.bin` file in its exact place.
4. **Locks File Attributes**: Sets the fake file to **Read-Only (`+r`)** so Google Chrome is structurally blocked from overwriting or re-downloading the model ever again.

## License
Feel free to share, modify, and contribute to this repository!
