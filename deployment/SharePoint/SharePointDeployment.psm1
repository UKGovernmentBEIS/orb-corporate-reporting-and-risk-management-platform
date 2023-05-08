param (
    [Parameter(Position = 0)]
    [string]
    $ErrorActionOverride = $(throw "You must supply an error action preference"),

    [Parameter(Position = 1)]
    [string]
    $InformationOverride = $(throw "You must supply an information preference"),

    [Parameter(Position = 2)]
    [string]
    $VerboseOverride = $(throw "You must supply a verbose preference")
)

$ErrorActionPreference = $ErrorActionOverride
$InformationPreference = $InformationOverride
$VerbosePreference = $VerboseOverride

function Ensure-PnPPowerShell {
    If (-not (Get-Module SharePointPnPPowerShellOnline)) {
        Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
        Install-Module SharePointPnPPowerShellOnline -Scope CurrentUser -Force    
    }
}
function Connect-SharePointAsServicePrincipal {
    param(
        [Parameter(Mandatory)]
        [String]
        $ServicePrincipalClientId,
        [Parameter(Mandatory)]
        [String]
        $ServicePrincipalTenantId,
        [Parameter(Mandatory)]
        [String]
        $ServicePrincipalCertificate,
        [Parameter(Mandatory)]
        [String]
        $CertificateFilePath,
        [Parameter(Mandatory)]
        [String]
        $SiteUrl
    )

    Write-Verbose -Message:"Connecting to SharePoint using the given Service Principal ID and certificate."

    # Store App Principal certificate as a .pfx file
    # Use code from https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/deploy/azure-key-vault?view=azure-devops

    $kvSecretBytes = [System.Convert]::FromBase64String("$ServicePrincipalCertificate")
    $certCollection = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2Collection
    $certCollection.Import($kvSecretBytes, $null, [System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::Exportable)
    $password = [System.Guid]::NewGuid().ToString()
    $protectedCertificateBytes = $certCollection.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Pkcs12, $password)
    [System.IO.File]::WriteAllBytes($CertificateFilePath, $protectedCertificateBytes)

    # Connect to SharePoint using the App Principal credentials

    $securePassword = $password | ConvertTo-SecureString -AsPlainText -Force
    Connect-PnPOnline -Url $SiteUrl  -ClientId $ServicePrincipalClientId -Tenant $ServicePrincipalTenantId -CertificatePath $CertificateFilePath -CertificatePassword $securePassword
}

function Undo-PageCheckOut {
    param(
        [Parameter(Mandatory)]
        [String]
        $Url
    )

    $item = Get-PnPFile -Url $Url -AsListItem;
    $ctx = Get-PnPConnection;

    If ($null -ne $item -and $null -ne $item.FieldValues["CheckoutUser"]) {
        $item.File.UndoCheckOut();
        $ctx.Context.ExecuteQuery();
    }
}

