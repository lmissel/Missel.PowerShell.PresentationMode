# Example: HttpListener with Presentation Mode

This example combines the `Missel.PowerShell.PresentationMode` module with an HttpListener. The goal is to create a simple web server that processes incoming HTTP requests and activates presentation mode while the server is running. As soon as the server is terminated, presentation mode is deactivated.

```powershell
# Define log file for Presentation Mode and HttpListener
$logFile = "C:\Logs\HttpListenerWithPresentationMode.log"

# Function to start an HttpListener
function Start-HttpServer {
    param (
        [int]$Port = 8080
    )

    # Enable Presentation Mode to keep the system active
    Enable-PresentationMode -LogFile $logFile -Verbose

    # Create an HttpListener
    $listener = New-Object System.Net.HttpListener
    $listener.Prefixes.Add("http://+:$Port/")
    $listener.Start()

    Write-Output "HTTP Server is running on port $Port. Press Ctrl+C to stop."

    try {
        while ($listener.IsListening) {
            # Begin listening for incoming requests
            $context = $listener.GetContext()
            $request = $context.Request
            $response = $context.Response

            # Log the incoming request
            Add-Content -Path $logFile -Value "Received request: $($request.HttpMethod) $($request.Url.AbsolutePath) at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

            # Generate a response
            $responseContent = "Hello! The server time is $(Get-Date -Format 'HH:mm:ss')."
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($responseContent)

            $response.ContentLength64 = $buffer.Length
            $response.OutputStream.Write($buffer, 0, $buffer.Length)
            $response.OutputStream.Close()

            # Log the response
            Add-Content -Path $logFile -Value "Responded to request: $responseContent"
        }
    } catch {
        Write-Error "An error occurred: $_"
        Add-Content -Path $logFile -Value "Error: $_"
    } finally {
        # Stop the listener
        $listener.Stop()
        $listener.Close()
        Write-Output "HTTP Server stopped."

        # Disable Presentation Mode
        Disable-PresentationMode -LogFile $logFile -Verbose
    }
}

# Start the HTTP server
Start-HttpServer -Port 8080
```

## **Explanation of the Script**

1. **Enable Presentation Mode**:
   - The `Enable-PresentationMode` command ensures that the system does not enter sleep mode while the server is running.
   - All changes are logged in a log file.

2. **Creating an HttpListener**:
   - An `HttpListener` is started, listening on port 8080.
   - The listener processes incoming requests and responds with the current server time.

3. **Logging Requests and Responses**:
   - All incoming HTTP requests and their corresponding responses are logged to a file.

4. **Error Handling**:
   - In case of an error, the script logs the issue and writes an entry to the log file.

5. **Disable Presentation Mode**:
   - When the listener is stopped (e.g., due to an error or exiting the script), the `Disable-PresentationMode` command is executed to revert the system to its normal power-saving state.

## **Example Output**

- **Console Output**:

  ```plaintext
  HTTP Server is running on port 8080. Press Ctrl+C to stop.
  ```

- **Log File** (`C:\Logs\HttpListenerWithPresentationMode.log`):

  ```plaintext
  2025-01-02 15:00:00 - Presentation Mode enabled.
  Received request: GET / at 2025-01-02 15:01:10
  Responded to request: Hello! The server time is 15:01:10.
  2025-01-02 15:02:00 - Presentation Mode disabled.
  ```

---

### **Use Cases**

- **Monitoring Systems**: Use the `HttpListener` to provide RESTful APIs while ensuring the system stays active.
- **Demonstrations**: Ideal for running a local web server during presentations or workshops.
- **Long-Running Tasks**: Keep the server and system resources active during critical operations.
