@echo off

git fetch && git pull
call pnpm build && call pnpm inject -branch stable

echo "Launching Discord"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0OpenDiscord.ps1"

IF %ERRORLEVEL% NEQ 0 (
    ECHO Failed to open Discord
	pause
)

exit /b 0