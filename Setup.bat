@echo off

winget install OpenJS.NodeJS.LTS
Invoke-WebRequest https://get.pnpm.io/install.ps1 -UseBasicParsing | Invoke-Expression

start PullBuildPath.bat