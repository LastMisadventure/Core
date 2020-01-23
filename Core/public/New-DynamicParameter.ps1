<#
.SYNOPSIS
Creates a new [System.Management.Automation.RuntimeDefinedParameter].

.DESCRIPTION
Creates a new [System.Management.Automation.RuntimeDefinedParameter]. These can be used in a [System.Management.Automation.RuntimeDefinedParameterDictionary].

.PARAMETER Name
The name of the resulting parameter. This is what the consumer will specify on the commandline.

.PARAMETER Mandatory
Sets 'Mandatory' on the resulting parameter.

.PARAMETER Position
Enables and defines the position of the resulting parameter.
Ensure statically-defined parameters do not conflict with this position. Multiple dynamically-defined parameters can share the same positon
if they do not share the same parameter set.

.PARAMETER ValueFromPipeLine
Enables 'ValueFromPipeLine' binding behavior for the resulting parameter.

.PARAMETER ValueFromPipeLineByPropertyName
Enables 'ValueFromPipeLineByPropertyName' binding behavior for the resulting parameter.

.PARAMETER ValidateData
A set of data with which to validate bound values of the resulting parameter.

.PARAMETER ParamTypeName
The type name of the resulting parameter.

.PARAMETER ParameterSet
The name of the parameter set the resulting parameter will belong to.

.EXAMPLE
New-DynamicParameter -Name ProjectName -Mandatory -Position 4 -ValueFromPipeLineByPropertyName

.NOTES
General notes
#>
function New-DynamicParameter {

    [CmdletBinding(ConfirmImpact = 'low', SupportsShouldProcess)]

    [OutputType([System.Management.Automation.RuntimeDefinedParameter])]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]
        $Mandatory,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Position,

        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]
        $ValueFromPipeLine,

        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]
        $ValueFromPipeLineByPropertyName,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $ValidateData,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [System.Type]
        $ParamTypeName,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $ParameterSet = '__AllParameterSets'

    )

    process {

        if ($PsCmdlet.ShouldProcess($Name, 'Create a "[System.Management.Automation.RuntimeDefinedParameter]" object')) {

            try {

                Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Name): Building dynamic parameter object..."

                $attributeCollection = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute] -ErrorAction Stop

                $parameterAttribute = New-Object -TypeName System.Management.Automation.ParameterAttribute -ErrorAction Stop

                $parameterAttribute.Mandatory = $Mandatory

                $parameterAttribute.ValueFromPipelineByPropertyName = $ValueFromPipeLineByPropertyName

                $parameterAttribute.ValueFromPipeline = $ValueFromPipeLine

                if ($Position) {

                    $parameterAttribute.Position = $Position

                }

                if ($ValidateData) {

                    $validateSetAttribute = New-Object -ErrorAction Stop -TypeName System.Management.Automation.ValidateSetAttribute($ValidateData)
                    $attributeCollection.Add($validateSetAttribute)

                    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Name): Assignments will be validated against $($ValidateData -join ", ")."
                }

                $parameterAttribute.ParameterSetName = $ParameterSet

                $attributeCollection.Add($ParameterAttribute)

                $runtimeParameter = New-Object -ErrorAction Stop -TypeName System.Management.Automation.RuntimeDefinedParameter($Name, $paramTypeName, $attributeCollection)

                Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Name): built dynamic parameter."

                Write-Output $runtimeParameter

            } catch {

                $PSCmdlet.ThrowTerminatingError($PSItem)

            }

        }

    }

}