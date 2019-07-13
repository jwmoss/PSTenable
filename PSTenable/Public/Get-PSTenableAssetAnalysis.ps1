function Get-PSTenableAssetAnalysis {
    <#
    .SYNOPSIS
        Returns all vulnerablitiies that are associated with a device in Tenable.
    .DESCRIPTION
        This function provides a way to retreive all vulnerabilities associated with a scanned device in Tenable.
    .EXAMPLE
        PS C:\> Get-PSTenableAssetAnalysis -ComputerName "server.fqdn.com"
        This retreives all vulnerabilities reported by Tenable from computername server.fqdn.com
    .PARAMETER ComputerName
        Computername in Tenable that you're searching for
    .INPUTS
        None
    .OUTPUTS
        None
    .NOTES
        Make sure the computername is spelled correctly, otherwise the request will fail.
    #>
    [CmdletBinding()]
    param (
        [String]
        [Parameter(Position = 0, Mandatory = $true)]
        [string]
        $ComputerName
    )

    begin {
        $TokenExpiry = Invoke-PSTenableTokenStatus
        if ($TokenExpiry -eq $True) {Invoke-PSTenableTokenRenewal} else {continue}
    }

    process {

        $query = @{
            "tool"       = "vulnipdetail"
            "sortField"  = "cveID"
            "sortDir"    = "ASC"
            "type"       = "vuln"
            "sourceType" = "cumulative"
            "query"      = @{
                "name"         = ""
                "description"  = ""
                "context"      = ""
                "status"       = "-1"
                "createdTime"  = 0
                "modifiedtime" = 0
                "sourceType"   = "cumulative"
                "sortDir"      = "desc"
                "tool"         = "listvuln"
                "groups"       = "[]"
                "type"         = "vuln"
                "startOffset"  = 0
                "endOffset"    = 5000
                "filters"      = [array]@{
                    "id"           = "dnsName"
                    "filterName"   = "dnsName"
                    "operator"     = "="
                    "type"         = "vuln"
                    "ispredefined" = $true
                    "value"        = "$ComputerName"
                }
                "vulntool"     = "listvuln"
                "sortField"    = "severity"
            }
        }

        $Splat = @{
            Method   = "Post"
            Body     = $(ConvertTo-Json $query -depth 5)
            Endpoint = "/analysis"
        }

    }

    end {
        Invoke-PSTenableRest @Splat | Select-Object -ExpandProperty Response | Select-Object -ExpandProperty Results
    }
}
