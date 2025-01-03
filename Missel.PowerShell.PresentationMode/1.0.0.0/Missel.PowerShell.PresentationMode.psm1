# Import the necessary .NET methods
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class NativeMethods {
    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern uint SetThreadExecutionState(uint esFlags);
}

public interface IThreadExecutionStateManager {
    uint SetExecutionState(uint flags);
}

public class ThreadExecutionStateManager : IThreadExecutionStateManager {
    public uint SetExecutionState(uint flags) {
        return NativeMethods.SetThreadExecutionState(flags);
    }
}

[Flags]
public enum ThreadExecutionState : uint {
    None = 0,
    ES_CONTINUOUS = 0x80000000,
    ES_DISPLAY_REQUIRED = 0x00000002,
    ES_SYSTEM_REQUIRED = 0x00000001,
    ES_AWAYMODE_REQUIRED = 0x00000040
}
"@

# Variable to track the current state
$Script:currentState = $false
$Script:statusDetails = $null

# .ExternalHelp Missel.PowerShell.PresentationMode-help.xml
function Enable-PresentationMode {
    [CmdletBinding(DefaultParameterSetName='Default',
                   SupportsShouldProcess=$true,
                   PositionalBinding=$false,
                   HelpUri='https://github.com/lmissel/Missel.PowerShell.PresentationMode/docs/en-US/Enable-PresentationMode.md',
                   ConfirmImpact='High')]
    [OutputType([ThreadExecutionState])]
    [Alias('Set-ThreadExecutionState')]
    param (

        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0,
                   ParameterSetName='Default')]
        [ThreadExecutionState]$Flags = [ThreadExecutionState]::ES_CONTINUOUS -bor [ThreadExecutionState]::ES_DISPLAY_REQUIRED -bor [ThreadExecutionState]::ES_SYSTEM_REQUIRED,

        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1,
                   ParameterSetName='Default')]
        [string]$LogFile,

        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2,
                   ParameterSetName='Default')]
        [Switch]$Force
    )

    Begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] ParameterSetName: $($PsCmdlet.ParameterSetName)"
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] PSBoundParameters: $($PSBoundParameters | Out-String)"

        if ($LogFile) { Test-LogFilePath -LogFile $LogFile }
    }

    Process {
        if ($Force -or $PSCmdlet.ShouldProcess($env:COMPUTERNAME, "Enabling Presentation Mode.")) {
            try {
                [IThreadExecutionStateManager] $manager = [ThreadExecutionStateManager]::new()
                $result = $manager.SetExecutionState($flags)
                $state = [ThreadExecutionState]$result

                if ($result -eq 0 -or $null -eq $result) {
                    $errorCode = [System.Runtime.InteropServices.Marshal]::GetLastWin32Error()
                    $errorMessage = [System.ComponentModel.Win32Exception]::new($errorCode).Message

                    if ($LogFile) {
                        Add-Content -Path $LogFile -Value "Failed to enable Presentation Mode. Error Code: $errorCode - $errorMessage"
                    }

                    Write-Error "Failed to enable Presentation Mode. Error Code: $errorCode - $errorMessage"
                } else {
                    $Script:currentState = $true
                    Write-Verbose "Presentation Mode enabled. Current State: $state"

                    if ($LogFile) {
                        Add-Content -Path $LogFile -Value "Presentation Mode enabled. Current State: $state"
                    }

                    $Script:statusDetails = [PSCustomObject]@{
                        CurrentState    = $Script:currentState
                        ActiveFlags     = $state
                        LastUpdated     = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
                        TriggeredBy     = $MyInvocation.MyCommand.Name
                    }

                    return $state
                }
            } catch {
                if ($LogFile) {
                    Add-Content -Path $LogFile -Value "An unexpected error occurred: $_"
                }

                Write-Error "An unexpected error occurred: $_"
            }
        }
    }

    End {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function ended"
    }
}

