Get-Module -Name Core | Remove-Module -Force

Import-Module -Name Core -Force

InModuleScope -ModuleName Core {
    Describe 'public/New-HostChoiceOption' {

        It 'Returns a new [System.Management.Automation.Host.ChoiceDescription] that matches specifications.' {

            $splat = @{

                Label       = 'TestLabel'
                HelpMessage = 'TestHelpMessage'

            }

            $testChoiceOption = New-HostChoiceOption @splat

            $testChoiceOption.GetType() -eq [System.Management.Automation.Host.ChoiceDescription] | Should be $true

            $testChoiceOption.Label -eq ('&' + $splat.Label) | Should be $true

            $testChoiceOption.HelpMessage -eq $splat.HelpMessage | Should be $true

        }

    }

}
