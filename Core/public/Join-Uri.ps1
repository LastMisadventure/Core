<#
.SYNOPSIS
Join a resource to a URL.

.DESCRIPTION
Join a resource to a URL.

.PARAMETER Url
The base URL to be joined.

.PARAMETER ChildPart
A child part (resource) to be joined to its parent URL.

.EXAMPLE
$invocation = Join-URL -Url 'https://server.domain.com' -ChildPart "api/v1/documentation?v1"

.NOTES
General notes
#>

function Join-Uri {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Uri,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ChildPart

    )

    process {

        Write-Output ([uri] ($Uri.ToString() + '/' + $ChildPart.ToString()))

    }

}