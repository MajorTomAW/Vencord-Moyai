@echo off

winget install OpenJS.NodeJS.LTS
winget install pnpm.pnpm

pnpm install --frozen-lockfile

start PullBuildPatch.bat