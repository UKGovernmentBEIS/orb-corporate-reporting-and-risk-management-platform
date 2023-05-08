# ORB.Data

## Database first scaffolding
`dotnet ef dbcontext scaffold "Server=localhost\SQLEXPRESS;Database=CorporateReportingDB;Trusted_Connection=True;" Microsoft.EntityFrameworkCore.SqlServer --output-dir Models --context OrbContext --context-dir Context --force --schema dbo`

EF6-like conventions applied by package Bricelam.EntityFrameworkCore.Pluralizer. Still changes ID to Id.  

var connection = (SqlConnection)Database.GetDbConnection();  
if (!connection.ConnectionString.ToLower().Contains("integrated security"))  
{  
    connection.AccessToken = (new Microsoft.Azure.Services.AppAuthentication.AzureServiceTokenProvider()).GetAccessTokenAsync("https://database.windows.net/").Result;  
}  
