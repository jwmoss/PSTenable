function Get-PSTenableCVE {
    <#
    .SYNOPSIS
        Retrieves all devices in Tenable affected by the CVE passthrough to the user.
    .DESCRIPTION
        This function provides a way to retrieve all devices affected by a CVE that is passed to the function.
    .EXAMPLE
        PS C:\> @("CVE-2019-0708","CVE-2019-13046") | Get-PSTenableCVE
        This passes an array of CVE's to the fucntion and returns and all devices affected by the CVEs.

        PS C:\> Get-PSTenableCVE -CVE "CVE-2019-0708"
        This returns all devices affected by CVE-2019-0708
    .PARAMETER CVE
        CVE Number, such as CVE-2019-0708
    .PARAMETER Tool
        The vulnerability tool to chose. Defaults to vulnipdetails.
    .INPUTS
        None
    .OUTPUTS
        None
    .NOTES
        Remember you can pass one or multiple CVE's in an array.
    #>
    [CmdletBinding()]
    param (
        [parameter(Position = 0,mandatory = $true,ValueFromPipeline = $true)]
        [string[]]
        $CVE,

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
        $CVE | Foreach-object {

            $Query = Set-PSTenableDefaultQuery -Tool $Tool

            $Query.Add("query",@{
                    createdTime  = 0;
                    sourceType   = "cumulative";
                    sortDir      = "desc";
                    tool         = "vulnipdetail";
                    modifiedTime = 0;
                    name         = "";
                    type         = "vuln";
                    filters      = [array]@{
                        operator   = "=";
                        value      = $_
                        filterName = "cveID"
                    }
                    description  = "";
                    sortField    = "severity";
                    startOffset  = 0;
                    context      = "";
                    endOffset    = 5000
                }
            )

            $Splat = @{
                Method   = "Post"
                Body     = $(ConvertTo-Json $query -depth 5)
                Endpoint = "/analysis"
            }

            Get-PSTenablePlugin -ID $Plugin -ID (Invoke-PSTenableRest @Splat).Response.Results.pluginID
        }
    }

    end {

    }
}
