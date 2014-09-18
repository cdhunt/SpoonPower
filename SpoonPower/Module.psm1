
<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Connect-SpoonUser
{
    [CmdletBinding()]
    [OutputType([Void])]
    Param
    (
        # Param1 help description
        [Parameter()]
        [PSCredential]
        $Credential = (Get-Credential)
    )

    $username = $Credential.UserName
    $password = $Credential.GetNetworkCredential().Password

    $command = "spoon login $username $password"

    $stringdata = Invoke-Expression $command

    if ($stringdata -eq "Logged in as $username")
    {
        Write-Verbose $stringdata
    }
    else
    {
        Write-Error $stringdata
    }
}

<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Disconnect-SpoonUser
{
    [CmdletBinding()]
    [OutputType([Void])]
    Param
    (
    )

    $command = "spoon logout"

    $stringdata = Invoke-Expression $command

    if (($stringdata -like " logged out at ") -or ($stringdata -eq "You are not currently logged into Spoon"))
    {
        Write-Verbose $stringdata
    }
    else
    {
        Write-Error $stringdata
    }
}

<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Import-SpoonImage
{
    [CmdletBinding()]
    [OutputType([System.Management.Automation.PSCustomObject])]
    Param
    (
        # Param1 help description
        [Parameter()]
        [Switch]
        $Latest
    )


    $command = "spoon images --csv"

    $stringdata = Invoke-Expression $command

    $stringdata | ConvertFrom-Csv -Delimiter "`t"
}


<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-SpoonImage
{
    [CmdletBinding()]
    [OutputType([Void])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory, Position=0)]
        [string]
        $Name,

        # Param1 help description
        [Parameter(Position=1)]
        [string]
        $Namespace,

        # Param1 help description
        [Parameter(Position=2)]
        [string]
        $Tag
    )

    $fqn = $Name

    if ($PSBoundParameters.ContainsKey("Namespace"))
    {
        $fqn = $Namespace + '/' + $fqn
    }

    if ($PSBoundParameters.ContainsKey("Tag"))
    {
        $fqn = $fqn + ':' + $Tag
    }

    $command = "spoon pull $fqn"

    $stringdata = Invoke-Expression $command

    Write-Verbose $stringdata
}

<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-SpoonContainer
{
    [CmdletBinding()]
    [OutputType([System.Management.Automation.PSCustomObject])]
    Param
    (
        # Param1 help description
        [Parameter()]
        [Switch]
        $Latest
    )


    $command = "spoon containers --csv"

    $stringdata = Invoke-Expression $command

    $stringdata | ConvertFrom-Csv -Delimiter "`t"
}

<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-SpoonContainers
{
    [CmdletBinding()]
    [OutputType([System.Management.Automation.PSCustomObject])]
    Param
    (
        # Param1 help description
        [Parameter()]
        [Switch]
        $Latest
    )


    $command = "spoon containers --csv"

    $stringdata = Invoke-Expression $command

    $stringdata | ConvertFrom-Csv -Delimiter "`t"
}

Export-ModuleMember -Function *

