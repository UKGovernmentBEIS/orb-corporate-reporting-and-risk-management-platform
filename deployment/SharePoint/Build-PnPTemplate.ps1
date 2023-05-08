#######################################################################################
# Script: Deploy-PnPTemplate.ps1
#
# Deploys a PnP Provisioning Template for the Corporate Reporting site created using 
# the Build-PnPTemplate script.
#
# Parameters:
#     Url - the url of the SharePoint site to which the template should be applied
#     AppIdUri - the uri for the App Registration which the Corporate Reporting WebParts should use for authentication with the Web API
#     ApiUrl - the base url for the OData Web API
#     TemplateName - location of the PnP Provisioning Template to apply
#######################################################################################

Param (
    [string]$Url = "https://beisdigitalsvc.sharepoint.com/sites/CorporateReportingTest/",
    [string]$AppIdUri = "https://beisdigitalsvc.onmicrosoft.com/CorporateReportingAPITest",
    [string]$ApiUrl = "https://corporatereportingapitest.azurewebsites.net/odata",
    [string]$TemplateName = "corporate-reporting-template.xml"
)

$pages = @(
    "ReportingData-Directorates.aspx",
    "ReportingData-Benefits.aspx",
    "ReportingData-Commitments.aspx",
    "ReportingData-Dependencies.aspx",
    "ReportingData-Directorates.aspx",
    "ReportingData-Groups.aspx",
    "ReportingData-KeyWorkAreas.aspx",
    "ReportingData-Metrics.aspx",
    "ReportingData-Milestones.aspx",
    "ReportingData-Projects.aspx",
    "ReportingData-PartnerOrganisations.aspx",
    "ReportingData-PartnerOrganisationRisks.aspx",
    "ReportingData-PartnerOrganisationRiskMitigationActions.aspx",
    "ReportingData-Risks.aspx",
    "ReportingData-RiskMitigationActions.aspx",
    "ReportingData-WorkStreams.aspx",
    "admin/Administration-Administrators.aspx",
    "admin/Administration-Attributes.aspx",
    "admin/Administration-BenefitTypes.aspx",
    "admin/Administration-MilestoneTypes.aspx",
    "admin/Administration-ProjectAttributes.aspx",
    "admin/Administration-RiskTypes.aspx",
    "admin/Administration-Thresholds.aspx",
    "admin/Administration-ThresholdAppetites.aspx",
    "admin/Administration-Units.aspx",
    "admin/Administration-Users.aspx",
    "admin/Administration-UserDirectorates.aspx",
    "admin/Administration-UserGroups.aspx",
    "admin/Administration-UserPartnerOrganisations.aspx",
    "admin/Administration-UserProjects.aspx",
    "RiskRegister.aspx"
);

Connect-PnPOnline -Url $Url -Credentials (Get-Credential);

# Export site structure

Get-PnPProvisioningTemplate -Out $TemplateName -ExcludeHandlers Lists,Features,Fields,SiteSecurity -Force;

# Export pages hosting SPFx WebParts

$pageTemplates = @();

$pages | ForEach-Object { 
    $pageTemplate = Export-PnPClientSidePage -Identity $_;
    $pageTemplates += ([xml]$pageTemplate).Provisioning.Templates.ProvisioningTemplate.ClientSidePages.ClientSidePage;
}

$siteTemplate = [xml](Get-Content $TemplateName)
$clientSidePages = $siteTemplate.Provisioning.Templates.ProvisioningTemplate.ClientSidePages;

$pageTemplates | ForEach-Object {
    If ($_ -ne $null) {
	    $importNode = $clientSidePages.OwnerDocument.ImportNode($_, $true);
	    $clientSidePages.AppendChild($importNode) | Out-Null;
    }
}

# Modify the default settings so the template does not duplicate the items in the Left Nav menu when it is applied

$siteTemplate.Provisioning.Templates.ProvisioningTemplate.Navigation.CurrentNavigation.StructuralNavigation.RemoveExistingNodes = 'true';

# Write-out the modified XML neatly
# Based on https://devblogs.microsoft.com/powershell/format-xml/

$stringWriter = New-Object System.IO.StringWriter;
$xmlWriter = New-Object System.Xml.XmlTextWriter $stringWriter;
$xmlWriter.Formatting = "indented";
$xmlWriter.Indentation = 2;
$siteTemplate.WriteContentTo($xmlWriter);
$xmlWriter.Flush();
$stringWriter.Flush();

$stringWriter.ToString() | Set-Content -Path $TemplateName;

# Parameterise the page templates so we can modify the WebPart configuration when applying the templates to a new site

((Get-Content $TemplateName) -replace $AppIdUri,"{parameter:appIdUrl}") `
    -replace $ApiUrl,"{parameter:apiUrl}" `
    | Set-Content -Path $TemplateName;
