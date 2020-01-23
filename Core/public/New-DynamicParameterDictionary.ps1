<#
.SYNOPSIS
Creates a new [System.Management.Automation.RuntimeDefinedParameterDictionary] from one or more [System.Management.Automation.RuntimeDefinedParameter]
objects.

.DESCRIPTION
Creates a new [System.Management.Automation.RuntimeDefinedParameterDictionary] from one or more [System.Management.Automation.RuntimeDefinedParameter]
objects.
This is a collection of 0 or more dynamically generated parameters; these are used in a cmdlet's `dynamicParam {}` block.

.PARAMETER DynamicParameter
A [System.Management.Automation.RuntimeDefinedParameter] object, such as one returned by `New-DynamicParameter`.

.EXAMPLE

# Create some dynamic parameters.

$_dynParam1 = New-DynamicParameter -Name DynParam1 -Mandatory -ParamTypeName string -ValidateData = $array_Values1

$_dynParam2 = New-DynamicParameter -Name DynParam2 -Mandatory -ParamTypeName string -ValidateData = $array_Values2

$_dynParam3 = New-DynamicParameter -Name DynParam3 -Mandatory -ParamTypeName string -ValidateData = $array_Values3

# Create the dynamic parameter dictionary.

$_dynParamDict = New-DynamicParameterDictionary -DynamicParameter $_dynParam1, $_dynParam2, $_dynParam3

.EXAMPLE

You can reuse the resulting dictionary object in multiple dynamicParam blocks within the same module by setting the desired variable scope.

# Assign a script-scoped variable that contains a dynamic parameter dictionary.

$script:dynParamDictTest = New-DynamicParameterDictionary -DynamicParameter $_dynParam1, $_dynParam2, $_dynParam3

# To add this to a cmdlet, simply reference the variable in the `dynamicParam {}` block.

dynamicParam {

    $dynParamDictTest

}

If you are calling this value from a PowerShell-defined class method, it may be necessary to include the scope identifier (`$script:`, etc.).

.EXAMPLE

To cause the Dynamic Parameter set to be generated dynamically each time a function, method, or cmdlet is run, regenerate the dictionary
at runtime.

# Cmdlet\function

dynamicParam {

    New-DynamicParameterDictionary -DynamicParameter $_dynParam1, $_dynParam2, $_dynParam3

}

.NOTES
General notes

.LINK
https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.runtimedefinedparameterdictionary?view=powershellsdk-1.1.0
#>
function New-DynamicParameterDictionary {

    [CmdletBinding(ConfirmImpact = 'low', PositionalBinding, SupportsShouldProcess)]

    [OutputType([System.Management.Automation.RuntimeDefinedParameterDictionary])]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline, Position = 0)]
        [System.Management.Automation.RuntimeDefinedParameter[]]
        $DynamicParameter

    )

    process {

        $spOperation = 'Create a "[System.Management.Automation.RuntimeDefinedParameterDictionary]" object'

        if ($PsCmdlet.ShouldProcess($spOperation)) {

            try {

                $runtimeParameterDictionary = New-Object -ErrorAction Stop -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary

                $DynamicParameter | ForEach-Object {

                    $runtimeParameterDictionary.Add($_.Name, $_)

                }

                Write-Output $runtimeParameterDictionary

            } catch {

                $PSCmdlet.ThrowTerminatingError($PSItem)

            }

        }

    }

}
