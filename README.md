# EDI and HL7 Message Reader

Explains HL7 v2 and X12 (EDI) messages segment by segment and field by field, in plain language.
Everything runs on your own computer. Nothing is sent over the internet.

## What's in this folder

| Item | What it is |
|---|---|
| `EDI and HL7 Message Reader.app` | The Mac desktop app. Double-click to open. Drag it into **Applications** if you like. |
| `EDI-and-HL7-Message-Reader.html` | The same tool as a single web page. Opens in any browser (Chrome, Edge, Safari, Firefox) on Mac or Windows, with nothing to install. |
| `desktop/` | What's needed to rebuild the desktop app: the launcher (`message_reader_app.py`), build scripts, and icons. |

## Mac

- **Open:** double-click `EDI and HL7 Message Reader.app`.
- **Rebuild after changing the HTML:** open Terminal and run `bash desktop/build_mac.sh` from this folder. The first build downloads two Python packages (pywebview and PyInstaller) into `desktop/.venv`. After that it takes about a minute.
- **On a different Mac:** the app isn't signed with an Apple Developer ID, so a copy downloaded or AirDropped to another Mac is blocked the first time. Try to open it once, then go to **System Settings → Privacy & Security**, scroll down, click **Open Anyway** next to the app's name, and confirm. Building it on that Mac with `build_mac.sh` avoids the prompt.

## Windows

A Windows `.exe` has to be built on a Windows PC, because a Mac can't produce one.

1. Install Python 3 from python.org. During setup, tick **"Add python.exe to PATH"**.
2. Copy this whole folder to the PC.
3. Double-click `desktop\build_windows.bat`.
4. `EDI and HL7 Message Reader.exe` appears in the main folder. It is one file, so you can copy it anywhere.

The Windows app uses Microsoft Edge WebView2, which is already built into Windows 10 and 11. Windows SmartScreen may warn about an unrecognized app the first time. Click **More info**, then **Run anyway**.

## Notes

- The built app (`.app` / `.exe`) isn't stored in git. Run the build script to make it from the files here.
- The desktop app and the HTML file show the same page. Change `EDI-and-HL7-Message-Reader.html`, then rebuild, to update the app.
- The desktop app saves its text size and light/dark setting in `~/Library/Application Support/EDI and HL7 Message Reader` on a Mac, or `%APPDATA%\EDI and HL7 Message Reader` on Windows. Messages you paste are not saved.
- Before putting it on a work computer, check with IT. Many companies don't allow unsigned or self-built apps.
