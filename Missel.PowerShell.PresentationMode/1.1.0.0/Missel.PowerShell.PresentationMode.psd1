#
# Modulmanifest für das Modul "Missel.PowerShell.PresentationMode"
#
# Generiert von: lmissel
#
# Generiert am: 01/01/2025
#

@{

    # Die diesem Manifest zugeordnete Skript- oder Binärmoduldatei.
    RootModule = 'Missel.PowerShell.PresentationMode.psm1'
    
    # Die Versionsnummer dieses Moduls
    ModuleVersion = '1.1.0.0'
    
    # Unterstützte PSEditions
    # CompatiblePSEditions = @()
    
    # ID zur eindeutigen Kennzeichnung dieses Moduls
    GUID = '8515ea70-3c13-4fa9-ad9c-2d3315bf5c8d'
    
    # Autor dieses Moduls
    Author = 'lmissel'
    
    # Unternehmen oder Hersteller dieses Moduls
    # CompanyName = 'Unbekannt'
    
    # Urheberrechtserklärung für dieses Modul
    # Copyright = ''
    
    # Beschreibung der von diesem Modul bereitgestellten Funktionen
    Description = 'This PowerShell module provides functionality to manage the Presentation Mode on Windows systems. It uses the Windows API `SetThreadExecutionState` to prevent the system from entering sleep mode or turning off the display while the Presentation Mode is enabled.'
    
    # Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Moduls
    # PowerShellVersion = ''
    
    # Der Name des für dieses Modul erforderlichen Windows PowerShell-Hosts
    # PowerShellHostName = ''
    
    # Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Hosts
    # PowerShellHostVersion = ''
    
    # Die für dieses Modul mindestens erforderliche Microsoft .NET Framework-Version. Diese erforderliche Komponente ist nur für die PowerShell Desktop-Edition gültig.
    # DotNetFrameworkVersion = ''
    
    # Die für dieses Modul mindestens erforderliche Version der CLR (Common Language Runtime). Diese erforderliche Komponente ist nur für die PowerShell Desktop-Edition gültig.
    # CLRVersion = ''
    
    # Die für dieses Modul erforderliche Prozessorarchitektur ("Keine", "X86", "Amd64").
    # ProcessorArchitecture = ''
    
    # Die Module, die vor dem Importieren dieses Moduls in die globale Umgebung geladen werden müssen
    # RequiredModules = @()
    
    # Die Assemblys, die vor dem Importieren dieses Moduls geladen werden müssen
    # RequiredAssemblies = @()
    
    # Die Skriptdateien (PS1-Dateien), die vor dem Importieren dieses Moduls in der Umgebung des Aufrufers ausgeführt werden.
    # ScriptsToProcess = @()
    
    # Die Typdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
    # TypesToProcess = @()
    
    # Die Formatdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
    # FormatsToProcess = @()
    
    # Die Module, die als geschachtelte Module des in "RootModule/ModuleToProcess" angegebenen Moduls importiert werden sollen.
    # NestedModules = @()
    
    # Aus diesem Modul zu exportierende Funktionen
    FunctionsToExport = '*'
    
    # Aus diesem Modul zu exportierende Cmdlets
    CmdletsToExport = '*'
    
    # Die aus diesem Modul zu exportierenden Variablen
    VariablesToExport = '*'
    
    # Aus diesem Modul zu exportierende Aliase
    AliasesToExport = '*'
    
    # Aus diesem Modul zu exportierende DSC-Ressourcen
    # DscResourcesToExport = @()
    
    # Liste aller Module in diesem Modulpaket
    # ModuleList = @()
    
    # Liste aller Dateien in diesem Modulpaket
    # FileList = @()
    
    # Die privaten Daten, die an das in "RootModule/ModuleToProcess" angegebene Modul übergeben werden sollen. Diese können auch eine PSData-Hashtabelle mit zusätzlichen von PowerShell verwendeten Modulmetadaten enthalten.
    PrivateData = @{
    
        PSData = @{
    
            # 'Tags' wurde auf das Modul angewendet und unterstützt die Modulermittlung in Onlinekatalogen.
            # Tags = @()
    
            # Eine URL zur Lizenz für dieses Modul.
            # LicenseUri = ''
    
            # Eine URL zur Hauptwebsite für dieses Projekt.
            # ProjectUri = ''
    
            # Eine URL zu einem Symbol, das das Modul darstellt.
            # IconUri = ''
    
            # 'ReleaseNotes' des Moduls
            # ReleaseNotes = ''
    
        } # Ende der PSData-Hashtabelle
    
    } # Ende der PrivateData-Hashtabelle
    
    # HelpInfo-URI dieses Moduls
    HelpInfoURI = 'https://github.com/lmissel/Missel.PowerShell.PresentationMode/'
    
    # Standardpräfix für Befehle, die aus diesem Modul exportiert werden. Das Standardpräfix kann mit "Import-Module -Prefix" überschrieben werden.
    # DefaultCommandPrefix = ''
}