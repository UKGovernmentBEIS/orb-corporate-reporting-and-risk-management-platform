CREATE VIEW [drafts].[ProjectUpdates]
AS
  SELECT g.Title AS [Group]
		, d.Title AS [Directorate]
		, p.Title AS [Project]
		, p.ID AS [ID]
		, Months.UpdatePeriod AS [Report Month]
		, SROUser.Title AS [SRO]
		, ProjectManagerUser.Title AS [Project Manager]
		, UpdateAuthor.Title AS [Author]
		, CAST(pu.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, p.Objectives AS [Objectives]
		, pu.ProgressUpdate AS [Delivery Confidence Update]
		, pu.FutureActions AS [Future Actions Update]
		, pu.Escalations AS [Escalations Update]
		, dbo.ProjectPhases.Title AS [Current Phase]
		, dbo.ProjectBusinessCaseTypes.Title AS [Latest approved business case type]
		, CAST(pu.BusinessCaseDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Business Case Approval Date]
		, pu.WholeLifeCost AS [Whole Life Cost £m]
		, pu.WholeLifeBenefit AS [Whole Life Benefit £m]
		, pu.NetPresentValue AS [Net Present Value £m]
		, es.Title AS [Status] 

		, ppu.PreviousDeliveryConfidenceRAG AS [Previous Delivery Confidence RAG]
		, ppu.PreviousFinanceRAG AS [Previous Finance RAG]
		, ppu.PreviousMilestonesRAG AS [Previous Milestones RAG]
		, ppu.PreviousBenefitsRAG AS [Previous Benefits RAG]
		, ppu.PreviousPeopleRAG AS [Previous People RAG]
	
		, ppu.PreviousDeliveryConfidenceRAGScore AS [Previous Delivery Confidence RAG Score]
		, ppu.PreviousFinanceRAGScore AS [Previous Finance RAG Score]
		, ppu.PreviousMilestonesRAGScore AS [Previous Milestones RAG Score]
		, ppu.PreviousBenefitsRAGScore AS [Previous Benefits RAG Score]
		, ppu.PreviousPeopleRAGScore AS [Previous People RAG Score]

		, OverallRAG.ReportName AS [Delivery Confidence RAG]
		, FinanceRAG.ReportName AS [Finance RAG]
		, MilestonesRAG.ReportName AS [Milestones RAG]
		, BenefitsRAG.ReportName AS [Benefits RAG]
		, PeopleRAG.ReportName AS [People RAG]
	
		, OverallRAG.Score AS [Delivery Confidence RAG Score]
		, FinanceRAG.Score AS [Finance RAG Score]
		, MilestonesRAG.Score AS [Milestones RAG Score]
		, BenefitsRAG.Score AS [Benefits RAG Score]
		, PeopleRAG.Score AS [People RAG Score]

		, pu.FinanceComment AS [Finance Update]
		, pu.MilestonesComment AS [Milestones Update]
		, pu.BenefitsComment AS [Benefits Update]
		, pu.PeopleComment AS [People Update]

		, (OverallRAG.Score - ppu.PreviousDeliveryConfidenceRAGScore) AS [Delivery Confidence RAG Change]
		, (FinanceRAG.Score - ppu.PreviousFinanceRAGScore) AS [Finance RAG Change]
		, (MilestonesRAG.Score - ppu.PreviousMilestonesRAGScore) AS [Milestones RAG Change]
		, (BenefitsRAG.Score - ppu.PreviousBenefitsRAGScore) AS [Benefits RAG Change]
		, (PeopleRAG.Score - ppu.PreviousPeopleRAGScore) AS [People RAG Change]

  FROM dbo.Projects AS p CROSS JOIN
           (SELECT DISTINCT UpdatePeriod
    FROM [dbo].[ProjectUpdates]
    WHERE UpdatePeriod IS NOT NULL) AS Months LEFT OUTER JOIN
    dbo.ProjectUpdates AS pu ON p.ID = pu.ProjectID AND Months.UpdatePeriod = pu.UpdatePeriod AND pu.ID IN
	(SELECT MAX([ID]) AS CurrentDraftID
    FROM [dbo].[ProjectUpdates]
    GROUP BY ProjectID, UpdatePeriod) LEFT OUTER JOIN
    dbo.Directorates AS d ON p.DirectorateID = d.ID LEFT OUTER JOIN
    dbo.Groups AS g ON d.GroupID = g.ID LEFT OUTER JOIN
    dbo.EntityStatuses AS es ON p.EntityStatusID = es.ID LEFT OUTER JOIN
    dbo.RagOptions AS OverallRAG ON pu.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
    dbo.RagOptions AS FinanceRAG ON pu.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
    dbo.RagOptions AS PeopleRAG ON pu.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
    dbo.RagOptions AS MilestonesRAG ON pu.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
    dbo.RagOptions AS BenefitsRAG ON pu.BenefitsRagOptionID = BenefitsRAG.ID LEFT OUTER JOIN
    dbo.Users AS SROUser ON p.SeniorResponsibleOwnerUserID = SROUser.ID LEFT OUTER JOIN
    dbo.Users AS ProjectManagerUser ON p.ProjectManagerUserID = ProjectManagerUser.ID LEFT OUTER JOIN
    dbo.Users AS UpdateAuthor ON pu.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
    dbo.ProjectPhases ON pu.ProjectPhaseID = dbo.ProjectPhases.ID LEFT OUTER JOIN
    dbo.ProjectBusinessCaseTypes ON pu.BusinessCaseTypeID = dbo.ProjectBusinessCaseTypes.ID LEFT OUTER JOIN
    dbo.PreviousProjectUpdates AS ppu ON p.ID = ppu.ProjectID AND Months.UpdatePeriod = ppu.NextMonth;