# .ExternalHelp Missel.PowerShell.PresentationMode-help.xml
function Disable-PresentationMode {
    [CmdletBinding(DefaultParameterSetName='Default',
                   SupportsShouldProcess=$true,
                   PositionalBinding=$false,
                   HelpUri='https://github.com/lmissel/Missel.PowerShell.PresentationMode/docs/en-US/Disable-PresentationMode.md',
                   ConfirmImpact='High')]
    [OutputType([ThreadExecutionState])]
    param (
        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0,
                   ParameterSetName='Default')]
        [string]$LogFile,

        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1,
                   ParameterSetName='Default')]
        [Switch]$Force
    )

    Begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] ParameterSetName: $($PsCmdlet.ParameterSetName)"
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] PSBoundParameters: $($PSBoundParameters | Out-String)"

        if ($LogFile) { Test-LogFilePath -LogFile $LogFile }
    }

    Process {
        if ($Force -or $PSCmdlet.ShouldProcess($env:COMPUTERNAME, "Disabling Presentation Mode.")) {
            Write-Verbose "Disabling Presentation Mode..."
            try {
                $flags = [ThreadExecutionState]::ES_CONTINUOUS
                [IThreadExecutionStateManager] $manager = [ThreadExecutionStateManager]::new()
                $result = $manager.SetExecutionState($flags)
                $state = [ThreadExecutionState]$result

                if ($result -eq 0 -or $null -eq $result) {
                    $errorCode = [System.Runtime.InteropServices.Marshal]::GetLastWin32Error()
                    $errorMessage = [System.ComponentModel.Win32Exception]::new($errorCode).Message

                    if ($LogFile) {
                        Add-Content -Path $LogFile -Value "Failed to disable Presentation Mode. Error Code: $errorCode - $errorMessage"
                    }

                    Write-Error "Failed to disable Presentation Mode. Error Code: $errorCode - $errorMessage"
                } else {
                    $Script:currentState = $false
                    Write-Verbose "Presentation Mode disabled. Current State: $state"

                    if ($LogFile) {
                        Add-Content -Path $LogFile -Value "Presentation Mode disabled. Current State: $state"
                    }

                    $Script:statusDetails = [PSCustomObject]@{
                        CurrentState    = $Script:currentState
                        ActiveFlags     = $state
                        LastUpdated     = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
                        TriggeredBy     = $MyInvocation.MyCommand.Name
                    }

                    return $state
                }
            } catch {
                if ($LogFile) {
                    Add-Content -Path $LogFile -Value "An unexpected error occurred: $_"
                }

                Write-Error "An unexpected error occurred: $_"
            }
        }
    }

    End {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function ended"
    }
}

# .ExternalHelp Missel.PowerShell.PresentationMode-help.xml
function Get-PresentationMode {
    [CmdletBinding(DefaultParameterSetName='Default',
                   SupportsShouldProcess=$true,
                   PositionalBinding=$false,
                   HelpUri = 'https://github.com/lmissel/Missel.PowerShell.PresentationMode/docs/en-US/Get-PresentationMode.md',
                   ConfirmImpact='Medium')]
    [OutputType([PSCustomObject])]
    [OutputType([System.Boolean])]
    [Alias('Confirm-PresentationModeState')]
    param (
        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Details')]
        [string]$LogFile,

        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Details')]
        [Switch]$Details
    )

    Begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] ParameterSetName: $($PsCmdlet.ParameterSetName)"
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] PSBoundParameters: $($PSBoundParameters | Out-String)"

        if ($LogFile) { Test-LogFilePath -LogFile $LogFile }
    }

    Process {
        if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, "Retrieve current Presentation Mode state.")) {

            Write-Verbose "Presentation Mode State: $($Script:statusDetails | Out-String)"

            if ($LogFile) {
                Add-Content -Path $LogFile -Value ($Script:statusDetails | Out-String)
            }

            if ($PsCmdlet.ParameterSetName -eq 'Default')
            {
                return $Script:currentState
            }

            if ($PsCmdlet.ParameterSetName -eq 'Details')
            {
                if ($null -eq $Script:statusDetails)
                {
                    $Script:statusDetails = [PSCustomObject]@{
                        CurrentState    = $Script:currentState
                        ActiveFlags     = [ThreadExecutionState]::None
                        LastUpdated     = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
                        TriggeredBy     = $MyInvocation.MyCommand.Name
                    }
                }

                return $Script:statusDetails
            }
        }
    }

    End {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function ended"
    }
}

# .ExternalHelp Missel.PowerShell.PresentationMode-help.xml
function Test-LogFilePath {
    [CmdletBinding(DefaultParameterSetName='Default',
                   SupportsShouldProcess=$true,
                   PositionalBinding=$false,
                   HelpUri = 'https://github.com/lmissel/Missel.PowerShell.PresentationMode/docs/en-US/Test-LogFilePath.md',
                   ConfirmImpact='Medium')]
    [OutputType([System.Boolean])]
    param (
        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Details')]
        [string]$LogFile
    )

    Begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] ParameterSetName: $($PsCmdlet.ParameterSetName)"
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] PSBoundParameters: $($PSBoundParameters | Out-String)"
    }

    Process {
        if ($PSCmdlet.ShouldProcess($LogFile, "Validate log file path.")) {
            try {
                # Check if path is fully qualified
                if (-not [System.IO.Path]::IsPathRooted($LogFile)) {
                    throw "The provided LogFile path is not fully qualified: '$LogFile'."
                }

                # Get directory of the log file
                $logDirectory = [System.IO.Path]::GetDirectoryName($LogFile)

                # Create directory if it does not exist
                if (-not (Test-Path -Path $logDirectory -PathType Container)) {
                    New-Item -ItemType Directory -Path $logDirectory -Force | Out-Null
                    Write-Verbose "Created log directory: $logDirectory"
                }

                # Test write access by creating and removing a test file
                $testFile = [System.IO.Path]::Combine($logDirectory, "test.log")
                New-Item -ItemType File -Path $testFile -Force | Out-Null
                Remove-Item -Path $testFile -Force | Out-Null
                Write-Verbose "Log file path is valid and writable: $LogFile"

                return $true
            } catch {
                Write-Error "LogFile validation failed: $_"
                throw
            }
        }
    }

    End {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function ended"
    }
}