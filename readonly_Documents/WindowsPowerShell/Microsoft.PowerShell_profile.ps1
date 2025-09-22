# ExecutionPolicy
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

# Enhanced Editor Detection with Priority and Fallback
function Set-PreferredEditor {
    param(
        [string[]]$EditorCandidates = @("nvim", "code", "notepad++", "vim", "nano", "notepad")
    )
    
    foreach ($editor in $EditorCandidates) {
        $command = Get-Command $editor -ErrorAction SilentlyContinue
        if ($command) {
            $env:EDITOR = $editor
            Write-Host "Editor set to: $editor" -ForegroundColor Green
            return $editor
        }
    }
    
    # Fallback to notepad if nothing else is found
    $env:EDITOR = "notepad"
    Write-Host "No preferred editors found. Defaulting to: notepad" -ForegroundColor Yellow
    return "notepad"
}

# Set the editor on profile load
Set-PreferredEditor | Out-Null

# Enhanced Key Bindings for Productivity
Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardKillWord

# History navigation
Set-PSReadLineKeyHandler -Key Ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Ctrl+n -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory

# Character and line navigation
Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit
Set-PSReadLineKeyHandler -Key Ctrl+f -Function ForwardChar
Set-PSReadLineKeyHandler -Key Ctrl+b -Function BackwardChar
Set-PSReadLineKeyHandler -Key Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Key Ctrl+e -Function EndOfLine

# Word navigation
Set-PSReadLineKeyHandler -Key Alt+f -Function NextWord
Set-PSReadLineKeyHandler -Key Alt+b -Function BackwardWord

# Line editing
Set-PSReadLineKeyHandler -Key Ctrl+k -Function KillLine
Set-PSReadLineKeyHandler -Key Ctrl+u -Function BackwardKillLine
Set-PSReadLineKeyHandler -Key Ctrl+y -Function Yank

# Clear screen
Set-PSReadLineKeyHandler -Key Ctrl+l -Function ClearScreen

# Quick directory navigation up
Set-PSReadLineKeyHandler -Key 'Ctrl+u,p' -ScriptBlock {
    Set-Location ..
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}

# Quick access to current directory in Explorer
Set-PSReadLineKeyHandler -Key 'Ctrl+o,e' -ScriptBlock {
    Start-Process explorer.exe -ArgumentList (Get-Location).Path
}

# Quick Git status
Set-PSReadLineKeyHandler -Key 'Ctrl+g,s' -ScriptBlock {
    if (Test-Path .git -PathType Container) {
        git status --short
        [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
    } else {
        Write-Host "Not a git repository" -ForegroundColor Yellow
    }
}

Set-PSReadLineKeyHandler -Key 'Ctrl+a,f'  -ScriptBlock {
    try {
        # Enhanced Directory Finder with better performance and duplicate handling
        $searchPaths = @(
            $HOME,
            "$HOME\Workspace",
            "D:\Workspace",
            "$HOME\Documents",
            "$HOME\Desktop"
        )
        
        # Use hashtable to avoid duplicates and improve performance
        $foundDirs = @{}
        
        foreach ($basePath in $searchPaths) {
            if (Test-Path $basePath -ErrorAction SilentlyContinue) {
                # Add base directory
                $foundDirs[$basePath] = $true
                
                # Search subdirectories with depth limit
                try {
                    Get-ChildItem -Path $basePath -Directory -Recurse -Depth 3 -ErrorAction SilentlyContinue | 
                        ForEach-Object { $foundDirs[$_.FullName] = $true }
                } catch {
                    Write-Warning "Could not search in: $basePath"
                }
            }
        }
        
        $allDirs = $foundDirs.Keys | Sort-Object
        
        if (-not $allDirs) {
            Write-Host "No directories found in search paths." -ForegroundColor Yellow
            return
        }
        
        # Try fzf first, then fallback to Out-GridView
        $selectedDir = $null
        if (Get-Command fzf -ErrorAction SilentlyContinue) {
            $selectedDir = $allDirs | fzf --height=50% --border --preview "dir {}" --preview-window=right:30%
        } else {
            $selectedDir = $allDirs | Out-GridView -Title "Select Directory (Found: $($allDirs.Count))" -PassThru
        }
        
        if ($selectedDir -and (Test-Path $selectedDir)) {
            Set-Location -Path $selectedDir
            Write-Host "Changed to: $selectedDir" -ForegroundColor Green
        }
    } catch {
        Write-Error "Error in directory finder: $($_.Exception.Message)"
    }
}

# Additional Productivity Functions and Aliases
function prompt {
    try {
        $currentPath = (Get-Location).Path
        $shortPath = $currentPath -replace [regex]::Escape($HOME), "~"
        
        # Git branch info if in a git repo
        $gitBranch = ""
        if (Test-Path .git -PathType Container) {
            try {
                $branch = git symbolic-ref --short HEAD 2>$null
                if ($branch) {
                    $gitBranch = " [$branch]"
                }
            } catch { }
        }
        
        Write-Host "$shortPath$gitBranch" -ForegroundColor Cyan -NoNewline
        return "> "
    } catch {
        return "PS> "
    }
}

# Useful aliases and functions
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name la -Value Get-ChildItem
Set-Alias -Name grep -Value Select-String

function .. { Set-Location .. }
function ... { Set-Location ../.. }
function .... { Set-Location ../../.. }

function which($name) {
    Get-Command $name -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Definition
}

function touch($file) {
    if (Test-Path $file) {
        (Get-Item $file).LastWriteTime = Get-Date
    } else {
        New-Item -ItemType File -Path $file | Out-Null
    }
}

function mkcd($path) {
    New-Item -ItemType Directory -Path $path -Force | Out-Null
    Set-Location $path
}

# Performance: Only load PSReadLine options if module is available
if (Get-Module PSReadLine -ListAvailable) {
    # Check PSReadLine version for compatibility
    $psReadLineModule = Get-Module PSReadLine -ListAvailable | Sort-Object Version -Descending | Select-Object -First 1
    
    # PredictionSource parameter requires PSReadLine 2.1.0 or higher
    if ($psReadLineModule.Version -ge [System.Version]"2.1.0") {
        Set-PSReadLineOption -PredictionSource History
    }
    
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    Set-PSReadLineOption -ShowToolTips
}