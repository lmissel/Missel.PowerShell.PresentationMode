# Missel.PowerShell.PresentationMode.Examples

This are some examples demonstrating the use of the **Missel.PowerShell.PresentationMode** module, incorporating complex scenarios and workflows.

## **Example 1: Enable Presentation Mode for a Scheduled Task**

Enable Presentation Mode to ensure the system remains active during a long-running task, such as database backup. Log the state before and after the task.

```powershell
# Define the log file
$logFile = "C:\Logs\ScheduledTask.log"

# Enable Presentation Mode
Enable-PresentationMode -LogFile $logFile -Verbose

# Simulate a long-running task
Write-Verbose "Starting database backup..." -Verbose
Start-Sleep -Seconds 300
Write-Verbose "Database backup completed." -Verbose

# Disable Presentation Mode
Disable-PresentationMode -LogFile $logFile -Verbose

# Verify the system state
Get-PresentationMode -Details | Out-File -FilePath $logFile -Append
```

**Expected Outcome:**

- Presentation Mode is enabled and logged.
- The task runs uninterrupted.
- Presentation Mode is disabled, and the state is logged.

## **Example 2: Bulk Processing with Presentation Mode**

Process a batch of files while keeping the system awake. Log each file's processing status.

```powershell
# Define the file batch and log file
$files = Get-ChildItem -Path "C:\Data\ToProcess" -File
$logFile = "C:\Logs\BatchProcessing.log"

# Enable Presentation Mode
Enable-PresentationMode -LogFile $logFile -Verbose

foreach ($file in $files) {
    try {
        Write-Verbose "Processing file: $($file.FullName)" -Verbose
        # Simulate file processing
        Start-Sleep -Seconds 10
        Add-Content -Path $logFile -Value "Successfully processed: $($file.FullName)"
    } catch {
        Add-Content -Path $logFile -Value "Failed to process: $($file.FullName). Error: $_"
    }
}

# Disable Presentation Mode
Disable-PresentationMode -LogFile $logFile -Verbose
```

**Expected Outcome:**

- Presentation Mode remains active throughout the batch processing.
- Each file's status is logged (success or failure).

## **Example 3: Verify and Enforce Presentation Mode State**

Ensure Presentation Mode is enabled before running a critical task. If not, log an error and exit.

```powershell
# Enable Presentation Mode
Enable-PresentationMode -LogFile $logFile -Verbose

# Verify Presentation Mode state
if (-not (Get-PresentationMode)) {
    $message = "Presentation Mode is not enabled. Critical task cannot proceed."
    Write-Error $message
    Add-Content -Path "C:\Logs\CriticalTask.log" -Value $message
    exit
}

# Run the critical task
try {
    Write-Verbose "Starting critical task..." -Verbose
    Start-Sleep -Seconds 120
    Write-Verbose "Critical task completed successfully." -Verbose
    Add-Content -Path "C:\Logs\CriticalTask.log" -Value "Task completed successfully."
} catch {
    Add-Content -Path "C:\Logs\CriticalTask.log" -Value "Critical task failed. Error: $_"
}

# Disable Presentation Mode
Disable-PresentationMode -LogFile $logFile -Verbose
```

**Expected Outcome:**

- The script verifies Presentation Mode is enabled before proceeding.
- If not enabled, an error is logged, and the task is not executed.