function Apply-SiteTemplate {
    param(
        [Parameter(Mandatory)]
        [String]
        $Url,
        [Parameter(Mandatory)]
        [String]
        $AppIdUri,
        [Parameter(Mandatory)]
        [String]
        $ApiUrl,
        [Parameter(Mandatory)]
        [String]
        $TemplateName
    )

    $corporateReportingAppTitle = "Corporate Reporting Web Parts";

    # Install the Corporate Reporting Web Parts if they are not already installed

    Write-Verbose "Ensure that Corporate Reporting WebPart is present.";

    $corporateReportingApp = Get-PnPApp -Scope Site | Where-Object { $_.Title -eq $corporateReportingAppTitle };

    If ($null -eq $corporateReportingApp) {
        Throw "The Corporate Reporting Web Parts have not been deployed the to App Catalog.  Deploy the Web Parts and try again.";
    }

    If ($null -eq $corporateReportingApp.InstalledVersion) {
        $corporateReportingApp | Install-PnPApp -Scope Site;
    }

    # Discard any checkouts on the pages we will provision

    $serverRelativeUrl = (Get-PnPWeb).ServerRelativeUrl;
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-Benefits.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-Commitments.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-Dependencies.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-Directorates.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-Groups.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-KeyWorkAreas.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-Metrics.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-Milestones.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-PartnerOrganisationsRiskMitigationActions.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-PartnerOrganisationsRisks.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-PartnerOrgs.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-Workstreams.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-Projects.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-RiskMitigationActions.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-Risks.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/ReportingData-Workstreams.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/Welcome.aspx"

    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/admin/Administration-Administrators.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/admin/Administration-Attributes.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/admin/Administration-BenefitTypes.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/admin/Administration-MilestoneTypes.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/admin/Administration-ProjectAttributes.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/admin/Administration-Thresholds.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/admin/Administration-ThresholdAppetites.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/admin/Administration-RiskTypes.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/admin/Administration-Units.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/admin/Administration-UserDirectorates.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/admin/Administration-UserGroups.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/admin/Administration-UserPartnerOrgs.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/admin/Administration-UserProjects.aspx"
    Undo-PageCheckOut -Url "${serverRelativeUrl}/SitePages/admin/Administration-Users.aspx"

    # Parameter substitution does not appear to work for the JsonControlData attribute of the <CanvasControl> element
    # Perform substitution here instead

    ((Get-Content "$PSScriptRoot\$TemplateName") -replace "{parameter:appIdUrl}", $AppIdUri) `
        -replace "{parameter:apiUrl}", $ApiUrl `
    | Set-Content -Path corporate-reporting-updated-template.xml;

    # Apply the PnP Template for the site

    Write-Verbose "Applying PnP Template.";

    Set-PnPTraceLog -On -Level Debug
    Apply-PnPProvisioningTemplate -Path corporate-reporting-updated-template.xml -Parameters @{ "{parameter:appIdUrl}" = $AppIdUri; "{parameter:apiUrl}" = $ApiUrl };

    # The Admin Site Pages are in a separate folder named "admin" however the PnP Template puts them in the root folder
    # Move these files to the "admin" folder

    Move-PnPFile -ServerRelativeUrl "${serverRelativeUrl}/SitePages/Administration-Administrators.aspx" -TargetUrl "${serverRelativeUrl}/SitePages/admin/Administration-Administrators.aspx" -Force -OverwriteIfAlreadyExists;
    Move-PnPFile -ServerRelativeUrl "${serverRelativeUrl}/SitePages/Administration-Attributes.aspx" -TargetUrl "${serverRelativeUrl}/SitePages/admin/Administration-Attributes.aspx" -Force -OverwriteIfAlreadyExists;
    Move-PnPFile -ServerRelativeUrl "${serverRelativeUrl}/SitePages/Administration-BenefitTypes.aspx" -TargetUrl "${serverRelativeUrl}/SitePages/admin/Administration-BenefitTypes.aspx" -Force -OverwriteIfAlreadyExists;
    Move-PnPFile -ServerRelativeUrl "${serverRelativeUrl}/SitePages/Administration-ProjectAttributes.aspx" -TargetUrl "${serverRelativeUrl}/SitePages/admin/Administration-ProjectAttributes.aspx" -Force -OverwriteIfAlreadyExists;
    Move-PnPFile -ServerRelativeUrl "${serverRelativeUrl}/SitePages/Administration-Units.aspx" -TargetUrl "${serverRelativeUrl}/SitePages/admin/Administration-Units.aspx" -Force -OverwriteIfAlreadyExists;
    Move-PnPFile -ServerRelativeUrl "${serverRelativeUrl}/SitePages/Administration-MilestoneTypes.aspx" -TargetUrl "${serverRelativeUrl}/SitePages/admin/Administration-MilestoneTypes.aspx" -Force -OverwriteIfAlreadyExists;
    Move-PnPFile -ServerRelativeUrl "${serverRelativeUrl}/SitePages/Administration-Thresholds.aspx" -TargetUrl "${serverRelativeUrl}/SitePages/admin/Administration-Thresholds.aspx" -Force -OverwriteIfAlreadyExists;
    Move-PnPFile -ServerRelativeUrl "${serverRelativeUrl}/SitePages/Administration-ThresholdAppetites.aspx" -TargetUrl "${serverRelativeUrl}/SitePages/admin/Administration-ThresholdAppetites.aspx" -Force -OverwriteIfAlreadyExists;
    Move-PnPFile -ServerRelativeUrl "${serverRelativeUrl}/SitePages/Administration-RiskTypes.aspx" -TargetUrl "${serverRelativeUrl}/SitePages/admin/Administration-RiskTypes.aspx" -Force -OverwriteIfAlreadyExists;
    Move-PnPFile -ServerRelativeUrl "${serverRelativeUrl}/SitePages/Administration-UserDirectorates.aspx" -TargetUrl "${serverRelativeUrl}/SitePages/admin/Administration-UserDirectorates.aspx" -Force -OverwriteIfAlreadyExists;
    Move-PnPFile -ServerRelativeUrl "${serverRelativeUrl}/SitePages/Administration-UserGroups.aspx" -TargetUrl "${serverRelativeUrl}/SitePages/admin/Administration-UserGroups.aspx" -Force -OverwriteIfAlreadyExists;
    Move-PnPFile -ServerRelativeUrl "${serverRelativeUrl}/SitePages/Administration-UserPartnerOrgs.aspx" -TargetUrl "${serverRelativeUrl}/SitePages/admin/Administration-UserPartnerOrgs.aspx" -Force -OverwriteIfAlreadyExists;
    Move-PnPFile -ServerRelativeUrl "${serverRelativeUrl}/SitePages/Administration-UserProjects.aspx" -TargetUrl "${serverRelativeUrl}/SitePages/admin/Administration-UserProjects.aspx" -Force -OverwriteIfAlreadyExists;
    Move-PnPFile -ServerRelativeUrl "${serverRelativeUrl}/SitePages/Administration-Users.aspx" -TargetUrl "${serverRelativeUrl}/SitePages/admin/Administration-Users.aspx" -Force -OverwriteIfAlreadyExists;
}

function Create-SiteAppCatalog {
    param (
        [Parameter(Mandatory)]
        [string]
        $SiteUrl
    )

    $context = Get-PnPContext;

    # Find the list of Site with Site App Catalogs
    
    $appCatalogSites = $context.Web.TenantAppCatalog.SiteCollectionAppCatalogsSites;
    $context.Load($appCatalogSites)
    $context.ExecuteQuery()

    $targetSite = $appCatalogSites | Where-Object { $_.AbsoluteUrl -eq $siteUrl }

    # Check whether the Site already has a Site App Catalog and create one if not

    If ($targetSite.Length -eq 0) {
        Write-Information "Enable App Catalog at site collection $siteUrl"
        Add-PnPSiteCollectionAppCatalog -Site $siteUrl
    }
    Else {
        Write-Information "App Catalog already exists at site collection $siteUrl"
    }
}
