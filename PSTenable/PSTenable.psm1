# Dot source public/private functions
$public  = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'public/*.ps1')  -Recurse -ErrorAction Stop)
$private = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'private/*.ps1') -Recurse -ErrorAction Stop)

Set-PSFconfig -Module PSTenable -Name Credential -Value $null -Initialize -Validation Credential -Description 'The credentials used for authenticating to the Tenable server'
Set-PSFconfig -Module PSTenable -Name WebSession -Value $null -Initialize -Description 'The web session stored from Invoke-RestMethod to the Tenable server'
Set-PSFconfig -Module PSTenable -Name Token -Value $null -Initialize -Description 'The token that is retrieved from Connect-PSTenable'
Set-PSFconfig -Module PSTenable -Name Server -Value $null -Initialize -Description 'The Tenable Server FQDN'

foreach ($import in @($public + $private)) {
    try {
        . $import.FullName
    }
    catch {
        throw "Unable to dot source [$($import.FullName)]"
    }
}

Export-ModuleMember -Function $public.Basename
