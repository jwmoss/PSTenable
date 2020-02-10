---
external help file: PSTenable-help.xml
Module Name: PSTenable
online version:
schema: 2.0.0
---

# Get-PSTenableCVE

## SYNOPSIS
Retrieves all devices in Tenable affected by the CVE passthrough to the user.

## SYNTAX

```
Get-PSTenableCVE [-CVE] <String[]> [-Tool <String>] [<CommonParameters>]
```

## DESCRIPTION
This function provides a way to retrieve all devices affected by a CVE that is passed to the function.

## EXAMPLES

### EXAMPLE 1
```
@("CVE-2019-0708","CVE-2019-13046") | Get-PSTenableCVE
This passes an array of CVE's to the fucntion and returns and all devices affected by the CVEs.
```

PS C:\\\> Get-PSTenableCVE -CVE "CVE-2019-0708"
This returns all devices affected by CVE-2019-0708

## PARAMETERS

### -CVE
CVE Number, such as CVE-2019-0708

```yaml
Type: String[]
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### None
## NOTES
Remember you can pass one or multiple CVE's in an array.

## RELATED LINKS
