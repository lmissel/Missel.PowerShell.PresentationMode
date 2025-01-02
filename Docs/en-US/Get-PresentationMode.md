---
external help file: Missel.PowerShell.PresentationMode-help.xml
Module Name: Missel.PowerShell.PresentationMode
online version: 1.0.0.0
schema: 2.0.0
---

# Get-PresentationMode

## SYNOPSIS

Displays the current status of Presentation Mode.

## SYNTAX

### Default (Default)

```powershell
Get-PresentationMode [[-LogFile] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Details

```powershell
Get-PresentationMode [[-LogFile] <String>] [-Details] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This function returns the current status of Presentation Mode.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-PresentationMode
```

## PARAMETERS

### -Details

Details on the current status of the PresentationMode.

```yaml
Type: SwitchParameter
Parameter Sets: Details
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -LogFile

The full path to the log file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Management.Automation.PSObject

### System.Boolean

## NOTES

- This function only checks the internal status variable and does not call any Windows API.
- Useful for validating the current mode.

## RELATED LINKS

[Disable-PresentationMode](Disable-PresentationMode.md)

[Enable-PresentationMode](Enable-PresentationMode.md)

[Test-LogFilePath](Test-LogFilePath.md)
