# Activity Simulation with Presentation Mode

This script, **Activity Simulation with Presentation Mode**, prevents the system from entering sleep mode by simulating user activity through periodic mouse movement. It integrates with the **Missel.PowerShell.PresentationMode** module to keep the system awake.

## Features

- **Simulates Mouse Movement**: Periodically moves the mouse cursor to prevent the system from detecting inactivity.
- **Enables Presentation Mode**: Prevents the system from sleeping or turning off the display during script execution.
- **Monitors Cursor Activity**: Tracks actual mouse movement to avoid unnecessary simulation.
- **Automatic Cleanup**: Ensures Presentation Mode is disabled when the script exits.

## Prerequisites

1. **PowerShell Version**: 5.1 or higher.
2. **Required Module**: `Missel.PowerShell.PresentationMode`.
   - Ensure the module is installed and available in your `$env:PSModulePath`.

3. **.NET Assemblies**:
   - The script relies on the `System.Windows.Forms` and `System.Drawing` namespaces for cursor manipulation.

## Installation

1. Clone or download this repository.
2. Place the script file `Start-ActivitySimulation.ps1` in your desired directory.

## Usage

Run the script using the following steps:

### 1. Open PowerShell

Launch PowerShell with sufficient permissions to execute scripts.

### 2. Import the Module

Ensure the module is imported:

```powershell
Import-Module Missel.PowerShell.PresentationMode
```

### 3. Run the Script

Execute the script:

```powershell
.\Start-ActivitySimulation.ps1
```

### 4. Stop the Script

Press `Ctrl+C` or close the PowerShell session to terminate the script.

## Script Workflow

1. **Enable Presentation Mode**:
   - Keeps the system awake using the `Enable-PresentationMode` cmdlet.

2. **Monitor Cursor Movement**:
   - Tracks the mouse cursor position every 10 seconds (default interval).
   - If no movement is detected, it simulates mouse activity using the `Move-Mouse` function.

3. **Disable Presentation Mode**:
   - Ensures the system reverts to its normal power-saving settings when the script stops.

## Example Output

When the cursor hasn’t moved:

```plaintext
Mouse has not moved. Moving mouse now.
```

When the cursor has moved:

```plaintext
Mouse has moved. Restarting check.
```

## Configuration

### Interval Adjustment

To change the interval for checking inactivity, modify the `$CheckInterval` variable:

```powershell
$CheckInterval = 15  # Checks every 15 seconds
```

### Log File

By default, no log file is generated. To add logging, integrate `Add-Content` to record actions in a file.
