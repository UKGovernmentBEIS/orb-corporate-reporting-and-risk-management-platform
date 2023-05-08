## Create Environment Settings file

Create an enviroment settings file that holds all of the settings needed for the environment in the [Secrets](./Secrets) folder.
The secrets folder will not be uploaded to Git.

```json
{
    "ServerName": "deploy-corp-reporting-sql.database.windows.net",
    "DatabaseName": "deploy-corp-reporting-db",
    "SourceEnvironment": "dev",
    "TargetEnvironment": "deploy",
    "Username": "Azure AD username",
    "Password": "Azure AD password"
} 
```

The settings are used as follows:

* ServerName: Name of the target Azure SQL server
* DatabaseName: Name of the target Azure SQL database
* SourceEnvironment: Environment from which the database was migrated (one of: dev, test or live)
* TargetEnvironment: Target environment
* Username: Username of an Azure AD Admin for the database
* Password: Password of Azure AD Admin