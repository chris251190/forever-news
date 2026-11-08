@echo off
rem Doppelklick: holt die neuesten WoW-Forever-Patch-Notes und aktualisiert das Addon.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Update-News.ps1"
echo.
echo Im Spiel danach /reload eingeben (oder das Spiel neu starten).
pause
