Function Invoke-PSTenableTokenRenewal {
    <#
    .SYNOPSIS
        Function that returns another token upon session expiration.
    .DESCRIPTION
        Function that returns another token upon session expiration.
    .EXAMPLE
        PS C:\> Invoke-PSTenableTokenRenewal
    .INPUTS
        None
    .OUTPUTS
        None
    .NOTES
        This a private function dedicated to retreiving a new token for the user and storing it using PSFramework.
    #>
    [CmdletBinding()]
    param (

    )

    # Credentials
    $APICredential = @{
        username       = (Get-PSFConfigValue -FullName 'PSTenable.Credential').UserName
        password       = (Get-PSFConfigValue -FullName 'PSTenable.Credential').GetNetworkCredential().Password
        releaseSession = "FALSE"
    }

    $SessionSplat = @{
        URI             = "$(Get-PSFConfigValue -FullName 'PSTenable.Server')/token"
        SessionVariable = "SCSession"
        Method          = "Post"
        ContentType     = "application/json"
        Body            = (ConvertTo-Json $APICredential)
        ErrorAction     = "Stop"
    }

    try {
        $Session = Invoke-RestMethod @SessionSplat
        Set-PSFconfig -FullName "PSTenable.Token" -Value $Session.response.token
    } catch {
        Write-PSFMessage -Level Warning -Message "Unable to execute Token Renewal." -ErrorRecord $_
    }
}

