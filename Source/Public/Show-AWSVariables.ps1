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