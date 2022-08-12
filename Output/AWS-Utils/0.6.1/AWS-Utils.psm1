### --- PUBLIC FUNCTIONS --- ###
#Region - Remove-AWSVariables.ps1
function Remove-AWSVariables {
    <#
    .SYNOPSIS
        Remove selected or all AWS profile and session related environment variables.

    .DESCRIPTION
        Remove selected or all AWS profile and session related environment variables.
        The following variables are removable:
        $Env:AWS_PROFILE
        $Env:AWS_ACCESS_KEY_ID
        $Env:AWS_SECRET_ACCESS_KEY
        $Env:AWS_SESSION_TOKEN
        $Env:AWS_REGION
        $Env:AWS_ROLE_ARN
        $Env:AWS_ROLE_SESSION_NAME

    .PARAMETER All
        Removes all of the following AWS envrionment variables:
        $Env:AWS_PROFILE
        $Env:AWS_ACCESS_KEY_ID
        $Env:AWS_SECRET_ACCESS_KEY
        $Env:AWS_SESSION_TOKEN
        $Env:AWS_REGION
        $Env:AWS_ROLE_ARN
        $Env:AWS_ROLE_SESSION_NAME

    .PARAMETER Keys
        Removes all of the following AWS envrionment variables:
        $Env:AWS_ACCESS_KEY_ID
        $Env:AWS_SECRET_ACCESS_KEY
        $Env:AWS_SESSION_TOKEN

    .PARAMETER Profile
        Removes all of the following AWS envrionment variables:
        $Env:AWS_PROFILE

    .PARAMETER Region
        Removes all of the following AWS envrionment variables:
        $Env:AWS_REGION

    .PARAMETER Role
        Removes all of the following AWS envrionment variables:
        $Env:AWS_ROLE_ARN
        $Env:AWS_ROLE_SESSION_NAME

    .EXAMPLE
        PS C:\> awc -A
        Removes all AWS related environment variables.

    .EXAMPLE
        PS C:\> awc -K
        Removes the Env:AWS_ACCESS_KEY_ID, $Env:AWS_SECRET_ACCESS_KEY and $Env:AWS_SESSION_TOKEN environment variables.

    .EXAMPLE
        PS C:\> awc -P
        Removes the $Env:AWS_PROFILE environment variable.

    .EXAMPLE
        PS C:\> awc -RE
        Removes the $Env:AWS_REGION environment variable.

    .EXAMPLE
        PS C:\> awc -RO
        Removes the $Env:AWS_ROLE_ARN and $Env:AWS_ROLE_SESSION_NAME environment variables.

    .EXAMPLE
        PS C:\> awc -P -K
        Removes the $Env:AWS_PROFILE, Env:AWS_ACCESS_KEY_ID, $Env:AWS_SECRET_ACCESS_KEY and $Env:AWS_SESSION_TOKEN environment variables.
    #>
    [CmdletBinding(DefaultParameterSetName = 'All')]
    [Alias("awc")]

    Param(

        [Parameter( ParameterSetName = 'All', Mandatory = $False, Position = 0)]
        [Alias('A')]
        [switch]$All,

        [Parameter(ParameterSetName = 'Variable', Mandatory = $False)]
        [Alias('K')]
        [switch]$Keys,

        [Parameter(ParameterSetName = 'Variable', Mandatory = $False)]
        [Alias('P')]
        [switch]$Profile,

        [Parameter(ParameterSetName = 'Variable', Mandatory = $False)]
        [Alias('RE')]
        [switch]$Region,

        [Parameter(ParameterSetName = 'Variable', Mandatory = $False)]
        [Alias('RO')]
        [switch]$Role
    )

    process {
 
        if ($PSBoundParameters.ContainsKey('Profile') -or $PSBoundParameters.ContainsKey('All')) {
            if (Test-Path Env:AWS_PROFILE) {
                Remove-Item Env:\AWS_PROFILE
            }

        }
        if ($PSBoundParameters.ContainsKey('Keys') -or $PSBoundParameters.ContainsKey('All')) {
            if (Test-Path Env:AWS_ACCESS_KEY_ID) {
                Remove-Item Env:\AWS_ACCESS_KEY_ID
            }
            if (Test-Path Env:AWS_SECRET_ACCESS_KEY) {
                Remove-Item Env:\AWS_SECRET_ACCESS_KEY
            }
            if (Test-Path Env:AWS_SESSION_TOKEN) {
                Remove-Item Env:\AWS_SESSION_TOKEN
            }
        }
        
        if ($PSBoundParameters.ContainsKey('Region') -or $PSBoundParameters.ContainsKey('All')) {
            if (Test-Path Env:AWS_REGION) {
                Remove-Item Env:\AWS_REGION
            }
        }
        if ($PSBoundParameters.ContainsKey('Role') -or $PSBoundParameters.ContainsKey('All')) {
            if (Test-Path Env:AWS_ROLE_ARN) {
                Remove-Item Env:\AWS_ROLE_ARN
            }
            if (Test-Path Env:AWS_ROLE_SESSION_NAME) {
                Remove-Item Env:\AWS_ROLE_SESSION_NAME
            }
        }
    }
}
Export-ModuleMember -Function Remove-AWSVariables
#EndRegion - Remove-AWSVariables.ps1
#Region - Set-AWSProfile.ps1
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
Export-ModuleMember -Function Set-AWSProfile
#EndRegion - Set-AWSProfile.ps1
#Region - Set-AWSRegion.ps1
Function Set-AWSRegion {
    <#
    .SYNOPSIS
        Set default region to use for current shell session via environment variable.

    .DESCRIPTION
        Get a list of allowed AWS Regions for your account through the AWS CLI.
        Select a region from the list using FZF and finally export that profile to the $env:AWS_REGION environment variable.

    .PARAMETER RegionName
        Name of the AWS Region to set as default via the $env:AWS_REGION environment variable.

    .EXAMPLE
        PS C:\> awr
        List all allowed regions in your AWS account for interactive selection.
        Selected region is exported to $env:AWS_REGION environment variable for default region.

    .EXAMPLE
        PS C:\> awr eu-central-1
        Pre-sort the allowed regions list with the entered keyword.
        If multiple regions matches the keyword, user is prompted to select profile from a list.
        If only a single match is found that region is directly selected without further user prompts.
        Selected region exported to $env:AWS_REGION environment variable

    .INPUTS
        Region
    #>
    [CmdletBinding()]
    [Alias("awr")]

    Param(

        [Parameter(
            Position = 0,
            Mandatory = $false,
            ValueFromPipeline = $True
        )]
        [AllowEmptyString()]
        [string]$Region
    )
    begin {
        if (!$env:AWP_FZF_OPTS)  {
            $AWP_FZF_OPTS = $FZF_SETTINGS.Arguments
        }
        else {
            $AWP_FZF_OPTS = $env:AWP_FZF_OPTS
        } 
    }
    process {
        if ($PSBoundParameters.ContainsKey('Region')) {
            $SelectedRegion = (aws ec2 describe-regions --no-all-regions | ConvertFrom-Json).Regions.RegionName | fzf -q $Region --select-1 --exit-0 $AWP_FZF_OPTS
        }
        else {
            $SelectedRegion = (aws ec2 describe-regions --no-all-regions | ConvertFrom-Json).Regions.RegionName | fzf $AWP_FZF_OPTS
        }
        
        If ($selectedRegion) {

            $env:AWS_REGION = $SelectedRegion
        }
        else {
            Write-Output "No Region found / No Region selected."
        }
    }
}
Export-ModuleMember -Function Set-AWSRegion
#EndRegion - Set-AWSRegion.ps1
#Region - Show-AWSVariables.ps1
function Show-AWSVariables {
    <#
    .SYNOPSIS
        List selected or all AWS profile and session related environment variables.

    .DESCRIPTION
        List selected or all AWS profile and session related environment variables.

    .EXAMPLE
        PS C:\> awl 
        List all environment variables starting with $Env:AWS_

    #>
    [Alias("awl")]

    Param()

    process {
        Get-ChildItem Env:* | Select-Object -Property Name,Value | Where-Object {$_.Name -like "AWS_*"}
    }
}
Export-ModuleMember -Function Show-AWSVariables
#EndRegion - Show-AWSVariables.ps1
### --- PRIVATE FUNCTIONS --- ###
#Region - BaseSettings.ps1
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
#EndRegion - BaseSettings.ps1
#Region - Register-AWSArgumentCompleter.ps1
# Register Argument completer for AWS CLI in PowerShell.
# Based on AWS Recommendations: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-windows

Register-ArgumentCompleter -Native -CommandName aws -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    $env:COMP_LINE = $wordToComplete
    $env:COMP_POINT = $cursorPosition
    aws_completer.exe | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
    Remove-Item Env:\COMP_LINE
    Remove-Item Env:\COMP_POINT
}
#EndRegion - Register-AWSArgumentCompleter.ps1
