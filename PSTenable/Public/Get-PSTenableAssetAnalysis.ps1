function Get-PSTenableAssetAnalysis {
    <#
    .SYNOPSIS
        Returns all vulnerablitiies that are associated with a device in Tenable.
    .DESCRIPTION
        This function provides a way to retreive all vulnerabilities associated with a scanned device in Tenable.
    .EXAMPLE
        PS C:\> Get-PSTenableAssetAnalysis -ComputerName "server.fqdn.com" -Tool "vulnipdetails"
        This retreives all vulnerabilities reported by Tenable from computername server.fqdn.com
    .PARAMETER ComputerName
        Computername in Tenable that you're searching for
    .PARAMETER Tool
        The vulnerability tool to chose. Defaults to vulnipdetails.
    .INPUTS
        None
    .OUTPUTS
        None
    .NOTES
        Make sure the computername is spelled correctly, otherwise the request will fail.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [PSFComputer]
        $ComputerName,

        [ValidateSet(
            "vulnipdetails",
            "listvuln"
        )]
        [string]
        $Tool = "vulnipdetails"
    )

    begin {
        $TokenExpiry = Invoke-PSTenableTokenStatus
        if ($TokenExpiry -eq $True) {Invoke-PSTenableTokenRenewal}
    }

    process {

        $Query = Set-PSTenableDefaultQuery -Tool $Tool

        $Query.Add("query",@{
            name         = ""
            description  = ""
            context      = ""
            status       = "-1"
            createdTime  = 0
            modifiedtime = 0
            sourceType   = "cumulative"
            sortDir      = "desc"
            tool         = $Tool
            groups       = "[]"
            type         = "vuln"
            startOffset  = 0
            endOffset    = 5000
            filters      = [array]@{
                id           = "dnsName"
                filterName   = "dnsName"
                operator     = "="
                type         = "vuln"
                ispredefined = $true
                value        = $ComputerName
            }
            vulntool     = $Tool
            sortField    = "severity"
            }
        )

        $Splat = @{
            Method   = "Post"
            Body     = $(ConvertTo-Json $query -depth 5)
            Endpoint = "/analysis"
        }

    }

    end {
        (Invoke-PSTenableRest @Splat).Response.Results
    }
}
