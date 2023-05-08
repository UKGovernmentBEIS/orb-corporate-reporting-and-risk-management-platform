CREATE VIEW [reports].[ReportingEntityUpdates]
AS
  SELECT so.ID AS [Report ID]
    , report.[Group] AS [Group]
    , report.Directorate AS [Directorate]
    , report.Project AS [Project]
    , report.PartnerOrganisation AS [Partner organisation]
    , so.ReportMonth AS [Report period]
    , reportEntityTypes.TypeName AS [Reporting entity type]
    , reportEntities.ReportingEntityID AS [Reporting entity ID]
    , reportEntities.ReportingEntityName AS [Reporting entity]
    , reportEntities.Comment AS [Progress update]
    , reportEntities.Rag AS [Current RAG]
    , reportEntities.RagScore AS [Current RAG score]
    , reportEntities.CurrentPerformance AS [Current performance]
    , CAST(reportEntities.ForecastDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Forecast delivery date]
    , CAST(reportEntities.ActualDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Actual delivery date]
    , reportEntities.LeadUser AS [Lead]
    , reportEntities.UpdateAuthor AS [Update author]
    , CAST(reportEntities.UpdateDate AT TIME ZONE 'UTC' AT TIME ZONE 'GMT Standard Time' AS DATE) AS [Last edited date]
    , CASE reportEntities.ToBeClosed WHEN 1 THEN 'Yes' ELSE 'No' END AS [Reporting entity closed]
    , reportEntities.EntityStatus AS [Status]
  FROM dbo.SignOffs AS so 
    CROSS APPLY OPENJSON(so.ReportJson, 'lax $')
    WITH (  
      [Group] NVARCHAR(255) '$.Directorate.Group.Title',
      Directorate NVARCHAR(255) '$.Directorate.Title',
      Project NVARCHAR(255) '$.Project.Title',
      PartnerOrganisation NVARCHAR(255) '$.PartnerOrganisation.Title',
      ReportingEntityTypes NVARCHAR(MAX) '$.ReportingEntityTypes' AS JSON
    ) AS report
    CROSS APPLY OPENJSON(report.ReportingEntityTypes) 
    WITH (
      TypeName NVARCHAR(255) '$.Title',
      ReportingEntities NVARCHAR(MAX) '$.ReportingEntities' AS JSON
    ) AS reportEntityTypes 
    CROSS APPLY OPENJSON(reportEntityTypes.ReportingEntities,'$')
    WITH (
      ReportingEntityID INT '$.ID',
      ReportingEntityName NVARCHAR(255) '$.Title',
      LeadUser NVARCHAR(255) '$.LeadUser.Title',
      EntityStatus NVARCHAR(50) '$.EntityStatus.Title',
      UpdateAuthor NVARCHAR(255) '$.ReportingEntityUpdates[0].UpdateUser.Title',
      UpdateDate DATETIME2(7) '$.ReportingEntityUpdates[0].UpdateDate',
      Rag NVARCHAR(2) '$.ReportingEntityUpdates[0].RagOption.ReportName',
      RagScore INT '$.ReportingEntityUpdates[0].RagOption.Score',
      Comment NVARCHAR(1000) '$.ReportingEntityUpdates[0].Comment',
      CurrentPerformance DECIMAL(18, 4) '$.ReportingEntityUpdates[0].CurrentPerformance',
      ForecastDate DATETIME2(7) '$.ReportingEntityUpdates[0].ForecastDate',
      ActualDate DATETIME2(7) '$.ReportingEntityUpdates[0].ActualDate',
      ToBeClosed BIT '$.ReportingEntityUpdates[0].ToBeClosed'
    ) AS reportEntities
  WHERE so.IsCurrent = 1