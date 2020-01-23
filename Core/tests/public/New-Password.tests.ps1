Get-Module -Name Core | Remove-Module -Force

Import-Module -Name Core -Force

InModuleScope -ModuleName Core {

    Describe 'public/New-Password' {

        It 'Creates a new 32-character clear-text password.' {

            $testResult = New-Password -Length 32 -MinimumSpecialCharacterCount 8

            $testResult.Length | Should be 32

        }

        It 'Creates a [securestring] password.' {

            $testResult = New-Password -Length 38 -MinimumSpecialCharacterCount 11 -OutSecureString

            $testResult -is [securestring] | should be $true

        }

    }

}