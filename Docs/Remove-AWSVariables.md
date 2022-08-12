---
external help file: AWS-Utils-help.xml
Module Name: AWS-Utils
online version:
schema: 2.0.0
---

# Remove-AWSVariables

## SYNOPSIS
Remove selected or all AWS profile and session related environment variables.

## SYNTAX

### All (Default)
```
Remove-AWSVariables [-All] [<CommonParameters>]
```

### Variable
```
Remove-AWSVariables [-Keys] [-Profile] [-Region] [-Role] [<CommonParameters>]
```

## DESCRIPTION
Remove selected or all AWS profile and session related environment variables.
The following variables are removable:
$Env:AWS_PROFILE
$Env:AWS_ACCESS_KEY_ID
$Env:AWS_SECRET_ACCESS_KEY
$Env:AWS_SESSION_TOKEN
$Env:AWS_REGION
$Env:AWS_ROLE_ARN
$Env:AWS_ROLE_SESSION_NAME

## EXAMPLES

### EXAMPLE 1
```
awc -A
Removes all AWS related environment variables.
```

### EXAMPLE 2
```
awc -K
Removes the Env:AWS_ACCESS_KEY_ID, $Env:AWS_SECRET_ACCESS_KEY and $Env:AWS_SESSION_TOKEN environment variables.
```

### EXAMPLE 3
```
awc -P
Removes the $Env:AWS_PROFILE environment variable.
```

### EXAMPLE 4
```
awc -RE
Removes the $Env:AWS_REGION environment variable.
```

### EXAMPLE 5
```
awc -RO
Removes the $Env:AWS_ROLE_ARN and $Env:AWS_ROLE_SESSION_NAME environment variables.
```

### EXAMPLE 6
```
awc -P -K
Removes the $Env:AWS_PROFILE, Env:AWS_ACCESS_KEY_ID, $Env:AWS_SECRET_ACCESS_KEY and $Env:AWS_SESSION_TOKEN environment variables.
```

## PARAMETERS

### -All
Removes all of the following AWS envrionment variables:
$Env:AWS_PROFILE
$Env:AWS_ACCESS_KEY_ID
$Env:AWS_SECRET_ACCESS_KEY
$Env:AWS_SESSION_TOKEN
$Env:AWS_REGION
$Env:AWS_ROLE_ARN
$Env:AWS_ROLE_SESSION_NAME

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases: A

Required: False
Position: 1
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Keys
Removes all of the following AWS envrionment variables:
$Env:AWS_ACCESS_KEY_ID
$Env:AWS_SECRET_ACCESS_KEY
$Env:AWS_SESSION_TOKEN

```yaml
Type: SwitchParameter
Parameter Sets: Variable
Aliases: K

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Profile
Removes all of the following AWS envrionment variables:
$Env:AWS_PROFILE

```yaml
Type: SwitchParameter
Parameter Sets: Variable
Aliases: P

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Region
Removes all of the following AWS envrionment variables:
$Env:AWS_REGION

```yaml
Type: SwitchParameter
Parameter Sets: Variable
Aliases: RE

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Role
Removes all of the following AWS envrionment variables:
$Env:AWS_ROLE_ARN
$Env:AWS_ROLE_SESSION_NAME

```yaml
Type: SwitchParameter
Parameter Sets: Variable
Aliases: RO

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
