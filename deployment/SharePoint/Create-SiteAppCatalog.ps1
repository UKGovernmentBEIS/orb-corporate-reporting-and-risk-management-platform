###############################################################################################
# Create-SiteAppCatalog.ps1
#
# This script creates a Site Collection App Catalog for the Corporate Reporting SharePoint site.
# It must be run be a user with the following permissions:
#     * Full Control on the Site Collection to which the Site App Catalog should be added
#     * Full Control on the Tenant App Catalog
#
# Parameters:
#     SiteUrl: Url of SharePoint site for which a Site App Catalog is required
###############################################################################################

param(
    # The Site for which a Site App Catalog is required
    [Parameter(Mandatory)]
    [string]
    $siteUrl,
    # The SharePoint Admin Site
    [Parameter(Mandatory)]
    [string]
    $spAdminSiteUrl
)

$ErrorActionPreference = 'Stop'
$InformationPreference = 'Continue'

Import-Module -Name:"$PSScriptRoot\SharePointDeployment" -Force -ArgumentList:@(
    $ErrorActionPreference,
    $InformationPreference,
    $VerbosePreference
)

# Connect to the SharePoint Admin site

Connect-PnPOnline -Url $spAdminSiteUrl -UseWebLogin

# Check if the Site App Catalog already exists and create it if not

Create-SiteAppCatalog -SiteUrl $siteUrl
