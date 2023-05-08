#######################################################################################
# Script: Deploy-PnPTemplate.ps1
#
# Deploys a PnP Provisioning Template for the Corporate Reporting site created using 
# the Build-PnPTemplate script.
#
# This script is intended to be run from Azure DevOps.  It requires parameters to be passed as Environment Variables.
#
# Parameters:
#     ServicePrincipalClientId - Client ID of the Service Principal to use to connect to SharePoint
#     ServicePrincipalTenantId - Tenant ID of Azure tenancy where Service Principal is located
#     ServicePrincipalCertificate - Service Principal Certificate (in base64 format)
#     CertificateFilePath - Location where the certificate can be stored temporarily
#     SiteUrl - the url of the SharePoint site to which the template should be applied
#     AppIdUri - the uri for the App Registration which the Corporate Reporting WebParts should use for authentication with the Web API
#     ApiUrl - the base url for the OData Web API
#     TemplateName - location of the PnP Provisioning Template to apply
#######################################################################################

$ErrorActionPreference = 'Stop'
$InformationPreference = 'Continue'

Import-Module -Name:"$PSScriptRoot\SharePointDeployment" -Force -ArgumentList:@(
    $ErrorActionPreference,
    $InformationPreference,
    $VerbosePreference
)

Write-Information -Message:"Check that PnP PowerShell is installed"

Ensure-PnPPowerShell

Write-Information -Message:"Log into SharePoint"

Connect-SharePointAsServicePrincipal `
    -ServicePrincipalClientId:$env:ServicePrincipalClientId `
    -ServicePrincipalTenantId:$env:ServicePrincipalTenantId `
    -ServicePrincipalCertificate:$env:ServicePrincipalCertificate `
    -CertificateFilePath:$env:CertificateFilePath `
    -SiteUrl:$env:SiteUrl `
    -Verbose:$VerbosePreference

Write-Information -Message:"Apply the SharePoint site template"

Apply-SiteTemplate `
    -Url:$env:SiteUrl `
    -AppIdUri:$env:AppIdUri `
    -ApiUrl:$env:ApiUrl `
    -TemplateName:$env:TemplateName `
    -Verbose:$VerbosePreference

Write-Information -Message:"Completed"