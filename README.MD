# Missel.PowerShell.PresentationMode

This PowerShell module provides functionality to manage the Presentation Mode on Windows systems. It uses the Windows API `SetThreadExecutionState` to prevent the system from entering sleep mode or turning off the display while the Presentation Mode is enabled.

## Description

A windows system automatically detects activities such as local keyboard or mouse input, server activity, and changing window focus. Activities that are not automatically detected include disk, network or CPU activity and video display.

To ensure proper functionality when using PowerShell scripts on a power-managed computer, scripts that perform tasks such as monitoring, backups, or network management must use both `ES_SYSTEM_REQUIRED` and `ES_CONTINUOUS` to prevent the system from entering sleep mode during long-running operations. PowerShell scripts that handle multimedia tasks, such as playing videos or displaying presentations for extended periods, should use `ES_DISPLAY_REQUIRED` to keep the display active. Scripts that involve user interaction, such as administrative tools or data entry tasks, typically do not need to call `SetThreadExecutionState` unless extended idle periods are expected.

This PowerShell module makes it possible to inform the system that it is in use and to prevent the system from going into standby mode or disabling the display while the script is running.

## Features

- **Enable Presentation Mode**: Prevents the system from entering sleep mode or turning off the display.
- **Disable Presentation Mode**: Restores the system's default power-saving behavior.
- **Get Presentation Mode**: Displays whether the Presentation Mode is currently enabled or disabled.

## Energy Efficiency Recommendations

The use of the `Missel.PowerShell.PresentationMode` module  temporarily overrides the system's energy management, which can lead to increased energy consumption under certain circumstances. The use of flags such as `ES_DISPLAY_REQUIRED` or `ES_SYSTEM_REQUIRED` can lead to the following:

- The screen remains permanently switched on.
- The computer does not switch to energy-saving mode.

This can lead to noticeably higher power consumption when activated for longer periods, especially on battery-powered devices such as laptops.

## Minimum Requirements

The module requires a Windows System and PowerShell. The following versions are supported:

|Product|Version|
|---|---|
|PowerShell|5.1 or higher|
|Windows System|XP or higher|

## Installation

To install and run this module, copy the folder with the name `Missel.PowerShell.PresentationMode` in one of the appropriate PowerShell paths and use `Import-Module -Name Missel.PowerShell.PresentationMode`.

The paths where you can install this module are in the `$env:PSModulePath` global variable. For example, a common path to store a module on a system would be `%SystemRoot%/users/<user>/Documents/PowerShell/Modules/<moduleName>`. Be sure to create a directory for this module that uses the same name `Missel.PowerShell.PresentationMode` as the script module. If you did not save this module in one of these paths, you must specify the location of the module in the Import-Module command. Otherwise, PowerShell would not be able to find the module.

