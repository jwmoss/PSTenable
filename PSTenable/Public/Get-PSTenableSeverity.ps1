function Get-PSTenableSeverity {
    <#
    .SYNOPSIS
        Retrieves all vulnerabilities that are Critical, High, Medium, or Low in Tenable.
    .DESCRIPTION
        This function provides a way to retrieve all vulnerabilities in Tenable that are Critical, High,
        Medium, or Low.  
        Revision 0.1, Sept 2019, jwmoss
        Revision 0.2, Nov 2019, aarong1234 
    .INPUTS
        None
    .PARAMETER Severity
        Option for any of "Critical", "High", "Medium", "Low", "Al"l, "All with Info". Defaults to "Critical","High".  All with Info will get ALL vuln data
    .PARAMETER MaxRecords
        Option for maximum records (rows of data) that should be requested (as a throttle), Default is 0 (all records) [note: sorted by score, descending]
    .PARAMETER Detail
        Option to enable detailed data. Defaults to Summary Data. To determine how detailed the resulting data is by querying Tenable.sc "Vulnerability Summary" versus "Vulnerability Detail"
    .OUTPUTS
        PSCustomObject
    .NOTES
        None
    .EXAMPLE
        Get-PSTenableSeverity -Severity "Critical"
        Retrieves all critical vulnerabilities, Summary Data [sorted by vprscore (note:Very OLD plugins dont have a VPR Scores)]
    .EXAMPLE
        Get-PSTenableSeverity -Detailed
        Retrieves all critical and high vulnerabilities, Detailed Data (return Tenable.sc Vulnerability Detail data instead of summary) [sorted by vprscore (note:Very OLD plugins dont have a VPR Scores)]
    .EXAMPLE 
        Get-PSTenableSeverity -Severity "High","Medium" -Maxrecords 200
        Retrieves high and medium vulnerabilities, up to 200 records, Summary Data [sorted by vprscore (note:Very OLD plugins dont have a VPR Scores)]
    .EXAMPLE
        Get-PSTenableSeverity -Severity "All" -Detailed
        Retrieves all non-info vulnerabilities, Detailed data [sorted by vprscore (note:Very OLD plugins dont have a VPR Scores)]
    #>
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [ValidateSet(
            'Critical',
            'High',
            'Medium',
            'Low',
            'All',
            'All with Info'

        )]
        [string[]]
        $Severity,
        
        [Parameter(Position = 1, Mandatory = $false)]
        [int]$MaxRecords = 0,

        [Parameter(Mandatory = $false)]
        [ValidateSet($true,$false)]
        [switch]
        $Detailed
        
    )

    begin {

        $TokenExpiry = Invoke-PSTenableTokenStatus
        if ($TokenExpiry -eq $True) {Invoke-PSTenableTokenRenewal}

        if (!($Severity)) {
            $ID = @("4","3") #Magic Numbers for Critical & High
        } elseif ($Severity -contains "All with Info") {
            $ID = @("4","3","2","1","0") #all but info
        } elseif ($Severity -contains "All") { #if $severity has both All and All with Info.. All with Info will take precedence
            $ID = @("4","3","2","1")
        } else { #if Severity has All or All with info, other values are ignored
            $ID = @() 
            switch ($Severity) {
                "Critical" { $ID += "4" }
                "High" { $ID += "3" }
                "Medium" { $ID += "2" }
                "Low" { $ID += "1" }
            }
        }
        $ID = $ID | Sort-Object -Descending

    }

    process {
        $APIresults = @()
        $CurrentStartOffset = 0

        $ID | % { #because of lack of useful sorting data (scores, time) within a severity, especially in summary data... we are going to query severities in order
            $Sev = $_

            Do {
                if ($MaxRecords -ne 0 -and $MaxRecords -lt ($CurrentStartOffset + 2147483647)) { 
                    $CurrentEndOffset = $MaxRecords
                } else {
                    $CurrentEndOffset = ($CurrentStartOffset + 2147483647)
                }
                Write-verbose "Querying SC for results: $CurrentStartOffset to $CurrentEndOffset" 

                $PreJSON = @{
                    "type"       = "vuln"
                    "sourceType" = "cumulative"
                    "sortField"    = "basescore"
                    "sortDir"      = "DESC"
                    "query"      = @{
                        "type"         = "vuln"
                        "startOffset"  = $CurrentStartOffset
                        "endOffset"    = $CurrentEndOffset
                        "tool"         = & {if ($Detailed) {"vulndetails"} else {"listvuln"}}
                    }
                }
                if ($ID) { 
                    $PreJSON.query.add("filters",[array]@{
                        "filterName"   = "severity"
                        "operator"     = "="
                        "value"        = "$Sev"
                    })
                } 
                
     

                $Splat = @{
                    Method   = "Post"
                    Body     = $(ConvertTo-Json $PreJSON -depth 5)
                    Endpoint = "/analysis"
                }
                #Note: initially I was paginating every 2000, but frankly it was super inefficient, now we paginate on sizeof(Int32) 
                $ThisResults = Invoke-PSTenableRest @Splat | Select-Object -ExpandProperty Response | Select-Object -ExpandProperty Results
                if ($ThisResults) { #non zero records came back
                    $APIresults += $Thisresults
                    #move pagination line (if you it is ever hit)
                    $CurrentStartOffset = $CurrentEndOffset
                    if ($Maxrecords -and ($CurrentStartOffset -ge $MaxRecords)) {$ThisResults = $Null} # we don't need to loop anymore
                }
            } While ($ThisResults)
        }

        $APIresults | Sort-object vprscore,basescore -Descending

    }

    end {
    }
}
