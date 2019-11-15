function Get-PSTenableSeverity {
    <#
    .SYNOPSIS
        Retrieves all vulnerabilities that are Critical, High, Medium, or Low in Tenable.
    .DESCRIPTION
        This function provides a way to retrieve all vulnerabilities in Tenable that are Critical, High,
        Meidum, or Low.
    .EXAMPLE
        PS C:\> Get-PSTenableSeverity -Severity "Critical"
        Retrieves all criitcal vulnerabilities.
    .INPUTS
        None
    .PARAMETER Severity
        Option for Critical, High, Medium or Low.
    .OUTPUTS
        None
    .NOTES
        None
    #>
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateSet(
            'Critical',
            'High',
            'Medium',
            'Low'
        )]
        [string[]]
        $Severity,
        
        [Parameter(Position = 0, Mandatory = $false)]
        [int]$maxrecords = 0
    )

    begin {

        $TokenExpiry = Invoke-PSTenableTokenStatus
        if ($TokenExpiry -eq $True) {Invoke-PSTenableTokenRenewal}

        $ID = "" 
        switch ($Severity) {
            "Critical" { $ID += "4" }
            "High" { $ID += "3" }
            "Medium" { $ID += "2" }
            "Low" { $ID += "1" }
        }
        $ID = ($ID -split "" | ? {$_}) -join ","

    }

    process {
        $APIresults = @()
        $CurrentStartOffset = 0

        Do {
            #we're gonna paginate at 5000 rows
            if ($MaxRecords -ne 0 -and $MaxRecords -lt ($CurrentStartOffset + 4999)) { 
                $CurrentEndOffset = $MaxRecords
            } else {
                $CurrentEndOffset = ($CurrentStartOffset + 4999)
            }
            Write-verbose "Querying SC for results: $CurrentStartOffset to $CurrentEndOffset" 

            $PreJSON = @{
                "type"       = "vuln"
                "sourceType" = "cumulative"
                "query"      = @{
                    "type"         = "vuln"
                    "sortField"    = "severity"
                    "sortDir"      = "DESC"
                    "startOffset"  = $CurrentStartOffset
                    "endOffset"    = $CurrentEndOffset
                    "tool"         = "vulndetails"
                    "filters"      = [array]@{
                        "filterName"   = "severity"
                        "operator"     = "="
                        "value"        = "$ID"
                    }

                }
            }

            $Splat = @{
                Method   = "Post"
                Body     = $(ConvertTo-Json $PreJSON -depth 5)
                Endpoint = "/analysis"
            }

            $ThisResults = Invoke-PSTenableRest @Splat | Select-Object -ExpandProperty Response | Select-Object -ExpandProperty Results
            if ($ThisResults) { #non zero records came back
                $APIresults += $Thisresults
                #move pagination line
                $CurrentStartOffset = $CurrentEndOffset + 1
            }
        } While ($ThisResults)
        $ApiResults

    }

    end {
    }
}
