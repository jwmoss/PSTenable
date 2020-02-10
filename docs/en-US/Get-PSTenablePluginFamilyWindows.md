---
external help file: PSTenable-help.xml
Module Name: PSTenable
online version:
schema: 2.0.0
---

# Get-PSTenablePluginFamilyWindows

## SYNOPSIS
Retrieves all vulnerabilities related to the "Windows" patch family.

## SYNTAX

```
Get-PSTenablePluginFamilyWindows [[-Tool] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function provides a way to retrieve all devices affected by the following Patch Families:
1.
Windows
2.
Windows : Microsoft Bulletins
3.
Windows : User management

## EXAMPLES

### EXAMPLE 1
```
Get-PSTenablePluginFamilyWindows
Retrieves all vulnerabilities related to the windows patch families.
```

## PARAMETERS

### -Tool
The vulnerability tool to chose.
Defaults to vulnipdetails.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Vulnipdetails
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### None
## NOTES
None

## RELATED LINKS
