CREATE VIEW [reports].[UserAssociations]
AS
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'User Group' AS [Thing Type]
		,g.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.UserGroups AS ug ON u.ID = ug.UserID
	INNER JOIN dbo.Groups AS g ON ug.GroupID = g.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'User Directorate' AS [Thing Type]
		,d.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.UserDirectorates AS ud ON u.ID = ud.UserID
	INNER JOIN dbo.Directorates AS d ON ud.DirectorateID = d.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'User Project' AS [Thing Type]
		,p.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.UserProjects AS up ON u.ID = up.UserID
	INNER JOIN dbo.Projects AS p ON up.ProjectID = p.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Group' AS [Thing Type]
		,g.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Groups AS g ON u.ID = g.BusinessPartnerUserID OR u.ID = g.DirectorGeneralUserID OR u.ID = g.RiskChampionDeputyDirectorUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Directorate' AS [Thing Type]
		,d.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Directorates AS d ON u.ID = d.DirectorUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Project' AS [Thing Type]
		,p.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Projects AS p ON u.ID = p.SeniorResponsibleOwnerUserID OR u.ID = p.ProjectManagerUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Key Work Area' AS [Thing Type]
		,k.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.KeyWorkAreas AS k ON u.ID = k.LeadUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Work Stream' AS [Thing Type]
		,w.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.WorkStreams AS w ON u.ID = w.LeadUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Milestone' AS [Thing Type]
		,m.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Milestones AS m ON u.ID = m.LeadUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Metric' AS [Thing Type]
		,m.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Metrics AS m ON u.ID = m.LeadUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Benefit' AS [Thing Type]
		,b.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Benefits AS b ON u.ID = b.LeadUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Commitment' AS [Thing Type]
		,c.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Commitments AS c ON u.ID = c.LeadUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Dependency' AS [Thing Type]
		,d.Title AS [Thing]
FROM dbo.Users AS u 
	INNER JOIN dbo.Dependencies AS d ON u.ID = d.LeadUserID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Key Work Area Contributor' AS [Thing Type]
		,k.Title AS [Thing]
FROM dbo.Users AS u
	INNER JOIN dbo.Contributors AS c ON u.ID = c.ContributorUserID
	INNER JOIN dbo.KeyWorkAreas AS k ON c.KeyWorkAreaID = k.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Work Stream Contributor' AS [Thing Type]
		,w.Title AS [Thing]
FROM dbo.Users AS u
	INNER JOIN dbo.Contributors AS c ON u.ID = c.ContributorUserID
	INNER JOIN dbo.WorkStreams AS w ON c.WorkStreamID = w.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Milestone Contributor' AS [Thing Type]
		,m.Title AS [Thing]
FROM dbo.Users AS u
	INNER JOIN dbo.Contributors AS c ON u.ID = c.ContributorUserID
	INNER JOIN dbo.Milestones AS m ON c.MilestoneID = m.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Metric Contributor' AS [Thing Type]
		,m.Title AS [Thing]
FROM dbo.Users AS u
	INNER JOIN dbo.Contributors AS c ON u.ID = c.ContributorUserID
	INNER JOIN dbo.Metrics AS m ON c.MetricID = m.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Benefit Contributor' AS [Thing Type]
		,b.Title AS [Thing]
FROM dbo.Users AS u
	INNER JOIN dbo.Contributors AS c ON u.ID = c.ContributorUserID
	INNER JOIN dbo.Benefits AS b ON c.BenefitID = b.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Commitment Contributor' AS [Thing Type]
		,com.Title AS [Thing]
FROM dbo.Users AS u
	INNER JOIN dbo.Contributors AS c ON u.ID = c.ContributorUserID
	INNER JOIN dbo.Commitments AS com ON c.CommitmentID = com.ID
UNION
SELECT u.ID AS [User ID]
		,u.Title AS [Name]
		,u.Username AS [Username]
		,'Dependency Contributor' AS [Thing Type]
		,d.Title AS [Thing]
FROM dbo.Users AS u
	INNER JOIN dbo.Contributors AS c ON u.ID = c.ContributorUserID
	INNER JOIN dbo.Dependencies AS d ON c.DependencyID = d.ID