<#
.SYNOPSIS
Creates a new, reasonably strong random password using [System.Web].

.PARAMETER Length
The total length of the resultant password.

.PARAMETER MinimumSpecialCharacterCount
The fewest special characters that will be present in the resultant password.

.PARAMETER AsSecureString
Outputs password as a [securestring] instead of a [string].

.EXAMPLE
New-Password -Length 42

.NOTES

.LINK
https://msdn.microsoft.com/en-us/library/system.web.security.membership.generatepassword(v=vs.110).aspx

#>

function New-Password {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low', SupportsShouldProcess)]

    [OutputType([string], [securestring])]

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingConvertToSecureStringWithPlainText', '')]

    param (

        [Parameter(ValueFromPipelineByPropertyName, ValueFromPipeline, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [ValidateRange(8, 128)]
        [int]
        $Length = 32,

        [Parameter(ValueFromPipelineByPropertyName, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [ValidateRange(8, 64)]
        [int]
        $MinimumSpecialCharacterCount = 8,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [switch]
        $OutSecureString

    )

    begin {

        $ErrorActionPreference = 'Stop'

        Add-Type -AssemblyName System.Web

    }

    process {

        if ($PsCmdlet.ShouldProcess('password', 'create')) {

            try {

                Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Generating a password with a length of $($Length) and a special character count of $($MinimumSpecialCharacterCount). "

                switch ($OutSecureString.IsPresent) {

                    $True {

                        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Returning securestring password..."

                        Write-Output ([System.Web.Security.Membership]::GeneratePassword($Length, $MinimumSpecialCharacterCount) | ConvertTo-SecureString -AsPlainText -Force)
                    }

                    $False {

                        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Returning clear-text string password..."

                        Write-Output ([System.Web.Security.Membership]::GeneratePassword($Length, $MinimumSpecialCharacterCount))
                    }
                }

            } catch {

                $PSCmdlet.ThrowTerminatingError($PSItem)

            }

        }

    }

}
