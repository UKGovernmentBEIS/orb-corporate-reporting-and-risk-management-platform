# ORB - Online Corporate Reporting and Risk Management
 
A service for the former Department for Business, Energy and Industrial Strategy (BEIS) to manage their internal performance and risk reporting process. This has now been moved to the Dept of Energy Security and Net Zero.
Staff use the service to report their directorate's status, progress on projects and deliverables, and risk management.

## Components

This solution contains the following projects:

* corporate-reporting - A SharePoint Framework (SPFx) solution that provides the user interface for business users
* CorporateReportingDB - A database project containing the SQL scripts for the Corporate Reporting database
* ORB.API - A .NET Core API service that handles user access to the data store
* ORB.Core - Data models, interfaces etc for the ORB solution
* ORB.Data - Data access layer with repositories that apply user permissions
* ORB.Functions - Azure Functions that send reminder emails on a schedule
* ORB.Services - Service layer containing business logic for the application
* ORB.Services.Tests - Unit tests for the service layer

## Build and run in a local development PC

The deployment folder contains scripts to provision Azure resources for deployments to test, refbuild and production. Following the instructions below to build and run the platform on a development machine.

## Required technical stack
To build, run and support the platform you need staff with the following technical knowledge.
1. Frontend ( SharePoint general usability, developing and deploying SharePoint web parts, Typescript, React, MS Visual Studio Code, Node JS, NPM, Postman, PowerBI & Gulp )
2. Backend ( C#, Visual Studio, Azure APIs, Azure Functions, Azure AD, Azure SQL and .Net 6 )
3. DevOps (Microsoft DevOps, PowerShell, SharePoint PnP and Git)
4. Sector (Corporate Projects Management, Corporate risk management)

  
## Required Software & SDK
To successfully run the application, ensure you have the following software and SDK installed:

1. .NET Core 6.0 SDK
2. Visual Studio 2022 or Visual Studio Code
3. SQL Server Management Studio 2016+
4. SharePoint Framework development environment, including tools like Node.js, Gulp, Yeoman, and the Yeoman SharePoint generator. For detailed instructions, refer to: [Set up your development environment](https://learn.microsoft.com/en-us/sharepoint/dev/spfx/set-up-your-development-environment)

## App Major Parts
The application consists of the following major components:

1. Web API
2. SharePoint client web part

## Build and run the Web API
To run the Web API, follow the steps below.
1. Open ORB.sln to open the solution in your Visual Studio.
2. The CorporateReportingDB project contains all the necessary database scripts. Set up your local database using these scripts.
3. ORB.API is the main Web API project. Before running the API configure appsettings.json using details below.
4. Set the database connection string ConnectionStrings. 
5. Set SharePoint site URL CorsOrigin.
6. Configure AzureAd settings (Instance, TenantId, ClientId, and Audience). To do this, go to portal.azure.com, navigate to Azure Active Directory, and register a new app for your API. Obtain the TenantId, ClientId, and Audience from your app registration. For the Instance value, you can use "https://login.microsoftonline.com".
7. After configuring these settings, insert the first user into your database in the Users table.
8. You can now run the Web API. Simply run the ORB.API project.

## Build, configure and run the SharePoint Client Web Part
To run the SharePoint client web part, follow the steps below.

1. Inside the main folder, you'll find a folder named "corporate-reporting" which contains your SharePoint client web part.
2. Open this folder in Visual Studio Code.
3. Open the command prompt/terminal and run `npm i` to install all the required Node packages.
4. Open Config/serve.json and set `initialPage` to `[your_sharepoint_site_url]/_layouts/15/workbench.aspx`.
5. Run the command `gulp serve` to start the workbench, and it will open the URL mentioned in the previous step in your browser.
6. Add the web part (ORB) by clicking the "+" icon on your workbench page.
7. Set the App ID URI and API URL. You can obtain the App ID URI from your app registration, and the API URL is your Web API URL ending with "/odata" (e.g., http://localhost:61000/odata).
8. Apply the changes, and you are ready to go. Enjoy!
