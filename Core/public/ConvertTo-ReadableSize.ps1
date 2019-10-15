<#
.SYNOPSIS
Converts between byte-based storage units and displays the highest unit of reasonable size.

Does not handle parsing [System.ValueType] from a string like `95 KB` (needs to be input as `95kb`).

.PARAMETER Size
The starting value (of type [System.ValueType]). There must be no space between the value and unit name.
See the example.

If the value is in bytes, no unit name is required.

.EXAMPLE
ConvertTo-ReadableSize -Size 1438.93GB

1.405 TB

.NOTES

https://en.wikipedia.org/wiki/Byte

#>

function ConvertTo-ReadableSize {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    [OutputType([string])]

    param (

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [System.ValueType]
        $Size

    )

    begin {

        $ErrorActionPreference = 'Stop'

    }

    process {

        switch ($Size) {

            # Petabytes.
            { $Size -gt 1PB } {

                $newSize = "$([math]::Round(($Size / 1PB), 4)) PB"
                break
            }

            # Terabytes.
            { $Size -gt 1TB } {

                $newSize = "$([math]::Round(($Size / 1TB), 3)) TB"
                break
            }

            # Gigabytes.
            { $Size -gt 1GB } {

                $newSize = "$([math]::Round(($Size / 1GB), 2)) GB"
                break
            }

            # Megabytes.
            { $Size -gt 1MB } {

                $newSize = "$([math]::Round(($Size / 1MB), 2)) MB"
                break
            }

            # Kilobytes.
            { $Size -gt 1KB } {

                $newSize = "$([math]::Round(($Size / 1KB), 2)) KB"
                break
            }

            Default {

                $newSize = $Size

            }

        }

        Write-Output $NewSize

    }

    end {

    }

}
