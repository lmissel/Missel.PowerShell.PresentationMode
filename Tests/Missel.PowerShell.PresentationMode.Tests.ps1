param(
$version = "1.0.0.0",
$moduleName = "Missel.PowerShell.PresentationMode",
$StartWith = "C:\GitHub\"
)

$Repository = "$StartWith\$moduleName"
$moduleFolder = "$Repository\$moduleName"
$moduleManifestPath = "$moduleFolder\$version\$moduleName.psd1"
$manifest = Import-PowerShellDataFile -Path $moduleManifestPath -ErrorAction Ignore

Describe "Testing module" {
    
    it "must have a module manifest with the same as the module" {
        $moduleManifestPath | should -Exist
    }

    it "must have the description manifest key populated" {
        $manifest.Description | should -Not -BeNullOrEmpty
    }

    it "must have the Autor manifest key populated" {
        $manifest.Author | should -Not -BeNullOrEmpty
    }

    it "must pass Test-ModuleManifest validation" {
        Test-ModuleManifest -Path $moduleManifestPath | Should -Be $true
    }

    it "muss pass PSScriptAnalyzer rules" {
        Invoke-ScriptAnalyzer -Path "$moduleFolder\$version\$moduleName.psm1" -ExcludeRule PSUseDeclaredVarsMoreThanAssignments | should -BeNullOrEmpty
    }
}