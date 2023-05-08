CREATE VIEW [reports].[FinancialRiskReports]
AS
WITH RiskFundingClassifications AS
(SELECT r.[ID] AS [RiskID], STRING_AGG(fcs.value, ', ') AS [FundingClassifications]
FROM [dbo].[Risks] AS r
CROSS APPLY OPENJSON(r.[FundingClassification]) AS fcs
GROUP BY r.ID),
RiskEconomicRingfences AS
(SELECT r.[ID] AS [RiskID], STRING_AGG(erf.value, ', ') AS [EconomicRingfences]
FROM [dbo].[Risks] AS r
CROSS APPLY OPENJSON(r.[EconomicRingfence]) AS erf
GROUP BY r.ID),
RiskPolicyRingfences AS
(SELECT r.[ID] AS [RiskID], STRING_AGG(prf.value, ', ') AS [PolicyRingfences]
FROM [dbo].[Risks] AS r
CROSS APPLY OPENJSON(r.[PolicyRingfence]) AS prf
GROUP BY r.ID)
  SELECT
    so.[ReportMonth] AS [Report Period]
    , CASE WHEN report.[OwnedByMultipleGroups] = 'true' THEN 'Central' 
        ELSE report.[Group] END AS [Group]
    , CASE WHEN report.[OwnedByMultipleGroups] = 'true' THEN 'Central'
        WHEN report.[OwnedByDgOffice] = 'true' THEN 'DG Office' 
        ELSE report.[Directorate] END AS [Directorate]
    , report.[RiskTitle] AS [Risk Name]
    , report.[RiskRegisteredDate] AS [Date Raised]
    , report.[StaffNonStaffSpend] AS [Staff/Non-staff spend]
    , RiskFundingClassifications.[FundingClassifications] AS [Funding Classifications]
    , RiskEconomicRingfences.[EconomicRingfences] AS [Economic Ringfences]
    , RiskPolicyRingfences.[PolicyRingfences] AS [Policy Ringfences]
    , report.[UniformChartOfAccountsID] AS [UCOA]
    , report.[FY0] AS [FY0]
    , report.[FY1] AS [FY1]
    , report.[FY2] AS [FY2]
    , report.[FY3] AS [FY3]
    , report.[FY4] AS [FY4]
    , report.[RiskEventDescription] AS [Risk Event Description]
    , report.[RiskCauseDescription] AS [Risk Cause Description]
    , report.[RiskImpactDescription] AS [Risk Impact Description]
    , report.[ImpactLevel] AS [Impact Level]
    , report.[Probability] AS [Probability]
    , report.[RAG] AS [RAG]
    , RiskActions.[ActionID] AS [Action ID]
    , RiskActions.[ActionTitle] AS [Action Title]
    , RiskActions.[ActionOwner] AS [Action Owner]
    , RiskActions.[ActionRag] AS [Action RAG]
    , RiskActions.[ActionComment] AS [Action Comment]
FROM
    [dbo].[SignOffs] AS so INNER JOIN
    [dbo].[Risks] AS r ON so.[RiskID] = r.[ID] LEFT OUTER JOIN
    RiskFundingClassifications ON so.[RiskID] = RiskFundingClassifications.[RiskID] LEFT OUTER JOIN
    RiskEconomicRingfences ON so.[RiskID] = RiskEconomicRingfences.[RiskID] LEFT OUTER JOIN
    RiskPolicyRingfences ON so.[RiskID] = RiskPolicyRingfences.[RiskID]
 CROSS APPLY OPENJSON(so.[ReportJson]) 
  WITH (
    [Group] NVARCHAR(MAX) '$.Risk.Group.Title',
    [OwnedByMultipleGroups] BIT '$.Risk.OwnedByMultipleGroups',
    [Directorate] NVARCHAR(MAX) '$.Risk.Directorate.Title',
    [OwnedByDgOffice] BIT '$.Risk.OwnedByDgOffice',
    [RiskTitle] NVARCHAR(MAX) '$.Risk.Title',
    [RiskRegisteredDate] DATETIME2(0) '$.Risk.RiskRegisteredDate',
    [StaffNonStaffSpend] NVARCHAR(MAX) '$.Risk.StaffNonStaffSpend',
    [UniformChartOfAccountsID] NVARCHAR(MAX) '$.Risk.UniformChartOfAccountsID',
    [FY0] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].Measurements.SpendProfile.FinancialYear0',
    [FY1] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].Measurements.SpendProfile.FinancialYear1',
    [FY2] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].Measurements.SpendProfile.FinancialYear2',
    [FY3] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].Measurements.SpendProfile.FinancialYear3',
    [FY4] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].Measurements.SpendProfile.FinancialYear4',
    [RiskEventDescription] NVARCHAR(MAX) '$.Risk.RiskEventDescription',
    [RiskCauseDescription] NVARCHAR(MAX) '$.Risk.RiskCauseDescription',
    [RiskImpactDescription] NVARCHAR(MAX) '$.Risk.RiskImpactDescription',
    [ImpactLevel] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].RiskImpactLevel.Title',
    [Probability] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].RiskProbability.Title',
    [RAG] NVARCHAR(MAX) '$.Risk.RiskUpdates[0].RagOptionID',
    [Actions] NVARCHAR(MAX) '$.RiskMitigationActions' AS JSON
    ) AS report
    CROSS APPLY OPENJSON(report.Actions)
        WITH (
            [ActionID] int '$.ID',
            [ActionTitle] nvarchar(255) '$.Title',
            [ActionOwner] nvarchar(255) '$.OwnerUser.Title',
            [ActionRag] int '$.RiskMitigationActionUpdates[0].RagOptionID',
            [ActionComment] nvarchar(500) '$.RiskMitigationActionUpdates[0].Comment'
        ) AS RiskActions 
WHERE r.[Discriminator] = 'FinancialRisk' AND so.[IsCurrent] = 'true';
