Get-Module -Name Core | Remove-Module -Force

Import-Module -Name Core -Force

InModuleScope -ModuleName Core {

    Describe 'public/ConvertTo-ReadableSize' {

        It 'Converts 250000 bytes into 244.14 KB' {

            $testResult = ConvertTo-ReadableSize -Size 250000

            $testResult | Should be '244.14 KB'

        }

    }

}