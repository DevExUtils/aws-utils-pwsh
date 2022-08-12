# AWS CLI Utilities for PowerShell

AWS CLI Utilities for PowerShell is a small set of tools and settings used for making it easier to work with the AWS CLI.

## Requirements

The plugin depends on the following tools, these must already be installed on your system and be available in your $PATH
* [FZF][fzf]
* [AWS CLI v2][AWSCLI]

## Installation

Install through the PowerShell Gallery.
Full system install, requires administrator rights:
```sh
Install-Module -Name AWS-Utils
```
Current user only install:
```sh
Install-Module -Name AWS-Utils -Scope CurrentUser
```

## About

This module contains the following functionality:

### AWS CLI argument autocompleter

The module will register an argument for the AWSCLIv2 so you can tab autocomplete AWS CLI commands.

### Set-AWSProfile (awp)

Function that uses FZF to easily select from your defined AWS profiles and set the selection as the current default for tools using the `$env:AWS_PROFILE` for profile selection.

List all profiles in your .aws/config file for interactive selection.
Selected profile exported to `$env:AWS_PROFILE` environment variable

```sh
awp
```

Pre-sort the profile list with the entered keyword.  
If multiple profiles matches the keyword, user is prompted to select profile from a list.  
If only a single match is found that profile is directly selected without further user prompts.  
Selected profile exported to `$env:AWS_PROFILE` environment variable.

```sh
awp myprofile
```

### Set-AWSRegion (awr)

Function that uses FZF to easily select from available AWS Regions and set the selection as the current default for tools using the `$env:AWS_REGION` environment variable.

List all avaiable regions and interacively select.
Selected region exported to `$env:AWS_REGION` environment variable.

```sh
awr
```

Pre-sort the region list with the entered keyword.  
If multiple regions matches the keyword, user is prompted to select a region from a list.  
If only a single match is found that region is directly selected without further user prompts.  
Selected region exported to `$env:AWS_REGION` environment variable.

```sh
awr eu-central-1
```

### Remove-AWSVariables (awc)

Function that clears selected or all environment variables used for AWS sessions.

Removes all profile and session related AWS environment variables from the current shell environment:
* `$Env:AWS_PROFILE`
* `$Env:AWS_ACCESS_KEY_ID`
* `$Env:AWS_SECRET_ACCESS_KEY`
* `$Env:AWS_SESSION_TOKEN`
* `$Env:AWS_REGION`
* `$Env:AWS_ROLE_ARN`
* `$Env:AWS_ROLE_SESSION_NAME`

```sh
awc -A
```

Remove spesific key types only:
* `-A` : Removes all variables
* `-K` : Removes Access, Secret and Session Token
* `-P` : Removes Profile
* `-RE` : Removes Region
* `-RO` : Removes Role ARN and Role Session Name

```sh
awc -K
awc -P
awc -RE
awc -RO
```

### Show-AWSVariables (awl)

Function that lists all environment variables that start with `$Env:AWS_` to check status for variables.

```sh
awl
```

[fzf]: https://github.com/junegunn/fzf
[AWSCLI]: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
