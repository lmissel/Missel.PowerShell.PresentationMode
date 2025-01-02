---
external help file: Missel.PowerShell.PresentationMode-help.xml
Module Name: Missel.PowerShell.PresentationMode
online version: 1.0.0.0
schema: 2.0.0
---

# Enable-PresentationMode

## SYNOPSIS

Enables Presentation Mode to prevent the system from entering sleep mode or turning off the display while the script is running.

## SYNTAX

```powershell
Enable-PresentationMode [[-Flags] <ThreadExecutionState>] [[-LogFile] <String>] [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

This function sets the flags ES_CONTINUOUS, ES_DISPLAY_REQUIRED, and ES_SYSTEM_REQUIRED, ensuring the system stays awake and the display remains on.
Presentation Mode remains active until it is explicitly disabled.

## EXAMPLES

### EXAMPLE 1

```powershell
Enable-PresentationMode -LogFile "C:\Logs\PresentationMode.log" -Verbose
```

Starts Presentation Mode, preventing the system from entering sleep mode or turning off the display, and logs the operation.

## PARAMETERS

### -Flags

The thread's execution requirements. This parameter can be one or more of the following values.

```yaml
Type: ThreadExecutionState
Parameter Sets: (All)
Aliases:
Accepted values: None, ES_SYSTEM_REQUIRED, ES_DISPLAY_REQUIRED, ES_AWAYMODE_REQUIRED, ES_CONTINUOUS

Required: False
Position: 1
Default value: ES_SYSTEM_REQUIRED, ES_DISPLAY_REQUIRED, ES_CONTINUOUS
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Force

The Force parameter allows the cmdlet to execute without user confirmation.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
Position: 2
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
- Ensure that the script disables Presentation Mode after completing its tasks.

## RELATED LINKS

[Disable-PresentationMode](Disable-PresentationMode.md)

[Get-PresentationMode](Get-PresentationMode.md)

[Test-LogFilePath](Test-LogFilePath.md)
