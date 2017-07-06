<#
.Synopsis
This function will set the proxy settings provided as input to the cmdlet.
.Description
This function will disable the proxy server and set the automatic configuration script
.Example
Setting the proxy information and automatic configuration script
Set-InternetProxy -acs "http://abc.com"
#>

Function Set-InternetProxy
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$False,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [AllowEmptyString()]
        [String[]]$acs
    )

    Begin
    {
        $regKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
    }

    Process
    {
        Set-ItemProperty -Path $regKey ProxyEnable -Value 0

        if([string]::IsNullOrWhitespace($acs))
        {
            $acs = "http://abc.com"
        }
        
        Set-ItemProperty -path $regKey AutoConfigURL -Value $acs
    }

    End
    {
        Write-Output "Proxy is now disabled"

        if($acs)
        {
            Write-Output "Automatic Configuration Script : $acs"
        }
        else
        {
            Write-Output "Automatic Configuration Script : Not Defined"
        }
    }
}