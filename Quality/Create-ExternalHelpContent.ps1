$version = "1.0.0.0"
$language = "en-US"

Set-Culture -CultureInfo $language

$MarkdownFolder = ("C:\GitHub\Missel.PowerShell.PresentationMode\docs\{0}" -f $language)
$OutputPath = ("C:\GitHub\Missel.PowerShell.PresentationMode\Missel.PowerShell.PresentationMode\{0}\{1}" -f $version, $language)

New-ExternalHelp -Path $MarkdownFolder -OutputPath $OutputPath

#Get-HelpPreview -Path $OutputPath