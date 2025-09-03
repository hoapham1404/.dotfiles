# ExecutionPolicy
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

# Variables
$env:EDITOR = "code"
# $IS_PS_VERSION_5 = $PSVersionTable.PSVersion.Major -eq 5

# key bindings
Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardKillWord

Set-PSReadLineKeyHandler -Key Ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Ctrl+n -Function HistorySearchForward

Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit

Set-PSReadLineKeyHandler -Key Ctrl+f -Function ForwardChar
Set-PSReadLineKeyHandler -Key Ctrl+b -Function BackwardChar
Set-PSReadLineKeyHandler -Key Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Key Ctrl+e -Function EndOfLine

Set-PSReadLineKeyHandler -Key 'Ctrl+a,f'  -ScriptBlock {
    # Directories to search
    $dirs =  @(
        "$HOME\Workspace",
        "D:\Workspace",
        "$HOME\Documents",
        "$HOME\Workspace"
    )

    # Find directories up to depth 3
    $foundDirs = foreach ($base in $dirs) {
        if (Test-Path $base) {
            $base

            Get-ChildItem -Path $base -Directory -Recurse -Depth 3 | Select-Object -ExpandProperty FullName
        }
    }

    if (-not $foundDirs) {
        Write-Host "No directories found."
        exit 0
    }

    # Try fzf first then fallback to Out-GridView
    if (Get-Command fzf -ErrorAction SilentlyContinue) {
        $Selected = $foundDirs | fzf
    } else {
        $Selected = $foundDirs | Out-GridView -Title "Select a directory" -PassThru
    }

    # Exit if nothing selected
    if (-not $Selected) {
        exit 0
    }

    Set-Location -Path $Selected
}