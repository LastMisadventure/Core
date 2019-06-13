# ! Not sure how to handle this test as the host choice menu expects user input...
# Describe 'public/New-OMTHostChoiceOption' {

#     $VerbosePreference = 'Continue'

#     It 'Returns a new `[System.Management.Automation.Host.ChoiceDescription]` that matches specifications.' {

#         $testChoiceLabels = 'Geode', 'Geology', 'Incense'

#         $testChoiceOptions = $testChoiceLabels | ForEach-Object {

#             $splat_TestChoiceOptionValues = @{

#                 Label = $_
#                 HelpMessage = 'TestHelpMessage'

#             }

#             Write-Output (New-OMTHostChoiceOption -Verbose -ErrorAction Stop @splat_TestChoiceOptionValues)

#         }

#         $testChoiceMenu = Invoke-OMTHostChoiceMenu -ErrorAction Stop -Verbose -Title TestMenu -Message 'Choose your destiny!' -Choice $testChoiceOptions -DefaultChoicePosition 0

#     }

#     $VerbosePreference = 'SilentlyContinue'

# } # End of Describe 'public/New-OMTHostChoiceOption'.
