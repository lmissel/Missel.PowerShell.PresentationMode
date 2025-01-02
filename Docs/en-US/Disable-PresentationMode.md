---
external help file: Missel.PowerShell.PresentationMode-help.xml
Module Name: Missel.PowerShell.PresentationMode
online version: 1.0.0.0
schema: 2.0.0
---

# Disable-PresentationMode

## SYNOPSIS

Disables Presentation Mode, allowing the system to resume sleep mode and turn off the display as per its energy-saving settings.

## SYNTAX

```powershell
Disable-PresentationMode [[-LogFile] <String>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This function sets only the ES_CONTINUOUS flag, which allows the system to return to its normal energy-saving state.

## EXAMPLES

### EXAMPLE 1

```powershell
Disable-PresentationMode -Verbose -LogFile "C:\Logs\PresentationMode.log"
```

Disables Presentation Mode, giving control back to the system's energy-saving settings, and logs the operation.

## PARAMETERS

### -Force

The Force parameter allows the cmdlet to execute without user confirmation.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
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

## OUTPUTS

### ThreadExecutionState

## NOTES

- This function uses the Windows API SetThreadExecutionState.
- Should be called after Enable-PresentationMode to restore the system's original state.

## RELATED LINKS

[Enable-PresentationMode](Enable-PresentationMode.md)

[Get-PresentationMode](Get-PresentationMode.md)

[Test-LogFilePath](Test-LogFilePath.md)
