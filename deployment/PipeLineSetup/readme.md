## Create Environment Settings file

Create an enviroment settings file that holds all of the settings needed for the environment in the [Secrets](./Secrets) folder.
The secrets folder will not be uploaded to Git so if created there secrets can be added.

```json
{
    "Location": "uksouth",
    "Name": "<environment>-PipeLines",
    "CertificateName": "ServicePrincipalCertificate",
    "AzureSubscription": "Visual Studio Enterprise",
    "SharePointTenant": "<tenant>.onmicrosoft.com",
    "SharePointTenantId": "8a63c215-6698-4468-a9c7-169c0a701e78",
    "SharePoint" : "beisdigitalsvc.sharepoint.com",
    "DevOpsSpn" : "2d786bb7-27c6-4f59-9e3c-993c4a037ce6"
} 
```

The settings are used as follows:

* Location: The Azure Data Centre where the Resource Group and Key Vault will be created
* Name: The name of the Resource Group, Key Vault and SharePoint App Principal
* AzureSubscription: The name of the Azure Subscription in which the Resource Group and Key Vault will be created
* SharePointTenant: The Azure AD directory for the O365/SharePoint tenant
* SharePointTenantId: The id of the O365/SharePoint tenant
* SharePoint: The domain for the O365/SharePoint tenant
* DevOpsSpn: The SPN for the Azure DevOps Service Principal (this is used to grant permissions on the Key Vault)