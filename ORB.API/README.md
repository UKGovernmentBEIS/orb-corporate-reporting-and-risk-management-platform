// Issues using dotnet core 3.1
// -- Updated API to dotnet 5.0 which resolves these issues

// Loading Corporate/Financial Risks list
// https://localhost:5001/odata/CorporateRisks?$select=ID,RiskCode,Title&$orderby=Title&$expand=RiskRegister($select=Title),Directorate($expand=Group($select=Title);$select=Title),RiskOwnerUser($select=Title),ReportApproverUser($select=Title),RiskMitigationActions($select=ID),EntityStatus($select=Title),Contributors($select=ContributorUser;$expand=ContributorUser($select=Title))&$filter=EntityStatusID%20eq%201

Microsoft.AspNetCore.Diagnostics.DeveloperExceptionPageMiddleware: Error: An unhandled exception has occurred while executing the request.

System.InvalidOperationException: When called from 'VisitLambda', rewriting a node of type 'System.Linq.Expressions.ParameterExpression' must return a non-null value of the same type. Alternatively, override 'VisitLambda' and change it to not visit children of this type.





// Loading home page Corporate Risks
// https://localhost:5001/odata/CorporateRisks?$select=ID,Title,RiskCode,DirectorateID&$expand=Directorate($select=ID),Attributes($expand=AttributeType)&$orderby=RiskRegisterID,ID&$filter=(RiskOwnerUser/Username%20eq%20%27andrew.lott2@beisdigitalsvc.onmicrosoft.com%27%20or%20ReportApproverUser/Username%20eq%20%27andrew.lott2@beisdigitalsvc.onmicrosoft.com%27%20or%20Contributors/any(c:%20c/ContributorUser/Username%20eq%20%27andrew.lott2@beisdigitalsvc.onmicrosoft.com%27)%20or%20DirectorateID%20eq%201%20or%20DirectorateID%20eq%203)%20and%20EntityStatusID%20eq%201

Microsoft.AspNetCore.Diagnostics.DeveloperExceptionPageMiddleware: Error: An unhandled exception has occurred while executing the request.

System.InvalidOperationException: EF.Property called with wrong property name.