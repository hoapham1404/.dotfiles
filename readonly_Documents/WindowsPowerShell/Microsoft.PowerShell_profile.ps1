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