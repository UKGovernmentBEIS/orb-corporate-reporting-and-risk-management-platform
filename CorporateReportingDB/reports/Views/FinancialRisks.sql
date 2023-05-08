CREATE VIEW [reports].[FinancialRisks]
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
    CASE WHEN r.[OwnedByMultipleGroups] = 'true' THEN 'Central' 
        ELSE g.[Title] END AS [Group]
    , CASE WHEN r.[OwnedByMultipleGroups] = 'true' THEN 'Central'
        WHEN r.[OwnedByDgOffice] = 'true' THEN 'DG Office' 
        ELSE d.[Title] END AS [Directorate]
    , r.[Title] AS [Risk Name]
    , r.[RiskRegisteredDate] AS [Date Raised]
    , r.[StaffNonStaffSpend] AS [Staff/Non-staff spend]
    , RiskFundingClassifications.[FundingClassifications] AS [Funding Classifications]
    , RiskEconomicRingfences.[EconomicRingfences] AS [Economic Ringfences]
    , RiskPolicyRingfences.[PolicyRingfences] AS [Policy Ringfences]
    , r.[UniformChartOfAccountsID] AS [UCOA]
    , r.[RiskEventDescription] AS [Risk Event Description]
    , r.[RiskCauseDescription] AS [Risk Cause Description]
    , r.[RiskImpactDescription] AS [Risk Impact Description]
    , es.[Title] AS [Status]
FROM [dbo].[Risks] AS r LEFT OUTER JOIN
    [dbo].[Groups] AS g ON r.[GroupID] = g.[ID] LEFT OUTER JOIN
    [dbo].[Directorates] AS d ON r.[DirectorateID] = d.[ID] LEFT OUTER JOIN
    [dbo].[EntityStatuses] AS es ON r.[EntityStatusID] = es.[ID] LEFT OUTER JOIN
    RiskFundingClassifications ON r.[ID] = RiskFundingClassifications.[RiskID] LEFT OUTER JOIN
    RiskEconomicRingfences ON r.[ID] = RiskEconomicRingfences.[RiskID] LEFT OUTER JOIN
    RiskPolicyRingfences ON r.[ID] = RiskPolicyRingfences.[RiskID]
WHERE r.[Discriminator] = 'FinancialRisk' AND r.[EntityStatusID] = 1;
