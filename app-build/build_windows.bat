@echo off
REM Builds "EDI and HL7 Message Reader.exe" for Windows.
REM Run on a Windows PC: double-click this file, or run it from Command Prompt.
REM Needs Python 3 from python.org (tick "Add python.exe to PATH" when installing).
REM The window uses Microsoft Edge WebView2, which is built into Windows 10 and 11.
setlocal
cd /d "%~dp0"
set "HERE=%CD%"

if not exist ".venv\Scripts\python.exe" (
  echo Setting up a private Python environment ^(first time only^)...
  py -3 -m venv .venv || python -m venv .venv || goto :fail
)
".venv\Scripts\python.exe" -m pip install --quiet --upgrade -r requirements.txt || goto :fail

set "WORK=%TEMP%\message-reader-build"
".venv\Scripts\pyinstaller.exe" --noconfirm --clean --windowed --onefile ^
  --name "EDI and HL7 Message Reader" ^
  --icon "%HERE%\icon.ico" ^
  --add-data "%HERE%\..\EDI-and-HL7-Message-Reader.html;." ^
  --workpath "%WORK%" --specpath "%WORK%" ^
  --distpath "%HERE%\dist" ^
  "%HERE%\message_reader_app.py" || goto :fail
rmdir /s /q "%WORK%" 2>nul

copy /y "dist\EDI and HL7 Message Reader.exe" ".." >nul
rmdir /s /q dist
echo.
echo Done: "EDI and HL7 Message Reader.exe" is in the folder above this one.
pause
exit /b 0

:fail
echo.
echo Build failed - see the messages above.
pause
exit /b 1
