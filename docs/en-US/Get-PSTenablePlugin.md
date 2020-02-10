---
external help file: PSTenable-help.xml
Module Name: PSTenable
online version:
schema: 2.0.0
---

# Get-PSTenablePlugin

## SYNOPSIS
Retrieves all devices that are affected by PluginID.

## SYNTAX

```
Get-PSTenablePlugin [-ID] <String> [-Tool <String>] [-PluginOutput] [<CommonParameters>]
```

## DESCRIPTION
This function provides a way to retrieve all devices affected by a specific PluginID that is passed to the function.

## EXAMPLES

### EXAMPLE 1
```
Get-PSTenablePlugin -ID "20007"
This passes PluginID 20007 CVE's to the function and returns and all devices affected by the PluginID 20007.
```

PS C:\\\> Get-PSTenablePlugin -ID "20007" -PluginOutput
This passes PluginID 20007 CVE's to the function and returns and all devices affected by the PluginID 20007, along with the plugin output.

PS C:\\\> @("20007","31705")  Get-PSTenablePlugin
This passes PluginID 20007 CVE's to the function and returns and all devices affected by the PluginID 20007.

## PARAMETERS

### -ID
PluginID from Tenable

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Tool
The vulnerability tool to chose.
Defaults to vulnipdetails.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Vulnipdetails
Accept pipeline input: False
Accept wildcard characters: False
```

### -PluginOutput
Switch that changes output type to include plugin output

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
You can pass one or multiple PluginID's in an array.

## RELATED LINKS
