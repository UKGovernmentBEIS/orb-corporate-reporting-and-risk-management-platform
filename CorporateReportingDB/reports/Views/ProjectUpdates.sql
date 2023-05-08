CREATE VIEW [reports].[ProjectUpdates]
AS
	SELECT dbo.Groups.Title AS [Group]
		, dbo.Directorates.Title AS [Directorate]
		, dbo.Projects.Title AS [Project]
		, dbo.Projects.ID AS [ID]
		, Months.ReportMonth AS [Report Month]
		, SROUser.Title AS [SRO]
		, ProjectManagerUser.Title AS [Project Manager]
		, UpdateAuthor.Title AS [Author]
		, SignOffUser.Title AS [Signed-off by]
		, dbo.SignOffs.ID AS [SignOff ID]
		, CAST(dbo.SignOffs.SignOffDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Date Signed-off]
		, CAST(ProjectUpdates.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last Edited Date]
		, dbo.Projects.Objectives AS [Objectives]
		, ProjectUpdates.ProgressUpdate AS [Delivery Confidence Update]
		, ProjectUpdates.FutureActions AS [Future Actions Update]
		, ProjectUpdates.Escalations AS [Escalations Update]
		, dbo.ProjectPhases.Title AS [Current Phase]
		, dbo.ProjectBusinessCaseTypes.Title AS [Latest approved business case type]
		, CAST(ProjectUpdates.BusinessCaseDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Business Case Approval Date]
		, ProjectUpdates.WholeLifeCost AS [Whole Life Cost £m]
		, ProjectUpdates.WholeLifeBenefit AS [Whole Life Benefit £m]
		, ProjectUpdates.NetPresentValue AS [Net Present Value £m]
		, es.Title AS [Status] 

		, PrevUpdate.PreviousDeliveryConfidenceRAG AS [Previous Delivery Confidence RAG]
		, PrevUpdate.PreviousFinanceRAG AS [Previous Finance RAG]
		, PrevUpdate.PreviousMilestonesRAG AS [Previous Milestones RAG]
		, PrevUpdate.PreviousBenefitsRAG AS [Previous Benefits RAG]
		, PrevUpdate.PreviousPeopleRAG AS [Previous People RAG]
	
		, PrevUpdate.PreviousDeliveryConfidenceRAGScore AS [Previous Delivery Confidence RAG Score]
		, PrevUpdate.PreviousFinanceRAGScore AS [Previous Finance RAG Score]
		, PrevUpdate.PreviousMilestonesRAGScore AS [Previous Milestones RAG Score]
		, PrevUpdate.PreviousBenefitsRAGScore AS [Previous Benefits RAG Score]
		, PrevUpdate.PreviousPeopleRAGScore AS [Previous People RAG Score]

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

		, ProjectUpdates.FinanceComment AS [Finance Update]
		, ProjectUpdates.MilestonesComment AS [Milestones Update]
		, ProjectUpdates.BenefitsComment AS [Benefits Update]
		, ProjectUpdates.PeopleComment AS [People Update]

		, (OverallRAG.Score - PrevUpdate.PreviousDeliveryConfidenceRAGScore) AS [Delivery Confidence RAG Change]
		, (FinanceRAG.Score - PrevUpdate.PreviousFinanceRAGScore) AS [Finance RAG Change]
		, (MilestonesRAG.Score - PrevUpdate.PreviousMilestonesRAGScore) AS [Milestones RAG Change]
		, (BenefitsRAG.Score - PrevUpdate.PreviousBenefitsRAGScore) AS [Benefits RAG Change]
		, (PeopleRAG.Score - PrevUpdate.PreviousPeopleRAGScore) AS [People RAG Change]

	FROM dbo.Projects CROSS JOIN
           (SELECT DISTINCT dbo.SignOffs.ReportMonth
		FROM dbo.SignOffs
		WHERE dbo.SignOffs.ReportMonth IS NOT NULL) AS Months LEFT OUTER JOIN
		dbo.SignOffs ON dbo.SignOffs.ProjectID = dbo.Projects.ID AND dbo.SignOffs.ReportMonth = Months.ReportMonth AND dbo.SignOffs.IsCurrent = 1 LEFT OUTER JOIN
		dbo.ProjectUpdates AS ProjectUpdates ON dbo.SignOffs.ID = ProjectUpdates.SignOffID LEFT OUTER JOIN
		dbo.Directorates ON dbo.Projects.DirectorateID = dbo.Directorates.ID LEFT OUTER JOIN
		dbo.Groups ON dbo.Directorates.GroupID = dbo.Groups.ID LEFT OUTER JOIN
		dbo.EntityStatuses AS es ON dbo.Projects.EntityStatusID = es.ID LEFT OUTER JOIN
		dbo.RagOptions AS OverallRAG ON ProjectUpdates.OverallRagOptionID = OverallRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS FinanceRAG ON ProjectUpdates.FinanceRagOptionID = FinanceRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS PeopleRAG ON ProjectUpdates.PeopleRagOptionID = PeopleRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS MilestonesRAG ON ProjectUpdates.MilestonesRagOptionID = MilestonesRAG.ID LEFT OUTER JOIN
		dbo.RagOptions AS BenefitsRAG ON ProjectUpdates.BenefitsRagOptionID = BenefitsRAG.ID LEFT OUTER JOIN
		dbo.Users AS SROUser ON dbo.Projects.SeniorResponsibleOwnerUserID = SROUser.ID LEFT OUTER JOIN
		dbo.Users AS ProjectManagerUser ON dbo.Projects.ProjectManagerUserID = ProjectManagerUser.ID LEFT OUTER JOIN
		dbo.Users AS SignOffUser ON dbo.SignOffs.SignOffUserID = SignOffUser.ID LEFT OUTER JOIN
		dbo.Users AS UpdateAuthor ON ProjectUpdates.UpdateUserID = UpdateAuthor.ID LEFT OUTER JOIN
		dbo.ProjectPhases ON ProjectUpdates.ProjectPhaseID = dbo.ProjectPhases.ID LEFT OUTER JOIN
		dbo.ProjectBusinessCaseTypes ON ProjectUpdates.BusinessCaseTypeID = dbo.ProjectBusinessCaseTypes.ID LEFT OUTER JOIN
		dbo.PreviousProjectUpdates AS PrevUpdate ON dbo.Projects.ID = PrevUpdate.ProjectID AND Months.ReportMonth = PrevUpdate.NextMonth
