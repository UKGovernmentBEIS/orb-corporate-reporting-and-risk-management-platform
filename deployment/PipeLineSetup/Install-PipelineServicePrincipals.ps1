param(
    # The path to the environment settings
    [Parameter(Mandatory)]
    [string]
    $Path
)

$ErrorActionPreference = 'Stop'
$InformationPreference = 'Continue'

Import-Module -Name:"$PSScriptRoot\PipeLines" -Force -ArgumentList:@(
    $ErrorActionPreference,
    $InformationPreference,
    $VerbosePreference
)

$Parameters = Get-Content -Raw -Path $Path | ConvertFrom-Json
az account set --subscription "$($Parameters.AzureSubscription)"

$AzureValues = Set-AzureResourceGroup -Name:$Parameters.Name -CertificateName:$Parameters.CertificateName -Location:$Parameters.Location -Verbose:$VerbosePreference
$SharePointValues = Set-ApplicationRegistration -Name:$Parameters.Name @AzureValues -Verbose:$VerbosePreference

Set-AzureKeyVaultSecrets `
    -Name:$Parameters.Name `
    -Secrets:@{
        ClientId = $SharePointValues.ClientId;
        TenantId = $Parameters.SharePointTenantId
    } `
    -Verbose:$VerbosePreference

# Grant the DevOps Service Principal permissions to view the contents of the Key Vault

Grant-AzureKeyVaultAccess `
    -Spn:$Parameters.DevOpsSpn `
    -Name:$Parameters.Name `
    -Verbose:$VerbosePreference
