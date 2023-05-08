###############################################################################################
# Tidy-WebApiPermissionRequests.ps1
#
# This script cleans-up outstanding Web API Permission Requests for the Corporate Reporting SPFx WebParts.
# It approves the Web API Request if it has not already been approved.
# Otherwise, it rejects (deletes) the Web API Permission Request.
#
# Parameters:
#     SpAdminSiteUrl: Url of SharePoint Admin site
#     ResourceName: Name of the resource (App Registration) that the SPFx WebParts are trying to access
#     Scope: Name of the scope that the SPFx WebParts are trying to use (normally user_impersonation)
###############################################################################################

param(
    # The path to the environment settings
    [Parameter(Mandatory)]
    [string]
    $spAdminSiteUrl,
    [Parameter(Mandatory)]
    [string]
    $resourceName,
    [Parameter(Mandatory)]
    [string]
    $scope
)

$ErrorActionPreference = 'Stop'
$InformationPreference = 'Continue'

# Connect to the SharePoint admin site

Write-Information -Message:"Log into the SharePoint Tenancy"
Connect-SPOService -Url $spAdminSiteUrl

# Check whether an equivalent Web API Permission Request has already been approved

$grants = Get-SPOTenantServicePrincipalPermissionGrants | Where-Object { $_.ConsentType -eq "AllPrincipals" -and $_.Resource -eq $resourceName -and $_.Scope -eq $scope }
$approvalRequired = $grants.Length -eq 0

# Approve the pending Web API Permission Request for the SPFx Webparts

Get-SPOTenantServicePrincipalPermissionRequests  | `
    Where-Object { $_.PackageName -eq "Corporate Reporting Web Parts" -and $_.Resource -eq $resourceName -and $_.Scope -eq $scope } | `
    ForEach-Object {
        If ($approvalRequired -eq $true) {
            Approve-SPOTenantServicePrincipalPermissionRequest -RequestId $_.Id
        } Else {
            # Since an equivalent Web API Permission Request has already been approved, we cannot approve another one
            # Denying the request will not remove the current permissions but will tidy-up the request queue
            Deny-SPOTenantServicePrincipalPermissionRequest -RequestId $_.Id
        }
    }
