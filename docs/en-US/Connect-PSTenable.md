---
external help file: PSTenable-help.xml
Module Name: PSTenable
online version:
schema: 2.0.0
---

# Connect-PSTenable

## SYNOPSIS
Connects to the Tenable API and sets credentials, token, web session, and Tenable Server using PSFramework.

## SYNTAX

```
Connect-PSTenable [-Credential] <PSCredential> [-TenableServer] <String> [-Register] [<CommonParameters>]
```

## DESCRIPTION
This function provides a way to set the credentials, token, web session, and
tenable server that is used within PSTenable.

## EXAMPLES

### EXAMPLE 1
```
Connect-PSTenable -Credential $Cred -TenableServer "tenable.domain.com/rest" -Register
This prompts for user credentials, and then, using Connect-PSTenable, sets the credentials,
token, web session, and the Tenable Server using PSFramework.
```

## PARAMETERS

### -Credential
PSCredential Object

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TenableServer
Tenable Server Name, tenable.domain.com/rest

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Register
If specified, this will cache the Credential, TenableServer, Token, and Web Session.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
If Connect-PSTenable is not ran with the Register switch, then Connect-PSTenable
must be ran each time since Tenable requires a unique token for each session.

## RELATED LINKS
