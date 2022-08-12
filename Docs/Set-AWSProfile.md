---
external help file: AWS-Utils-help.xml
Module Name: AWS-Utils
online version:
schema: 2.0.0
---

# Set-AWSProfile

## SYNOPSIS
Set current shell session AWS Profile via environment variable.

## SYNTAX

```
Set-AWSProfile [[-Profile] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get a list of your configured AWS Profiles through the AWS CLI.
Select a profile from the list using FZF and finally export that profile to the $env:AWS_PROFILE environment variable.
This variable is respected by the AWS CLI, see Configuration settings and precedence in the AWS CLI documentation:
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html

## EXAMPLES

### EXAMPLE 1
```
awp
List all profiles in your .aws/config file for interactive selection.
Selected profile exported to $env:AWS_PROFILE environment variable
```

### EXAMPLE 2
```
awp myprofile
Pre-sort the profile list with the entered keyword.
If multiple profiles matches the keyword, user is prompted to select profile from a list.
If only a single match is found that profile is directly selected without further user prompts.
Selected profile exported to $env:AWS_PROFILE environment variable
```

## PARAMETERS

### -Profile
{{ Fill Profile Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
### ProfileName
## OUTPUTS

## NOTES

## RELATED LINKS
