Get-Module -Name Core | Remove-Module -Force

Import-Module -Name Core -Force

InModuleScope -ModuleName Core {

    Describe 'public/New-DynamicParameterDictionary' {

        It 'Creates a new [System.Management.Automation.RuntimeDefinedParameterDictionary] that matches specifications.' {

            $testDynamicParamNames = 'Potato', 'Apple', 'Orange', 'Waffle'

            $testDynamicParams = $testDynamicParamNames | ForEach-Object {

                $splat = @{

                    Name              = $_
                    Position          = 1
                    Mandatory         = $true
                    ValueFromPipeline = $true
                    ValidateData      = (1, 2, 3)
                    ParamTypeName     = 'string'
                }

                Write-Output (New-DynamicParameter @splat)

            }

            $testDynamicParamDict = New-DynamicParameterDictionary -DynamicParameter $testDynamicParams

            Compare-Object -ReferenceObject $testDynamicParamNames -DifferenceObject $testDynamicParamDict.Values.Name | Should be $null

        }

    }

}
