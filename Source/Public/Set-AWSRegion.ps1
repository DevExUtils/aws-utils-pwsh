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