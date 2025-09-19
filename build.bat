@echo off
set NAME=JobAppTracker
set DESKTOP=%USERPROFILE%\Desktop
set EXE=%DESKTOP%\%NAME%.exe

echo Building %NAME%...
py -m PyInstaller --clean --onefile --noconsole ^
  --icon=app.ico ^
  --add-data "app.ico;." ^
  -n %NAME% job_tracker_pretty.py

echo.
echo Copying EXE to Desktop...
copy /Y "dist\%NAME%.exe" "%EXE%"

echo.
echo Unpinning old shortcut from taskbar (if exists)...
powershell -command "$s=(New-Object -ComObject Shell.Application).NameSpace((Split-Path '%EXE%')).ParseName((Split-Path '%EXE%' -Leaf));$s.InvokeVerb('Unpin from Tas&kbar')" 2>nul

timeout /t 2 >nul

echo Pinning new EXE to taskbar...
powershell -command "$s=(New-Object -ComObject Shell.Application).NameSpace((Split-Path '%EXE%')).ParseName((Split-Path '%EXE%' -Leaf));$s.InvokeVerb('Pin to Tas&kbar')" 2>nul

echo.
echo Build complete! %NAME% is on Desktop and pinned to taskbar.
pause
