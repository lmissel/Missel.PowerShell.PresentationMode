# Import the PresentationMode module
Import-Module Missel.PowerShell.PresentationMode

# Enable Presentation Mode to prevent the system from sleeping
Enable-PresentationMode -Force

# Define the interval for checking inactivity (in seconds)
$CheckInterval = 10

# Store the last cursor position
$LastCursorPosition = [System.Windows.Forms.Cursor]::Position

# Function to move the mouse
function Move-Mouse {
    param (
        [int]$Offset = 10
    )
    $CurrentPosition = [System.Windows.Forms.Cursor]::Position
    $NewPosition = @{
        X = $CurrentPosition.X + $Offset
        Y = $CurrentPosition.Y + $Offset
    }

    # Move the cursor to a new position
    [System.Windows.Forms.Cursor]::Position = [System.Drawing.Point]::new($NewPosition.X, $NewPosition.Y)
    Start-Sleep -Seconds 1

    # Return the cursor to the original position
    [System.Windows.Forms.Cursor]::Position = $CurrentPosition
}

# Start the loop to simulate activity
try {
    while ($true) {
        Start-Sleep -Seconds $CheckInterval

        # Check the current cursor position
        $CurrentCursorPosition = [System.Windows.Forms.Cursor]::Position

        if ($CurrentCursorPosition -eq $LastCursorPosition) {
            Write-Host "Mouse has not moved. Moving mouse now."
            Move-Mouse
        } else {
            Write-Host "Mouse has moved. Restarting check."
        }

        # Update the last cursor position
        $LastCursorPosition = $CurrentCursorPosition
    }
} finally {
    # Ensure Presentation Mode is disabled when the script exits
    Disable-PresentationMode -Force
    Write-Host "Presentation Mode disabled. Exiting simulation."
}