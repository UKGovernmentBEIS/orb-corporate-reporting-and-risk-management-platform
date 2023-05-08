param (
    [Parameter(Position=0)]
    [string]
    $ErrorActionOverride = $(throw "You must supply an error action preference"),

    [Parameter(Position=1)]
    [string]
    $InformationOverride = $(throw "You must supply an information preference"),

    [Parameter(Position=2)]
    [string]
    $VerboseOverride = $(throw "You must supply a verbose preference")
)

$ErrorActionPreference = $ErrorActionOverride
$InformationPreference = $InformationOverride
$VerbosePreference = $VerboseOverride

function Set-AzureResourceGroup {
    param(
        [Parameter(Mandatory)]
        [String]
        $Name,
        [Parameter(Mandatory)]
        [String]
        $CertificateName,
        [Parameter(Mandatory)]
        [String]
        $Location
    )

    Write-Verbose -Message:"Creating the $Name resource group."
    az group create --name $Name --location $Location | Out-Null

    Write-Verbose -Message:"Creating the $Name key vault."
    az keyvault create --name $Name --resource-group $Name | Out-Null

    Write-Information -Message:"Checking for existing $CertificateName certificate"
    $keyValueCertificates = az keyvault certificate list --vault-name $Name --include-pending $true --query "[?id == 'https://$($Name.ToLower()).vault.azure.net/certificates/$CertificateName']" | ForEach-Object { $PSItem -join '' } | ConvertFrom-Json
    $keyValueCertificates | ForEach-Object {
        $keyValueCertificate = $PSItem
        Write-Information -Message:"Disabling the $($keyValueCertificate.id) certificate"
        az keyvault certificate set-attributes --id $($keyValueCertificate.id) --vault-name $Name --enabled $false | Out-Null
    }

    Write-Information -Message:"Creating the $CertificateName certificate"
    az keyvault certificate create --vault-name $Name --name $CertificateName --policy "`@$PSScriptRoot\defaultpolicy.json" --validity 24 | Out-Null

    $certificateHash = az keyvault certificate show --vault-name $Name --name $CertificateName | ForEach-Object { $PSItem -join '' } | ConvertFrom-Json

    Write-Output @{
        CertificateKeyValue = $certificateHash.cer
    }
}

function Set-ApplicationRegistration {
    param(
        [Parameter(Mandatory)]
        [string]
        $Name,
        [Parameter(Mandatory)]
        [string]
        $CertificateKeyValue
    )

    $ErrorActionPreference = 'Stop'
    $InformationPreference = 'Continue'

    Write-Verbose -Message:"Getting the $Name application registration."
    $AppRegistration = az ad app list --query "[?displayName == '$Name']" | ForEach-Object { $PSItem -join '' } | ConvertFrom-Json | Select-Object -First 1
    if (-not $AppRegistration) {
        Write-Verbose -Message:"Creating the $Name App Registration."
        $AppRegistration = az ad app create --display-name $Name --identifier-uris https://$Name --required-resource-accesses "$PSScriptRoot\requiredResourceManifest.json" |
        ForEach-Object { $PSItem -join '' } |
        ConvertFrom-Json
    }

    Write-Information -Message:"Granting Admin Consent."
    az ad app permission admin-consent --id $($AppRegistration.appId) | Out-Null

    Write-Information -Message:"Updating KeyCredentials"
    az ad app update --id "$($AppRegistration.appId)" --key-type "AsymmetricX509Cert" --key-usage "Verify" --key-value "$CertificateKeyValue" | Out-Null

    Write-Output @{
        ClientId = $AppRegistration.appId
    } 
}

function Set-AzureKeyVaultSecrets {
    param(
        # The Key Vault Name
        [Parameter(Mandatory)]
        [string]
        $Name,

        # The secrets
        [Parameter(Mandatory)]
        $Secrets
    )

    $Secrets.Keys | ForEach-Object {
        $Key = $PSItem
    
        Write-Verbose -Message:"Checking the $Name key vault $Key secret."
        $ExistKeyVaultSecret = az keyvault secret list --vault-name $Name --query "[?id == 'https://$Name.vault.azure.net/secrets/$Key']" | ForEach-Object { $PSItem -join '' } | ConvertFrom-Json | Select-Object -First 1
        if ($ExistKeyVaultSecret) {
            Write-Verbose -Message:"Disabling the $Name key vault $Key secret's previous value."
            az keyvault secret set-attributes --name $Key --vault-name $Name --enabled $false | Out-Null
        }
        
        Write-Verbose -Message:"Adding the $Name key vault $Key secret."
        az keyvault secret set --name $Key --vault-name $Name --value $Secrets[$Key] | Out-Null
    }
}

function Grant-AzureKeyVaultAccess {
    param(
        # The Key Vault Name
        [Parameter(Mandatory)]
        [string]
        $Name,

        # The SPN of the Service Principal to which access will be granted
        [Parameter(Mandatory)]
        [string]
        $Spn
    )

#    $spnObjectId = az ad sp list --query "[?servicePrincipalNames[?contains(@, '$Spn')]].objectId" --all | `
#        ConvertFrom-Json

    Write-Verbose -Message:"Granting permissions on the $Name key vault to $Spn"
    az keyvault set-policy --name $Name --spn $Spn --certificate-permissions get list --secret-permissions get list | Out-Null
}