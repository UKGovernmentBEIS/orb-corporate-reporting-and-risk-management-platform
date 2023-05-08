######################################################################################################
# Script: grant-orb-integration-api-access.ps1
#
# This script grants apps access to the ORB Integration API
#
# Parameters:
#
#     1) The environment name
#     2) CSV file with apps
#
#       
#
######################################################################################################

param(
    [string]$env,
    [string]$appsCsv
)

# Set-up common resource names (execute in current shell)
# . set-resource-names $env

$orbIntegrationApiFunctionAppName = "$env-orb-integration-api"

Write-Host "Granting API access for $orbIntegrationApiFunctionAppName..."

$apiAppRegId = az ad app list --display-name "$orbIntegrationApiFunctionAppName" --query '[0].appId' --output tsv
$apiAppRoleId = az ad app list --display-name "$orbIntegrationApiFunctionAppName" --query "[0].appRoles[?displayName == 'Can invoke API'][].id" --output tsv

Import-Csv -Path $appsCsv | ForEach-Object {
    az ad app permission add --id $_.appId --api $apiAppRegId --api-permissions "$apiAppRoleId=Role"
    az ad app permission grant --id $_.appId --api $apiAppRegId
    Write-Host "Granted access to $($_.displayName)"
}   
