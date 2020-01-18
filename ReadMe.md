# Core

Provides a set of cmdlets that generate code and do other useful things. Intended to be used by other modules and not interactively for the most part.

## Getting Started

1. Place the module folder in a directory that's part of `$env:PsModulePath`.

## Example Operations with Core

1. Easily manage [Dynamic Parameters](https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/cmdlet-dynamic-parameters?):

```PowerShell
# Create some dynamic parameters.

$dynParam1 = New-DynamicParameter -Name DynParam1 -Mandatory -ParamTypeName string -ValidateData = $array_Values1

$dynParam2 = New-DynamicParameter -Name DynParam2 -Mandatory -ParamTypeName string -ValidateData = $array_Values2

$dynParam3 = New-DynamicParameter -Name DynParam3 -Mandatory -ParamTypeName string -ValidateData = $array_Values3

# Create the dynamic parameter dictionary.

$dynParamDict = New-DynamicParameterDictionary -DynamicParameter $_dynParam1, $_dynParam2, $_dynParam3

# Now, you can simply insert `$dynParamDict` into the `dynamicParam {}` of your function.

dynamicParam {

    $dynParamDict

}

```

2. Convert a `byte`, `megabyte`, `kilobyte`, or `gigabyte` value into the highest sensible unit:

```PowerShell

# This will output `200.12 MB`.
ConvertTo-ReadableSize 209843252

# This will output `8.2 GB`.
ConvertTo-ReadableSize 8400mb

```

3. Easily use Host Choice Menus

```PowerShell

# Create some options...
$optionDelete = New-HostChoiceOption -Label Delete -HelpMessage "Deletes the computer; it can't be recovered."

# Create the menu.

$optionPowerDown = New-HostChoiceOption -Label Delete -HelpMessage "Powers the computer off."

    $menuPowerDownOrDeleteComputer = @{

        Title                 = "Power down or delete this computer"

        Message               = "Choose to either delete or turn off this computer."

        Choice                = $optionDelete, $optionPowerDown

        DefaultChoicePosition = 0

    }

# Then, when you want to show the menu:

$userChoice = Invoke-HostChoiceMenu @menuPowerDownOrDeleteComputer

# $userChoice will contain an [int] that represents the selected option.

```
