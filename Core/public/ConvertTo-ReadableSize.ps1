<#
.SYNOPSIS
Converts between byte-based storage units and displays the highest unit of reasonable size.

.PARAMETER Size
The starting value (of type [System.ValueType]). There must be no space between the value and unit name.
See the example.


.EXAMPLE
ConvertTo-ReadableSize 4939892421415

4.94 TB

.NOTES

https://en.wikipedia.org/wiki/Byte

#>

function ConvertTo-ReadableSize {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    [OutputType([string])]

    param (

        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [int64]
        $Size

    )

    process {

        try {

            switch ($Size) {

                { $Size -gt 1000000000000000 } {

                    $newSize = "$([math]::Round(($Size / 1000000000000000), 4)) PB"

                    break

                }

                { $Size -gt 1000000000000 } {

                    $newSize = "$([math]::Round(($Size / 1000000000000), 3)) TB"

                    break

                }

                { $Size -gt 1000000000 } {

                    $newSize = "$([math]::Round(($Size / 1000000000), 2)) GB"

                    break

                }


                { $Size -gt 1000000 } {

                    $newSize = "$([math]::Round(($Size / 1000000), 2)) MB"

                    break

                }

                { $Size -gt 1000 } {

                    $newSize = "$([math]::Round(($Size / 1000), 2)) KB"

                    break

                }

                Default {

                    $newSize = "$Size bytes"

                }

            }

            Write-Output $NewSize

        } catch {

            $PSCmdlet.ThrowTerminatingError($PSItem)

        }

    }

}