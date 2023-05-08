#######################################################################################
# Script: Set-SinglePartAppPages.ps1
#
# Sets all app pages on the Corporate Reporting site to single part app pages.
#
# This script is intended to be run from Azure DevOps.  It requires parameters to be passed as Environment Variables.
#
# Parameters:
#     ServicePrincipalClientId - Client ID of the Service Principal to use to connect to SharePoint
#     ServicePrincipalTenantId - Tenant ID of Azure tenancy where Service Principal is located
#     ServicePrincipalCertificate - Service Principal Certificate (in base64 format)
#     CertificateFilePath - Location where the certificate can be stored temporarily
#     SiteUrl - the URL of the SharePoint site to set the pages
#######################################################################################

$ErrorActionPreference = 'Stop';
$InformationPreference = 'Continue';

Import-Module -Name:"$PSScriptRoot\SharePointDeployment" -Force -ArgumentList:@(
    $ErrorActionPreference,
    $InformationPreference,
    $VerbosePreference
)

Write-Information -Message:"Check that PnP PowerShell is installed";

Ensure-PnPPowerShell;

Write-Information -Message:"Log in to SharePoint";

Connect-SharePointAsServicePrincipal `
    -ServicePrincipalClientId:$env:ServicePrincipalClientId `
    -ServicePrincipalTenantId:$env:ServicePrincipalTenantId `
    -ServicePrincipalCertificate:$env:ServicePrincipalCertificate `
    -CertificateFilePath:$env:CertificateFilePath `
    -SiteUrl:$env:SiteUrl `
    -Verbose:$VerbosePreference;

Write-Information -Message:"Set app pages to single part app pages";

$pages = "ReportingData-Benefits.aspx",
    "ReportingData-Commitments.aspx",
    "ReportingData-Dependencies.aspx",
    "ReportingData-Directorates.aspx",
    "ReportingData-Groups.aspx",
    "ReportingData-KeyWorkAreas.aspx",
    "ReportingData-Metrics.aspx",
    "ReportingData-Milestones.aspx",
    "ReportingData-PartnerOrganisationsRiskMitigationActions.aspx",
    "ReportingData-PartnerOrganisationsRisks.aspx",
    "ReportingData-PartnerOrgs.aspx",
    "ReportingData-Workstreams.aspx",
    "ReportingData-Projects.aspx",
    "ReportingData-RiskMitigationActions.aspx",
    "ReportingData-Risks.aspx",
    "ReportingData-Workstreams.aspx",
    "Welcome.aspx",
    "admin/Administration-Administrators.aspx",
    "admin/Administration-Attributes.aspx",
    "admin/Administration-BenefitTypes.aspx",
    "admin/Administration-MilestoneTypes.aspx",
    "admin/Administration-ProjectAttributes.aspx",
    "admin/Administration-Thresholds.aspx",
    "admin/Administration-ThresholdAppetites.aspx",
    "admin/Administration-RiskTypes.aspx",
    "admin/Administration-Units.aspx",
    "admin/Administration-UserDirectorates.aspx",
    "admin/Administration-UserGroups.aspx",
    "admin/Administration-UserPartnerOrgs.aspx",
    "admin/Administration-UserProjects.aspx",
    "admin/Administration-Users.aspx";

$pages | ForEach-Object {
    $page = Set-PnPClientSidePage -Identity $_ -LayoutType SingleWebPartAppPage;
    Write-Information "Page '$($page.PageTitle)' ($_) set to single part app page";

    # Replace web part to ensure unique InstanceId for web part on each page
    $webPart = Get-PnPClientSideComponent -Page $_;
    $webPartPropsJson = $webPart.PropertiesJson;
    Remove-PnPClientSideComponent -Page $_ -InstanceId $webPart.InstanceId -Force;
    if ($_.Substring(0, 5) -eq "Repor") {
        $component = "CR - Reference Data Admin";
    }
    if ($_.Substring(0, 5) -eq "Welco") {
        $component = "CR - My Progress Updates";
    }
    if ($_.Substring(0, 5) -eq "admin") {
        $component = "CR - System Administration";
    }
    $newWebPartInstance = Add-PnPClientSideWebPart -Page $_ -Component $component;
    Set-PnPClientSideWebPart -Page $_ -Identity $newWebPartInstance.InstanceId -PropertiesJson $webPartPropsJson;
    Write-Information "$component replaced"
}

Write-Information -Message:"Completed";