<#
.SYNOPSIS
Updates a PowerShell module if the on-disk version is higher than the currently imported version.

.DESCRIPTION
Updates a PowerShell module if the on-disk version is higher than the currently imported version.

.PARAMETER Module
The Module object.

.PARAMETER IncludeRequiredModules
Also removes all dependant modules. This will force them to get imported again when the triggering module imports.

.EXAMPLE

$script:module = Get-Module

Update-ScriptModule $module

.NOTES
General notes
#>

function Update-ScriptModule {

    [CmdletBinding(ConfirmImpact = 'low', PositionalBinding)]

    param (

        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSModuleInfo]
        $Module,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [switch]
        $IncludeRequiredModules

    )

    process {

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: [$($Module.Name)]: Checking if a new version of this module has been deployed..."

        $availableModule = Get-Module ($Module.Path.Replace('.psm1', '.psd1')) -ListAvailable -Verbose:$false

        if ($Module.Version -lt $availableModule.Version) {

            $choice_Restart = Core\New-HostChoiceOption -Label 'Halt' -HelpMessage "Halts execution of this command." -Verbose:$false

            $choice_Reload = Core\New-HostChoiceOption -Label 'Reload' -HelpMessage "Reload out-dated module '$($Module.Name)'." -Verbose:$false

            $choice_Continue = Core\New-HostChoiceOption -Label 'Continue' -HelpMessage "Continue with the outdated module." -Verbose:$false

            $splat = @{

                Title                 = "A newer version of '$($Module.Name)' was found"

                Message               = "You may forcibly import the new version of the module or restart the session."

                Choice                = $choice_Reload, $choice_Restart, $choice_Continue

                DefaultChoicePosition = 0

                Verbose               = $false

            }

            $result = Core\Invoke-HostChoiceMenu @splat

            switch ($result) {

                0 {

                    try {

                        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: [$($Module.Name)]: Importing new module version..."

                        Remove-Module -Name $Module.Name -Force

                        if ($IncludeRequiredModules.IsPresent) {

                            if ("" -ne $Module.RequiredModules) {

                                Write-Verbose "[$($MyInvocation.MyCommand.Name)]: [$($Module.Name)]: The following Modules are marked as dependancies and will be removed: $($Module.RequiredModules.Name -join ', ')."

                                $Module.RequiredModules | Remove-Module -Force

                            }

                        }

                        Import-Module ($Module.Path.Replace('psm1', 'psd1')) -Global -Force -ErrorAction Stop

                        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: [$($Module.Name)]: Module is now up-to-date."

                    }

                    catch {

                        Write-Error -ErrorAction Stop -Exception $_.Exception
                    }

                }

                1 {

                    Write-Error -ErrorAction Stop -Message "Operator chose to halt operation."

                }

                2 {

                    Write-Warning "[$($MyInvocation.MyCommand.Name)]: [$($Module.Name)]: Continuing with out-dated module."

                    return

                }

            }

        }

        else {

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: [$($Module.Name)]: Module is up-to-date."
        }

    }

}
