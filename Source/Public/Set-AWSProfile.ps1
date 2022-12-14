function Set-AWSProfile {
    <#
    .SYNOPSIS
        Set current shell session AWS Profile via environment variable.

    .DESCRIPTION
        Get a list of your configured AWS Profiles through the AWS CLI.
        Select a profile from the list using FZF and finally export that profile to the $env:AWS_PROFILE environment variable.
        This variable is respected by the AWS CLI, see Configuration settings and precedence in the AWS CLI documentation:
        https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html

    .PARAMETER ProfileName
        Name of the AWS Profile to set as default via the $env:AWS_PROFILE environment variable.

    .EXAMPLE
        PS C:\> awp
        List all profiles in your .aws/config file for interactive selection.
        Selected profile exported to $env:AWS_PROFILE environment variable

    .EXAMPLE
        PS C:\> awp myprofile
        Pre-sort the profile list with the entered keyword.
        If multiple profiles matches the keyword, user is prompted to select profile from a list.
        If only a single match is found that profile is directly selected without further user prompts.
        Selected profile exported to $env:AWS_PROFILE environment variable

    .INPUTS
        None
        ProfileName
    #>
    [Alias("awp")]

    Param(
        [Parameter(Mandatory = $False, Position = 0)]
        [AllowEmptyString()]
        [Alias('Name')]
        [string]$Profile

    )
    begin {
        if (!$env:AWP_FZF_OPTS) {
            $AWP_FZF_OPTS = $FZF_SETTINGS.Arguments
        }
        else {
            $AWP_FZF_OPTS = $env:AWP_FZF_OPTS
        } 
    }
    process {

        if ($PSBoundParameters.ContainsKey('Profile')) {
            $SelectedProfile = aws configure list-profiles | fzf -q $Profile --select-1 --exit-0 $AWP_FZF_OPTS
        }
        else {
            $SelectedProfile = aws configure list-profiles | fzf $AWP_FZF_OPTS
        }
        
        If ($SelectedProfile) {
            $env:AWS_PROFILE = $SelectedProfile
        }
        else {
            Write-Output "No Profile found / No Profile selected."
        }
    }
}