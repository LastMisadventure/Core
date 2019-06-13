<#
.SYNOPSIS
Creates a new [System.Management.Automation.Host.ChoiceDescription] object.

.DESCRIPTION
Creates a new [System.Management.Automation.Host.ChoiceDescription] object.

.PARAMETER Label
The choice. See the example.

.PARAMETER HelpMessage
A message that explains the choice.

.EXAMPLE
New-HostChoiceOption -Label Delete -HelpMessage "Deletes the computer; it can't be recovered."

Label   HelpMessage
-----   -----------
&Delete Deletes the computer; it can't be recovered.

.NOTES
The '&' denotes which character is the abbrevition for a given choice. For example, for `&Delete`, the user could type in 'Delete', or 'd', or 'D'.
#>
function New-HostChoiceOption {

    [CmdletBinding(ConfirmImpact = 'low', PositionalBinding, SupportsShouldProcess)]

    [OutputType([System.Management.Automation.Host.ChoiceDescription])]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Label,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [string]
        $HelpMessage

    )

    begin {

        $ErrorActionPreference = 'Stop'

    }

    process {

        $spTarget = $Label
        $spOperation = 'Create a "[System.Management.Automation.Host.ChoiceDescription]" object'

        if ($PsCmdlet.ShouldProcess($spTarget, $spOperation)) {


            $_labalWithHotKeyValue = ('&' + $Label)

            Write-Output (New-Object -ErrorAction Stop -TypeName System.Management.Automation.Host.ChoiceDescription -ArgumentList $_labalWithHotKeyValue, $HelpMessage)

        }

    }

    end {

    }

}
