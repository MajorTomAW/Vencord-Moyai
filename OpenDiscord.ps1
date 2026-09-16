function Get-DiscordPath {
    $updateExe = Join-Path $env:LOCALAPPDATA 'Discord\Update.exe'
    if (Test-Path $updateExe) {
        Write-Host "Success: Found Discord via Update.exe launcher."
        return $updateExe
    }

    $discordDir = Join-Path $env:LOCALAPPDATA 'Discord'
    if (Test-Path $discordDir) {
        # Find all folders matching 'app-*' and sort them to get the newest
        $latestAppFolder = Get-ChildItem -Path $discordDir -Filter 'app-*' -Directory |
                           Sort-Object Name -Descending |
                           Select-Object -First 1
        
        if ($latestAppFolder) {
            $discordExe = Join-Path $latestAppFolder.FullName 'Discord.exe'
            if (Test-Path $discordExe) {
                Write-Host "Success: Found Discord in the latest app folder."
                return $discordExe
            }
        }
    }

    $regPath = 'HKCU:\Software\Discord'
    if (Test-Path $regPath) {
        $installDir = (Get-ItemProperty -Path $regPath -ErrorAction SilentlyContinue).InstallLocation
        if ($installDir) {
            $discordExe = Join-Path $installDir 'Discord.exe'
            if (Test-Path $discordExe) {
                Write-Host "Success: Found Discord using the registry."
                return $discordExe
            }
        }
    }

    return $null
}

$discordPath = Get-DiscordPath

if ($discordPath) {
    if ($discordPath -like '*Update.exe') {
        Start-Process -FilePath $discordPath -ArgumentList '--processStart Discord.exe'
    } else {
        Start-Process -FilePath $discordPath
    }
} else {
    Write-Error "Could not find a Discord installation."
    Exit 1
}