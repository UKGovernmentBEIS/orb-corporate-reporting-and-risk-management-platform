CREATE VIEW [dbo].[PreviousMilestoneUpdates]
AS
	SELECT dbo.MilestoneUpdates.MilestoneID
			, nextso.ReportMonth AS [NextMonth]
			, dbo.RagOptions.ReportName AS [PreviousRAG]
			, dbo.RagOptions.Score AS [PreviousRAGScore]
	FROM dbo.SignOffs AS so INNER JOIN
		dbo.MilestoneUpdates ON so.ID = dbo.MilestoneUpdates.SignOffID LEFT OUTER JOIN
		dbo.RagOptions ON dbo.MilestoneUpdates.RagOptionID = dbo.RagOptions.ID LEFT OUTER JOIN
		dbo.SignOffs AS nextso ON nextso.IsCurrent = 1 AND (
			(
				so.DirectorateID = nextso.DirectorateID AND nextso.ReportMonth = (
					SELECT MIN(ReportMonth)
					FROM SignOffs
					WHERE DirectorateID = so.DirectorateID AND ReportMonth > so.ReportMonth AND IsCurrent = 1
				)
			) OR (
				so.ProjectID = nextso.ProjectID AND nextso.ReportMonth = (
					SELECT MIN(ReportMonth)
					FROM SignOffs
					WHERE ProjectID = so.ProjectID AND ReportMonth > so.ReportMonth AND IsCurrent = 1
				)
			) OR (
				so.PartnerOrganisationID = nextso.PartnerOrganisationID AND nextso.ReportMonth = (
					SELECT MIN(ReportMonth)
					FROM SignOffs
					WHERE PartnerOrganisationID = so.PartnerOrganisationID AND ReportMonth > so.ReportMonth AND IsCurrent = 1
				)
			))
	WHERE so.IsCurrent = 1