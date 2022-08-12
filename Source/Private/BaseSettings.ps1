# Create default FZF Settings to be used in module

if (-not (Get-Command -Name fzf -ErrorAction SilentlyContinue)) {
    Write-Error "AWS Utils Module was loaded but not find FZF in system Path."
    Write-Error "Make sure FZF is installed and available in Path as most functions in this module depends on it: https://github.com/junegunn/fzf#windows"
}

$FZF_VALUES = [ordered]@{
    Arguments = '--ansi', '--layout=reverse', '--border', '--height', '60%'
}

New-Variable -Name FZF_SETTINGS  -Value $FZF_VALUES -Scope Script -Force

Export-ModuleMember -Function * -Alias *