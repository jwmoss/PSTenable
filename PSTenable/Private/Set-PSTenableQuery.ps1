function Set-PSTenableQuery {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateSet(
            "vulnipdetail",
            "listvuln"
        )]
        [string]
        $Tool
    )

    [ordered]@{
        tool       = $Tool
        sortField  = "cveID"
        sortDir    = "ASC"
        type       = "vuln"
        sourceType = "cumulative"
    }
}
