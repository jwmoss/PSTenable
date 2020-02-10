function Set-PSTenableDefaultQuery {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    [OutputType('System.Collections.Specialized.OrderedDictionary')]
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
