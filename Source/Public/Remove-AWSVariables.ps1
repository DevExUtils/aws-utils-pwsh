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