$language = "en-US"
$OutputFolder = ("C:\GitHub\Missel.PowerShell.PresentationMode\docs\{0}" -f $language)

Set-Culture -CultureInfo $language

$parameters = @{
    Module = "Missel.PowerShell.PresentationMode"
    OutputFolder = $OutputFolder
    AlphabeticParamsOrder = $true
    WithModulePage = $true
    ExcludeDontShow = $false
    Encoding = [System.Text.Encoding]::UTF8
}
New-MarkdownHelp @parameters