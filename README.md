# ORB (Online Reporting in BEIS)
Formerly known as Corporate Reporting.  
  
A service for the Department for Business, Energy and Industrial Strategy (BEIS) to manage their internal performance and risk reporting process. 
Staff use the service to report their directorate's status, progress on projects and deliverables, and risk management.

## Components

This solution contains the following projects:

* corporate-reporting - A SharePoint Framework (SPFx) solution that provides the user interface for business users
* CorporateReportingDB - A database project containing the SQL scripts for the Corporate Reporting database
* ORB.API - A .NET Core API service that handles user access to the data store
* ORB.Core - Data models, interfaces etc for the ORB solution
* ORB.Data - Data access layer with repositories that apply user permissions
* ORB.Functions - Azure Functions that send reminder emails on a schedule
* ORB.IntegrationAPI - A set of .NET Core Azure Functions allowing partner organisations to submit reports to ORB
* ORB.IntegrationAPI.Tests - Unit tests for the Integration API
* ORB.Services - Service layer containing business logic for the application
* ORB.Services.Tests - Unit tests for the service layer

The deployment folder contains scripts to provision Azure resources for the environments in which the application runs.
  
## Prerequisites

- Create a Sharepoint Modern Team Site Collection
- Add a Site Collection App Catalog.

```ps
.\deployment\SharePoint\Install-AppCatalog.ps1 -Path:.\secrets\development.json -Verbose
```

##releases
6.1.3 : This fixed a bug where Partner Orgs needed to opens some modules before they could provide an update.