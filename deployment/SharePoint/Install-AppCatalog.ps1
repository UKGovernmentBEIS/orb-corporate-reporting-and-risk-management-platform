param(
    # The path to the environment settings
    [Parameter(Mandatory)]
    [string]
    $Path
)

$ErrorActionPreference = 'Stop'
$InformationPreference = 'Continue'

$Parameters = Get-Content -Raw -Path $Path | ConvertFrom-Json

Connect-SPOService -Url:$Parameters.SharePointAdminUrl

Write-Information -Message:"Adding the site collection app catalog..."
Add-SPOSiteCollectionAppCatalog -Site:$Parameters.SharePointSiteCollectionUrl
