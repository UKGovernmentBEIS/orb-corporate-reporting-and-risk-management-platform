#########################################################################################
# Create-ApplicationUsers.ps1
#
# Sets-up permissions for the application Service Principals
#
# Parameters
#    * SourceEnvironment - The environment from which the database was migrated (dev, test or live)
#    * TargetEnvironment - The environment being configured
#    * AzureSubscription - The name of the Azure subscription to use
#
#########################################################################################

param(
    # The environment from which the database was migrated (dev, test or live)
    [Parameter(Mandatory)]
    [string]
    $sourceEnvironment,
    # The environment being configured
    [Parameter(Mandatory)]
    [string]
    $targetEnvironment,
    # The Azure Subscription to use
    [Parameter(Mandatory)]
    [string]
    $azureSubscription
)

$ErrorActionPreference = 'Stop'
$InformationPreference = 'Continue'

Function Add-AdGroupMember {
    param(
        # Object ID of the Group
        [Parameter(Mandatory)]
        [string]
        $groupId,
        # ObjectID of the account to add to the Group
        [Parameter(Mandatory)]
        [string]
        $memberId
    )

    $memberExistsInGroup = az ad group member check --group "$groupId" --member-id "$memberId" --query value --output tsv
    If ($memberExistsInGroup -eq "false") {
        Write-Information -MessageData:"Adding Member $memberId to group $groupId."
        az ad group member add --group "$groupId" --member-id "$memberId"
    } Else {
        Write-Information -MessageData:"Member $memberId already in group $groupId."
    }
}

Write-Information -MessageData:"Log into the Azure Tenancy"
az login
az account set --subscription "$azureSubscription"

$apiUserGroupName = "APP - U - Corporate Reporting - API Users"
$reportsUserGroupName = "APP - U - Corporate Reporting - Reports Users"
$supportUserGroupName = "APP - U - Corporate Reporting - Support Users"

$webApiServicePrincipalName = "$targetEnvironment-corp-reporting-api"
$functionAppServicePrincipalName = "$targetEnvironment-corp-reporting-reminders"

# Add the Service Principals for the Web API and Function App to the API Group

# Get the API Users Group

$apiUsersGroupObjectId = az ad group show --group $apiUserGroupName --query objectId --output tsv

# Add the Web API Service Principal to the Group (if necessary)

$webApiServicePrincipalObjectId = az ad sp list --all --query "[?displayName == '$webApiServicePrincipalName'].objectId" --output tsv
Add-AdGroupMember -groupId $apiUsersGroupObjectId -memberId $webApiServicePrincipalObjectId

# Add the Function App Service Principal to the Group (if necessary)

$functionAppServicePrincipalObjectId = az ad sp list --all --query "[?displayName == '$functionAppServicePrincipalName'].objectId" --output tsv
Add-AdGroupMember -groupId $apiUsersGroupObjectId -memberId $functionAppServicePrincipalObjectId

# Prepare the SQL script to execute

$sql = @()

If ($sourceEnvironment -eq "dev") {
    $sql += "IF USER_ID('Corporate Reporting (Dev) API Users') IS NOT NULL BEGIN DROP USER [Corporate Reporting (Dev) API Users] END"
    $sql += "IF USER_ID('Corporate Reporting (Dev) Reports Users') IS NOT NULL BEGIN DROP USER [Corporate Reporting (Dev) Reports Users] END"
} ElseIf ($sourceEnvironment -eq "test") {
    $sql += "IF USER_ID('Corporate Reporting (Test) Reports Users') IS NOT NULL BEGIN DROP USER [Corporate Reporting (Test) Reports Users] END"
    $sql += "IF USER_ID('Corporate Reporting (Test) API Users') IS NOT NULL BEGIN DROP USER [Corporate Reporting (Test) API Users] END"
} ElseIf ($sourceEnvironment -eq "live") {
    $sql += "IF USER_ID('apiuser') IS NOT NULL BEGIN DROP USER [apiuser] END"
} Else {
    throw "Unexpected value for SourceEnvironment parameter"
}

$sql += "IF USER_ID('$apiUserGroupName') IS NULL BEGIN CREATE USER [$apiUserGroupName] FROM EXTERNAL PROVIDER END"
$sql += "ALTER ROLE api_user ADD MEMBER [$apiUserGroupName];"
$sql += "IF USER_ID('$reportsUserGroupName') IS NULL BEGIN CREATE USER [$reportsUserGroupName] FROM EXTERNAL PROVIDER END"
$sql += "ALTER ROLE reports_reader ADD MEMBER [$reportsUserGroupName];"
$sql += "IF USER_ID('$supportUserGroupName') IS NULL BEGIN CREATE USER [$supportUserGroupName] FROM EXTERNAL PROVIDER END"
$sql += "ALTER ROLE db_datareader ADD MEMBER [$supportUserGroupName];"

Write-Information -Message:"Execute SQL script for appropriate environment (based on the database that was migrated into the target environment)"
$serverName =  "$targetEnvironment-corp-reporting-sql.database.windows.net"
$databaseName = "$targetEnvironment-corp-reporting-db"
$connString = "Data Source=$($serverName);Initial Catalog=$($databaseName);"
$conn = New-Object System.Data.SqlClient.SQLConnection($connString)
$accessToken = az account get-access-token --resource https://database.windows.net/ --query accessToken --output tsv
$conn.AccessToken = $accessToken

Try {
    $conn.Open()
    $cmd = $conn.CreateCommand()
    $sql | ForEach-Object {
        $cmd.CommandText = $_
        $cmd.ExecuteNonQuery()    
    }
}
Finally {
    $conn.Close()
}
