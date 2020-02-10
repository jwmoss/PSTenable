---
external help file: PSTenable-help.xml
Module Name: PSTenable
online version:
schema: 2.0.0
---

# Get-PSTenableSeverity

## SYNOPSIS
Retrieves all vulnerabilities that are Critical, High, Medium, or Low in Tenable.

## SYNTAX

```
Get-PSTenableSeverity [[-Severity] <String[]>] [[-MaxRecords] <Int32>] [-Detailed] [<CommonParameters>]
```

## DESCRIPTION
This function provides a way to retrieve all vulnerabilities in Tenable that are Critical, High,
Medium, or Low.
Revision 0.1, Sept 2019, jwmoss
Revision 0.2, Nov 2019, aarong1234

## EXAMPLES

### EXAMPLE 1
```
Get-PSTenableSeverity -Severity "Critical"
Retrieves all critical vulnerabilities, Summary Data [sorted by vprscore (note:Very OLD plugins dont have a VPR Scores)]
```

### EXAMPLE 2
```
Get-PSTenableSeverity -Detailed
Retrieves all critical and high vulnerabilities, Detailed Data (return Tenable.sc Vulnerability Detail data instead of summary) [sorted by vprscore (note:Very OLD plugins dont have a VPR Scores)]
```

### EXAMPLE 3
```
Get-PSTenableSeverity -Severity "High","Medium" -Maxrecords 200
Retrieves high and medium vulnerabilities, up to 200 records, Summary Data [sorted by vprscore (note:Very OLD plugins dont have a VPR Scores)]
```

### EXAMPLE 4
```
Get-PSTenableSeverity -Severity "All" -Detailed
Retrieves all non-info vulnerabilities, Detailed data [sorted by vprscore (note:Very OLD plugins dont have a VPR Scores)]
```

## PARAMETERS

### -Severity
Option for any of "Critical", "High", "Medium", "Low", "All", "All with Info".
Defaults to "Critical","High". 
All with Info will get ALL vuln data

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxRecords
Option for maximum records (rows of data) that should be requested (as a throttle), Default is 0 (all records) \[note: sorted by score, descending\]

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Detailed
Option to enable detailed data.
Defaults to Summary Data.
To determine how detailed the resulting data is by querying Tenable.sc "Vulnerability Summary" versus "Vulnerability Detail"

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

### PSCustomObject
## NOTES
None

## RELATED LINKS