Starting with PowerShell, if you've placed this module in one of the PowerShell module paths, you don't need to explicitly import it. This module is automatically loaded when a user calls a function of the module. For more information about the module path, see [Importing a PowerShell Module](https://docs.microsoft.com/en-us/powershell/scripting/developer/module/importing-a-powershell-module?view=powershell-7.1) and [Modifying the PSModulePath Installation Path](https://docs.microsoft.com/en-us/powershell/scripting/developer/module/modifying-the-psmodulepath-installation-path?view=powershell-7.1).

To remove this module from active service in the current PowerShell session, use `Remove-Module -name Missel.PowerShell.PresentationMode`.

> [!Note]
> `Remove-Module` removes a module from the current PowerShell session, but doesn't uninstall the module or delete the module's files.

## Usage

This example shows and explains how the module can be used.

### Importing the Module

Import the module `Missel.PowerShell.PresentationMode` in your PowerShell session:

```powershell
Import-Module Missel.PowerShell.PresentationMode
```

### Cmdlet Descriptions

#### Enable-PresentationMode

Activates Presentation Mode to keep the system awake and the display on.

**Syntax:**

```powershell
Enable-PresentationMode [[-Flags] <ThreadExecutionState>] [[-LogFile] <String>] [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

**Example:**

```powershell
Enable-PresentationMode -Force
```

**Output:**

```Output
ES_CONTINUOUS
```

Activates Presentation Mode to keep the display on.

**Example:**

```powershell
Enable-PresentationMode -Flags ES_CONTINUOUS, ES_DISPLAY_REQUIRED -Force
```

**Output:**

```Output
ES_CONTINUOUS
```

>[!Important]
>Ensure `Disable-PresentationMode` is called after enabling it to avoid unintended consequences.

#### Disable-PresentationMode

Deactivates Presentation Mode, allowing the system to revert to its default power-saving behavior.

**Syntax:**

```powershell
Disable-PresentationMode [[-LogFile] <String>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

**Example:**

```powershell
Disable-PresentationMode -Force
```

**Output:**

```Output
ES_SYSTEM_REQUIRED, ES_DISPLAY_REQUIRED, ES_CONTINUOUS
```

#### Get-PresentationMode

Displays the current state of Presentation Mode.

**Syntax:**

```powershell
Get-PresentationMode [[-LogFile] <String>] [-Details] [-WhatIf] [-Confirm] [<CommonParameters>]
```

**Example:**

```powershell
Get-PresentationMode
```

**Output:**

```Output
False
```

## Verifying the Status

To check the current state of power requests and the impact of the Presentation Mode, you can run the following command:

```powershell
powercfg /requests
```

**Example Output:**

```output
DISPLAY:
[PROCESS] \Device\HarddiskVolume3\Windows\System32\powershell.exe
```

This command lists all active power requests that may prevent the system from entering sleep mode or turning off the display. If `Missel.PowerShell.PresentationMode` is active, an entry for the PowerShell process should appear.

### Recommendation

- Use this command to verify that enabling Presentation Mode is working as expected.
- After disabling Presentation Mode, there should no longer be any entries generated by the module. This helps identify potential issues or unexpected behavior.

## Technical Details

### `SetThreadExecutionState` API

This module relies on the Windows API function `SetThreadExecutionState`, which modifies the state of the system thread to control its power-saving behavior.

#### Relevant ThreadExecutionStates

| ThreadExecutionState | Description                                              |
|----------------------|----------------------------------------------------------|
| `ES_CONTINUOUS`      | Maintains the power-saving behavior until explicitly reset. |
| `ES_DISPLAY_REQUIRED`| Keeps the display turned on.                              |
| `ES_SYSTEM_REQUIRED` | Prevents the system from entering sleep mode.            |

#### Function Signature

```c
DWORD SetThreadExecutionState(
    EXECUTION_STATE esFlags
);
```

**Parameters:**

- `esFlags`: A combination of flags that specify the desired behavior. Commonly used flags include:
  - `ES_CONTINUOUS`: Ensures the setting persists until reset.
  - `ES_DISPLAY_REQUIRED`: Prevents the display from powering off.
  - `ES_SYSTEM_REQUIRED`: Prevents the system from sleeping.

**Return Value:**

- If the function succeeds, it returns the previous thread execution state.
- If it fails, it returns `0` or `NULL`. Use `GetLastError` to retrieve additional error information.

**Important Notes:**

- Misuse of this function can prevent the system from entering energy-saving states, which may impact power consumption.
- Always reset the state using `ES_CONTINUOUS` when Presentation Mode is no longer needed.

## Recommendations

- **Logging**: Use the `-LogFile` parameter to maintain a record  of actions and errors.
- **Error Handling**: Always verify the return value of `SetThreadExecutionState` to handle errors effectively.

## Changelog

|Version|State|Comment|
|---|---|---|
|1.0.0.0|done|Initial module|

## See also

For more details, visit the [official Win32 Api documentation](https://learn.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-setthreadexecutionstate).
