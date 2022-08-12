---
external help file: AWS-Utils-help.xml
Module Name: AWS-Utils
online version:
schema: 2.0.0
---

# Set-AWSRegion

## SYNOPSIS
Set default region to use for current shell session via environment variable.

## SYNTAX

```
Set-AWSRegion [[-Region] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get a list of allowed AWS Regions for your account through the AWS CLI.
Select a region from the list using FZF and finally export that profile to the $env:AWS_REGION environment variable.

## EXAMPLES

### EXAMPLE 1
```
awr
List all allowed regions in your AWS account for interactive selection.
Selected region is exported to $env:AWS_REGION environment variable for default region.
```

### EXAMPLE 2
```
awr eu-central-1
Pre-sort the allowed regions list with the entered keyword.
If multiple regions matches the keyword, user is prompted to select profile from a list.
If only a single match is found that region is directly selected without further user prompts.
Selected region exported to $env:AWS_REGION environment variable
```

## PARAMETERS

### -Region
{{ Fill Region Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Region
## OUTPUTS

## NOTES

## RELATED LINKS
