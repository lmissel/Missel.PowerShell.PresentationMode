---
Module Name: Missel.PowerShell.PresentationMode
Module Guid: 8515ea70-3c13-4fa9-ad9c-2d3315bf5c8d
Download Help Link: {{ Update Download Link }}
Help Version: 1.0.0.0
Locale: en-US
---

# Missel.PowerShell.PresentationMode Module

## Description

This PowerShell module provides functionality to manage the Presentation Mode on Windows systems. It uses the Windows API `SetThreadExecutionState` to prevent the system from entering sleep mode or turning off the display while the Presentation Mode is enabled.

## Missel.PowerShell.PresentationMode Cmdlets

### [Disable-PresentationMode](Disable-PresentationMode.md)

Disables Presentation Mode, allowing the system to resume sleep mode and turn off the display as per its energy-saving settings.

### [Enable-PresentationMode](Enable-PresentationMode.md)

Enables Presentation Mode to prevent the system from entering sleep mode or turning off the display while the script is running.

### [Get-PresentationMode](Get-PresentationMode.md)

Displays the current status of Presentation Mode.

### [Test-LogFilePath](Test-LogFilePath.md)

Validates a given log file path for correctness and write access.
