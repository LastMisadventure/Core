Get-Module -Name Core | Remove-Module -Force
Import-Module -Name Core -Force

InModuleScope -ModuleName Core {

    Describe 'public/New-DynamicParameter' {

        It 'Creates a new [System.Management.Automation.RuntimeDefinedParameter] that matches specifications.' {

            $splat = @{

                Name              = 'TestDynamicParam'
                Position          = 1
                Mandatory         = $true
                ValueFromPipeline = $true
                ValidateData      = (1, 2, 3)
                ParamTypeName     = 'string'

            }

            $testDynamicParam = New-DynamicParameter @splat

            $testDynamicParam.Name | Should be $splat.Name

            $testDynamicParam.ParameterType | Should match $splat.ParamTypeName

        }

    }

}
