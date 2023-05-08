CREATE VIEW [reports].[PartnerOrganisationRisksMitigationActions]
AS
WITH RiskTypesForRisk AS
(SELECT por.ID AS PartnerOrganisationRiskID, STRING_AGG(rt.Title, ',') WITHIN GROUP (ORDER BY rt.Title) AS RiskTypes
FROM dbo.PartnerOrganisationRisks por
JOIN dbo.PartnerOrganisationRiskRiskTypes porrt ON porrt.PartnerOrganisationRiskID = por.ID
JOIN dbo.RiskTypes rt ON rt.ID = porrt.RiskTypeID
GROUP BY por.ID
)
SELECT 
    po.Title AS [Partner Organisation]	 
	,por.Title AS [Risk Name]
	,poRiskTypes.RiskTypes AS [Risk Type] 
    ,porma.Title AS [Risk Mitigation]
    ,porma.Description AS [Description]
    ,ownr.Title AS [Mitigating Action Owner]
    ,(SELECT STRING_AGG(cusr.Title, ', ') FROM dbo.Contributors c LEFT OUTER JOIN
    dbo.Users cusr ON cusr.ID = c.ContributorUserID
     WHERE PartnerOrganisationRiskMitigationActionID = porma.ID ) AS [Contributors]
	,ISNULL(porma.ActualDate, porma.ForecastDate) AS [Delivery date]
    ,CASE
		WHEN porma.ActionIsOngoing = 'true' THEN 'Yes'
		ELSE 'No'
	 END AS [Ongoing Action]
FROM dbo.PartnerOrganisationRiskMitigationActions porma LEFT OUTER JOIN
    dbo.PartnerOrganisationRisks por ON porma.PartnerOrganisationRiskID = por.ID LEFT OUTER JOIN
	dbo.PartnerOrganisations po ON po.ID = por.PartnerOrganisationID LEFT OUTER JOIN
    dbo.Users ownr ON porma.OwnerUserID = ownr.ID LEFT OUTER JOIN
    RiskTypesForRisk AS poRiskTypes ON por.ID = poRiskTypes.PartnerOrganisationRiskID
    