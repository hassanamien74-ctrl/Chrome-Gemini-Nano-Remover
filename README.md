# Chrome Gemini Nano Remover 🚀

A lightweight Windows Batch script (`.bat`) that forcefully blocks Google Chrome from silently downloading the massive 4GB `weights.bin` (Gemini Nano AI model) in the background. It saves your local storage, limits background RAM consumption, and stops unexpected CPU/GPU throttling.

## What This Script Does:
1. **Force Closes Google Chrome**: Safely releases any file locks on Chrome directories.
2. **Deletes the Hidden AI Directory**: Completely wipes out the `OptGuideOnDeviceModel` folder and the heavy `weights.bin` file.
3. **Creates a Dummy File**: Places an empty, 0-byte fake `weights.bin` file in its exact place.
4. **Locks File Attributes**: Sets the fake file to **Read-Only (`+r`)** so Google Chrome is structurally blocked from overwriting or re-downloading the model ever again.

## How To Use It:
1. Download the `Remove_Gemini.bat` file from this repository.
2. Right-click on the file and select **Run as administrator** (Required to modify folder permissions and kill active processes).
3. Let the script execute all 4 steps. Once completed, you can safely reopen Google Chrome.

## License
Feel free to share, modify, and contribute to this repository!
