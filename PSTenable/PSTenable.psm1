# Dot source public/private functions
$public  = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'public/*.ps1')  -Recurse -ErrorAction Stop)
$private = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'private/*.ps1') -Recurse -ErrorAction Stop)

Set-PSFconfig -Module PSTenable -Name Credential -Value $null -Initialize -Validation credential -Description "The credentials used for authenticating to the Tenable server"
Set-PSFconfig -Module PSTenalbe -Name WebSession -Value $null -Initialize -Description "WebSession for Invoke Rest Method"
Set-PSFconfig -Module PSTenalbe -Name Token -Value $null -Initialize -Validation string -Description "Token used with Tenable"
Set-PSFconfig -Module PSTenalbe -Name Server -Value $null -Initialize -Validation string -Description "REST Tenable endpoint for Tenable Server"

foreach ($import in @($public + $private)) {
    try {
        . $import.FullName
    }
    catch {
        throw "Unable to dot source [$($import.FullName)]"
    }
}

Export-ModuleMember -Function $public.Basename
