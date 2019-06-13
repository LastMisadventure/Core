<#
.SYNOPSIS
Invokes a host choice menu.

.DESCRIPTION
Invokes a host choice menu.

.PARAMETER Title
The title of the menu. See the example.

.PARAMETER Message
The message of the menu--this is the question to which the choice answers. See the example.

.PARAMETER Choice
One or more choice ([System.Management.Automation.Host.ChoiceDescription]) objects.

.PARAMETER DefaultChoicePosition
Pressing 'enter' will send the default choice.

.EXAMPLE
An example

.NOTES
General notes
#>
function Invoke-HostChoiceMenu {

    [CmdletBinding(ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        $Title,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        $Message,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.Host.ChoiceDescription[]]
        $Choice,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [int]
        $DefaultChoicePosition = 0

    )

    begin {

        $ErrorActionPreference = 'Stop'

    }

    process {

        Write-Output ($host.ui.PromptForChoice($Title, $Message, $Choice, $DefaultChoicePosition))

    }

    end {

    }

}
