CREATE PROCEDURE [reports].[spReportingEntityTextProperties]
AS
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON

-- Source: https://stackoverflow.com/a/14789896

DECLARE @PivotQuery AS NVARCHAR(MAX);
DECLARE @ColumnNames AS NVARCHAR(MAX);

--Get distinct values of the PIVOT Column 
SELECT @ColumnNames = ISNULL(@ColumnNames + ',','') + QUOTENAME([FieldTitle])
FROM (SELECT DISTINCT [FieldTitle]
  FROM [reports].[ReportingEntityTextProperties]) AS [Field];

SET @PivotQuery = 
	  N'
      SELECT *
      FROM
      (
        SELECT [ReportingEntityID], [FieldTitle], STRING_AGG([Value],'', '') AS [Values]
        FROM [reports].[ReportingEntityTextProperties]
        GROUP BY [ReportingEntityID], [FieldTitle]
      ) src
      PIVOT
      (
        MAX([Values])
        FOR [FieldTitle] IN (' + @ColumnNames + ')
      ) piv';

EXEC sp_executesql @PivotQuery;
